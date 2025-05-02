#!/usr/bin/env bash
set -euo pipefail
# set -x

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BREW_SCRIPT="${DOTFILES_DIR}/.brew.sh"
DO_BREW=false

# map[src]=dest
declare -A FILES=(
  # dotfiles simples
  ["${DOTFILES_DIR}/.bashrc"]="${HOME}/.bashrc"
  ["${DOTFILES_DIR}/.vimrc"]="${HOME}/.vimrc"
  ["${DOTFILES_DIR}/.zshrc"]="${HOME}/.zshrc"
  ["${DOTFILES_DIR}/.zprofile"]="${HOME}/.zprofile"
  ["${DOTFILES_DIR}/.gitconfig"]="${HOME}/.gitconfig"
  ["${DOTFILES_DIR}/.zsh_aliases"]="${HOME}/.zsh_aliases"
  ["${DOTFILES_DIR}/.zsh_keybindings"]="${HOME}/.zsh_keybindings"
  ["${DOTFILES_DIR}/.functions"]="${HOME}/.functions"
  ["${DOTFILES_DIR}/.tmux.conf"]="${HOME}/.tmux.conf"
  ["${DOTFILES_DIR}/.p10k.zsh"]="${HOME}/.p10k.zsh"
  ["${DOTFILES_DIR}/.gitignore"]="${HOME}/.gitignore"
  ["${DOTFILES_DIR}/.gitattributes"]="${HOME}/.gitattributes"  
  ["${DOTFILES_DIR}/.alacritty.toml"]="${HOME}/.config/alacritty/alacritty.toml"
  ["${DOTFILES_DIR}/.aws-alias"]="${HOME}/.aws/cli/alias"
)

function usage() {
  cat <<-EOF
Usage: $(basename "$0") [options]

Options:
  -c, --clean     Remove todas as configurações
  -b, --brew      Executa brew.sh após criar os symlinks
  -h, --help      Exibe esta ajuda
EOF
}

function clean_all() {
  echo "🧹 Limpando todas as configurações..."
  for src in "${!FILES[@]}"; do
    dest="${FILES[$src]}"
    if [[ -L "$dest" ]]; then
      rm "$dest" && echo "  ↳ removed symlink $dest"
    elif [[ -e "$dest" ]]; then
      rm -rf "$dest" && echo "  ↳ removed $dest"
    fi
  done
  echo "✔ Limpeza concluída."
  exit 0
}

# parse options
while [[ $# -gt 0 ]]; do
  case "$1" in
    -c|--clean) clean_all ;;
    -b|--brew)  DO_BREW=true; shift ;;
    -h|--help)  usage; exit 0 ;;
    *)          echo "⚠ Opção inválida: $1"; usage; exit 1 ;;
  esac
done

# Banner
cat << 'EOF'
███    ███ ██  █████  ███    ██  ██████  
████  ████ ██ ██   ██ ████   ██ ██    ██ 
██ ████ ██ ██ ███████ ██ ██  ██ ██    ██ 
██  ██  ██ ██ ██   ██ ██  ██ ██ ██    ██ 
██      ██ ██ ██   ██ ██   ████  ██████  
EOF

# Verifica se o repositório existe
if [[ ! -d "${DOTFILES_DIR}" ]]; then
  >&2 echo "❌ Diretório ${DOTFILES_DIR} não encontrado."
  exit 1
fi

echo "🔗 Criando symlinks…"
for src in "${!FILES[@]}"; do
  dest="${FILES[$src]}"

  # cria pasta de destino, se precisar
  mkdir -p "$(dirname "$dest")"

  # remove link ou arquivo antigo
  if [[ -e "$dest" || -L "$dest" ]]; then
    rm -rf "$dest"
  fi

  ln -s "$src" "$dest"
  echo "✔️  $(basename "$dest") → $(dirname "$dest")"
done

# executa brew.sh se solicitado
if $DO_BREW; then
  if [[ -x "$BREW_SCRIPT" ]]; then
    echo "⚙️  Executando brew.sh…"
    bash "$BREW_SCRIPT"
  else
    echo "⚠️  brew.sh não encontrado ou sem permissão."
  fi
fi

echo "✅ Setup concluído!"
