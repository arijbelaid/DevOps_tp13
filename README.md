<div align="center">

# ☁️ TP13 - AWS Local, SDK & Terraform
### Floci, AWS CLI, Terraform, OpenTofu & Scan IaC

[![AWS](https://img.shields.io/badge/AWS-CLI-orange?style=for-the-badge&logo=amazon-aws)](https://aws.amazon.com/cli/)
[![Terraform](https://img.shields.io/badge/Terraform-v1.17-purple?style=for-the-badge&logo=terraform)](https://www.terraform.io/)
[![OpenTofu](https://img.shields.io/badge/OpenTofu-v1.13-blue?style=for-the-badge)](https://opentofu.org/)
[![Floci](https://img.shields.io/badge/Floci-Emulator-green?style=for-the-badge)](https://github.com/floci/floci)

📄 **[Télécharger le rapport complet (PDF)](rapport_tp13.pdf)**

</div>

---

## 🎯 Objectifs du TP

Ce TP a pour but de maîtriser l'utilisation d'un émulateur AWS local (Floci) et de Terraform :

- **AWS CLI** : Manipuler S3, SQS, DynamoDB, Secrets Manager et Lambda.
- **SDK JavaScript** : Interagir avec Floci via Node.js et Docker Compose.
- **Terraform** : Provisionner des ressources AWS sécurisées (bucket S3, file SQS, table DynamoDB, secret).
- **Backend S3** : Stocker le state à distance avec verrouillage DynamoDB.
- **Scan IaC** : Détecter les mauvaises configurations avec Checkov et Trivy.
- **OpenTofu** : Rejouer le cycle avec le fork open-source de Terraform.

---

## 📝 Description

Le projet simule un environnement AWS complet en local avec Floci :
1.  Création de ressources avec la **CLI AWS**.
2.  Automatisation avec un **SDK Node.js** et **Docker Compose**.
3.  Infrastructure as Code avec **Terraform** (modules, environnements, backend S3).
4.  Audit de sécurité avec **Checkov** et **Trivy**.
5.  Migration vers **OpenTofu**.

---

## 📸 Captures d'écran

Toutes les captures sont disponibles dans le dossier [`captures/`](captures/).

### 🛠️ Partie 1 : AWS CLI contre Floci

#### 1. Configuration du profil Floci
![01](captures/01_sts_identity.png)

#### 2. S3 (Bucket, upload, list)
![02](captures/02_s3.png)

#### 3. SQS (Queue, send, receive)
![03](captures/03_sqs.png)

#### 4. DynamoDB (Création de la table)
![04](captures/04_dynamodb_create.png)

#### 4b. DynamoDB (Insertion et scan)
![04b](captures/04_dynamodb_data.png)

#### 5. Secrets Manager (Create, get)
![05](captures/05_secrets.png)

#### 6. Lambda (Création de la fonction)
![06](captures/06_lambda_create.png)

#### 6b. Lambda (Invocation)
![06b](captures/06_lambda_invoke.png)

### 📦 Partie 2 : SDK JavaScript

#### 7. Script SDK (S3 + SQS)
![07](captures/07_sdk_sqs.png)

#### 8. Docker Compose (Floci + SDK)
![08](captures/08_docker_compose.png)

### 🏗️ Partie 3 : Terraform

#### 9. Apply Terraform (Ressources créées)
![09](captures/09_terraform_apply.png)

#### 10. Outputs Terraform
![10](captures/10_terraform_outputs.png)

#### 11. Drift (Suppression manuelle + Plan)
![11](captures/11_terraform_drift.png)

### 📦 Partie 4 : Modules et Backend S3

#### 12. Module S3 (Uploads + Backups)
![12](captures/12_terraform_module.png)

#### 13. Backend S3 (State migré)
![13](captures/13_terraform_backend.png)

#### 14. Verrouillage (State Lock)
![14](captures/14_terraform_lock.png)

### 🛡️ Partie 5 : Scan IaC et OpenTofu

#### 15. Scan Checkov (Avant)
![15](captures/15_checkov_before.png)

#### 16. Scan Trivy (Avant)
![16](captures/16_trivy_iac_before.png)

#### 17. Scan Checkov (Après failles)
![17](captures/17_checkov_after.png)

#### 18. Scan Trivy (Après failles)
![18](captures/18_trivy_iac_after.png)

#### 19. Restauration du code sécurisé
![19](captures/19_terraform_restored.png)

#### 20. Installation d'OpenTofu
![20](captures/20_opentofu_install.png)

#### 21. Apply avec OpenTofu
![21](captures/21_opentofu_apply.png)

#### 22. Destroy (Nettoyage)
![22](captures/22_terraform_destroy.png)

---

## 📊 Tableau comparatif : Floci vs LocalStack vs AWS Réel

| Critère | Floci | LocalStack (Community) | AWS Réel |
| :--- | :--- | :--- | :--- |
| **Licence** | MIT (open-source, gratuit) | Freemium (token requis) | Payant (à l'usage) |
| **Services couverts** | 1 850+ tests (S3, SQS, DynamoDB, Lambda, RDS, etc.) | Large couverture, certains services réservés à la version Pro | Tous les services AWS |
| **Fidélité** | Très bonne pour les tests locaux | Très bonne (référence du marché) | Parfaite (c'est le vrai AWS) |
| **Coût** | Gratuit (auto-hébergé) | Gratuit en communauté | Facturation à l'usage (peut être élevé) |
| **Usage en CI** | Idéal (léger, rapide) | Possible (token requis) | Déconseillé (coût, lenteur) |

## 📊 Tableau comparatif : Terraform vs OpenTofu

| Critère | Terraform (v1.17.0) | OpenTofu (v1.13.9) |
| :--- | :--- | :--- |
| **Licence** | BUSL (Business Source License) | MPL 2.0 (open-source) |
| **Compatibilité** | Référence | Lit les fichiers `.tf` et le state Terraform 1.x |
| **Chiffrement du state** | Non natif | **Natif** (v1.7+) : AES-GCM côté client |
| **Providers** | Registry officiel | Même registry (a utilisé `hashicorp/aws v6.73.0`) |
| **Fonctionnalités propres** | N/A | `for_each` sur les providers, `-exclude` |

---

<div align="center">
  <b>Fait avec ❤️ par Arij Belaid</b>
</div>
