terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc4"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.5.2"
    }
  }
  backend "s3" {
    bucket = "proxmox-state"
    key    = "terraform.tfstate"
    region = "placeholder"

    endpoints = {
      s3 = "http://minio:9000"
    }

    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    force_path_style            = true
  }
}

provider "proxmox" {
  pm_api_url      = "https://192.168.0.2:8006/api2/json"
  pm_tls_insecure = true
}