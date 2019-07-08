"Pathogen load
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on
colorscheme molokai

set nocompatible
set path+=**
set wildmenu
set history=50
set encoding=utf8
set smartindent
set expandtab
set shiftwidth=4
set tabstop=4
set textwidth=80
set formatoptions+=t
set number
set mouse=a
set cursorline
set showmatch
set t_Co=256
set t_ut=
set laststatus=2
set ruler

map <F2> :NERDTreeToggle<CR>
