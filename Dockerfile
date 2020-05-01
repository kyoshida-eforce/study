FROM ubuntu:18.04
ENV APP_PATH /app
WORKDIR $APP_PATH
RUN apt update \
  && apt upgrade -y \ 
  && apt install -y software-properties-common \
  && add-apt-repository ppa:neovim-ppa/unstable \
  && apt install -y \
  python3 \
  python3-pip \
  neovim \
  tree \
  mosquitto \
  mosquitto-clients \
  unzip \
  locales \
  curl \
  git \
  npm
RUN echo "ja_JP UTF-8" > /etc/locale.gen && locale-gen
ENV LANG ja_JP.UTF-8
COPY requirements.txt $APP_PATH
RUN pip3 install -r requirements.txt
RUN pip3 install --upgrade msgpack
WORKDIR /root
RUN git clone --depth 1 https://github.com/kyoshida-eforce/neovim-config.git .config
COPY bash_aliases /root/.bash_aliases
WORKDIR $APP_PATH
