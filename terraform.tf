terraform {
  required_version = ">= 0.12"

  cloud {
    organization = "GodEye"

    workspaces {
      name = "Jenkins"
    }
  }
}
