# Install helm
function install_helm() {

    # Strip latest release tag from github release page
    function helm_latest_version() {
        echo $(curl -s $url | grep 'href="/helm/helm/releases/tag/' | sed -E 's/^.*\/helm\/helm\/releases\/tag\/(v[0-9]+\.[0-9]+\.[0-9]+).*$/\1/g' | head -1)
    }

    function cpu_arch() {
        case "$(uname -i)" in
            x86_64*)
                echo amd64;;
            arm*)
                echo arm64;;
            i*86)
                echo 386;;
        esac
    }

    function system_os() {
        echo $(uname | awk '{print tolower($0)}')
    }

    echo -e "######## Start of ${FUNCNAME[0]} ########"
    if ! command_exist helm; then
        url='https://github.com/helm/helm/releases'
        durl='https://get.helm.sh'
        # expect $1 to input certain version e.g. v0.3.7.1, no omit/null, install latest stable version.
        target_version=${1:-$(helm_latest_version)}
        echo "Target package: helm_$(system_os)_$(cpu_arch):${target_version}"
        echo "Download package from url: ${durl}/helm-${target_version}-$(system_os)-$(cpu_arch).tar.gz"
        curl -sLO "${durl}/helm-${target_version}-$(system_os)-$(cpu_arch).tar.gz"
        tar -zxf "helm-${target_version}-$(system_os)-$(cpu_arch).tar.gz"
        sudo mv $(system_os)-$(cpu_arch)/helm /usr/local/bin/helm
        sudo chmod +x /usr/local/bin/helm
        rm "helm-${target_version}-$(system_os)-$(cpu_arch).tar.gz"
        rm -rf $(system_os)-$(cpu_arch)
    else
        echo "detect existing helm"
    fi

    get_version helm
    echo -e "######## End of ${FUNCNAME[0]} ########\n"
}



