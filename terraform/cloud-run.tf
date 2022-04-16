# Create the Cloud Run service
resource "google_cloud_run_service" "cloud_run_microservice" {
  name = var.cloud_run_microservice_name
  location = var.region_cloud_run_microservice

  template {
    spec {
      containers {
        image = var.cloud_run_microservice_container
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

}