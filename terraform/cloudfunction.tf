resource "google_cloudfunctions_function" "function" {
  project = var.project_id
  name = var.function
  available_memory_mb = 256
  runtime = "python39"
  source_archive_bucket = "cloud_functions_dev"
  source_archive_object = "pluto.zip"
  entry_point = "pubsub_to_bigquery"
  timeout = 60
  event_trigger {
    resource = google_pubsub_topic.topic.name
    event_type = "google.pubsub.topic.publish"
  }
}