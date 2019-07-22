filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on
set background=dark
let g:solarized_termcolors=256
let g:airline_theme='solarized'
colorscheme solarized
set nocompatible
set path+=**
set wildmenu
set history=50
set smartindent
set number
set mouse=a
set cursorline
set showmatch
set t_Co=256
set t_ut=
set laststatus=2
set ruler
map <F2> :NERDTreeToggle<CR>
