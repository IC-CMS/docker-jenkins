provider "consul" {
  address 	= "127.0.0.1:8500"
  version	= "2.1.0"
}

provider "vault" {
  address	= "http://127.0.0.1:8200"
  token		= "e8f5102d-c5fe-55c4-7b0e-036e4ec41f97"
  version	= "1.1.0"
}
