call plug#begin('~/.vim/plugged')

Plug 'neomake/neomake'
Plug 'Lokaltog/vim-powerline'

call plug#end()

autocmd! BufWritePost * Neomake

