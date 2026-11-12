# ============================================================
# 1. Modules S3 (uploads et backups)
# ============================================================
module "uploads" {
  source      = "./modules/secure-bucket"
  bucket_name = "tp13-uploads-${var.environment}"
  environment = var.environment
}

module "backups" {
  source      = "./modules/secure-bucket"
  bucket_name = "tp13-backups-${var.environment}"
  environment = var.environment
}

# ============================================================
# 2. Blocs "moved" pour éviter la destruction
# ============================================================
moved {
  from = aws_s3_bucket.uploads
  to   = module.uploads.aws_s3_bucket.this
}

moved {
  from = aws_s3_bucket_versioning.uploads
  to   = module.uploads.aws_s3_bucket_versioning.this
}

moved {
  from = aws_s3_bucket_server_side_encryption_configuration.uploads
  to   = module.uploads.aws_s3_bucket_server_side_encryption_configuration.this
}

moved {
  from = aws_s3_bucket_public_access_block.uploads
  to   = module.uploads.aws_s3_bucket_public_access_block.this
}

# ============================================================
# 3. File SQS avec DLQ
# ============================================================
resource "aws_sqs_queue" "uploads_dlq" {
  name                      = "tp13-uploads-dlq"
  message_retention_seconds = 1209600
}

resource "aws_sqs_queue" "uploads" {
  name = "tp13-uploads"
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.uploads_dlq.arn
    maxReceiveCount     = 4
  })
}

# ============================================================
# 4. Table DynamoDB
# ============================================================
resource "aws_dynamodb_table" "visits" {
  name         = "tp13-visits"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}

# ============================================================
# 5. Secret Secrets Manager
# ============================================================
resource "aws_secretsmanager_secret" "api_key" {
  name = "tp13/api-key"
}

resource "aws_secretsmanager_secret_version" "api_key" {
  secret_id     = aws_secretsmanager_secret.api_key.id
  secret_string = var.api_key_value
}
