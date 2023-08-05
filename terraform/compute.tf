resource "google_compute_instance" "grafana_oss_vm" {
  name         = "grafana-oss"
  machine_type = "e2-micro"
  zone         = "asia-south1-a"

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu_jammy.self_link
      size  = 10
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.default.id
    access_config {

    }
  }

  metadata = {
    "ssh-keys" = "grafana:${tls_private_key.grafana_oss_vm_key.public_key_openssh}"
  }

  service_account {
    scopes = ["storage-rw"]
  }

  provisioner "remote-exec" {
    inline = ["echo Infrastruture provisioning is done!"]

    connection {
      host        = self.network_interface.0.access_config.0.nat_ip
      type        = "ssh"
      user        = "grafana"
      private_key = tls_private_key.grafana_oss_vm_key.private_key_openssh
    }
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    environment = {
      "PATH" = "$PATH:/opt/homebrew/bin"
    }
    command = "ansible-galaxy install --roles-path ./playbooks oefenweb.swapfile"
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    environment = {
      "PATH" = "$PATH:/opt/homebrew/bin"
    }
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u grafana -i '${self.network_interface.0.access_config.0.nat_ip},' --private-key ./id_ed25519 playbooks/main.yml --extra-vars \"gcs_bucket_name=${google_storage_bucket.loki-storage.name} domain_name=${var.grafana_domain_name}\""
  }
}

resource "cloudflare_record" "grafana_domain" {
  zone_id = var.cloudflare_zone_id
  name    = "grafana"
  value   = google_compute_instance.grafana_oss_vm.network_interface.0.access_config.0.nat_ip
  type    = "A"
  ttl     = 3600

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    environment = {
      "PATH" = "$PATH:/opt/homebrew/bin"
    }
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u grafana -i '${google_compute_instance.grafana_oss_vm.network_interface.0.access_config.0.nat_ip},' --private-key ./id_ed25519 playbooks/certbot.yml --extra-vars \"domain_name=${var.grafana_domain_name} email=${var.webmaster_email}\""
  }
}



output "grafana_vm_private_key" {
  value     = tls_private_key.grafana_oss_vm_key.private_key_openssh
  sensitive = true
}

output "grafana_vm_private_ip" {
  value = google_compute_instance.grafana_oss_vm.network_interface.0.network_ip
}

output "grafana_vm_public_ip" {
  value = google_compute_instance.grafana_oss_vm.network_interface.0.access_config.0.nat_ip
}

output "grafana_vm_domain_name" {
  value = var.grafana_domain_name
}
