#!/bin/bash

# Обновление списка пакетов
echo "Обновление списка пакетов..."
sudo apt update

# Обновление установленных пакетов
echo "Обновление установленных пакетов..."
sudo apt upgrade -y

# Добавление репозитория universe, если он уже не добавлен
echo "Добавление репозитория universe..."
sudo add-apt-repository universe -y

# Повторное обновление списка пакетов после добавления нового репозитория
echo "Обновление списка пакетов после добавления репозитория universe..."
sudo apt update

git clone https://github.com/Argen7umCode/linux-setup.git

# Установка GNOME Tweaks Tool
echo "Установка GNOME Tweaks..."
sudo apt install gnome-tweaks -y

echo "Установка Python"
sudo add-apt-repository ppa:deadsnakes/ppa -y
sudo apt update
sudo apt install python3.10-venv -y
sudo apt install python3.12 -y
sudo apt install python3.12-venv -y
sudo apt install python3.13 -y
sudo apt install python3.13-venv -y

# Добавление репозитория для Visual Studio Code и установка
echo "Добавление репозитория и установка Visual Studio Code..."
sudo apt install wget gpg -y  # Убедитесь, что у вас установлены wget и gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt update
sudo apt install code -y # Установка Visual Studio Code


echo "Настройка GIT"
echo "Введите name"
read name
git config --global name.name "$name"

echo "Введите email"
read email
git config --global name.email "$email"


echo "Настройка zsh"
sudo apt install -y zsh
RUNZSH=no CHSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
cp linux-setup/.zshrc ~/
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git 
echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
source ./zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

sudo chsh -s $(which zsh) $USER
exec zsh


echo "Настройка telegram"
sudo add-apt-repository ppa:atareao/telegram -y
sudo apt update -y
sudo apt install telegram -y
sudo apt install snapd -y

sudo apt install wg-quick
sudo snap install dbeaver-ce
sudo snap install postman
sudo snap install obsidian --classic
sudo snap install google

sudo cp /var/lib/snapd/desktop/applications/*.desktop ~/.local/share/applications/
sudo add-apt-repository ppa:appimagelauncher-team/stable -y
sudo apt-get update -y
sudo apt-get install appimagelauncher -y

curl -LsSf https://astral.sh/uv/install.sh | sh

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo groupadd docker
sudo usermod -aG docker $USER -y
newgrp docker -y
sudo systemctl enable docker.service -y
sudo systemctl enable containerd.service -y

sudo groupadd docker

echo "Скрипт выполнен."
