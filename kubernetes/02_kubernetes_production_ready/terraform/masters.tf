resource "proxmox_vm_qemu" "masters" {
  count = local.masters.count

  target_node = local.proxmox_node
  vmid        = local.masters.vmid_prefix + count.index
  name = format(
    "%s-%s",
    local.masters.name_prefix,
    count.index
  )

  onboot = local.onboot
  clone  = local.template
  agent  = local.agent

  cores   = local.masters.cores
  sockets = local.masters.sockets
  memory  = local.masters.memory

  ciuser  = local.cloud_init.user
  sshkeys = local.cloud_init.ssh_public_key
  ipconfig0 = format(
    "ip=%s/24,gw=%s",
    cidrhost(
      local.cidr,
      local.masters.network_last_octect + count.index
    ),
    cidrhost(local.cidr, 1)
  )

  network {
    bridge = local.bridge.interface
    model  = local.bridge.model
  }

  scsihw = local.scsihw

  serial {
    id   = local.serial.id
    type = local.serial.type
  }

  disk {
    backup  = local.disks.cloudinit.backup
    format  = local.disks.cloudinit.format
    type    = local.disks.cloudinit.type
    storage = local.disks.cloudinit.storage
    slot    = local.disks.cloudinit.slot
  }

  disk {
    backup  = local.disks.main.backup
    format  = local.disks.main.format
    type    = local.disks.main.type
    storage = local.disks.main.storage
    size    = local.masters.disk_size
    slot    = local.disks.main.slot
  }

  tags = local.masters.tags
}