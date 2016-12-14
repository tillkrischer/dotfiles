call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-commentary' 

call plug#end()

" Let's be smart about indentation, including custom per-filetype
filetype plugin indent on
set autoindent

" 4 column expanded tabs by default
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4

"syntax highlighting, numbering
set relativenumber
set number
"set colorcolumn=80
syntax on

" Be smart about case sensitivity
set ignorecase
set smartcase

" Anything but utf-8 is silly
set encoding=utf-8

set splitbelow
set splitright

