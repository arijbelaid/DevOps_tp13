variable "region" {
  description = "Région AWS simulée"
  type        = string
  default     = "us-east-1"
}

variable "floci_endpoint" {
  description = "URL du endpoint Floci"
  type        = string
  default     = "http://localhost:4566"
}

variable "environment" {
  description = "Nom de l'environnement (dev, staging, prod)"
  type        = string
  default     = "dev"

  # TODO (partie 4) : ajouter un bloc validation qui n'accepte que dev, staging ou prod
}
variable "api_key_value" {
  description = "Valeur du secret API (sensible)"
  type        = string
  sensitive   = true
  default     = "super-secret-key-123" # Pour le TP, on met une valeur par défaut
}
