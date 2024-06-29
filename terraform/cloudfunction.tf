resource "google_cloudfunctions_function" "pluto_function" {
  name        = "pluto-function"
  description = "PLUTO Cloud Function"
  runtime     = "python39"

  source_archive_url = "https://github.com/ROIGCP/PLUTO/archive/refs/heads/master.zip"
  entry_point        = "main_function_entry_point"  # Update this to match your actual entry point

  event_trigger {
    event_type = "google.pubsub.topic.publish"
    resource   = google_pubsub_topic.pluto_topic.id
  }

  environment_variables = {
    PROJECT_ID = var.project_id
  }
}

resource "google_cloudfunctions_function" "function" {
  project             = var.project_id
  name                = var.function
  available_memory_mb = 256
  runtime             = "python39"
  source_repository {
    url = "https://github.com/mbabiak39/PLUTO/blob/master/cloudfunction/main.py"
  }
  entry_point       = "pubsub_to_bigquery"
  timeout = 60
  event_trigger {
    resource   = google_pubsub_topic.topic.name
    event_type = "google.pubsub.topic.publish"
  }
}