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

" Enable fuzzy matching
set completeopt+=fuzzy

" Always show the status line at the bottom, even if you only have one window
" open.
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

" NetRW mapping
nnoremap <leader>e :Lexplore<CR>

" GitGutter mappings
nnoremap <leader>hn :GitGutterNextHunk<CR>
nnoremap <leader>hp :GitGutterPreviewHunk<CR>
nnoremap <leader>hr :GitGutterUndoHunk<CR>
nnoremap <leader>hs :GitGutterStageHunk<CR>

" vim-better-whitespace mappings
nnoremap <leader>ss :StripWhitespace<CR>

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
Plug 'ntpeters/vim-better-whitespace'
Plug 'machakann/vim-highlightedyank'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:lightline = { 'colorscheme': 'gruvbox' }
let g:highlightedyank_highlight_duration = 100
call plug#end()

" Coc Setup
" Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>ra <Plug>(coc-rename)

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ca  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>sa  <Plug>(coc-codeaction-source)

" Remap <C-f> and <C-b> to scroll float windows/popups
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Appearance
set termguicolors
set background=dark
colorscheme gruvbox
set colorcolumn=80

set cursorline
set cursorlineopt=line,number
