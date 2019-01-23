

variable "dcos_install_mode" {
  description = "specifies which type of command to execute. Options: install or upgrade"
  default     = "install"
}

data "http" "whatismyip" {
  url = "http://whatismyip.akamai.com/"
}

variable "cluster_name" {
  description = "Name of the DC/OS cluster"
  default     = "labroots"
}

variable "ssh_public_key_file" {
  description = "Path to an SSH public key to be used with the instances. Make sure you added this key to your ssh-agent"
  default = "~/.ssh/labsp.pub"
}

variable "dcos_version" {
  description = "Version of dc/os to install"
  default     = "1.12.0"
}

variable "tags" {
  description = "Add custom tags to all resources"
  type        = "map"
  default     = {}
}

variable "admin_ips" {
  description = "Admin Ips"
  type        = "string"
}

module "dcos" {
  source  = "dcos-terraform/dcos/aws"
  version = "~> 0.1"

  dcos_version = "${var.dcos_version}"
  dcos_variant = "open"
  # dcos_variant = "ee"
  dcos_install_mode = "${var.dcos_install_mode}"
  # dcos_license_key_contents = "${file("./license.txt")}"

  dcos_instance_os    = "coreos_1855.5.0"
  cluster_name        = "${var.cluster_name}"
  ssh_public_key_file = "${var.ssh_public_key_file}"
  # admin_ips           = ["${data.http.whatismyip.body}/32"]
  admin_ips           = ["${var.admin_ips}"]
  tags                = "${var.tags}"

  num_masters        = "1"
  num_private_agents = "4"
  num_public_agents  = "2"

  # availability_zones = ["<your_selected_region>a"]

  # dcos_use_proxy = "yes"
  # dcos_http_proxy = "inkeystone.com"
  # dcos_https_proxy = "inkeystone.com"
}

output "cluster-address" {
  value = "${module.dcos.masters-loadbalancer}"
}

output "masters-ips" {
  value = "${module.dcos.masters-ips}"
}

output "public-agents-loadbalancer" {
  value = "${module.dcos.public-agents-loadbalancer}"
}
