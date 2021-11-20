# Install zsh and oh-my-zsh
function install_zsh() {
    echo -e "######## Start of ${FUNCNAME[0]} ########"
    if ! grep -q "/zsh$" /etc/shells; then
        echo "installing zsh"
        sudo apt install zsh -y
        sudo chsh -s $(which zsh) $(whoami)
        echo "installing oh-my-zsh"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    else
        echo "detect existing zsh"
    fi
    zsh --version | head -1
    echo -e "######## End of ${FUNCNAME[0]} ########\n"
}