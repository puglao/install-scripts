# Install go
function install_go() {
    echo -e "######## Start of ${FUNCNAME[0]} ########"
    if ! command_exist go; then
        url='https://golang.org/dl/'
        # expect $1 to input certain version e.g. 1.16.3, no omit/null, install latest stable version.
        target_version=${1:-$(curl -s $url | grep downloadBox | sed -E 's/^.*\/dl\/go([0-9]+\.[0-9]+\.[0-9]).*/\1/g' | head -1)}

        case "$(uname -i)" in
            x86_64*)
                arch=amd64;;
            arm*)
                arch=arm64;;
            i*86)
                arch=386;;
        esac

        package=go"$target_version".linux-"$arch".tar.gz
        echo "Download $package"
        curl -sLO $url$package
        echo "Install go $target_version"
        sudo rm -rf /usr/local/go
        sudo tar -C /usr/local -xzf $package
        if ! grep -Fxq 'export PATH=$PATH:/usr/local/go/bin' $SHELL_RC; then
            printf '\nexport PATH=$PATH:/usr/local/go/bin' >> $SHELL_RC
        fi
        rm $package
    else
        echo "detect existing go"
    fi

    get_version go
    echo -e "######## End of ${FUNCNAME[0]} ########\n"

}

