resource "google_pubsub_topic" "sensor_data" {
  name = "sensor-data"
  
  labels = {
    environment = var.environment
  }
}

resource "google_pubsub_topic_iam_binding" "publisher" {
  topic   = google_pubsub_topic.sensor_data.name
  role    = "roles/pubsub.publisher"
  members = var.publisher_members
} 