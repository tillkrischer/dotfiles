call plug#begin('~/.vim/plugged')

Plug 'neomake/neomake'

call plug#end()

autocmd! BufWritePost * Neomake

