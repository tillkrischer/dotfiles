let g:ale_fixers = ['prettier']

packadd yajs.vim
packadd vim-jsx
packadd ale
"packadd vim-javascript
"packadd nerdtree

if has("gui_running")
    colorscheme OceanicNext
endif

set ts=2 sw=2 et
set ff=unix

let g:ale_fix_on_save = 1
