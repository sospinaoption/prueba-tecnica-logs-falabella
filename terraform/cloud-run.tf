# Create the Cloud Run service
resource "google_cloud_run_service" "cloud_run_microservice" {
  name = var.cloud_run_microservice_name
  location = var.region_cloud_run_microservice

  template {
    spec {
      containers {
        image = var.cloud_run_microservice_container

        env {
            name  = "OUTPUT_BUCKET"
            value = var.output_bucket_name
        }

        resources {
            limits = {
            memory = "4096Mi"
          }
        }
      }
    }
  }

  traffic {
    percent = 100
    latest_revision = true
  }

}


resource "google_cloud_run_service_iam_member" "allUsers" {
  service  = google_cloud_run_service.cloud_run_microservice.name
  location = google_cloud_run_service.cloud_run_microservice.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}


# Create a Pub/Sub trigger
resource "google_eventarc_trigger" "trigger-pubsub-tf" {
  name     = "trigger-pubsub-tf"
  location = google_cloud_run_service.cloud_run_microservice.location

  matching_criteria {
    attribute = "type"   
    value     = "google.cloud.pubsub.topic.v1.messagePublished"
  }
  destination {
    cloud_run_service {
      service = google_cloud_run_service.cloud_run_microservice.name
      region  = google_cloud_run_service.cloud_run_microservice.location
    }
  }
}


resource "google_cloud_run_service_iam_member" "iam_member" {
  service  = google_cloud_run_service.cloud_run_microservice.name
  location = google_cloud_run_service.cloud_run_microservice.location
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.service_account.email}"
}