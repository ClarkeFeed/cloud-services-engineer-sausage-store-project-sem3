resource "yandex_compute_disk" "sausage-store-dev-vm" {
  name     = "sausage-store-dev-vm"
  type     = "network-ssd"
  size     = 10
  image_id = "fd82odtq5h79jo7ffss3"
}

resource "yandex_compute_instance" "sausage-store-dev-vm" {
  name        = "vm-dev"
  platform_id = "standard-v1"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.sausage-store-dev-vm.id
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.sausage_store_dev_subnet.id
    nat = true
  }

  metadata = {
    ssh-keys = "sausagestore:${var.ssh_public_key}"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = base64decode(var.ssh_private_key)
    host        = self.network_interface.0.nat_ip_address
  }

  #Test egress

  provisioner "remote-exec" {
    inline = [ 
      "ping -c 5 ya.ru",
      "curl https://ya.ru"
     ]
  }
}