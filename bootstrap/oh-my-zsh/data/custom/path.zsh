# - Local composer tools are in ./vendor/bin
# - Global composer tools are installed into $HOME/.composer/vendor/bin
# - Some Homebrew formulae put executables into /usr/local/sbin

export PATH="./vendor/bin:$HOME/.composer/vendor/bin:/usr/local/sbin:$PATH"
