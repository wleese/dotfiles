nnoremap <F11> :set nonumber!<CR>:GitGutterDisable<CR>:set norelativenumber<CR>
map <C-n> :NERDTreeToggle<CR>

map <Leader>r :VimuxPromptCommand<CR>
map <Leader>a :VimuxRunLastCommand<CR>
let VimuxUseNearest = 0

" no need for shift
nnoremap    ;     :

" s for seek
nmap s <Plug>(easymotion-s2)

" q no more
"map q :

set t_Co=256

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Vundle
Bundle 'gmarik/vundle'
Bundle 'Raimondi/delimitMate'
Bundle 'Yggdroot/indentLine'
Bundle 'scrooloose/nerdtree'
Bundle 'luochen1990/rainbow'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
Bundle 'godlygeek/tabular'
Bundle 'tomtom/tlib_vim'
Bundle 'SirVer/ultisnips'
Bundle 'ardagnir/united-front'
Bundle 'Shougo/unite.vim'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-commentary'
Bundle 'easymotion/vim-easymotion'
Bundle 'xolox/vim-easytags'
Bundle 'tpope/vim-fugitive'
Bundle 'airblade/vim-gitgutter'
Bundle 'michaeljsmith/vim-indent-object'
Bundle 'xolox/vim-misc'
Bundle 'Shougo/vimproc.vim'
Bundle 'rodjek/vim-puppet'
Bundle 'honza/vim-snippets'
Bundle 'tpope/vim-surround'
Bundle 'kana/vim-textobj-line'
Bundle 'kana/vim-textobj-user'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'benmills/vimux'
Bundle 'Valloric/YouCompleteMe'

filetype plugin indent on

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unite plugin
nnoremap <Leader>f :Unite -start-insert file_rec/async<CR>

" fix common typos
:command WQ wq
:command Wq wq
:command W w
:command Q q

syntax on
set autoindent
set backspace=indent,eol,start " Set for maximum backspace smartness"
set cmdheight=1         " Less Hit Return messages
set cursorline
set display+=uhex " Show unprintables as <xx>
set encoding=utf-8
set expandtab
set fileencodings=utf-8
set fileencodings=utf-8,ucs-bom,cp1251
set fileencoding=utf-8
set fileformats=unix,dos,mac
set fileformat=unix
set gdefault
set hlsearch
set ignorecase
set incsearch
set laststatus=2        " Always show status bar
set linespace=1 " add some line space for easy reading
set nocompatible
set noshowmode
set relativenumber
set pastetoggle=<F10>
set scrolloff=3 " don't scroll any closer to top/bottom
set secure
set shiftwidth=2
set shortmess=aoOtT     " Abbreviate the status messages
set showcmd             " Show command I'm typing
set showmatch           " show matching ({[
set sidescrolloff=5 " don't scroll any closer to left/right
set smartcase
set smartindent
set smarttab
set softtabstop=2
set tabstop=2
set timeoutlen=500

set wildchar=<TAB>      " Character to start command line completion
set wildmenu            " Enhanced command line completion mode
set wildmode=longest:full,full

set undofile
set undodir=~/.vim/undo

let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

let g:delimitMate_expand_cr = 2
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_inside_quotes = 1
let g:delimitMate_balance_matchpairs = 1
let g:delimitMate_jump_expansion = 1
let g:rainbow_active = 1
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#eclim#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = 'no scm'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
let g:airline#extensions#ctrlp#color_template = 'normal'
let g:airline#extensions#ctrlp#show_adjacent_modes = 1

let g:UltiSnipsExpandTrigger       ="<c-tab>"
let g:UltiSnipsJumpForwardTrigger  = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" Enable tabbing through list of results
function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au InsertEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"

" Expand snippet or return
let g:ulti_expand_res = 0
function! Ulti_ExpandOrEnter()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res
        return ''
    else
        return "\<return>"
endfunction

" Set <space> as primary trigger
inoremap <return> <C-R>=Ulti_ExpandOrEnter()<CR>
