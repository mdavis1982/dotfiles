# Dotfiles
Because `~` is where the ❤️ is.

## What is it?
This repository contains my personal collection of dotfiles. It also includes some initialisation scripts that install the applications, tools and utilities that I use. There is also the Mac Terminal.app theme that I use, along with a port for iTerm 2.

## Usage
To install the whole thing, just run `./install.sh` from the root directory. This will:

- Check that the XCode Command Line Tools are installed
- Install [Homebrew](https://brew.sh)
- Bootstrap all of the applications, utilities and fonts listed in `bootstrap/homebrew/Brewfile`
- Install [Oh My ZSH!](https://ohmyz.sh)
- Install [Pure Prompt](https://github.com/sindresorhus/pure)
- Create some directories on the filesystem and set their icons:
    - `~/Code`
    - `~/Code/Sites`
    - `~/Code/Other`
- Set up my dotfiles
- Configure the Git author information
- Configure [php-cs-fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer) with my personal rule set

Running the `./install.sh` script multiple times will attempt to check for existing installations and won't install things for a second time. Subsequent runs will always offer to install the configuration files for the various pieces.
