provider "docker" {
   host = "unix:///var/run/docker.sock"
}

resource "docker_container" "jenkins" {
  name = "jenkins"
  image = "jenkins:test"
  ports {
    internal = 8080
    external = 8082
  }
}
