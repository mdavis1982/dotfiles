#!/usr/bin/env bash

# Ask if the user wants to install hardware software
# ------------------------------------------------------------------------------
printf "\nWould you like to install hardware software? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        # Do nothing: Let the rest of the script run
        ;;
    *)
        printf "Hardware software not installed.\n"
        [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
        ;;
esac

# Let's ask about each piece of hardware
# ------------------------------------------------------------------------------
printf "\nWould you like to install Logi Options+? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        brew install --cask logi-options-plus
        ;;
    *)
        printf "Logi Options+ not installed.\n"
        [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
        ;;
esac
