# Indicar proveedor de GCP
provider "google" {
project = var.project_id
region  = var.region
}

# resource "google_project" "project" {
#   name            = var.project_id
#   project_id      = var.project_id
# }