# WEB VM

variable "vm_web_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "vm_web_name" {
  type    = string
  default = "platform-web"
}

variable "vm_web_platform_id" {
  type    = string
  default = "standard-v1"
}

# variable "vm_web_cores" {
#   type    = number
#   default = 2
# }

# variable "vm_web_memory" {
#   type    = number
#   default = 1
# }

# variable "vm_web_core_fraction" {
#   type    = number
#   default = 5
# }

variable "vm_web_preemptible" {
  type    = bool
  default = true
}

variable "vm_web_nat" {
  type    = bool
  default = true
}

# variable "vm_web_serial_port_enable" {
#   type    = string
#   default = "1"
# }

# variable "vm_web_ssh_user" {
#   type    = string
#   default = "ubuntu"
# }


# DB VM

variable "vm_db_image_family" {
  type    = string
  default = "ubuntu-2004-lts"
}

variable "vm_db_name" {
  type    = string
  default = "platform-db"
}

variable "vm_db_platform_id" {
  type    = string
  default = "standard-v3"
}

# variable "vm_db_cores" {
#   type    = number
#   default = 2
# }

# variable "vm_db_memory" {
#   type    = number
#   default = 2
# }

# variable "vm_db_core_fraction" {
#   type    = number
#   default = 20
# }

variable "vm_db_preemptible" {
  type    = bool
  default = true
}

variable "vm_db_nat" {
  type    = bool
  default = true
}

# variable "vm_db_serial_port_enable" {
#   type    = string
#   default = "1"
# }

# variable "vm_db_ssh_user" {
#   type    = string
#   default = "ubuntu"
# }

variable "vm_db_zone" {
  type    = string
  default = "ru-central1-d"
}

variable "vm_db_subnet_name" {
  type    = string
  default = "develop-db"
}

variable "vm_db_cidr" {
  type    = string
  default = "10.0.2.0/24"
}
variable "vm_name_prefix" {
  type    = string
  default = "netology"
}
variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))

  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
    }

    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
    }
  }
}
variable "metadata" {
  type = map(string)
}
