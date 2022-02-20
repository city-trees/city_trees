FROM ubuntu:jammy

RUN apt-get update -y \
    && apt-get install -y \ 
      build-essential \
      git \
      curl \ 
      automake \ 
      autoconf \ 
      ncurses-dev \
      libncurses5-dev \ 
      libssl-dev \
      unzip \
      locales \
    && apt-get clean \
    && rm -f /var/lib/apt/lists/*_*

RUN git clone https://github.com/asdf-vm/asdf.git ~/.asdf
RUN echo -e '\nsource $HOME/.asdf/asdf.sh' >> ~/.bashrc

# Only way to customize non interactive shells
# @see https://hhoeflin.github.io/2020/08/19/bash-in-docker/
ENV BASH_ENV=~/.asdf/asdf.sh

SHELL ["/bin/bash", "-c"] 

ENV KERL_CONFIGURE_OPTIONS="--without-javac --without-wx"
ENV KERL_BUILD_DOCS="no"

RUN . $HOME/.asdf/asdf.sh \
  && asdf plugin add erlang \
  && asdf install erlang 24.2.1 \
  && asdf global erlang 24.2.1
  
RUN . $HOME/.asdf/asdf.sh \ 
  && asdf plugin add elixir \
  && asdf install elixir 1.13.3-otp-24 \
  && asdf global elixir 1.13.3-otp-24

RUN . $HOME/.asdf/asdf.sh \
  && asdf plugin add nodejs \ 
  && asdf install nodejs 16.14.0 \
  && asdf global nodejs 16.14.0

# Setup locales to ensure that elixir to notuse latin-1
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

# Install hex + rebar
RUN mix local.hex --force && mix local.rebar --force

CMD ["bash"]