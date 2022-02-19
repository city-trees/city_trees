# CityTrees.Umbrella

## Install erlang and elixir

```bash
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch master
source $HOME/.asdf/asdf.sh
source $HOME/.asdf/completions/asdf.bash

export KERL_CONFIGURE_OPTIONS="\
    --without-javac \
    --without-wx"

asdf plugin add erlang
asdf plugin add elixir

asdf install erlang latest
asdf global erlang latest

asdf install elixir latest
asdf global elixir latest

asdf install

```

## Install vscode plugins

- [Elixr LS](https://marketplace.visualstudio.com/items?itemName=JakeBecker.elixir-ls)
- [Credo](https://marketplace.visualstudio.com/items?itemName=pantajoe.vscode-elixir-credo) 
- [Eslint](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)
