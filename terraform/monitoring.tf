resource "google_monitoring_alert_policy" "low_cpu_alert" {
  display_name = "Low CPU Usage Alert"

  conditions {
    display_name = "Low CPU Usage"
    condition_threshold {
      filter = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""
      comparison = "COMPARISON_LT"
      threshold_value = 3.0
      duration = "5s"
      aggregations {
        alignment_period = "5s"
        per_series_aligner = "ALIGN_MEAN"
        cross_series_reducer = "REDUCE_MEAN"
        group_by_fields = [
          "metric.label.\"instance_name\""]
      }
      trigger {
        count = 12
      }
    }
  }

  notification_channels = [
    google_monitoring_notification_channel.pubsub_channel.id]

  combiner = "AND"
}

# Pub/Sub Notification channel
resource "google_monitoring_notification_channel" "pubsub_channel" {
  type = "pubsub"
  display_name = "Pub/Sub Channel"
  description = "Pub/Sub channel for low CPU usage alerts"
  labels = {
    topic = google_pubsub_topic.idle_vm_topic.id
  }

}