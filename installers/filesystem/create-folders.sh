#!/usr/bin/env bash

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create folders
# ------------------------------------------------------------------------------
printf "Would you like to create filesystem folders (~/Developer etc)? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        # Do nothing: Let the rest of the script run
        ;;
    *)
        printf "Filesystem folders not created.\n"
        [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
        ;;
esac

# Create some folders
# ------------------------------------------------------------------------------
printf "Creating filesystem folders... "

# -- Create folders
mkdir -p ~/Developer
mkdir -p ~/Developer/Apps
mkdir -p ~/Developer/Packages
mkdir -p ~/Developer/Sites
mkdir -p ~/Developer/Other

printf "\033[32mDone\033[0m\n"
