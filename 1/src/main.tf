resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

# WEB subnet
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

# DB subnet
resource "yandex_vpc_subnet" "db" {
  name           = var.vm_db_subnet_name
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = [var.vm_db_cidr]
}

# WEB image
data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_image_family
}

# DB image
data "yandex_compute_image" "db" {
  family = var.vm_db_image_family
}

# WEB VM
resource "yandex_compute_instance" "platform" {
  name        = local.vm_web_name
  platform_id = var.vm_web_platform_id

  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
  }

  metadata = var.metadata
}

# DB VM
resource "yandex_compute_instance" "db" {
  name        = local.vm_db_name
  platform_id = var.vm_db_platform_id
  zone        = var.vm_db_zone

  resources {
    cores         = var.vms_resources.db.cores
    memory        = var.vms_resources.db.memory
    core_fraction = var.vms_resources.db.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.db.image_id
    }
  }

  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.db.id
    nat       = var.vm_db_nat
  }

  metadata = var.metadata
}
