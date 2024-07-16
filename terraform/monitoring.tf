resource "google_monitoring_alert_policy" "low_cpu_alert" {
  display_name = "Low CPU Usage Alert"

  conditions {
    display_name = "Low CPU Usage"
    condition_threshold {
      filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""
      comparison = "COMPARISON_LT"
      threshold_value = 0.50
      duration = "60s"
      aggregations {
        alignment_period = "60s"
        per_series_aligner = "ALIGN_MEAN"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields = [
          "metric.label.\"instance_name\""]
      }
      trigger {
        count = 1
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.pubsub_channel.id]

  combiner = "AND"
}

resource "google_monitoring_alert_policy" "excessive_compute_creation_alert" {
  display_name = "Excessive Compute Instance Creation Alert"
  combiner     = "OR"
  conditions {
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/compute_instance_creation_count\""
      comparison      = "COMPARISON_GT"
      threshold_value = 5
      duration        = "120s"
      trigger {
        count = 1
      }
    }
    display_name = "Instance creation count"
  }
  notification_channels = [google_monitoring_notification_channel.email_channel.id]
}

resource "google_monitoring_alert_policy" "local_ssd_creation_alert" {
  display_name = "Local SSD VM Creation Alert"
  combiner     = "OR"
  conditions {
    condition_threshold {
      filter          = "metric.type=\"logging.googleapis.com/user/local_ssd_creation_count\""
      comparison      = "COMPARISON_GT"
      threshold_value = 0
      duration        = "0s"
      trigger {
        count = 1
      }
    }
    display_name = "Local ssd creation"
  }
  notification_channels = [google_monitoring_notification_channel.email_channel.id]
}


resource "google_monitoring_notification_channel" "pubsub_channel" {
  type = "pubsub"
  display_name = "Pub/Sub Channel"
  description = "Pub/Sub channel for low CPU usage alerts"
  labels = {
    topic = google_pubsub_topic.idle_vm_topic.id
  }

}

resource "google_monitoring_notification_channel" "email_channel" {
  display_name = "Email Notification Channel"
  type         = "email"
  labels = {
    email_address = "mbabiak39@gmail.com"
  }
}