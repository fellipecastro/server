#!/bin/bash
sudo locale-gen UTF-8

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

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
sudo echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee \
    /etc/apt/sources.list.d/mongodb.list

sudo apt-get install aptitude -y
sudo aptitude update -y
sudo aptitude safe-upgrade -y

sudo aptitude install build-essential python-dev python3-dev python-setuptools python3-setuptools \
    ipython ipython3 tree git exuberant-ctags supervisor nginx postgresql postgresql-contrib \
    golang redis-server mongodb-org tig python-pip python3-pip ntp -y

sudo aptitude clean -y

git config --global push.default simple
git config --global core.editor vim

sudo pip2 install virtualenv virtualenvwrapper flake8 ipdb httpie argparse
sudo pip3 install flake8 ipdb httpie argparse

echo -e '\nsource /usr/local/bin/virtualenvwrapper.sh' >> ~/.bashrc

git clone https://github.com/rafael84/vim-ide.git ~/vim-ide
source ~/vim-ide/install.sh
touch ~/.vimrc_extra

git clone https://github.com/powerline/fonts.git ~/fonts
source ~/fonts/install.sh
git clone https://github.com/milkbikis/powerline-shell.git ~/powerline-shell
cp ~/powerline-shell/config.py{.dist,}
cd ~/powerline-shell/ && ./install.py && cd -
ln -s ~/powerline-shell/powerline-shell.py ~/powerline-shell.py
echo -e '\nfunction _update_ps1() {\n    export PS1="$(~/powerline-shell.py $? 2> /dev/null)"\n}' \
    >> ~/.bashrc
echo -e '\nexport PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"' >> ~/.bashrc
echo -e 'alias python2="python"' >> ~/.bash_aliases
sed -i '1s/.*/#!\/usr\/bin\/env python2/' ~/powerline-shell/powerline-shell.py

git clone https://github.com/fellipecastro/ubuntu-updater.git ~/ubuntu-updater
ln -s ~/ubuntu-updater/updater.sh ~/updater.sh

sudo reboot
