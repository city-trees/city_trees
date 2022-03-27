# Local setup


## Install erlang, elixir, nodejs and postgres

### Instalation asdf [asdf](https://github.com/asdf-vm/asdf)

This assume Ubuntu or Debian system 


```bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0

```

Below plugins will be used 
- [erlang](https://github.com/asdf-vm/asdf-erlang)
- [postgres](https://github.com/smashedtoatoms/asdf-postgres)
- [elixir](https://github.com/asdf-vm/asdf-elixir)
- [nodejs](https://github.com/asdf-vm/asdf-nodejs)

Install asdf plugins

``` bash
asdf plugin add erlang
asdf plugin add elixir
asdf plugin add nodejs
asdf plugin-add postgres
asdf plugin-add terraform
```

### Add asdf to .bashrc

```
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash
```

### Install pg build dependacies and pheonix

```bash
sudo apt-get install linux-headers-$(uname -r) 
sudo apt-get install build-essential libssl-dev libreadline-dev 
sudo apt-get install zlib1g-dev libcurl4-openssl-dev uuid-dev
sudo apt-get install inotify-tools
```

### Install erlang, elixir, nodejs, pg

```bash
export KERL_CONFIGURE_OPTIONS="--without-javac --without-wx"

asdf install erlang 24.2.1
asdf global erlang 24.2.1

asdf install elixir 1.13.3-otp-24
asdf global elixir 1.13.3-otp-24

asdf install nodejs 16.14.0
asdf global nodejs 16.14.0

asdf install postgres 14.2
asdf global postgres 14.2

asdf install terraform 1.1.7
asdf global terraform 1.1.7

asdf install
```

### Verify instalation by running:

Before verification, open new shell to source asdf.

```bash
node --version
iex --version
elixir --version
pg_ctl --version
```

## Setup PostgresSQL

When postgres is installed via asdf, database would run under current user

### Start postgres server

```
~/.asdf/installs/postgres/14.2/bin/pg_ctl -D ~/.asdf/installs/postgres/14.2/data -l pg.log start
```

### Create database for local dev

```
createdb city_trees_dev
psql -l

```
### Create database user

```
psql -d city_trees_dev
create user city_trees_dev with encrypted password 'city_trees_dev';
grant all privileges on database city_trees_dev to city_trees_dev;
```

## Install vscode plugins

- [Elixr LS](https://marketplace.visualstudio.com/items?itemName=JakeBecker.elixir-ls)
- [Credo](https://marketplace.visualstudio.com/items?itemName=pantajoe.vscode-elixir-credo) 
- [Eslint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
- [SpellCheck](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)
- [Phenix](https://marketplace.visualstudio.com/items?itemName=phoenixframework.phoenix)
- [Terraform](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
