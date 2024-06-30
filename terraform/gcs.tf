resource "google_storage_bucket" "cloud_functions_dev" {
  project  = var.project_id
  name     = "cloud_functions_dev"
  location = "US"
}
