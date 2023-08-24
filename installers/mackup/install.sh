#!/usr/bin/env bash

# Heading
# ------------------------------------------------------------------------------
printf "\n\033[35;4mMackup\033[0m\n"

# Check prerequisites
# ------------------------------------------------------------------------------
printf "Checking for Mackup installation... "
if ! command -v mackup &> /dev/null; then
    printf "\033[31mNot found\033[0m\n\n"
    printf "Exiting.\n"
    [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit
else
    printf "\033[32mInstalled\033[0m\n"
fi

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ask if the user wants to configure Git
# ------------------------------------------------------------------------------
printf "Would you like to install the Mackup configuration files? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        # Do nothing: Let the rest of the script run
        ;;
    *)
        printf "Mackup configuration not installed.\n"
        [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
        ;;
esac

# Install Mackup configuration
# ------------------------------------------------------------------------------
printf "Configuring Mackup...\n"

printf "Removing any existing configuration... "
rm -f ~/.mackup.cfg
printf "\033[32mDone\033[0m\n"

printf "Installing new configuration... "
cp $DIRECTORY/data/mackup.cfg ~/.mackup.cfg
printf "\033[32mDone\033[0m\n"

# Ask if the user wants to restore preferences
# ------------------------------------------------------------------------------
printf "Would you like to restore preferences using Mackup? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        # Do nothing: Let the rest of the script run
        ;;
    *)
        printf "Preferences not restored.\n"
        [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
        ;;
esac

mackup restore

# Success message
# ------------------------------------------------------------------------------
printf "\033[32mPreferences restored with Mackup.\033[0m\n"
