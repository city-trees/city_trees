# Terraform managed infrastructure

## Workspaces

This project use two workspaces
- dev
- prod

To change workspace:

```
terraform workspace select dev
```

## Output

Once servers are deployed, we can use `terraform output` to get servers details.

```hcl
server_apps = [
  {
    "floating_ip" = "195.201.250.204"
    "id" = "20523485"
    "internal_ip" = "167.235.57.78"
    "labels" = tomap({
      "env" = "dev"
      "project" = "city_trees"
    })
  },
]
```
Prod:

```
server_apps = [
  {
    "floating_ip" = "195.201.250.214"
    "id" = "20522699"
    "internal_ip" = "167.235.57.53"
    "labels" = tomap({
      "env" = "prod"
      "project" = "city_trees"
    })
  },
]

```

To get server fingerprints we can use `ssh-keyscan`

```sh
ssh-keyscan -p 2211 -t ed25519 195.201.250.204
```