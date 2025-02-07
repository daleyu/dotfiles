" ---------------------------
" Appearance & Filetype Settings
" ---------------------------
syntax enable
filetype plugin indent on

set encoding=utf-8
set number
set laststatus=2
set ruler
set wildmenu

set scrolloff=5
set sidescrolloff=5

" Configure visible whitespace characters
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+

" ---------------------------
" Backup and Undo
" ---------------------------
set backup
set undofile

" Create a backup directory if it doesn’t exist
silent! !mkdir -p ~/.backup

set backupdir^=~/.backup
set undodir^=~/.backup
set dir^=~/.backup//

" ---------------------------
" Search Settings
" ---------------------------
set hlsearch
set incsearch
set smartcase

" ---------------------------
" Indentation and Spelling
" ---------------------------
set textwidth=80
filetype plugin indent on
set tabstop=4
set shiftwidth=4
set expandtab

" Map leader to space
let mapleader = " "

" Remap x so that it does not yank the character (uses the black hole register)
nnoremap x "_x

" Copy a word into the default register
nmap ,c yiw

" Visually select a word
nmap ,v viw

" Paste commands that insert a newline at the cursor position
nnoremap gP i<CR><Esc>PkJxJx
nnoremap gp a<CR><Esc>PkJxJx

" Make Y and V behave like y$ and v$
nnoremap Y y$
nnoremap V v$
nnoremap vv V

" Recenter the screen after paging or scrolling
nnoremap <C-f> <C-f>zz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap <C-b> <C-b>zz

" Easy window navigation:
nnoremap <A-k> gT
nnoremap <A-j> gt
nnoremap <C-S-Tab> gT
nnoremap <C-Tab> gt

" Clear search highlighting with <leader>+Enter
nnoremap <leader><CR> :nohlsearch<CR>

" Copy the entire file to the clipboard
nmap <C-a> ggVG"+y
