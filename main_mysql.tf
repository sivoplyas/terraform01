terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
required_version = ">=1.8.4" 
}
provider "docker" {
  host = "ssh://ssa@62.84.126.105"
}
resource "random_password" "random_string_root" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}
resource "random_password" "random_string_user" {
  length      = 16
  special     = false
  min_upper   = 1
  min_lower   = 1
  min_numeric = 1
}
resource "docker_image" "mysql" {
  name = "mysql:8"
  keep_locally = true
}
resource "docker_container" "mysql" {
  image = docker_image.mysql.image_id
  name  = "mysql"
  env = [ "MYSQL_ROOT_PASSWORD=${random_password.random_string_root.result}", "MYSQL_DATABASE=wordpress", "MYSQL_USER=wordpress", "MYSQL_PASSWORD=${random_password.random_string_user.result}", "MYSQL_ROOT_HOST=%"]
  ports {
    ip = "127.0.0.1"
    internal = 3306
    external = 3306
  }
}