# CityTrees.Umbrella

## Install erlang, elixir and nodejs

### Instalation asdf [asdf](https://github.com/asdf-vm/asdf)

```bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.9.0

```

### Add asdf to .bashrc

```
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash
```

### Install erlang, elixir and nodejs

```bash
export KERL_CONFIGURE_OPTIONS="--without-javac --without-wx"

asdf plugin add erlang
asdf install erlang latest
asdf global erlang 24.2.1

asdf plugin add elixir
asdf install elixir latest
asdf global elixir 1.13.3-otp-24

asdf plugin add nodejs
asdf install nodejs 16.14.0
asdf global nodejs 16.14.0

asdf install
```

### Verify instalation by running:

```bash
node -v
iex -v
elixir -v
```

## Install PostgresSQL


## Install vscode plugins

- [Elixr LS](https://marketplace.visualstudio.com/items?itemName=JakeBecker.elixir-ls)
- [Credo](https://marketplace.visualstudio.com/items?itemName=pantajoe.vscode-elixir-credo) 
- [Eslint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
- [SpellCheck](https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker)
