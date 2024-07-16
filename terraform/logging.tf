resource "google_logging_metric" "compute_instance_creation_count" {
  name        = "compute_instance_creation_count"
  description = "Count of Compute Engine instance creation events"
  filter      = "resource.type=\"gce_instance\" AND protoPayload.methodName=\"compute.instances.insert\""
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}

resource "google_logging_metric" "local_ssd_creation_count" {
  name        = "local_ssd_creation_count"
  description = "Count of VM creation events with Local SSDs"
  filter      = "resource.type=\"gce_instance\" AND protoPayload.methodName=\"v1.compute.instances.insert\" AND jsonPayload.resourceProperties.disks.type=\"local-ssd\""
  metric_descriptor {
    metric_kind = "DELTA"
    value_type  = "INT64"
  }
}