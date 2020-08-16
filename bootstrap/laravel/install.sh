#!/usr/bin/env bash

# Heading
# ------------------------------------------------------------------------------
printf "\n\033[35;4mLaravel Tools\033[0m\n"

printf "Checking for composer installation... "
if ! command -v composer &> /dev/null; then
    printf "\033[31mNot found\033[0m\n\n"
    printf "Exiting.\n"
    [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit
else
    printf "\033[32mInstalled\033[0m\n"
fi

# Install
# ------------------------------------------------------------------------------
printf "Installing Laravel Tools...\n"
composer global require laravel/installer --quiet
composer global require laravel/valet --quiet

valet install
printf "\033[32mLaravel Tools Installed\033[0m\n"
