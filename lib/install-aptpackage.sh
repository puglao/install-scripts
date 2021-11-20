# Install apt packages
function install_aptpackage() {
    echo -e "######## Start of ${FUNCNAME[0]} ########"
    readarray -t packages < apt-packages
    for package in "${packages[@]}"; do
        install_package $package
    done
    echo -e "######## End of ${FUNCNAME[0]} ########\n"
}


function install_package() {
    echo "------------------------------------"
    PACKAGE=$1
    if ! command_exist $PACKAGE; then
        echo "installing $PACKAGE"
        sudo apt install $PACKAGE -y
    else
        echo "detect existing $PACKAGE"
    fi

    if dpkg -s $PACKAGE &> /dev/null; then
        dpkg -s $PACKAGE | grep Version
    else
        get_version $PACKAGE
    fi
}

function get_version() {
    PACKAGE=$1
    if $PACKAGE --version &>/dev/null; then
        $PACKAGE --version | head -1
    elif $PACKAGE -v &>/dev/null; then
        $PACKAGE -v | head -1
    else
        $PACKAGE version | head -1
    fi
}