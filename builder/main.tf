provider "consul" {
  address 	= "127.0.0.1:8500"
  version	= "2.1.0"
}

provider "vault" {
  address	= "http://127.0.0.1:8200"
  token		= "e8f5102d-c5fe-55c4-7b0e-036e4ec41f97"
  version	= "1.1.0"
}

resource "consul_service" "jenkins" {
  name    = "jenkins"
  node    = "${consul_node.compute.name}"
  port    = 80
  tags    = ["tag0"]

}



resource "consul_node" "compute" {
  name    = "jenkins"
  address = "www.google.com"

}
