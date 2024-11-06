# Terraform

## Credenciais

Você pode conferir a documentação atualizada [aqui](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs#creating-the-proxmox-user-and-role-for-terraform).

Para criar o usuário:

```bash
$ pveum role add TerraformProv -privs "Datastore.AllocateSpace Datastore.AllocateTemplate Datastore.Audit Pool.Allocate Sys.Audit Sys.Console Sys.Modify VM.Allocate VM.Audit VM.Clone VM.Config.CDROM VM.Config.Cloudinit VM.Config.CPU VM.Config.Disk VM.Config.HWType VM.Config.Memory VM.Config.Network VM.Config.Options VM.Migrate VM.Monitor VM.PowerMgmt SDN.Use"
$ pveum user add terraform-prov@pve --password <password>
$ pveum aclmod / -user terraform-prov@pve -role TerraformProv

```

Depois, basta criar um token de autenticação para este usuário.

**Datacenter → Permissions → API Tokens → Add → desmarcar Privilege Separation.**

Coloque essas credenciais dentro de um arquivo `.env`.

```bash
export PM_API_TOKEN_ID="<token id>"
export PM_API_TOKEN_SECRET="<token secret>"
```

Então, você só precisa garantir que essas variáveis existam onde você for executar o Terraform. Para usar localmente, eu costumo fazer o seguinte:

```bash
$ source .env
$ terraform init
$ terraform apply
```