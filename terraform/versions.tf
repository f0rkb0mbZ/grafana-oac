terraform {
  required_providers {
    google = {
        source = "hashicorp/google",
        version = "4.75.1"
    }
    cloudflare = {
        source  = "cloudflare/cloudflare"
        version = "~> 4.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
  }
}