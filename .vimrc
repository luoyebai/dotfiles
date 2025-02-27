call plug#begin('~/.vim/plugged')

"" basic setting
set relativenumber  " relativenumber
set tabstop=4       " setting Tab is 4 spaces
set shiftwidth=4    " auto format same
set expandtab       " tab is spaces
set softtabstop=4   " auto setting
set smarttab        " smart tab

"" plugs list
" basic
Plug 'tpope/vim-sensible'               " some defalut setting
Plug 'vim-airline/vim-airline'          " status bar
Plug 'preservim/nerdtree'               " files tree
" edit
Plug 'easymotion/vim-easymotion'        " easy to jump
Plug 'tpope/vim-commentary'             " use gcc to comment
Plug 'jiangmiao/auto-pairs'             " auto add pairs
Plug 'tpope/vim-surround'               " change parentheses/quotes/XML-tags/much more with ease
" cpp
Plug 'octol/vim-cpp-enhanced-highlight' " cpp highlight
Plug 'rhysd/vim-clang-format'           " clang format

"" set keybinds
" basic
let mapleader = " "
map Y y$
" plug
map <Leader> <Plug>(easymotion-prefix)
map <C-n> :NERDTreeToggle<CR>
nnoremap <C-s> :ClangFormat<CR>

"" plugs setting
let g:indent_guides_enable_on_vim_startup = 1
set ts=4 sw=4 et
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:clang_format#style = "file"


call plug#end()

