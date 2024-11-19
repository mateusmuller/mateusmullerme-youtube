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
}

provider "proxmox" {
  pm_api_url      = "https://192.168.0.2:8006/api2/json"
  pm_tls_insecure = true
}