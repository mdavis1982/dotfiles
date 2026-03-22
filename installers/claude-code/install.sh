#!/usr/bin/env bash

# Heading
# ------------------------------------------------------------------------------
printf "\n\033[35;4mClaude Code\033[0m\n"

# Check prerequisites
# ------------------------------------------------------------------------------
printf "Checking for Claude Code installation... "
if ! command -v claude &> /dev/null; then
    printf "\033[31mNot found\033[0m\n\n"
    printf "Exiting.\n"
    [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit
else
    printf "\033[32mInstalled\033[0m\n"
fi

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Ask if the user wants to configure Git
# ------------------------------------------------------------------------------
printf "Would you like to install the Claude Code configuration files? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        # Do nothing: Let the rest of the script run
        ;;
    *)
        printf "Claude Code configuration not installed.\n"
        [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
        ;;
esac

# Install Claude Code configuration
# ------------------------------------------------------------------------------
printf "Configuring Claude Code...\n"

printf "Removing any existing configuration... "
rm -f ~/.claude/settings.json
rm -f ~/.claude/statusline.sh
printf "\033[32mDone\033[0m\n"

printf "Installing new configuration... "
cp $DIRECTORY/data/global/settings.json ~/.claude/settings.json
cp $DIRECTORY/data/global/statusline.sh ~/.claude/statusline.sh
printf "\033[32mDone\033[0m\n"

# Success message
# ------------------------------------------------------------------------------
printf "\033[32mClaude Code configuration installed.\033[0m\n"
