variable "cloud_id" {
  description = "Cloud ID"
  type        = string
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
}

variable "zone" {
  description = "Zone"
  type        = string
  default     = "ru-central1-a"
}

variable "ubuntu_image" {
  description = "Ubuntu image ID"
  type        = string
  default     = "fd8snjpoq85qqv0mk9gi" # Ubuntu 22.04 LTS
}

variable "public_key_path" {
  description = "Path to public key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

# Ресурсы для Kafka нод
variable "kafka_resources" {
  description = "Resources for Kafka nodes"
  type = object({
    cores         = number
    memory       = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory       = 4
    core_fraction = 20
  }
}

# Ресурсы для ClickHouse
variable "db_resources" {
  description = "Resources for ClickHouse server"
  type = object({
    cores         = number
    memory       = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory       = 4
    core_fraction = 20
  }
}

# Ресурсы для Web сервера
variable "web_resources" {
  description = "Resources for Web server"
  type = object({
    cores         = number
    memory       = number
    core_fraction = number
  })
  default = {
    cores         = 2
    memory       = 2
    core_fraction = 20
  }
}

# Размеры дисков для разных типов серверов
variable "disk_sizes" {
  description = "Disk sizes for different server types"
  type = object({
    kafka = number
    db    = number
    web   = number
  })
  default = {
    kafka = 15
    db    = 20
    web   = 15
  }
}

# Тип дисков
variable "disk_type" {
  description = "Disk type for servers"
  type        = string
  default     = "network-hdd"
} 