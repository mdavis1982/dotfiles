# Homebrew
if command -v /opt/homebrew/bin/brew &> /dev/null; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Global Composer tools
export PATH="$HOME/.composer/vendor/bin:$PATH"

# Global Node global installed binaries
export PATH="$HOME/.node/bin:$PATH"

# Use project specific binaries before global ones
export PATH="vendor/bin:node_modules/.bin:$PATH"
