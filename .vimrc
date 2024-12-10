source $VIMRUNTIME/defaults.vim
""""""""""" Appearance
syntax enable
filetype plugin indent on

set encoding=utf-8
set number
set laststatus=2
set ruler
set wildmenu

set scrolloff=5
set sidescrolloff=5

set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

""""""""""" Backup and Undo
set backup
set undofile

silent! !mkdir -p ~/.backup

set backupdir^=~/.backup

set undodir^=~/.backup

set dir^=~/.backup//

""""""""""""" Search
set hlsearch
set incsearch
set smartcase

if maparg('<C-L>','n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif

"""""""""""""" Indentation and Spelling

set textwidth=80
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

augroup FiletypeIndentation
  autocmd!

  autocmd FileType make setlocal noexpandtab

  autocmd FileType help setlocal nospell

  autocmd FileType text setlocal autoindent expandtab softtabstop=2 textwidth=76 spell spelllang=en_us
augroup END

""""""""""" Misc

packadd! matchit
set ttimeout
set ttimeoutlen=100

set autoread