" --- Início da seção de plugins ---
call plug#begin('~/.vim/plugged')

" Plugin de árvore de arquivos (tipo Explorer do VSCode)
Plug 'preservim/nerdtree'

" Tema Gruvbox (se ainda não tiver)
Plug 'morhetz/gruvbox'

" Barra de status moderna
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Auto fechamento de parênteses, colchetes, etc
Plug 'jiangmiao/auto-pairs'

call plug#end()
" --- Fim da seção de plugins ---

" --- Ativar coloração ---
syntax on
set background=dark
colorscheme gruvbox

" --- Números de linha ---
set number
set relativenumber

" --- Aparência ---
set cursorline
set scrolloff=8
set sidescrolloff=8
set signcolumn=yes       " Deixa uma coluna fixa para diagnostics (ex.: LSP)
set termguicolors         " Melhor qualidade de cores (se seu terminal suportar)

" --- Indentação ---
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set autoindent

" --- Buscas ---
set ignorecase
set smartcase
set incsearch
set hlsearch

" --- Interface ---
set showcmd
set showmode
set ruler
set wildmenu
set lazyredraw
set timeoutlen=500
set clipboard=unnamedplus
set hidden
set updatetime=300        " Para plugins e LSP serem mais responsivos

" --- Map Leader ---
let mapleader=" "          " Usa espaço como tecla principal de atalho (super intuitivo)

" --- Atalhos úteis ---
" Salvar rápido
nnoremap <leader>w :w<CR>

" Fechar rápido
nnoremap <leader>q :q<CR>

" Limpar highlight da busca
nnoremap <leader>n :noh<CR>

" Abrir árvore de arquivos (se usar NERDTree ou nvim-tree)
nnoremap <leader>e :NERDTreeToggle<CR>

" Alternar entre buffers
nnoremap <leader>l :bnext<CR>
nnoremap <leader>h :bprevious<CR>

" Remap para mover entre splits
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k


