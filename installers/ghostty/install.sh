#!/usr/bin/env bash

# Heading
# ------------------------------------------------------------------------------
printf "\n\033[35;4mGhostty\033[0m\n"

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ask if the user wants to configure Ghostty
# ------------------------------------------------------------------------------
printf "Would you like to install the Ghosty configuration files? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        # Do nothing: Let the rest of the script run
        ;;
    *)
        printf "Ghostty configuration not installed.\n"
        [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
        ;;
esac

# Install Ghostty configuration
# ------------------------------------------------------------------------------
printf "Configuring Ghostty...\n"

printf "Removing any existing configuration... "
rm -f ~/.config/ghostty/config.ghostty
printf "\033[32mDone\033[0m\n"

printf "Installing new configuration... "
mkdir -p ~/.config/ghostty
cp $DIRECTORY/data/config.ghostty ~/.config/ghostty/config.ghostty
printf "\033[32mDone\033[0m\n"

# Success message
# ------------------------------------------------------------------------------
printf "\033[32mGhostty configuration installed.\033[0m\n"
