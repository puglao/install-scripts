# Install kubectl
function install_kubectl() {
    echo -e "######## Start of ${FUNCNAME[0]} ########"
    if ! command_exist kubectl; then
        echo "installing kubectl"
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
        rm kubectl
    else
        echo "detect existing kubectl"    
    fi
    get_version kubectl
    echo -e "######## End of ${FUNCNAME[0]} ########\n"
}