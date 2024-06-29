output "pubsub_topic" {
  value = google_pubsub_topic.pluto_topic.name
}

output "bigquery_dataset" {
  value = google_bigquery_dataset.pluto_dataset.dataset_id
}

output "cloud_function" {
  value = google_cloudfunctions_function.pluto_function.name
}