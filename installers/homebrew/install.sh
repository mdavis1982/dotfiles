#!/usr/bin/env bash

# Heading
# ------------------------------------------------------------------------------
printf "\n\033[35;4mHomebrew\033[0m\n"

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if Homebrew is already installed
# ------------------------------------------------------------------------------
INSTALLED=true
printf "Checking for Homebrew installation... "
if ! command -v /opt/homebrew/bin/brew &> /dev/null; then
    printf "\033[31mNot found\033[0m\n\n"
    INSTALLED=false
else
    printf "\033[32mInstalled\033[0m\n"
fi

# Offer an install of Homebrew if it isn't already installed
# ------------------------------------------------------------------------------
if ! $INSTALLED; then
    printf "Would you like to install Homebrew? (y/N): "
    read -r RESPONSE
    case $RESPONSE in
        [yY])
            printf "Installing Homebrew...\n"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            printf "\033[32mDone\033[0m\n\n"
            ;;
        *)
            printf "Homebrew not installed.\n"
            [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
            ;;
    esac
fi

# Ask if the user wants to bootstrap the machine
# ------------------------------------------------------------------------------
printf "Would you like to bootstrap the machine with Homebrew? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        # Do nothing: Let the rest of the script run
        ;;
    *)
        printf "Machine not bootstrapped.\n"
        [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
        ;;
esac

# Let's brew
# ------------------------------------------------------------------------------
printf "\nBootstrapping core module...\n\n"
brew bundle install --file=$DIRECTORY/data/Brewfile.core --no-lock

printf "\nWould you like to bootstrap the development module? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        brew bundle install --file=$DIRECTORY/data/Brewfile.development --no-lock
        ;;
    *)
        printf "Development module not bootstrapped.\n"
        ;;
esac

printf "\nWould you like to bootstrap the audio module? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        brew bundle install --file=$DIRECTORY/data/Brewfile.audio --no-lock
        ;;
    *)
        printf "Audio module not bootstrapped.\n"
        ;;
esac

printf "\nWould you like to bootstrap the video module? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        brew bundle install --file=$DIRECTORY/data/Brewfile.video --no-lock
        ;;
    *)
        printf "Video module not bootstrapped.\n"
        ;;
esac

printf "\nWould you like to bootstrap the electronics module? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        brew bundle install --file=$DIRECTORY/data/Brewfile.electronics --no-lock
        ;;
    *)
        printf "Electronics module not bootstrapped.\n"
        ;;
esac

printf "\nWould you like to bootstrap the games module? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        brew bundle install --file=$DIRECTORY/data/Brewfile.games --no-lock
        ;;
    *)
        printf "Games module not bootstrapped.\n"
        ;;
esac

brew cleanup

# Ask individual questions about specific hardware
# ------------------------------------------------------------------------------
source $DIRECTORY/install-hardware.sh

# Success message
# ------------------------------------------------------------------------------
printf "\033[32mMachine bootstrapped.\033[0m\n"
