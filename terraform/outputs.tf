output "kafka_external_ips" {
  description = "External IPs of Kafka nodes"
  value = {
    for instance in yandex_compute_instance.kafka :
    instance.name => instance.network_interface[0].nat_ip_address
  }
}

output "db_external_ip" {
  description = "External IP of DB server"
  value       = yandex_compute_instance.db.network_interface[0].nat_ip_address
}

output "web_external_ip" {
  description = "External IP of Web server"
  value       = yandex_compute_instance.web.network_interface[0].nat_ip_address
}

output "internal_ips" {
  description = "Internal IPs of all instances"
  value = {
    kafka = {
      for instance in yandex_compute_instance.kafka :
      instance.name => instance.network_interface[0].ip_address
    }
    db    = yandex_compute_instance.db.network_interface[0].ip_address
    web   = yandex_compute_instance.web.network_interface[0].ip_address
  }
} 