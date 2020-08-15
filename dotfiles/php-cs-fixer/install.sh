#!/usr/bin/env bash

# Information
# ------------------------------------------------------------------------------
printf "# -------------------------\n"
printf "# PHP-CS-Fixer installation\n"
printf "# -------------------------\n"

# Set the directory to the directory where the script is
# ------------------------------------------------------------------------------
DIRECTORY="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Check if the required files are already in place and, if so, ask if we should
# remove them
# ------------------------------------------------------------------------------
CONTINUE=true
if [ -e ~/.php_cs ]; then
    printf "Some files would be overwritten installing PHP-CS-Fixer config. Continue? (y/N): "
    read -r RESPONSE
    case $RESPONSE in
        [yY])
            printf "Removing ~/.php_cs... "
            rm ~/.php_cs
            printf "Done\n"
            ;;
        *)
            CONTINUE=false
            ;;
    esac
fi

if ! $CONTINUE; then
    printf "Nothing installed\n\n"
    exit 0
fi

# Copy the required files
# ------------------------------------------------------------------------------
cp $DIRECTORY/data/php_cs ~/.php_cs

# Success message
# ------------------------------------------------------------------------------
printf "\nPHP-CS-Fixer config installed\n\n"
