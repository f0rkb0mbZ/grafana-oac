provider "google" {
  project = "<your_gcp_project>"
  region = "asia-south1"
  credentials = file("<your_gcp_service_account>.json")
}

provider "cloudflare" {
    api_token = var.cloudflare_api_token
}