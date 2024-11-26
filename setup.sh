sudo apt update
sudo apt upgrade

sudo apt install wget build-essential libssl-dev libbz2-dev libreadline-dev libsqlite3-dev zlib1g-dev libncurses5-dev libncursesw5-dev libffi-dev libgdbm-dev liblzma-dev uuid-dev tk-dev

cd /tmp
wget https://www.python.org/ftp/python/3.12.0/Python-3.12.0.tgz

tar -xf Python-3.12.0.tgz
cd Python-3.12.0

./configure --enable-optimizations
sudo make altinstall


python3.12 -m venv pyenv

source pyenv/bin/activate 

python3.12 -m pip install numpy ipykernel torch
