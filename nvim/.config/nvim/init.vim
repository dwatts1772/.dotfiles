"                _
"    ____ _   __(_)___ ___
"   / __ \ | / / / __ `__ \
"  / / / / |/ / / / / / / /
" /_/ /_/|___/_/_/ /_/ /_/
"

"---[Autoinstall]--------------------------------------------------------------

if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

"---[Plug]---------------------------------------------------------------------

call plug#begin('~/.config/nvim/plugged')

" visual
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'nanotech/jellybeans.vim'
Plug 'mhinz/vim-startify'

" file navigation
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
" project text search
Plug 'mileszs/ack.vim'
" commenting
Plug 'scrooloose/nerdcommenter'
" automatic parentesis
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
" autocompletion
Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
Plug 'carlitux/deoplete-ternjs'
Plug 'zchee/deoplete-jedi'
Plug 'zchee/deoplete-clang'
Plug 'sebastianmarkow/deoplete-rust'
" syntax check, task runner
Plug 'neomake/neomake'
" tags
Plug 'ludovicchabant/vim-gutentags'
" git
"Plug 'motemen/git-vim'
Plug 'airblade/vim-gitgutter'
" misc
Plug 'troydm/zoomwintab.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'kshenoy/vim-signature'
Plug 'mattn/emmet-vim'
Plug 'wesQ3/vim-windowswap'
Plug 'docunext/closetag.vim'
Plug 'wellle/targets.vim'
Plug 'milkypostman/vim-togglelist'
Plug 'junegunn/vim-easy-align'
Plug 'epeli/slimux'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'thirtythreeforty/lessspace.vim'
Plug 'ctrlpvim/ctrlp.vim'

" langs
Plug 'pangloss/vim-javascript'
Plug 'kchmck/vim-coffee-script'
Plug 'tmhedberg/SimpylFold'
Plug 'tikhomirov/vim-glsl'
Plug 'groenewege/vim-less'
Plug 'shmup/vim-sql-syntax'
Plug 'rust-lang/rust.vim'
Plug 'othree/xml.vim'

call plug#end()

"---[Settings]-----------------------------------------------------------------

let mapleader="\<Space>"

" per project settings
set exrc
set secure

" turn on filetype
filetype plugin indent on
syntax enable

" reload on external change
set autoread

" syntax
set background=dark
colorscheme jellybeans
set cursorline
hi Normal ctermbg=None
hi NonText ctermbg=None
hi SpecialKey ctermbg=None
hi VertSplit ctermbg=234 ctermfg=234
hi SignColumn ctermbg=233
hi LineNr ctermbg=233

" remove vertical bar chars
" WARNING: trailing char is vital!
set fillchars+=vert:\ "

" tabs
set tabstop=4
set expandtab
set shiftwidth=4

set number

set foldmethod=syntax
set foldlevelstart=99

set backspace=indent,eol,start
set nowrap

" ruler options
set ruler
set cc=81
hi ColorColumn ctermbg=233

" show invisibiles
set list
set lcs+=eol:¬,extends:>,precedes:<,tab:»\ ,trail:·

set encoding=utf-8
set termencoding=utf-8
setglobal fileencoding=utf-8

" splitting
set splitbelow
set splitright

" wrapping
set linebreak

" scroll offset
set so=10

" search highlight
set hlsearch

" incremental substitute
set inccommand=split

" smart case in search
set ignorecase
set smartcase

" mouse support
set mouse=a
:map <MiddleMouse> <Nop>
:imap <MiddleMouse> <Nop>
:map <2-MiddleMouse> <Nop>
:imap <2-MiddleMouse> <Nop>
:map <3-MiddleMouse> <Nop>
:imap <3-MiddleMouse> <Nop>
:map <4-MiddleMouse> <Nop>
:imap <4-MiddleMouse> <Nop>

" nohl shortcut
nnoremap <silent> <Leader>/ :nohl<cr>

" pane resize shortcut
nnoremap <Leader>> <C-w>10>
nnoremap <Leader>< <C-w>10<
nnoremap <Leader>+ <C-w>10+
nnoremap <Leader>- <C-w>10-

" tags
nnoremap ]t :tnext<cr>
nnoremap [t :tprev<cr>

"---[Plugins]------------------------------------------------------------------

"---[airline]
set laststatus=2
set noshowmode
let g:airline_powerline_fonts=0
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline_theme='custom'
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_close_button = 0

let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''

"---[startify]
autocmd User Startified setlocal buftype=
hi StartifyHeader ctermfg={{accent.base8()}}
hi StartifyPath ctermfg={{foreground.base256()}}
hi StartifySlash ctermfg={{foreground.base256()}}
hi StartifyFile ctermfg={{foreground.base256()}}
hi StartifyNumber ctermfg={{accent.base8()}}
hi StartifySection ctermfg={{accent.base8() + 8}}
hi StartifyBracket ctermfg={{foreground.base256()}}
let g:startify_change_to_dir=0
let g:startify_custom_header=
    \ map(split(system("figlet -f slant -w $COLUMNS Defeat the Machine"), '\n'),
    \ '" ".  v:val') + ['']

"---[nerdtree]
let NERDTreeShowHidden=0
hi NERDTreeDir ctermfg={{accent.base8() + 8}}
hi NERDTreeFile ctermfg={{foreground.base256()}}
hi NERDTreeExecFile ctermfg={{foreground.base256()}} cterm=bold
hi NERDTreeLinkFile ctermfg={{accent.base8()}}
hi NERDTreeDirSlash ctermfg={{foreground.base256()}}
hi NERDTreeCWD ctermfg={{accent.base8() + 8}} cterm=bold
hi NERDTreeHelp ctermfg={{foreground.base256()}}
hi link NERDTreeUp NERDTreeDir
hi link NERDTreeLinkDir NERDTreeLinkFile
nnoremap <silent> <Leader>f :NERDTreeTabsToggle<CR>
nnoremap <silent> <F2> :NERDTreeFind<CR>
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'

"---[nerdtree git plugin]
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "~",
    \ "Staged"    : "+",
    \ "Untracked" : "+",
    \ "Renamed"   : ">",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "-",
    \ "Dirty"     : "~",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

"---[auto pairs]
let g:AutoPairsMapSpace = 0

"---[deoplete]
let g:deoplete#enable_at_startup = 1
" using only tab
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
" autoclose sratch pad
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

"---[neomake]
autocmd! BufReadPost,BufWritePost * Neomake
let g:neomake_open_list = 2
let g:neomake_warning_sign = {'text': 'W', 'texthl': 'WarningMsg'}
let g:neomake_error_sign = {'text': 'E', 'texthl': 'ErrorMsg'}
" makers
" TODO: makers for less, html
let g:neomake_todo_maker = {
    \'exe': 'ack',
    \'args': ['-r', '-H', '--nogroup', 'TODO|FIXME|WARNING'],
    \'errorformat': '%f:%l:%m'
    \}
let g:neomake_note_maker = {
    \'exe': 'ack',
    \'args': ['-r', '-H', '--nogroup', 'NOTE'],
    \'errorformat': '%f:%l:%m'
    \}
nnoremap <Leader>rr :Neomake! todo<cr>
nnoremap <Leader>rn :Neomake! note<cr>
nnoremap <Leader>m :Neomake!<cr>

let g:neomake_glsl_live_maker = {'exe': 'glslviewer', 'args': ['-l']}
autocmd BufReadPost *.frag Neomake live
"---[tagbar]
nnoremap <Leader>t :TagbarToggle<cr>

"---[gitgutter]
let g:gitgutter_sign_column_always = 1

"---[zoomwintab]
let g:zoomwintab_hidetabbar = 0
nnoremap <silent> <Leader>z :ZoomWinTabToggle<cr>

"---[vim tmux navigator]
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <C-H> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-J> :TmuxNavigateDown<cr>
nnoremap <silent> <C-K> :TmuxNavigateUp<cr>
nnoremap <silent> <C-L> :TmuxNavigateRight<cr>
" C-h is recognized as <BS> in nvim due to libtermkey
" see https://github.com/neovim/neovim/issues/2048
if has("nvim")
    nmap <BS> <C-H>
endif

"---[emmet]
let g:user_emmet_leader_key='<C-z>'

"---[easy align]
au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

"---[slimux]
let g:slimux_pane_format = '#{session_name}:#{window_index}.#{pane_index} ' .
    \'#{pane_current_command}'
nnoremap <silent><Leader>ee :SlimuxREPLSendLine<cr>
nnoremap <silent><Leader>eb :SlimuxREPLSendBuffer<cr>
nnoremap <silent><Leader>ev :SlimuxREPLConfigure<cr>

vnoremap <silent><Leader>e :SlimuxREPLSendSelection<cr>

"---[rainbow parentheses]
nnoremap <silent><Leader>( :RainbowParentheses!!<cr>
augroup rainbow_lisp
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

"---[number toggle]
let g:NumberToggleTrigger="<Leader>n"

"---[lessspace]
let g:lessspace_blacklist = ['markdown']

"---[Custom Functions]----------------------------------------------------------
function ToggleWrap()
    if (&wrap == 0)
        set wrap
    else
        set nowrap
    endif
endfunction

map <leader>wt :call ToggleWrap()<cr>
