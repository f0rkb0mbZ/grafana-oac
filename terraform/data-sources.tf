data "google_compute_image" "ubuntu_jammy" {
    family = "ubuntu-2204-lts"
    project = "ubuntu-os-cloud"
}
