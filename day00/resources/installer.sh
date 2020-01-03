#!/bin/bash
#
# Ensures the correct Python version is intalled using miniconda

INSTALL_DIR="/goinfre/$USER/miniconda3"

function install_python {
	mkdir -p $INSTALL_DIR
    curl -s -o ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
    bash ~/miniconda.sh -b -p $INSTALL_DIR
    echo "Python has been installed."
    rm ~/miniconda.sh
    exit 0
}

if [ "$1" == "install-python" ]; then
    if command -v python3 &>/dev/null; then
        echo "Python is already installed, do you want to reinstall it?"
        read -p "[yes|no]> " choice
    case $choice in
        [Nn]o )
            echo "exit."
            exit 0
            ;;
        [Yy]es )
            rm -rf $INSTALL_DIR
            echo "Python has been removed."
            install_python
            ;;
    esac
    else
        install_python
    fi
else
    echo "Usage: ./installer.sh install-python"
    exit 0
fi
