resource "google_pubsub_topic" "meteorological-data" {
  name = var.pub_sub_topic_meteorological_data_name

  labels = {
    kind_of_data = "temperature"
  }

  message_retention_duration = "86600s"
}