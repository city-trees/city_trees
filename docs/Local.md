# Local setup


## Install erlang, elixir, nodejs and postgres

### Instalation asdf [asdf](https://github.com/asdf-vm/asdf)

This assume Ubuntu or Debian system 


```bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0

```

Below plugins will be used 
- [erlang](https://github.com/asdf-vm/asdf-erlang)
- [elixir](https://github.com/asdf-vm/asdf-elixir)
- [nodejs](https://github.com/asdf-vm/asdf-nodejs)

Install asdf plugins

``` bash
asdf plugin add erlang
asdf plugin add elixir
asdf plugin add nodejs
asdf plugin-add terraform
```

### Add asdf to .bashrc

```
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash
```

### Install pg build dependencies and phoenix

```bash
sudo apt-get install linux-headers-$(uname -r) 
sudo apt-get install build-essential libssl-dev libreadline-dev 
sudo apt-get install zlib1g-dev libcurl4-openssl-dev uuid-dev
sudo apt-get install inotify-tools
```

### Install erlang, elixir, nodejs, pg

```bash
export KERL_CONFIGURE_OPTIONS="--without-javac --without-wx"

asdf install erlang 25.0.1
asdf global erlang 25.0.1

asdf install elixir 1.13.4-otp-25
asdf global elixir 1.13.4-otp-25

asdf install nodejs 18.4.0
asdf global nodejs 18.4.0

asdf install terraform 1.1.7
asdf global terraform 1.1.7

asdf install
```

### Verify installation by running:

Before verification, open new shell to source asdf.

```bash
node --version
iex --version
elixir --version
```

## Setup PostgresSQL

On ubuntu linux use below to install and configure postgres

```bash
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get -y update
sudo apt-get -y install postgresql-14
sudo apt-get install postgis postgresql-14-postgis-3

sudo -u postgres psql << EOF
  CREATE DATABASE city_trees;
  CREATE USER city_trees WITH ENCRYPTED PASSWORD 'city_trees';
  GRANT ALL PRIVILEGES ON DATABASE city_trees TO city_trees;
EOF

sudo -u postgres psql city_trees << EOF
  CREATE EXTENSION postgis;
EOF
```

## Install vscode plugins

- [Elixr LS](https://marketplace.visualstudio.com/items?itemName=JakeBecker.elixir-ls)
- [Credo](https://marketplace.visualstudio.com/items?itemName=pantajoe.vscode-elixir-credo) 
- [Eslint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
- [SpellCheck](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)
- [Phenix](https://marketplace.visualstudio.com/items?itemName=phoenixframework.phoenix)
- [Terraform](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
