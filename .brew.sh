#!/usr/bin/env bash

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install a modern version of Bash.
brew install bash
brew install bash-completion2

# Switch to using brew-installed bash as default shell
if ! fgrep -q "${BREW_PREFIX}/bin/bash" /etc/shells; then
  echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells;
  chsh -s "${BREW_PREFIX}/bin/bash";
fi;

brew install asdf
brew install awscli
brew install azure-cli
brew install ca-certificates
brew install docker
brew install docker-completion

# New commands write in Rust and/or Go
brew install dust
brew install eza
brew install bottom
brew install bat
brew install zoxide
brew install ripgrep

brew install gettext

# GIT
brew install gh
brew install git
brew install git-flow
brew install git-gui
# brew install git-lfs
# brew install git-quick-stats

brew install gmp
brew install gnupg
brew install gnutls
brew install go
brew install jq

brew install neovim

brew install pinentry
brew install pinentry-mac
brew install pkgconf
brew install procs
brew install pycparser
brew install python@3.13
brew install readline
brew install sqlite

brew install tmux
brew install tree
brew install tree-sitter
brew install unbound
brew install unibilium
brew install utf8proc
brew install xz

# zsh
brew install zsh
brew install zsh-autosuggestions
brew install powerlevel10k
brew install fzf

# cask
brew install --cask alacritty
brew install --cask arc
brew install --cask balenaetcher
brew install --cask beyond-compare
brew install --cask bitwarden
brew install --cask citrix-workspace
brew install --cask dbeaver-community
brew install --cask displaylink
brew install --cask docker
brew install --cask drawio
brew install --cask font-hack-nerd-font
brew install --cask font-meslo-lg-nerd-font
brew install --cask git-credential-manager
brew install --cask github
brew install --cask iterm2
brew install --cask microsoft-onenote
brew install --cask obsidian
brew install --cask postman
brew install --cask powershell
brew install --cask rectangle
brew install --cask sourcetree
brew install --cask spotify
brew install --cask tabby
brew install --cask visual-studio-code
brew install --cask warp
brew install --cask webex
brew install --cask whatsapp
brew install --cask xmind

# Remove outdated versions from the cellar.
brew cleanup