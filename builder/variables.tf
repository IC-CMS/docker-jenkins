variable "dev_box_key_file" {
  default = ""
}

variable "dev_box_cert_file" {
  default = ""
}

variable "org" {
  default = "cms"
}

variable "project" {
  default = "jenkins"
}

variable "env" {
  default = "dev"
}

variable "ssh_key_file" {
  default = "/app/id_rsa"
}

variable "cacert" {
  default = ""
}

variable "build_project" {
  default = "docker-jenkins"
}
