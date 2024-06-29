terraform {
  backend "gcs" {
    bucket  = "roimb-devopsuser10-dev-tf-state"
    prefix  = "terraform/state"
  }
}