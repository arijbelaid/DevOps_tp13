// TP13 partie 2 : le même code fonctionne sur Floci et sur AWS ; seul le endpoint change.
import { S3Client, CreateBucketCommand, PutObjectCommand, ListObjectsV2Command } from "@aws-sdk/client-s3";
import { SQSClient, CreateQueueCommand, SendMessageCommand } from "@aws-sdk/client-sqs";

const common = {
  region: process.env.AWS_REGION ?? "us-east-1",
  endpoint: process.env.AWS_ENDPOINT_URL ?? "http://localhost:4566",
  credentials: { accessKeyId: "test", secretAccessKey: "test" },
};

const s3 = new S3Client({ ...common, forcePathStyle: true });
const bucket = process.env.BUCKET ?? "tp13-demo";

// 1. Créer le bucket S3 s'il n'existe pas
try {
  await s3.send(new CreateBucketCommand({ Bucket: bucket }));
  console.log(`Bucket ${bucket} créé.`);
} catch (err) {
  if (err.name !== "BucketAlreadyExists" && err.name !== "BucketAlreadyOwnedByYou") {
    throw err;
  }
}

// 2. Envoyer un objet dans S3
await s3.send(new PutObjectCommand({ Bucket: bucket, Key: "hello.txt", Body: "Bonjour Floci" }));
const { Contents = [] } = await s3.send(new ListObjectsV2Command({ Bucket: bucket }));
console.log("Objets du bucket :", Contents.map((o) => o.Key));

// 3. Créer la file SQS et envoyer un message
const queueUrl = process.env.QUEUE_URL;

if (queueUrl) {
  const sqs = new SQSClient(common);
  
  // Créer la file si elle n'existe pas (idempotent sur AWS)
  try {
    await sqs.send(new CreateQueueCommand({ QueueName: "tp13-demo" }));
    console.log("File SQS tp13-demo créée.");
  } catch (err) {
    if (err.name !== "QueueAlreadyExists" && err.name !== "QueueNameExists") {
      console.log("Note: la file existe déjà ou erreur ignorée.");
    }
  }

  // Envoyer le message
  const message = {
    event: "contact.created",
    at: new Date().toISOString()
  };
  
  await sqs.send(new SendMessageCommand({
    QueueUrl: queueUrl,
    MessageBody: JSON.stringify(message)
  }));
  console.log("Message SQS envoyé avec succès !");
} else {
  console.log("QUEUE_URL non fourni, envoi SQS ignoré.");
}
