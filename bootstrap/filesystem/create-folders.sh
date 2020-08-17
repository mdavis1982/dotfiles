#!/usr/bin/env bash

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create folders
# ------------------------------------------------------------------------------
printf "Would you like to create filesystem folders (~/Code etc)? (y/N): "
read -r RESPONSE
case $RESPONSE in
    [yY])
        # Do nothing: Let the rest of the script run
        ;;
    *)
        printf "Filesystem folders not created.\n"
        [[ "${BASH_SOURCE[0]}" != "${0}" ]] && return 1 || exit 0
        ;;
esac

# Create some folders
# ------------------------------------------------------------------------------
printf "Creating filesystem folders... "

# -- ~/Code folder with icon
mkdir -p ~/Code
$DIRECTORY/../utilities/set-icon.applescript "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/DeveloperFolderIcon.icns" ~/Code >& /dev/null

# -- ~/Code/Other folder with icon
mkdir -p ~/Code/Other
$DIRECTORY/../utilities/set-icon.applescript "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/UtilitiesFolder.icns" ~/Code/Other >& /dev/null

# -- ~/Code/Sites folder with icon
mkdir -p ~/Code/Sites
$DIRECTORY/../utilities/set-icon.applescript "/System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/SitesFolderIcon.icns" ~/Code/Sites >& /dev/null

printf "\033[32mDone\033[0m\n"
