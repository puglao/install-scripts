# little function to check if command exist in system
function command_exist() {
    command -v "$@" &> /dev/null
}

# little function to add alias in .zshrc/.bashrc/.bash_profile
function set_alias(){
    # expect $1 input like 'alias k="kubectl"'
    
    # Create ALIAS_FILE if not exist
    [ ! -f $ALIAS_FILE ] && (echo "create alias file $ALIAS_FILE" ; touch $ALIAS_FILE) || echo "alias file exist"

    # Exit if SHELL_RC not exist
    [ ! -f $SHELL_RC ] && echo "no existing SHELL_RC file " && exit 1

    # Create source command in $SHELL_RC if not exist
    ! grep -Fxq "source $ALIAS_FILE" $SHELL_RC && (echo "create source alias in $SHELL_RC"; echo "source $ALIAS_FILE" >> $SHELL_RC) || echo "source alias exist in $SHELL_RC"

    # Insert alias to $ALIAS_FILE    
    IFS='=' read -r -a als <<< $1
    if grep -q "^${als[0]}" $ALIAS_FILE; then
        sed -i 's/^'"${als[0]}"'.*$/'"${als[0]}"'='"${als[1]}"'/g' $ALIAS_FILE
    else
        printf "\n${als[0]}=${als[1]}" >> $ALIAS_FILE
    fi
}