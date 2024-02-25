#!/usr/bin/env bash

# Heading
# ------------------------------------------------------------------------------
printf "\n\033[35;4mKitty\033[0m\n"

# Check prerequisites
# ------------------------------------------------------------------------------
printf "Checking for Kitty installation... "
if ! command -v /opt/homebrew/bin/kitty &> /dev/null; then
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
printf "Would you like to install the Kitty configuration files? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        # Do nothing: Let the rest of the script run
        ;;
    *)
        printf "Kitty configuration not installed.\n"
        [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
        ;;
esac

# Install Git configuration
# ------------------------------------------------------------------------------
printf "Configuring Kitty...\n"

printf "Removing any existing configuration... "
rm -fr ~/.config/kitty
printf "\033[32mDone\033[0m\n"

printf "Installing new configuration... "
mkdir -p ~/.config/kitty
cp $DIRECTORY/data/kitty.conf ~/.config/kitty/kitty.conf
cp $DIRECTORY/data/carbon-theme.conf ~/.config/kitty/carbon-theme.conf
printf "\033[32mDone\033[0m\n"

# Success message
# ------------------------------------------------------------------------------
printf "\033[32mKitty configuration installed.\033[0m\n"
