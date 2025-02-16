# Настройка провайдера
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "~> 0.100"
    }
  }
}

provider "yandex" {
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.zone
}

# Создание сети
resource "yandex_vpc_network" "network" {
  name = "kafka-network"
}

# Создание подсети
resource "yandex_vpc_subnet" "subnet" {
  name           = "kafka-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

# Kafka кластер
resource "yandex_compute_instance" "kafka" {
  count    = 3
  name     = "kafka${format("%02d", count.index + 1)}"
  hostname = "kafka${format("%02d", count.index + 1)}"

  resources {
    cores         = var.kafka_resources.cores
    memory       = var.kafka_resources.memory
    core_fraction = var.kafka_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image
      size     = var.disk_sizes.kafka
      type     = var.disk_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

# ClickHouse сервер
resource "yandex_compute_instance" "db" {
  name     = "db01"
  hostname = "db01"

  resources {
    cores         = var.db_resources.cores
    memory       = var.db_resources.memory
    core_fraction = var.db_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image
      size     = var.disk_sizes.db
      type     = var.disk_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
}

# Web сервер
resource "yandex_compute_instance" "web" {
  name     = "web01"
  hostname = "web01"

  resources {
    cores         = var.web_resources.cores
    memory       = var.web_resources.memory
    core_fraction = var.web_resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.ubuntu_image
      size     = var.disk_sizes.web
      type     = var.disk_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }
} 