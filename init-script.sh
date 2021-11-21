#!/bin/bash

SHELL_RC=~/.zshrc
ALIAS_FILE=~/.alias

# Load library
for f in lib/*; do echo "source $f"; source $f; done


# apt update for following step
# sudo apt update
# install_aptpackage
# install_zsh
# install_kubectl
# set_alias 'alias k=kubectl'
# install_awscli
# install_terraform
# install_go
# install_terragrunt