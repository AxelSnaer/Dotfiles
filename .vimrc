"-- SETTINGS ---------------------- {{{

" Disable compatability with vi
set nocompatible 

" Enable file type detection
filetype on

" Enable plugins and load plugin for the detected file type
filetype plugin on

" Load an indent file for the detected file type
filetype indent on

" Turn on syntax highlighting
syntax on

" Enable line numbers
set number

" Highlight cursor line underneath the cursor horizontally
set cursorline

" Set shift width to 4 spaces
set shiftwidth=4

" Set tab width to 4 columns
set tabstop=4

" Disable backups
set nobackup

" Disable line wrapping
set nowrap

" Enable incremental search
set incsearch

" Show partial command you type in the last line of the screen
set showcmd

" Show the mode you are in on the last line
set showmode

" Show matching words during a search
set showmatch

" Use highlighting when duing a search
set hlsearch

" Set command history to 1000 (default: 20)
set history=1000


" Enable auto completion menu after pressing tab
set wildmenu

" Make wildmenu behave similar to Bash completion
set wildmode=list:longest

" Ignore files you don't want to edit with Vim
set wildignore=*.docx,*.jpg,*.jpeg,*.png,*.gif,*.pdf,*pyc,*.exe,*.flv,*.img,*.xlsx

" }}}

"-- PLUGINS --------------------------------------{{{

call plug#begin('~/.vim/plugged')

	"Plug 'dense-analysis/ale'
	Plug 'preservim/nerdtree'

call plug#end()

let NERDTreeIgnore=['\.git$', '\.jpg$', '\.jpeg$', '\.mp4$', '\.ogg$', '\.iso$', '\.pdf$', '\.pyc$']

"}}}

"-- KEYMAPS --------------------------------------{{{

let mapleader = ","

" Nerd Tree Toggle
nnoremap <F3> :NERDTreeToggle<cr>

" Use space to put : in the command line
nnoremap <space> :

" Split Window
nnoremap <c-s> :split<cr>
nnoremap <c-d> :vsplit<cr>

" Split Window Navigation
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Resize Split Windows
nnoremap <c-up> <c-w>+
nnoremap <c-down> <c-w>-
nnoremap <c-left> <c-w>>
nnoremap <c-right> <c-w><

"}}}

" Enable code folding
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END


" Set the color scheme
colorscheme molokai
