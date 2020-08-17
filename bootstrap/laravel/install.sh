#!/usr/bin/env bash

# Heading
# ------------------------------------------------------------------------------
printf "\n\033[35;4mLaravel Tools\033[0m\n"

# Check prerequisites
# ------------------------------------------------------------------------------
printf "Checking for composer installation... "
if ! command -v composer &> /dev/null; then
    printf "\033[31mNot found\033[0m\n\n"
    printf "Exiting.\n"
    [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit
else
    printf "\033[32mInstalled\033[0m\n"
fi

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run each step in turn
# ------------------------------------------------------------------------------
source $DIRECTORY/laravel-installer.sh
source $DIRECTORY/laravel-valet.sh
