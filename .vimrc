" easy toggle to allow nastly mouse based copy
nnoremap <F11> :GitGutterDisable<CR>:set norelativenumber!<CR>

" no need for shift
nnoremap ; :

" s for seek
nmap s <Plug>(easymotion-s2)

" more colors
set t_Co=256

" Vundle
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
Plugin 'gmarik/vundle'

" vertical indent line
Plugin 'Yggdroot/indentLine'

" color nested [({
Plugin 'luochen1990/rainbow'

" git
Plugin 'airblade/vim-gitgutter'

" automatic closing of quotes, parenthesis, brackets, etc
Plugin 'Raimondi/delimitMate'

" filetree browser
Plugin 'scrooloose/nerdtree'
map <C-n> :NERDTreeToggle<CR>

" obsolete due to YCM
" " all insert mode completions with tab
Plugin 'ervandew/supertab'

" syntax highlighting
Plugin 'scrooloose/syntastic'

" text alignment
Plugin 'godlygeek/tabular'

" 
Plugin 'tomtom/tlib_vim'

" common snippets for multiple languages
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

" share the registers of any and/or all vim instances
Plugin 'ardagnir/united-front'

" file find and more
Plugin 'Shougo/unite.vim'
Plugin 'Shougo/vimproc.vim'
nnoremap <Leader>f :Unite -start-insert file_rec/async<CR>

" nice statusbar
Plugin 'bling/vim-airline'

" easy comment out. e.g. gcap
Plugin 'tpope/vim-commentary'

" quicker motion
Plugin 'easymotion/vim-easymotion'

" make vim tags easier
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-easytags'

" lots of git commands
Plugin 'tpope/vim-fugitive'

" ii is indentation text object
Plugin 'michaeljsmith/vim-indent-object'

" everything puppet
Plugin 'rodjek/vim-puppet'

" change surroundings with s object
Plugin 'tpope/vim-surround'

" line object
Plugin 'kana/vim-textobj-line'
Plugin 'kana/vim-textobj-user'

" completation based on history
Plugin 'Valloric/YouCompleteMe'

" integration with tmux
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'benmills/vimux'
map <Leader>r :VimuxPromptCommand<CR>
map <Leader>a :VimuxRunLastCommand<CR>
let VimuxUseNearest = 0

call vundle#end()
filetype plugin indent on

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

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

" Show any trailing whitespace
set list
set listchars=tab:>-,trail:-

" file is large from 5mb
let g:LargeFile = 1024 * 1024 * 5
augroup LargeFile 
 autocmd BufReadPre * let f=getfsize(expand("<afile>")) | if f > g:LargeFile || f == -2 | call LargeFile() | endif
augroup END

function LargeFile()
 " no syntax highlighting etc
 set eventignore+=FileType
 " save memory when other file is viewed
 setlocal bufhidden=unload
 " is read-only (write with :w new_filename)
 setlocal buftype=nowrite
 " no undo possible
 setlocal undolevels=-1
 " display message
 autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) . " MB, so some options are changed (see .vimrc for details)."
endfunction

