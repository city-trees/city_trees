# Terraform managed infrastructure


## Output

Once servers are deployed, we can use `terraform output` to get servers details

```hcl
app_ip_addr = [
  {
    "id" = "20402105"
    "ip" = "167.235.57.78"
  },
]
minio_ip_addr = [
  {
    "id" = "20402103"
    "ip" = "167.235.57.53"
  },
  {
    "id" = "20402104"
    "ip" = "167.235.247.35"
  },
]
minio_volumes = [
  {
    "server_id" = 20402103
    "volume_id" = 19449088
  },
  {
    "server_id" = 20402104
    "volume_id" = 19449087
  },
]
```

To get server fingerprints we can use `ssh-keyscan`

```sh
ssh-keyscan -p 2211 -t ed25519 167.235.57.53

```