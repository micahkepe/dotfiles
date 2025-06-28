"
"  ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"  ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"  ██║   ██║██║██╔████╔██║██████╔╝██║
"  ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"   ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"    ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible

filetype plugin indent on

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show relative line numbers by default.
set number
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" No swapfile
set noswapfile

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Set leader to space.
let mapleader = "\<Space>"

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Vim Terminal Mappings
" Open terminal in bottom of window
nnoremap <leader>h :below terminal<CR>

" Toggle relative line numbering with <leader>rn
nnoremap <leader>rn :set relativenumber!<CR>

" Set yank register to allow for clipboard.
set clipboard=unnamedplus,unnamed,autoselect

" Window management
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>sd :close<CR>

" Save mapping
nnoremap <C-s> :w<CR>

" Yank all mapping
nnoremap <C-c> :%y+<CR>

" Close mapping
nnoremap <C-x> :close<CR>

" GitGutter mappings
nnoremap <leader>hn :GitGutterNextHunk<CR>
nnoremap <leader>hp :GitGutterPreviewHunk<CR>
nnoremap <leader>hr :GitGutterUndoHunk<CR>
nnoremap <leader>hs :GitGutterStageHunk<CR>

" Terminal
tnoremap <C-x> <C-w>N

" Some tricks taken from this YouTube lecture:
"   https://www.youtube.com/watch?v=XA2WjJbmmoM
" Set wild menu
set wildmenu
set wildmode=list:longest,full

" Change cursor appearance on mode
let &t_SI = "\e[6 q" " INSERT mode
let &t_EI = "\e[2 q" " NORMAL mode

" No sluggish ESC
if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=0
endif

" Display last line
set display+=lastline
if has('patch-7.4.2109')
  set display+=truncate
endif

" Auto reload files when they are edited outside of Vim
set autoread

" Longer command history
set history=1000

" Better matching for %
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'christoomey/vim-tmux-navigator'
let g:lightline = { 'colorscheme': 'gruvbox' }
call plug#end()

" Appearance
set termguicolors
set background=dark
colorscheme gruvbox
