#!/usr/bin/env bash

# Heading
# ------------------------------------------------------------------------------
printf "\n\033[35;4mOh My ZSH!\033[0m\n"

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if Oh My ZSH! is already installed
# ------------------------------------------------------------------------------
INSTALLED=true
printf "Checking for Oh My ZSH! installation... "
if [ ! -d ~/.oh-my-zsh ]; then
    printf "\033[31mNot found\033[0m\n\n"
    INSTALLED=false
else
    printf "\033[32mInstalled\033[0m\n"
fi

# Offer an install of Oh My ZSH! if it isn't already installed
# ------------------------------------------------------------------------------
if ! $INSTALLED; then
    printf "Would you like to install Oh My ZSH!? (y/N): "
    read -r RESPONSE
    case $RESPONSE in
        [yY])
            printf "Installing Oh My ZSH!... "
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
            printf "\033[32mDone\033[0m"
            ;;
        *)
            printf "Oh My ZSH not installed.\n"
            [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
            ;;
    esac
fi

# Ask if the user wants to configure Oh My ZSH!
# ------------------------------------------------------------------------------
printf "Would you like to install the Oh My ZSH! configuration files? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        # Do nothing: Let the rest of the script run
        ;;
    *)
        printf "Oh My ZSH! configuration not installed.\n"
        [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
        ;;
esac

# Install Oh My ZSH! configuration
# ------------------------------------------------------------------------------
printf "Configuring Oh My ZSH!... "

rm ~/.zshrc
rm ~/.oh-my-zsh/custom/git.zsh
rm ~/.oh-my-zsh/custom/laravel.zsh
rm ~/.oh-my-zsh/custom/path.zsh
rm ~/.oh-my-zsh/custom/themes/lick.zsh-theme

cp $DIRECTORY/data/zshrc ~/.zshrc
cp $DIRECTORY/data/custom/git.zsh ~/.oh-my-zsh/custom/git.zsh
cp $DIRECTORY/data/custom/laravel.zsh ~/.oh-my-zsh/custom/laravel.zsh
cp $DIRECTORY/data/custom/path.zsh ~/.oh-my-zsh/custom/path.zsh
cp $DIRECTORY/data/custom/themes/lick.zsh-theme ~/.oh-my-zsh/custom/themes/lick.zsh-theme

printf "\033[32mDone\033[0m\n"
