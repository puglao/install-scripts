# Install awscli
function install_awscli() {
    echo -e "######## Start of ${FUNCNAME[0]} ########"
    if ! command_exist aws; then
        echo "installing aws"
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
        rm awscliv2.zip
        rm -rf aws
    else
        echo "detect existing aws"    
    fi
    get_version aws
    echo -e "######## End of ${FUNCNAME[0]} ########"
}