resource "google_service_account" "service_account" {
  account_id   = var.function_sa
}

resource "google_project_iam_member" "function_sa_binding" {
  project       = var.project_id
  role          = "roles/viewer"
  member        = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_service_account" "cloud_build" {
  account_id   = "cloud_build"
  display_name = "Service account for Cloud build deployments"
}

resource "google_project_iam_member" "service_account_roles" {
  for_each = toset([
    "roles/cloudasset.owner",
    "roles/cloudbuild.builds.builder",
    "roles/editor",
    "roles/resourcemanager.projectIamAdmin",
    "roles/pubsub.admin",
    "roles/iam.serviceAccountAdmin",
    "roles/storage.admin",
    "roles/viewer"
  ])
  project = var.project_id
  member  = "serviceAccount:${google_service_account.cloud_build.email}"
  role    = each.key
}