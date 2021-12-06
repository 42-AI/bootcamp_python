#!/bin/bash

function which_dl {
    if uname -s | grep -iqF Darwin; then
        echo "Miniconda3-latest-MacOSX-x86_64.sh"
    else
        echo "Miniconda3-latest-Linux-x86_64.sh"
    fi
}

function which_shell {
    if echo $SHELL | grep -iqF zsh; then
        echo "zsh"
    else
        echo "bash"
    fi
}

function set_conda {
    HOME=$(echo ~)
    INSTALL_PATH="/goinfre"
    MINICONDA_PATH=$INSTALL_PATH"/miniconda3/bin"
    PYTHON_PATH=$(which python)
    REQUIREMENTS="jupyter numpy pandas pycodestyle"
    SCRIPT=$(which_dl)
    MY_SHELL=$(which_shell)
    DL_LINK="https://repo.anaconda.com/miniconda/"$SCRIPT
    DL_LOCATION="/tmp/"


    if $MINICONDA_PATH/conda info --envs | grep -iqF 42AI; then
	    echo "nothing to be done :)"
        return
    fi
    if [ ! -d $MINICONDA_PATH ]; then
        if [ ! -f $DL_LOCATION$SCRIPT ]; then
            cd $DL_LOCATION
		    curl -LO $DL_LINK
            cd -
        fi
	    sh $DL_LOCATION$SCRIPT -b -p $INSTALL_PATH"/miniconda3" || true
	fi
    $MINICONDA_PATH/conda init $MY_SHELL
    $MINICONDA_PATH/conda config --set auto_activate_base false
    if [ $MY_SHELL == "zsh" ]; then
        source ~/.zshrc
    else
        source ~/.bash_profile
    fi
    conda create --name 42AI python=3.7 jupyter numpy pandas pycodestyle
}

set_conda
