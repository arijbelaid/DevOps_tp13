output "bucket_name" {
  description = "Nom du bucket S3 pour les uploads"
  value       = module.uploads.bucket_id
}

output "backups_bucket_name" {
  description = "Nom du bucket S3 pour les backups"
  value       = module.backups.bucket_id
}
