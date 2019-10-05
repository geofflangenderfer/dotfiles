" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
"  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

" map copy to usual functionality in visual mode
" map paste to normal functionalty in all modes
vnoremap <C-c> :w !xclip -i -sel c
noremap <C-v> :r !xclip -o -sel c
" vnoremap <C-d> "+d
" inoremap <C-v> <C-o>"+p

" use spaces instad of tabs
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab

" show line numbers and length
set number " show line numbers
" set fo-=t  " don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233


filetype off
filetype plugin indent on
syntax on

" set colorscheme to hemisu, which should be good for light/dark screens
" colorscheme hemisu

" better copy/paste
set pastetoggle=<F2>
set clipboard=unnamed

" rebind <Leader> key
let mapleader = ","

" nohl bind
" noremap <C-n> :nohl<CR>
" vnoremap <C-n> :nohl<CR>
" inoremap <C-n> :nohl<CR>

" quick save command
" noremap <C-P> :update<CR>
" vnoremap <C-P> :update<CR>
" inoremap <C-P> :update<CR>

" bind Ctrol+<movement> keys to move around windows instaed of
" Ctrl+w+<movement>
map <c-h> <c-w>h
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l

" easier moving between tabs
map <Leader>n <esc>:tabprevious<CR>
map <Leader>m <esc>:tabnext<CR>

" map sort function 
vnoremap <Leaders>s :sort<CR>

" move code blocks easier
vnoremap < < gv 
vnoremap > > gv 

" show whitespace
" MUST be inserted BEFORE the colorscheme command 
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
" au InsertLeave * match ExtraWhitespace /\s\+$/



" turn on case-insensitive search
set hlsearch
set incsearch
set ignorecase
set smartcase

" collect all backup ~ files in one place 
set undodir=/home/geoff/.vim_undo

" changing comments from dark blue to light blue
set background=dark

" change location of backup files
" set bdir=~/tmp

" disable ~ and .swp files
set nobackup
set nowritebackup
set noswapfile

" search down into subfolders
" tab-completion for all file-related tasks
set path+=**

" display all matchin files when we tab compmlete
set wildmenu

" enable syntax and plugins
syntax enable
filetype plugin on

" nocompatible
set nocompatible
" relative line numbers
set gdefault
" Add the full path to the status line
set statusline+=%F

" turn on spell-checking 
" set spell spelllang=en_us

" =========================================================================
" Javascript IDE Setup
" =========================================================================
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
" =========================================================================
" Python IDE Setup
" =========================================================================



" settings for python-mode
" cd ~/.vim/bundle
" git clone https://github.com/python-mode/python-mode.git
map <Leader>g :call RopeGotoDefinition()<CR>
let ropevim_enable_shortcuts = 1
let g:pymode_rope_goto_def_newwin = "vnew"
let g:pymode_rope_extended_complete = 1
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_rope=0
let g:pymode_folding = 0
let g:pymode_syntax_builtin_funcs = 0
map <Leader>b Oimport pdb; pdb.set_trace() # BREAKPOINT<C-c>

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Adding filetypes available to Ultisnips
autocmd FileType py UltiSnipsAddFiletypes python
autocmd FileType js UltiSnipsAddFiletypes javascript
autocmd FileType html UltiSnipsAddFiletypes html
" autocmd FileType html UltiSnipsAddFiletypes jinja
autocmd FileType java UltiSnipsAddFiletypes java



"============================================================================
"Plugin Manager: vim-plug
"===========================================================================
call plug#begin('~/.vim/plugged')

Plug 'python-mode/python-mode', { 'branch': 'develop' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'pangloss/vim-javascript'
Plug 'ervandew/supertab'
Plug 'tpope/vim-surround'
Plug 'vim-syntastic/syntastic'

call plug#end()

   
