resource "google_compute_network" "grafana_oss_vpc" {
    name = "grafana-oss-vpc"
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "default" {
    name = "grafana-oss-subnet"
    ip_cidr_range = "10.0.0.0/24"
    region = "asia-south1"
    network = google_compute_network.grafana_oss_vpc.id
}

resource "google_compute_firewall" "grafana_oss_ingress_rules" {
    name = "allow-ssh-http-https-icmp"
    allow {
      ports = ["22"]
      protocol = "tcp"
    }

    allow {
      ports = [ "80", "443", "3000", "3100", "9090", "9100" ]
      protocol = "tcp"
    }

    allow {
      protocol = "icmp"
    }
    direction = "INGRESS"
    network = google_compute_network.grafana_oss_vpc.id
    source_ranges = ["0.0.0.0/0"]
}