# Dotfiles Setup

Este repositório contém os arquivos de configuração (dotfiles) e scripts necessários para configurar rapidamente seu ambiente de terminal.

## Estrutura do Repositório

- **Dotfiles**:
  - `.bashrc`, `.vimrc`, `.zshrc`, `.gitconfig`, etc.
- **Scripts**:
  - `setup.sh`: Script principal para configurar o ambiente.
  - `brew.sh`: Instala dependências via Homebrew.
- **Configurações adicionais**:
  - `config/alacritty/alacritty.toml`: Configuração do terminal Alacritty.

## Como Usar

1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Execute o script de setup:
   ```bash
   ./setup.sh
   ```

   - O script criará links simbólicos para os dotfiles no diretório home.
   - Ele também executará o script `brew.sh` para instalar dependências.

3. Personalize os arquivos de configuração conforme necessário.

## Estrutura do Script `setup.sh`

- Define o diretório base dos dotfiles como o diretório atual:
  ```bash
  BASE_DIR=$(pwd)
  ```
- Lista os arquivos de configuração que serão vinculados simbolicamente na variável `FILES`:
  ```bash
  FILES=(".bashrc" ".vimrc" ".zshrc" ".gitconfig")
  ```
- Para cada arquivo em `FILES`, o script:
  - Remove arquivos antigos ou links simbólicos existentes no diretório home:
    ```bash
    rm -f ~/$file
    ```
  - Cria um novo link simbólico apontando para o arquivo no repositório:
    ```bash
    ln -s $BASE_DIR/$file ~/$file
    ```
- Executa o script `brew.sh` para instalar dependências:
  ```bash
  ./brew.sh
  ```

## Contribuição

Sinta-se à vontade para abrir issues ou enviar pull requests para melhorias.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).
