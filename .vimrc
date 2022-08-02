syntax enable
colorscheme vim-monokai-tasty
filetype plugin indent on
set nocompatible
set path+=**
set wildmenu
set history=50
set smartindent
set number
set mouse=a
set clipboard+=unnamedplus
set cursorline
set showmatch
set t_Co=256
set t_ut=
set laststatus=2
set ruler
let g:airline_theme='monokai_tasty'
let g:airline#extensions#ale#enabled=1
let g:ale_lint_on_text_changed=0
map <F2> :NERDTreeToggle<CR>
