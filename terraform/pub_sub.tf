resource "google_pubsub_topic" "topic" {
  project = var.project_id
  name = var.topic
  message_retention_duration = "10000s"
}

resource "google_pubsub_topic" "idle_vm_topic" {
  project = var.project_id
  name = "idle_vm_topic"
  message_retention_duration = "10000s"
}

resource "google_pubsub_subscription" "subscription" {
  project = var.project_id
  name = "${var.project_id}-catchall"
  topic = google_pubsub_topic.topic.name
  ack_deadline_seconds = 60
}

resource "google_pubsub_subscription" "idle_vm_subscription" {
  project = var.project_id
  name = "idle_vm-subscription"
  topic = google_pubsub_topic.idle_vm_topic.name
  ack_deadline_seconds = 60
}
