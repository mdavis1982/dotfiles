#!/usr/bin/env bash

# Check prerequisites
# ------------------------------------------------------------------------------
printf "Checking for npm... "
if ! command -v npm &> /dev/null; then
    printf "\033[31mNot found\033[0m\n\n"
    printf "Exiting.\n"
    [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit
else
    printf "\033[32mInstalled\033[0m\n"
fi

# Pure Prompt
# ------------------------------------------------------------------------------
printf "Checking for Pure Prompt... "
if ! npm list --depth 1 --global pure-prompt > /dev/null 2>&1; then
    printf "\033[31mNot found\033[0m\n\n"
    printf "Would you like to install Pure Prompt? (y/N): "
    read -r RESPONSE
    case $RESPONSE in
        [yY])
            printf "Installing Pure Prompt... "
            npm install --global pure-prompt &> /dev/null
            printf "\033[32mDone\033[0m"
            ;;
        *)
            printf "Pure Prompt not installed.\n"
            ;;
    esac
else
    printf "\033[32mInstalled\033[0m\n"
fi
