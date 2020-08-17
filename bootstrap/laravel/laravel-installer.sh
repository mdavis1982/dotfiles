#!/usr/bin/env bash

# Laravel Installer
# ------------------------------------------------------------------------------
printf "Checking for Laravel installer... "
if ! command -v laravel &> /dev/null; then
    printf "\033[31mNot found\033[0m\n\n"
    printf "Would you like to install Laravel installer? (y/N): "
    read -r RESPONSE
    case $RESPONSE in
        [yY])
            printf "Installing Laravel installer... "
            composer global require laravel/installer --quiet
            printf "\033[32mDone\033[0m\n"
            ;;
        *)
            printf "Laravel installer not installed.\n"
            ;;
    esac
else
    printf "\033[32mInstalled\033[0m\n"
fi
