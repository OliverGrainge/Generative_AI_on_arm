#!/bin/bash

# Update and upgrade the package list
sudo apt update
sudo apt upgrade -y

# Install essential development packages
sudo apt install -y wget build-essential libssl-dev libbz2-dev libreadline-dev libsqlite3-dev \
zlib1g-dev libncurses5-dev libncursesw5-dev libffi-dev libgdbm-dev liblzma-dev uuid-dev tk-dev

# Install perf for performance profiling
sudo apt install -y linux-perf

# Verify perf installation
if command -v perf >/dev/null 2>&1; then
    echo "perf installed successfully!"
else
    echo "Error: perf installation failed."
    exit 1
fi

# Download and build Python 3.12.0
cd /tmp
wget https://www.python.org/ftp/python/3.12.0/Python-3.12.0.tgz

tar -xf Python-3.12.0.tgz
cd Python-3.12.0

./configure --enable-optimizations
sudo make altinstall

# Create a Python virtual environment
python3.12 -m venv venv

# Activate the virtual environment
source venv/bin/activate

# Install Python packages
python3.12 -m pip install numpy matplotlib pandas torch transformers jupyterlab 

echo "Setup script completed successfully!"
