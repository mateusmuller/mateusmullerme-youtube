locals {
  # global configurations
  agent        = 1
  cidr         = "192.168.0.0/24"
  onboot       = true
  proxmox_node = "thor"
  scsihw       = "virtio-scsi-pci"
  template     = "ubuntu-2204-cloud-init"

  bridge = {
    interface = "vmbr0"
    model     = "virtio"
  }
  disks = {
    main = {
      backup  = true
      format  = "raw"
      type    = "disk"
      storage = "local-lvm"
      slot    = "scsi0"
    }
    cloudinit = {
      backup  = false
      format  = "raw"
      type    = "cloudinit"
      storage = "local-lvm"
      slot    = "ide2"
    }
  }
  # serial is needed to connect via WebGUI console
  serial = {
    id   = 0
    type = "socket"
  }

  # cloud init information to be injected
  cloud_init = {
    user           = "ubuntu"
    password       = "ubuntu"
    ssh_public_key = file("/home/mateus/.ssh/id_rsa.pub")
  }

  # master specific configuration
  masters = {
    # how many nodes?
    count = 3

    name_prefix = "k8s-master-youtube"
    vmid_prefix = 300

    # hardware info
    cores     = 2
    disk_size = "110G"
    memory    = 2048
    sockets   = 1

    # 192.168.0.7x and so on...
    network_last_octect = 70
    tags                = "masters"
  }

  # worker specific configuration
  workers = {
    count = 3

    name_prefix = "k8s-worker-youtube"
    vmid_prefix = 400

    cores     = 1
    disk_size = "110G"
    memory    = 2048
    sockets   = 1

    network_last_octect = 90
    tags                = "workers"
  }
}