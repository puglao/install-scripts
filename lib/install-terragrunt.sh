# Install terragrunt
function install_terragrunt() {

    # Strip latest release tag from github release page
    function terragrunt_latest_version() {
        echo $(curl -s $url | grep 'href="/gruntwork-io/terragrunt/releases/tag/' | sed -E 's/^.*\/gruntwork-io\/terragrunt\/releases\/tag\/(v[0-9]+\.[0-9]+\.[0-9]+).*$/\1/g' | head -1)
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
    if ! command_exist terragrunt; then
        url='https://github.com/gruntwork-io/terragrunt/releases'
        # expect $1 to input certain version e.g. v0.35.12, no omit/null, install latest stable version.
        target_version=${1:-$(terragrunt_latest_version)}
        echo "Target package: terragrunt_$(system_os)_$(cpu_arch):${target_version}"
        echo "Download package from url: ${url}/download/${target_version}/terragrunt_$(system_os)_$(cpu_arch)"
        sudo curl -sL "${url}/download/${target_version}/terragrunt_$(system_os)_$(cpu_arch)" -o /usr/local/bin/terragrunt
        sudo chmod +x /usr/local/bin/terragrunt
    else
        echo "detect existing terragrunt"
    fi

    get_version terragrunt
    echo -e "######## End of ${FUNCNAME[0]} ########\n"
}



