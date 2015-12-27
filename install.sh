#!/bin/bash
sudo ufw allow ssh
sudo ufw allow www
sudo ufw enable

sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo sh -c 'echo "/swapfile none swap sw 0 0" >> /etc/fstab'

sudo echo 'America/Sao_Paulo' > /etc/timezone

ssh-keygen -f ~/.ssh/id_rsa -N ''

sudo apt-get update
    
sudo apt-get install zsh git curl apt-transport-https -y

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
sudo echo "deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse" | sudo tee \
    /etc/apt/sources.list.d/mongodb-org-3.0.list
    
curl https://repo.varnish-cache.org/GPG-key.txt | sudo apt-key add -
echo "deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-4.1" >> /etc/apt/sources.list.d/varnish-cache.list

sudo apt-get install aptitude -y
sudo aptitude update -y
sudo aptitude safe-upgrade -y

sudo aptitude install build-essential python-dev python3-dev python-setuptools python3-setuptools \
    ipython ipython3 tree exuberant-ctags supervisor nginx postgresql postgresql-contrib \
    golang golang-go.tools redis-server mongodb-org tig python-pip python3-pip ntp varnish p7zip p7zip-full \
    p7zip-rar lzma lzma-dev tmux vim indicator-keylock rabbitmq-server mysql-client mysql-server \
    libmysqlclient-dev -y

sudo aptitude clean -y

wget -O - https://raw.githubusercontent.com/fellipecastro/.gitconfig/master/.gitconfig > .gitconfig

sudo pip2 install virtualenv virtualenvwrapper flake8 ipdb httpie argparse
sudo pip3 install flake8 ipdb httpie argparse

echo -e '\nsource /usr/local/bin/virtualenvwrapper.sh' >> ~/.zshrc

wget -O - https://raw.githubusercontent.com/fellipecastro/vim-ide/master/install.sh | zsh
touch ~/.vimrc_extra

git clone https://github.com/powerline/fonts.git ~/fonts
source ~/fonts/install.sh

git clone https://github.com/fellipecastro/ubuntu-updater.git ~/ubuntu-updater
ln -s ~/ubuntu-updater/updater.sh ~/updater.sh

gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | zsh -s stable --ruby
rvm --default use current

sudo reboot
