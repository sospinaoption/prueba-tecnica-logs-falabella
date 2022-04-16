resource "google_pubsub_topic" "meteorological-data-topic" {
  name = var.pub_sub_topic_meteorological_data_name

  labels = {
    kind_of_data = "temperature"
  }

  message_retention_duration = "86600s"
}



resource "google_pubsub_subscription" "meteorological-data-subscription-pull" {
  name  = var.pub_sub_meteorological_data_subscription_pull
  topic = google_pubsub_topic.meteorological-data-topic.name

  labels = {
    kind_of_data = "temperature"
  }

  # 20 minutes
  message_retention_duration = "1200s"
  retain_acked_messages      = true

  ack_deadline_seconds = 20

  expiration_policy {
    ttl = "300000.5s"
  }
  retry_policy {
    minimum_backoff = "10s"
  }

  enable_message_ordering    = false
}


resource "google_pubsub_subscription" "meteorological-data-subscription-push" {
  name  = var.pub_sub_meteorological_data_subscription_push
  topic = google_pubsub_topic.meteorological-data-topic.name

  ack_deadline_seconds = 20

  labels = {
    kind_of_data = "temperature"
  }

  push_config {
    push_endpoint = "https://example.com/push"

    attributes = {
      x-goog-version = "v1"
    }
  }
}