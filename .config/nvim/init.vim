if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" easy toggle to allow nastly mouse based copy
nnoremap <F11> :GitGutterDisable<CR>:set norelativenumber!<CR>

" disable highlighted last search
nnoremap <F3> :set hlsearch!<CR>

" no need for shift
nnoremap ; :

call plug#begin('~/.config/nvim/plugged')

" 2 char f behavior
Plug 'justinmk/vim-sneak'
nmap f <Plug>Sneak_s
nmap F <Plug>Sneak_S
xmap f <Plug>Sneak_s
xmap F <Plug>Sneak_S
omap f <Plug>Sneak_s
omap F <Plug>Sneak_S

" tagsbar
Plug 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_puppet = {
    \ 'ctagstype': 'puppet',
    \ 'kinds': [
        \'c:class',
        \'s:site',
        \'n:node',
        \'d:definition'
      \]
    \}

" gr to replace with buffer without yank
Plug 'vim-scripts/ReplaceWithRegister'

" color nested [({
Plug 'luochen1990/rainbow'

" edit surrounding
Plug 'tpope/vim-surround'

" copy to system clipboard with cp
Plug 'christoomey/vim-system-copy'

" syntax based closing statements
Plug 'tpope/vim-endwise'

" syntax based closing statements
Plug 'rstacruz/vim-closer'

" git
Plug 'airblade/vim-gitgutter'

" filebrowser
Plug 'tpope/vim-vinegar'

" q to exit netrw
autocmd FileType netrw nnoremap q :bd<CR>

" all insert mode completions with tab
Plug 'ervandew/supertab'

" syntax highlighting
Plug 'benekastah/neomake'
autocmd! BufWritePost * Neomake

" text alignment
Plug 'godlygeek/tabular'

" 
Plug 'tomtom/tlib_vim'

" file find and more
"Plug 'Shougo/denite.vim'
Plug 'Shougo/unite.vim'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" nnoremap <Leader>f :Unite -start-insert -force-redraw -toggle -no-split -resume file_rec/neovim<CR>
" nnoremap <Leader>g :Unite -toggle -no-split -force-redraw -resume grep:.<CR>
"nnoremap <Leader>s :UniteWithCursorWord -toggle -no-split -force-redraw -resume grep:.<CR>
nnoremap <Leader>b :Unite -toggle -no-split -resume buffer:-<CR>
nnoremap <Leader>r :Unite -toggle -no-split -resume register<CR>
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_max_files = 0
let g:ctrlp_lazy_update = 1
" nnoremap <Leader>f :CtrlP :pwd<CR>

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
nnoremap <Leader>f :Files<CR>


command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap <Leader>g :Ag<space>
" auto close quickfix window after selection
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

nnoremap s :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><CR>

" dont select first match - confusing
let g:unite_enable_auto_select = 0

" apt-get install silversearcher-ag
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif


" nice statusbar
Plug 'bling/vim-airline'

" easy comment out. e.g. gcap
Plug 'tpope/vim-commentary'

" quicker motion
"Plug 'easymotion/vim-easymotion'

" lots of git commands
Plug 'tpope/vim-fugitive'

" ii is indentation text object
Plug 'michaeljsmith/vim-indent-object'

" everything puppet
Plug 'rodjek/vim-puppet'

" change surroundings with s object
Plug 'tpope/vim-surround'

" line object
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'

" various completion stuff
Plug 'Shougo/deoplete.nvim'

" " be smart about pasting into vim
" Plug 'ConradIrwin/vim-bracketed-paste'

call plug#end()

""" :terminal magic

" Window split settings
highlight TermCursor ctermfg=red guifg=red
set splitbelow
set splitright

" term in a split, also reuse existing terms
nnoremap <Leader>t :call TermEnter()<CR>

" dont close terminal buffer
autocmd TermOpen * set bufhidden=hide

set switchbuf+=useopen
function! TermEnter()
  let bufcount = bufnr("$")
  let currbufnr = 1
  let nummatches = 0
  let firstmatchingbufnr = 0
  while currbufnr <= bufcount
    if(bufexists(currbufnr))
      let currbufname = bufname(currbufnr)
      if(match(currbufname, "term://") > -1)
        echo currbufnr . ": ". bufname(currbufnr)
        let nummatches += 1
        let firstmatchingbufnr = currbufnr
        break
      endif
    endif
    let currbufnr = currbufnr + 1
  endwhile
  if(nummatches >= 1)
    execute ":sbuffer ". firstmatchingbufnr
    startinsert
  else
    execute "split"
    execute "terminal"
    execute "resize 15"
  endif
endfunction

" easy terminal to command mode
tnoremap <Esc> <C-\><C-n>

" crtl+<left/right> for word back and forward in insert mode
tnoremap <C-Left> <m-b>
tnoremap <C-Right> <m-f>

" more scrollback buffer
:au TermOpen * :let  g:terminal_scrollback_buffer_size=100000

" Window navigation keys
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>




if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" fix common typos
:command WQ wq
:command Wq wq
:command W w
:command Q q

syntax on

" " neovim enabled
" set autoindent
" set backspace=indent,eol,start " Set for maximum backspace smartness"
" set encoding=utf-8
" set hlsearch
" set incsearch
" set laststatus=2        " Always show status bar
" set wildmenu            " Enhanced command line completion mode
" set listchars=tab:>-,trail:-

" set clipboard+=unnamedplus
" let g:indentLine_noConcealCursor="" " concealing quotes is bad
set cmdheight=1         " Less Hit Return messages
set cursorline
"set display+=uhex " Show unprintables as <xx>
set expandtab
set ignorecase
set linespace=1 " add some line space for easy reading
set list
set noshowmode
set relativenumber
set number
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


" Disable mouse click to go to position
set mouse-=a

set wildchar=<TAB>      " Character to start command line completion
set wildmode=longest:full,full

set undofile
set undodir=~/.vim/undo

let g:rainbow_active = 1
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#eclim#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = 'no scm'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tagbar#flags = 'f'
let g:airline#extensions#hunks#enabled = 1
let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
let g:airline_section_b = '%{getcwd()}'

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

" somehow filetype = conf for pp files. fixing
" augroup filetypedetect
"   au BufNewFile,BufRead *.pp setl ft=puppet
" augroup END

" puppet-lint.rc isnt respected by syntastic
let g:syntastic_puppet_puppetlint_args="no-80chars-check"

" only show the cursorline when theres focus
augroup highlight_follows_focus
    autocmd!
    autocmd WinEnter * set cursorline
    autocmd WinLeave * set nocursorline
augroup END

augroup highligh_follows_vim
    autocmd!
    autocmd FocusGained * set cursorline
    autocmd FocusLost * set nocursorline
augroup END

" open current buffer as new tab and use ctrl+w c .. to get back
nnoremap <Leader>m :tab sp<CR>

" ctags
let g:tagbar_type_puppet = {
    \ 'ctagstype': 'puppet',
    \ 'kinds': [
        \'c:class',
        \'s:site',
        \'n:node',
        \'d:definition'
      \]
    \}

" K is google search
" set keywordprg=~/bin/openfromvim.sh
nnoremap K :silent ! /home/wleese/bin/openfromvim.sh <c-r><c-w><cr>
