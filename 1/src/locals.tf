
locals {
  vm_web_name = "${var.vm_name_prefix}-${var.vpc_name}-${var.vm_web_name}"
  vm_db_name  = "${var.vm_name_prefix}-${var.vpc_name}-${var.vm_db_name}"
}

