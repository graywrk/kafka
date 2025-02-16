resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tpl",
    {
      kafka_nodes = [
        for instance in yandex_compute_instance.kafka : {
          name = instance.name
          ip   = instance.network_interface[0].nat_ip_address
        }
      ]
      db_node = {
        name = yandex_compute_instance.db.name
        ip   = yandex_compute_instance.db.network_interface[0].nat_ip_address
      }
      web_node = {
        name = yandex_compute_instance.web.name
        ip   = yandex_compute_instance.web.network_interface[0].nat_ip_address
      }
    }
  )
  filename = "../inventory_yandex.ini"
} 