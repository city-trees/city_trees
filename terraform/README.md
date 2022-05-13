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
```

To get server fingerprints we can use `ssh-keyscan`

```sh
ssh-keyscan -p 2211 -t ed25519 167.235.57.53

```