#!/usr/bin/env bash

# Laravel Valet
# ------------------------------------------------------------------------------
printf "Checking for Laravel Valet... "
if ! command -v valet &> /dev/null; then
    printf "\033[31mNot found\033[0m\n\n"
    printf "Would you like to install Laravel Valet? (y/N): "
    read -r RESPONSE
    case $RESPONSE in
        [yY])
            printf "Installing Laravel Valet...\n"
            composer global require laravel/valet --quiet
            valet install
            printf "\033[32mDone\033[0m"
            ;;
        *)
            printf "Laravel Valet not installed.\n"
            ;;
    esac
else
    printf "\033[32mInstalled\033[0m\n"
fi
