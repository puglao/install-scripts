# Install Terraform
function install_terraform() {
    echo -e "######## Start of ${FUNCNAME[0]} ########"
    if ! command_exist terraform; then
        echo "installing terraform"
        release_url="https://github.com/hashicorp/terraform/releases"
        target_version=$(curl -s $release_url | grep -E 'href="/hashicorp/terraform/releases/tag/v[0-9]+\.[0-9]+\.[0-9]+"' | sed -E 's/.*\/hashicorp\/terraform\/releases\/tag\/v([0-9\.]+)".*/\1/g' | head -1)
        curl -s "https://releases.hashicorp.com/terraform/${target_version}/terraform_${target_version}_linux_amd64.zip" -o terraform.zip
        unzip -q terraform.zip
        sudo install -o root -g root -m 0755 terraform /usr/local/bin/terraform
        rm terraform terraform.zip
    else
        echo "detect existing terraform"
    fi
    terraform --version | head -1
    echo -e "######## End of ${FUNCNAME[0]} ########"
}