#!/usr/bin/env bash

# Description: This script is used to setup the development environment for the project.


check_python_version() {
    # Check python version if greater or equal than 3.10, otherwise exit
    python_version=$(python3 -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
    if python3 -c "import sys; sys.exit(not (sys.version_info >= (3, 10)))"; then
        echo "Python version is $python_version"
        return 0
    else
        echo "Python version is $python_version, but 3.10 or greater is required"
        return 1
    fi
}

activate_venv() {
    # Check if venv directory exists, otherwise create it. Then activate venv
    if [ -d "venv" ]; then
        echo "venv directory exists"
    else
        echo "venv directory does not exist, creating it now"
        python3 -m venv venv
    fi
    echo "activating venv"
    source ./venv/bin/activate
}

install_dev_dependencies() {
    # Install development dependencies
    echo "installing development dependencies"
    # Check if pip3 version is greater or equal than 21.2.4, otherwise upgrade it
    pip3_version=$(pip3 --version | awk '{print $2}')
    if python3 -c "import sys; sys.exit(not (sys.version_info >= (21, 2, 4)))"; then
        echo "pip3 version is $pip3_version"
    else
        echo "pip3 version is $pip3_version, but 21.2.4 or greater is required"
        pip3 install --upgrade pip
    fi
    # Check if ruff is installed, otherwise install it
    if ! command -v ruff &> /dev/null
    then
        echo "ruff could not be found, installing it now"
        pip3 install ruff
    else
        echo "ruff is installed"
    fi

    # Check if autopep8 is installed, otherwise install it
    if ! command -v autopep8 &> /dev/null
    then
        echo "autopep8 could not be found, installing it now"
        pip3 install --upgrade autopep8
    else
        echo "autopep8 is installed"
    fi
}

check_python_version

if [ $? -eq 0 ]; then
    activate_venv
    install_dev_dependencies
fi
