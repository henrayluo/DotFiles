#!/bin/bash

# Copy my gitconfigs...
ditto -v .gitconfig ~/.gitconfig
ditto -v .gitignore ~/.gitignore
ditto -v .clang-format ~/.clang-format

# Install homebrew.
if [ ! -f /usr/local/bin/brew ]; then
    xcode-select --install
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

cat brew-packages | xargs brew install
cat brew-cask-packages | xargs brew cask install
cat mas-app-ids | xargs mas install

# Install long list of packages.
IFS=$'\n'

# Set sane defaults
./defaults-write.sh

sudo xcodebuild -license accept

# Start services
brew services start mariadb
brew services start redis
