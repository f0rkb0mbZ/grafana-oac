resource "tls_private_key" "grafana_oss_vm_key" {
  algorithm = "ED25519"
}

resource "local_sensitive_file" "name" {
  content = tls_private_key.grafana_oss_vm_key.private_key_openssh
  filename = "id_ed25519"
  file_permission = "0400"
}