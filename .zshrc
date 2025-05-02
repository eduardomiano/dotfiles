# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="agnoster"
ZSH_THEME_RANDOM_CANDIDATES=("robbyrussell" "agnoster")

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-completions
  alias-tips
  zsh-history-substring-search
  docker
  history
  colored-man-pages
  command-not-found
  macos
  asdf
  aws
  azure
  brew
  dotnet
  gitignore
  github
  git-flow
  golang
  gulp
  man
  npm
  perl
  python
  pip
  sudo
  ssh
  ssh-agent
  terraform
  tmux
  vagrant
  vagrant-prompt
  vi-mode
  vscode
  xcode
  yarn
  zsh-interactive-cd
  zsh-navigation-tools
)

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

### PATH customizado ###
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"

### Completions e FZF ###
# Ajuste do fpath para completions
fpath=(
  "${ASDF_DIR:-$HOME/.asdf}/completions"
  "$HOME/.docker/completions"
  "$(brew --prefix)/share/zsh/site-functions"
  $fpath
)

# Inicializa completions
zstyle ':compinit' strict false
autoload -Uz compinit
compinit -C

# Inicializa bash completion para Docker (só se existir)
if type bashcompinit &>/dev/null; then
  autoload -Uz bashcompinit
  bashcompinit
fi

# Inicializa fzf (fuzzy finder) e do Zoxide
# Set up fzf key bindings and fuzzy completion
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
  [[ -f $(brew --prefix)/opt/fzf/shell/completion.zsh ]] && source $(brew --prefix)/opt/fzf/shell/completion.zsh
fi
eval "$(zoxide init zsh)"


### Configurações do asdf (Go version) ###
if [ -f "$(brew --prefix asdf)/libexec/asdf.sh" ]; then
  source "$(brew --prefix asdf)/libexec/asdf.sh"
fi

### Themes ###
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### AWS ###
export AWS_PROFILE=default
# export REQUESTS_CA_BUNDLE="$HOME/.certs/btg-ca-chain.pem"

### Histórico ###
SAVEHIST=20000
HISTSIZE=20000
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

source ~/.zsh_aliases
source ~/.zsh_keybindings
source ~/.functions

zi() {
  local dir
  dir=$(zoxide query -ls |
    fzf --height 40% --layout=reverse --info=inline --preview 'exa -T --color=always {} 2>/dev/null | head -100' \
        --prompt='zoxide > ' --bind 'ctrl-r:reload(zoxide query -ls)' --exit-0) &&
    cd "$dir"
}

### end ###