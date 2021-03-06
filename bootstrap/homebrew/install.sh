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
if ! command -v brew &> /dev/null; then
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
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
            printf "\033[32mDone\033[0m"
            ;;
        *)
            printf "Homebrew not installed.\n"
            [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
            ;;
    esac
fi

# Ask if the user wants to bootstrap the machine
# ------------------------------------------------------------------------------
printf "Would you like to bootstrap the machine with applications, utilities and fonts? (y/N): "
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
brew bundle install --file=$DIRECTORY/Brewfile --no-lock
brew cleanup

# Start any brew installed services
# ------------------------------------------------------------------------------
brew services start mysql

# Success message
# ------------------------------------------------------------------------------
printf "\033[32mMachine bootstrapped.\033[0m\n"
