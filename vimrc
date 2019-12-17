""" General
set nocompatible            " be iMproved, required

""" Vundle (plugin mgmt)

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

"" Plugins Used
Plugin 'SirVer/ultisnips'
Plugin 'airblade/vim-gitgutter'
Plugin 'danielwe/base16-vim'                    "TODO: change to use chriskempson's repo
Plugin 'honza/vim-snippets'
Plugin 'ludovicchabant/vim-gutentags'           " Automatic tag generation
Plugin 'scrooloose/nerdtree'
Plugin 'tommcdo/vim-exchange'
Plugin 'tpope/vim-commentary'                   " use gcc to toggle comment
Plugin 'tpope/vim-fugitive'                     " git wrapper
Plugin 'tpope/vim-obsession'                    " record vim session with :Obsession
Plugin 'tpope/vim-repeat'                       " use . to repeat compatible plugins
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'file:///home/seznec/.dotfiles/fzf'
Plugin 'junegunn/fzf.vim'

""" Completion
if v:version >= 800
    Plugin 'roxma/nvim-yarp'                        " needed for deoplete
    Plugin 'roxma/vim-hug-neovim-rpc'               " needed for deoplete
    Plugin 'Shougo/deoplete.nvim'                   " asynchronous completion
    Plugin 'Shougo/deoplete-clangx'
    Plugin 'zchee/deoplete-jedi'
endif

""" Language specific
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'lervag/vimtex'
Plugin 'tpope/vim-git'
Plugin 'octol/vim-cpp-enhanced-highlight'

call vundle#end()

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-3.8/lib/libclang.so.1'
let g:deoplete#sources#clang#clang_header  = '/usr/lib/llvm-3.8/lib/clang/3.8.0/include/'

let g:hybrid_custom_term_colors=1

let base16colorspace=256
if &diff
    colorscheme base16-snazzy
else
    colorscheme base16-snazzy
endif
let g:airline_theme = "base16_tomorrow"

syntax enable               " add syntax coloration
filetype off                " required for vundle
filetype plugin indent on   " recognize file type

" iterm2 is slow...
if has('mac')
    set ttyfast
    set lazyredraw
else
    set relativenumber
    set cursorline                          " show line where cursor is
endif

set title                                   " Show title in terminal
set nomore
set autowrite
set updatecount=10                          " Auto write every 10 characters
set autoread                                " Auto reload modified files
set timeout timeoutlen=300 ttimeoutlen=300  " Command timeout = 300ms
set laststatus=2                            " bar always appears

set list                                    " show trailing whitespaces
" set listchars=tab:›\ ,trail:•,extends:#,nbsp:.

set autoindent
set smartindent
set backspace=indent,eol,start
set hidden                  " can switch between buffers without saving
set wildmenu                " better command-line completion
set wildmode=list:longest,full
set wildignore+=*.o
set showcmd                 " show completion

set backupdir=$HOME/.vim/backup,.
set directory=$HOME/.vim/backup,.

set undofile                " save A LOT of undo
set undodir=$HOME/.vim/undo,.
set undolevels=1000
set undoreload=10000
set history=1000            " store A LOT of history

set incsearch
set hlsearch                " highlight search
set ignorecase              " ignore case...
set smartcase               " ...unless capital letter searched

set nostartofline           " stop going to start of line after commands
set number                  " show line numbers left
set scrolloff=5
set synmaxcol=250

set tabstop=4               " Length of an actual tab
set shiftwidth=0            " shiftwidth = tabstop (sw = number of spaces when >> or <<)
set softtabstop=-1          " Softtabs are the same size as actual tabs

set expandtab               " convert tabs to spaces
set shiftround              " always indent to nearest tabstop

set mouse=a                 " Handle mouse

set nojoinspaces            " When joining a dot ending line with J, don't insert two spaces

set foldmethod=syntax
set foldlevel=99

" vim -b : edit binary using xxd-format!
augroup Binary
    au!
    au BufReadPre  *.bin let &bin=1
    au BufReadPost *.bin if &bin | %!xxd
    au BufReadPost *.bin set ft=xxd | endif
    au BufWritePre *.bin if &bin | %!xxd -r
    au BufWritePre *.bin endif
    au BufWritePost *.bin if &bin | %!xxd
    au BufWritePost *.bin set nomod | endif
augroup END

autocmd BufNewFile,BufReadPost *.aidl set filetype=java
autocmd BufNewFile,BufReadPost *.md set filetype=markdown
autocmd BufNewFile,BufReadPost *.cuh set filetype=cuda

autocmd FileType html :setlocal sw=2 sts=2          " Indent 2 spaces for those files
autocmd FileType javascript :setlocal sw=2 sts=2
autocmd FileType css :setlocal sw=2 sts=2
autocmd FileType python :setlocal colorcolumn=121   " Show column not to be exceeded

autocmd BufWritePost * GitGutter

let g:tex_flavor = "latex"

""" Mappings
let mapleader=','
let maplocalleader=mapleader

" Be consistent with D
nnoremap Y y$

nnoremap <silent> j gj
nnoremap <silent> k gk

" Replace word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

nnoremap <F2> :set expandtab! expandtab?<CR>
nnoremap <F3> :set paste! paste?<CR>

nnoremap S  :%s//g<LEFT><LEFT>

" Use those azerty keys
nmap é [
nmap è ]
vmap é [
vmap è ]

" Use ,[ypP] to use system buffer
nnoremap <leader>y "+y
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>y "+y
vnoremap <leader>p "+p
vnoremap <leader>P "+P

nnoremap <leader>ev :e ~/.vimrc<CR>
nnoremap <leader>v :source ~/.vimrc<CR>

nnoremap <leader>q :bw<CR>

nnoremap <silent> <leader>j :wa!<CR>:!tmux send-keys -t bottom-right C-P C-J <CR><CR>
nnoremap <silent> <leader>k :wa!<CR>:!tmux send-keys -t top-right C-P C-J <CR><CR>

nnoremap <leader>m yy :silent execute "!tmux send-keys -t top-right " . shellescape(@") <CR><C-L>
vnoremap <leader>m "+y :silent execute "!tmux send-keys -t top-right \\\%paste C-J"<CR><C-L>

" fzf mappings
nnoremap <C-p> :Files<CR>
nnoremap <C-j> :Lines<CR>
nnoremap ù :Lines <C-r><c-w><CR>
nnoremap <C-k> :Buffers<CR>

" GitGutter mappings
nnoremap <silent> <leader>gn :GitGutterNextHunk<CR>
nnoremap <silent> <leader>gp :GitGutterPrevHunk<CR>
nnoremap <silent> <leader>gu :GitGutterUndoHunk<CR>
nnoremap <silent> <leader>ga :GitGutterStageHunk<CR>

""" Vim-airline
let g:airline_powerline_fonts=1     " powerline symbols
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#whitespace#enabled=1
let g:airline_section_z = airline#section#create(['%{ObsessionStatus(''Rec'', '''')}', 'windowswap', '%3p%% ', 'linenr', ':%3v '])

""" Nerd Tree
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <leader>e :NERDTreeFind<CR>

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$', '\.orig$']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1

""" UltiSnips
let g:UltiSnipsSnippetsDir="$HOME/.vim/UltiSnips"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:UltiSnipsListSnippets="<C-l>"
