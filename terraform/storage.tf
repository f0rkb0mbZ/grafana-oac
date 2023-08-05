resource "google_storage_bucket" "loki-storage" {
  name = "loki-store-23450782"
  location = "ASIA-SOUTH1"
  public_access_prevention = "enforced"
  force_destroy = true
}