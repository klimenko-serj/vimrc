set nocp       " nocompatible
set visualbell " stop
set guioptions=
set hidden " for buffers
set clipboard=unnamed
set tabstop=4
set shiftwidth=4
set updatetime=1000
set encoding=utf-8

"--------------------------------------------------------------------------------
" vim-plug
call plug#begin('~/.vim/plugged')

Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'tpope/vim-repeat'
Plug 'xolox/vim-misc'
Plug 'thaerkh/vim-workspace'

" view
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'

" basic editing
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/vim-easy-align'
Plug 'terryma/vim-multiple-cursors'
Plug 'vim-scripts/YankRing.vim' " 'maxbrunsfeld/vim-yankstack'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'idanarye/vim-merginal'
Plug 'jreybert/vimagit'

" programming
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
Plug 'ntpeters/vim-better-whitespace'
Plug 'majutsushi/tagbar'
Plug 'xolox/vim-easytags'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-commentary'
Plug 'SirVer/ultisnips'
" clojure
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
" golang
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

Plug 'scrooloose/nerdtree', { 'on':  ['NERDTreeToggle', 'NERDTreeFind', 'NERDTree'] }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tacahiroy/ctrlp-funky'
Plug 'dyng/ctrlsf.vim'

call plug#end()
"--------------------------------------------------------------------------------

filetype plugin indent on

set t_Co=256
syntax enable
set background=dark
colorscheme gruvbox

set guifont=Monaco:h14

" set relativenumber
set number
set cursorline
set scrolloff=3
set colorcolumn=100

set mouse=a

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" Search
set hlsearch  " Highlight search terms...
set incsearch " ...dynamically as they are typed.
set ignorecase
set smartcase

set completeopt=longest,menuone

set backspace=indent,eol,start

" CtrlP
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.webhistory     " CtrlP MacOSX/Linux
let g:ctrlp_working_path_mode = 'ra'         " where
let g:ctrlp_by_filename       = 1
let g:ctrlp_user_command      = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

" CtrlSF
let g:ctrlsf_indent = 1
let g:ctrlsf_case_sensitive = 'smart'
let g:ctrlsf_default_root = 'project-ww'
let g:ctrlsf_context = '-B 3 -A 2'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
			  \ --ignore .git
			  \ --ignore .svn
			  \ --ignore .hg
			  \ --ignore .DS_Store
			  \ --ignore "**/*.pyc"
			  \ -g ""'

  let g:gitgutter_grep_command='ag --nocolor'
  " ag is fast enough that CtrlP doesn't need to cache
  " let g:ctrlp_use_caching = 0
endif

" Ag
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!

set wildmenu

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Tags
let g:easytags_async = 1
let g:easytags_dynamic_files = 1
let g:easytags_events = ['BufWritePost']

"Git
set diffopt+=vertical


" UltiSnips triggering
let g:UltiSnipsExpandTrigger = '<C-j>'
let g:UltiSnipsJumpForwardTrigger = '<C-j>'
let g:UltiSnipsJumpBackwardTrigger = '<C-k>'
let g:UltiSnipsSnippetDirectories=[$HOME.'/vimrc/mysnippets']


let mapleader=" " " Space as <leader>
let maplocalleader="," " Space as <localleader>

" NERDTree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if (argc() == 0 && !exists("s:std_in")) | NERDTree | endif
" autocmd bufenter * if (winnr(“$”) == 1 && exists(“b:NERDTreeType”) && b:NERDTreeType == “primary”) | q | endif
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
function! SmartNERDTree()
    if @% == ""
        NERDTreeToggle
    else
        NERDTreeFind
    endif
endfun


nmap <leader>t  :call SmartNERDTree()<CR>
nmap <leader>b  :CtrlPBuffer<CR>
nmap <leader>f  :CtrlPMixed<CR>
nmap <leader>r  :CtrlPMRU<CR>
nmap <leader>j  :CtrlPFunky<CR>
nmap <leader>w  <C-w>
nmap <leader>W  :ToggleWorkspace<CR>
nmap <leader>s  <Plug>(easymotion-overwin-f)
nmap <leader>m  :MultipleCursorsFind<Space>
nmap <leader>y  :YRShow<CR>
nmap <leader>c  gc
vmap <leader>c  gc
" search in project
nmap <leader>ag  :Ag<SPACE>
nmap <leader>ap <Plug>CtrlSFPrompt
nmap <leader>at :CtrlSFToggle<CR>
nmap <leader>aa <Plug>CtrlSFCwordPath
vmap <leader>aa <Plug>CtrlSFVwordPath
"git
nmap <leader>gs :MagitOnly<CR>
nmap <leader>gS :Gstatus<CR>
nmap <leader>gb :Gblame<CR>
nmap <leader>gg :Git<Space>
nmap <leader>gm :MerginalToggle<CR>
"tags
nmap <leader>df :CtrlPTag<CR>
nmap <leader>db :CtrlPBufTag<CR>
nmap <leader>dt :TagbarToggle<CR>
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <leader>= <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>= <Plug>(EasyAlign)

"clojure
autocmd FileType clojure setlocal commentstring=;;\ %s

"golang
let g:go_auto_sameids = 1
let g:go_auto_type_info = 1
autocmd FileType go nmap <leader>j :GoDecls<CR>
autocmd FileType go nmap <leader>dd :GoDef<CR>
autocmd FileType go nmap <leader>B :GoBuild<CR>
autocmd FileType go nmap <leader>R :GoRun<CR>

"json
nmap =j :%!python -m json.tool<CR>
vmap =j :%!python -m json.tool<CR>


nmap <leader>D [<C-D>
 "eval and print result
nmap <leader>ee (y%P)a<CR><Esc>c!!

function ClojureSymbolWithoutNamespace()
	let wordUnderCursor = expand("<cword>")
	let symbol = get(reverse(split(wordUnderCursor, "\/")), 0, "")
	return symbol
endfunction

function ClojureTag()
	let symb = ClojureSymbolWithoutNamespace()
	echo symb
	execute "tag " . symb
endfunction

function ClojureTagSelect()
	let symb = ClojureSymbolWithoutNamespace()
	echo symb
	execute "tselect " . symb
endfunction

nmap <leader>dd :call ClojureTag()<CR>
nmap <leader>ds :call ClojureTagSelect()<CR>


" Enable Rainbow Parentheses when dealing with Clojure files
au FileType clojure RainbowParenthesesActivate
au Syntax * RainbowParenthesesLoadRound

