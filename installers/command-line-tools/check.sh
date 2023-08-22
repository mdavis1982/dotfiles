#!/usr/bin/env bash

# Check if command line tools have already been installed
# ------------------------------------------------------------------------------
printf "Checking for command line tools... "
if [ ! -d "$( xcode-select -p )" ]; then
    printf "\033[31mNot found\033[0m\n\n"
    printf "You must install the command line tools before continuing!\n"
    printf "You can do this with:\n\n"
    printf "    \033[33mxcode-select --install\033[0m\n\n"
    printf "Or by installing XCode.\n\n"
    printf "Exiting."

    exit 0
else
    printf "\033[32mInstalled\033[0m\n"
fi
