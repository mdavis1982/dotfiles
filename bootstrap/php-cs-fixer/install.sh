#!/usr/bin/env bash

# Heading
# ------------------------------------------------------------------------------
printf "\n\033[35;4mphp-cs-fixer\033[0m\n"

# Check prerequisites
# ------------------------------------------------------------------------------
printf "Checking for php-cs-fixer installation... "
if ! command -v php-cs-fixer &> /dev/null; then
    printf "\033[31mNot found\033[0m\n\n"
    printf "Exiting.\n"
    [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit
else
    printf "\033[32mInstalled\033[0m\n"
fi

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ask if the user wants to configure php-cs-fixer
# ------------------------------------------------------------------------------
printf "Would you like to install the php-cs-fixer configuration? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        # Do nothing: Let the rest of the script run
        ;;
    *)
        printf "php-cs-fixer configuration not installed.\n"
        [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
        ;;
esac

# Install php-cs-fixer configuration
# ------------------------------------------------------------------------------
printf "Configuring php-cs-fixer...\n"

printf "Removing any existing configuration... "
rm ~/.php_cs
printf "\033[32mDone\033[0m\n"

printf "Installing new configuration... "
cp $DIRECTORY/data/php_cs ~/.php_cs
printf "\033[32mDone\033[0m\n"

# Success message
# ------------------------------------------------------------------------------
printf "\033[32mphp-cs-fixer configuration installed.\033[0m\n"
