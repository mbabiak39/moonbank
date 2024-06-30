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
  service_account_email = google_service_account.service_account.email
}

resource "google_cloudfunctions_function" "stop_vm" {
  project = var.project_id
  name = "stop_vm"
  available_memory_mb = 256
  runtime = "python39"
  source_archive_bucket = "cloud_functions_dev"
  source_archive_object = "pluto.zip"
  entry_point = "stop_vm"
  timeout = 60
  event_trigger {
    resource = google_pubsub_topic.idle_vm_topic.name
    event_type = "google.pubsub.topic.publish"
  }
  service_account_email = google_service_account.service_account.email
}