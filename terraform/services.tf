resource google_project_service enabled_services {
  project = var.project_id
  for_each = toset(var.services)
  service = each.value
  disable_on_destroy = false
}