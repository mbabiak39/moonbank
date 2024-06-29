variable project_id {
  type = string
  description = "GCP project ID"
}
variable services {
  type = list(string)
  description = "List of services to enable"
}

variable region {
  type = string
  description = "Region to deploy resources"
  default = "us-central1"
}

variable topic {
  type = string
  description = "Topic name"
}

variable function {
  type = string
  description = "Function name"
}

variable function_sa {
  type = string
  description = "Cloud function service account name"
}

variable "asset_list" {
  type = list(string)
}