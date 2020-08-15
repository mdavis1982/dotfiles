# Install message
# ------------------------------------------------------------------------------
printf "Installing Laravel tools...\n"

# Install
# ------------------------------------------------------------------------------
composer global require laravel/installer --quiet
composer global require laravel/valet --quiet

valet install

# Success message
# ------------------------------------------------------------------------------
printf "Laravel tools installed successfully.\n"
