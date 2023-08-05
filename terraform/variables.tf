variable "cloudflare_api_token" {
    type = string
    default = "<your_cloudflare_api_token>"
}
variable "cloudflare_zone_id" {
  type = string
  default = "<your_cloudflare_zone_id>"
}

variable "grafana_domain_name" {
  type = string
  default = "<your_grafana_domain_name>"
}

variable "webmaster_email" {
  type = string
  default = "<your_webmaster_email_to_get_ssl_certificate>"
}
