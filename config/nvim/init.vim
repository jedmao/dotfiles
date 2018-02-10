set autoindent                  " Enable auto indentation
set ruler                       " Show line and column numbers
set showcmd                     " Show command in status line
set nrformats=                  " Increment numbers in decimal only
set mouse=a                     " Enable mouse support in terminal
set wildmode=longest,list       " Smart tab completion from command line
set cpoptions=aABceFs           " Set some reasonable vi-compatible behavior
set backspace=indent,eol,start  " Allow backspace over indentation and newlines
set guioptions=agi              " Set gVim guioptions (no toolbar or scrollbar)
set number                      " Turn on line numbers
set showtabline=1               " Show tab bar conditionally
set laststatus=2                " Always show status bar
set ignorecase                  " Use case insensitive searches by default
set smartcase                   " Use case sensitive search when uppercase used
set incsearch                   " Jump to search strings while typing
set hlsearch                    " Highlight search results
set spell                       " Enable spell checking

" Use 4 spaces instead of a tab
set expandtab
set smarttab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Live dangerously
set nobackup
set nowritebackup
set noswapfile

" Create splits to the right (vertical) or to the bottom (horizontal)
set splitbelow
set splitright

" Don't auto-insert EOL
set nofixeol

" Use SPACE for leader key
let mapleader = " "

" Use ENTER to write files, and SPACE-SPACE to clear search highlighting
nmap <CR> :write<CR>
nmap <Leader><Leader> :nohlsearch<CR>:<Backspace>

" Add keyboard shortcuts for navigating splits
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg
nnoremap  <leader>y  "+y

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

set pastetoggle=<F2>

" Add keyboard shortcuts for moving between tabs
map <S-tab> <esc>:tabprevious<CR>
map <tab> <esc>:tabnext<CR>

" Install plugins
call plug#begin('~/AppData/Local/nvim/plugged')
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

" Trey's plugins: https://github.com/treyhunner/dotfiles
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'neomake/neomake', { 'on': 'Neomake' }
Plug 'ctrlpvim/ctrlp.vim'
Plug 'frankier/neovim-colors-solarized-truecolor-only'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'editorconfig/editorconfig-vim'
Plug 'danro/rename.vim'
Plug 'moll/vim-bbye'
Plug 'Rykka/riv.vim'

" Alina's Plugins
Plug 'tmhedberg/SimpylFold'
Plug 'vim-scripts/indentpython.vim'
Plug 'nvie/vim-flake8'
Plug 'jnurmine/Zenburn'
Plug 'scrooloose/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'mattn/emmet-vim'
Plug 'Valloric/YouCompleteMe'

" Duplicates
" Plug 'kien/ctrlp.vim'

" Not working
" Plug 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

call plug#end()

:nnoremap <Leader>w :Bdelete<CR>

" Set Python paths
let g:python3_host_prog = 'C:/Program Files (x86)/Python36-32/python.exe'

" Enable deoplete on startup
let g:deoplete#enable_at_startup = 1

" Configure CtrlP plugin
let g:ctrlp_map = '<Leader>t'
let g:ctrlp_user_command = 'ag --nogroup --nobreak --noheading --nocolor -g "" %s '
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_switch_buffer = 1

" Configure riv plugin
let g:riv_disable_folding = 1
let g:riv_ignored_maps = '<CR>, <KEnter>'
let g:riv_ignored_imaps = "<Tab>, <S-Tab>"
let g:riv_ignored_nmaps = "<Tab>, <S-Tab>"

" Configure Airline plugin
let g:airline_theme = 'solarized'
let g:airline_powerline_fonts = 1

" Use one of my favorite color schemes if available
syntax on
" colors slate

" if has('gui_running')
  set termguicolors
  set background=dark
"   set guifont="Fira Code:h14:cANSI:qDRAFT"
  set winfixwidth
  set winfixheight
  colorscheme solarized
" else
"   colorscheme Zenburn
" endif

call togglebg#map("<F5>")

let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree

" Run Neomake for buffer opens/writes
autocmd! BufWritePost,BufEnter * Neomake

" Toggle hiding of decorations on Shift-H
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all == 0
        let s:hidden_all = 1
        set noruler
        set laststatus=0
        set noshowcmd
        set showtabline=0
        sign unplace *
    else
        let s:hidden_all = 0
        set ruler
        set laststatus=2
        set showcmd
        set showtabline=1
        Neomake
    endif
endfunction
nnoremap <S-h> :call ToggleHiddenAll()<CR>:<Backspace>
