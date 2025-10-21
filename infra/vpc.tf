resource "yandex_vpc_network" "sausage-store-dev-network" {}

resource "yandex_vpc_subnet" "sausage_store_dev_subnet" {
  v4_cidr_blocks = ["10.0.0.0/24"]
  network_id     = yandex_vpc_network.sausage-store-dev-network.id
}

resource "yandex_vpc_network" "sausage-store-prod-network" {}

resource "yandex_vpc_subnet" "sausage_store_prod_subnet" {
  v4_cidr_blocks = ["192.168.1.0/24"]
  network_id     = yandex_vpc_network.sausage-store-prod-network.id
}

resource "yandex_vpc_security_group" "prod-sec-group" {
  name        = "prod-sec-group"
  network_id  = yandex_vpc_network.sausage-store-prod-network.id

  ingress {
    protocol       = "TCP"
    description    = "Allow http port"
    v4_cidr_blocks = ["192.168.1.0/24"]
    port           = 8200
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow ssh port"
    v4_cidr_blocks = ["192.168.1.0/24"]
    port           = 22
  }

  egress {
    protocol       = "ANY"
    description    = "Allow all egress trafic"
    v4_cidr_blocks = ["192.168.1.0/24"]
    port = -1
  }
}