#!/usr/bin/env bash

# Heading
# ------------------------------------------------------------------------------
printf "\n\033[35;4mNeoVim\033[0m\n"

# Check prerequisites
# ------------------------------------------------------------------------------
printf "Checking for Neovim installation... "
if ! command -v /opt/homebrew/bin/nvim &> /dev/null; then
    printf "\033[31mNot found\033[0m\n\n"
    printf "Exiting.\n"
    [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit
else
    printf "\033[32mInstalled\033[0m\n"
fi

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ask if the user wants to configure Kitty
# ------------------------------------------------------------------------------
printf "Would you like to install the NeoVim configuration files? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        # Do nothing: Let the rest of the script run
        ;;
    *)
        printf "NeoVim configuration not installed.\n"
        [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
        ;;
esac

# Install NeoVim configuration
# ------------------------------------------------------------------------------
printf "Configuring NeoVim...\n"

printf "Removing any existing configuration... "
rm -fr ~/.config/nvim
printf "\033[32mDone\033[0m\n"

printf "Installing new configuration... "
cp -R $DIRECTORY/data ~/.config/nvim
printf "\033[32mDone\033[0m\n"

# Ask for Intelephense license if one hasn't already been provided
if ! [ -f ~/.config/intelephense/license.txt ]; then
    printf "What is your Intelephense license key?: "
    read -r -s LICENSE
    rm -fr ~/.config/intelephense
    mkdir ~/.config/intelephense
    echo "$LICENSE" > ~/.config/intelephense/license.txt
    echo "\n"
fi

# Success message
# ------------------------------------------------------------------------------
printf "\033[32mNeoVim configuration installed.\033[0m\n"
