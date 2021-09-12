terraform {
  backend "remote" {
    organization = "chethan-training"

    workspaces {
      name = "mtcdev"
    }
  }
}