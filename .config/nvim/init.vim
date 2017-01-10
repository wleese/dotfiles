if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" easy toggle to allow nastly mouse based copy
nnoremap <F11> :GitGutterDisable<CR>:set norelativenumber!<CR>:set nonumber!<CR>

" no need for shift
nnoremap ; :

call plug#begin('~/.config/nvim/plugged')

" easy split maximize
Plug 'szw/vim-maximizer'
nnoremap <Leader>m :MaximizerToggle<cr>

" git stuff
Plug 'jreybert/vimagit'
let g:magit_default_fold_level=2
nnoremap <Leader>g :MagitOnly<CR>
nnoremap <leader>gps :! gps<CR>

" highlight current search hit
Plug 'timakro/vim-searchant'

" Smart indent moves - great for yaml
Plug 'jeetsukumaran/vim-indentwise'

" better . behavior
Plug 'tpope/vim-repeat'

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

" go
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries'}
" handle go imports
let g:go_fmt_command = "goimports"

" color schemes
Plug 'rafi/awesome-vim-colorschemes'

" copy to sys clipboard
"set clipboard^=unnamedplus,unnamed

" syntax based closing statements
Plug 'tpope/vim-endwise'

" syntax based closing statements
Plug 'rstacruz/vim-closer'

" git
Plug 'airblade/vim-gitgutter'

" Denite
Plug 'Shougo/denite.nvim'

" filebrowser
Plug 'tpope/vim-vinegar'

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
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
nnoremap <Leader>f :DeniteProjectDir -mode=insert file_rec<CR>
nnoremap <Leader>s :DeniteProjectDir -mode=insert grep<CR>
nnoremap <Leader>r :Denite -mode=normal file_mru<CR>
Plug 'Shougo/neomru.vim'

"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
"Plug 'junegunn/fzf.vim'

"" nice statusbar
Plug 'rafi/vim-tinyline'

" easy comment out. e.g. gcap
Plug 'tpope/vim-commentary'

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
let g:deoplete#enable_at_startup = 1

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
set omnifunc=syntaxcomplete#Complete


Plug 'Konfekt/FastFold'

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
    execute "resize 25"
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

" delete to blackhole
nnoremap <Leader>d "_dd


" fix common typos
:command WQ wq
:command Wq wq
:command W w
:command Q q

syntax on

set cmdheight=1         " Less Hit Return messages
set cursorline
set expandtab
set ignorecase
set linespace=1 " add some line space for easy reading
set list
set noshowmode
set relativenumber
set number
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
"nnoremap <Leader>m :tab sp<CR>

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
let g:tagbar_compact = 1
let g:tagbar_show_linenumbers = 1

"let g:solarized_termcolors=256
set background=dark
colorscheme hybrid

" cycle through splits with backspace
nnoremap <bs> <c-w>w

" go tabs
au FileType go setlocal noexpandtab nolist

" remove trailing whitespace
autocmd BufWritePre *.yaml,*.pp :%s/\s\+$//e

" folding
autocmd Syntax go,json setlocal foldmethod=syntax
autocmd Syntax go normal zR
autocmd FileType go normal zR
autocmd Syntax json normal zR
autocmd Syntax yaml setlocal foldmethod=indent
autocmd Syntax yaml normal zR
autocmd Syntax yml setlocal foldmethod=indent
autocmd Syntax yml normal zR

nnoremap <Leader>a :Gstatus<cr>

autocmd FileType go nmap <leader>d <Plug>(go-doc)
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)
" under cursor type info
"let g:go_auto_type_info = 1
"set updatetime=200

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --vimgrep
  set grepformat^=%f:%l:%c:%m   " file:line:column:message
endif

function! MySearch()
  let grep_term = input("Enter search term: ")
  if !empty(grep_term)
    execute 'silent grep' grep_term | copen
  else
    echo "Empty search term"
  endif
  redraw!
endfunction

command! Search call MySearch()

nnoremap <leader>q :Search<CR>

call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)

call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)

" auto close quickfix window after selection
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" q to exit netrw
autocmd FileType netrw nnoremap q :bd<CR>
