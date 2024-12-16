#!/bin/bash

# Update and upgrade the package list
echo "Updating and upgrading the system..."
sudo apt update
sudo apt upgrade -y

# Install essential development packages
echo "Installing required packages..."
sudo apt install -y wget build-essential libssl-dev libbz2-dev libreadline-dev libsqlite3-dev \
    zlib1g-dev libncurses-dev libffi-dev libgdbm-dev liblzma-dev uuid-dev tk-dev python3.12-venv linux-tools-common linux-tools-$(uname -r) python3-pip libblas-dev

sudo apt -y install cmake
# Verify perf installation
if command -v perf >/dev/null 2>&1; then
    echo "perf installed successfully."
else
    echo "Error: perf installation failed."
    exit 1
fi

# Check if Python 3.12 is already installed
if ! command -v python3.12 >/dev/null 2>&1; then
    echo "Downloading and building Python 3.12..."
    cd /tmp
    if [ ! -f /tmp/Python-3.12.0.tgz ]; then
        wget https://www.python.org/ftp/python/3.12.0/Python-3.12.0.tgz
    else
        echo "Python 3.12 source archive already exists. Skipping download."
    fi

    tar -xf Python-3.12.0.tgz
    cd Python-3.12.0
    ./configure --enable-optimizations
    sudo make altinstall
else
    echo "Python 3.12 is already installed. Skipping build."
fi

# Check if virtual environment already exists
if [ -d my_env ]; then
    echo "Removing existing virtual environment..."
    rm -rf my_env
fi

# Create the virtual environment
echo "Creating Python virtual environment..."
python3.12 -m venv my_env

# Verify if the virtual environment was created successfully
if [ ! -f my_env/bin/activate ]; then
    echo "Error: Virtual environment creation failed. Check your Python installation."
    exit 1
fi

# Activate the virtual environment and install Python packages
if [ -d my_env ]; then
    echo "Activating virtual environment and installing required Python packages..."
    . my_env/bin/activate
    python3.12 -m pip install --upgrade pip --break-system-packages
    python3.12 -m pip install --upgrade numpy matplotlib pandas torch transformers jupyterlab ipykernel ipywidgets seaborn --break-system-packages
else
    echo "Error: Virtual environment directory 'my_env' does not exist."
    exit 1
fi

echo "Setup script completed successfully!"
