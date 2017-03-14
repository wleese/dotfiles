if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/wleese/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/wleese/.config/nvim/dein')
  call dein#begin('/home/wleese/.config/nvim/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/wleese/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/denite.nvim')              " Unite dark powered
  call dein#add('Shougo/deoplete.nvim')            " completion
  call dein#add('Shougo/deoplete-rct')             " Ruby code completion. requires gem install rcodetools
  call dein#add('zchee/deoplete-jedi')             " Python code completion. requires python-jedi
  call dein#add('zchee/deoplete-go')               " because vim-go only does neocomplete
  call dein#add('Shougo/neomru.vim')               " Unite mru
  call dein#add('Shougo/unite.vim')                " needed for mru, tag
  call dein#add('jodosha/vim-godebug')             " godebug. requires delve: go get github.com/derekparker/delve/cmd/dlv

  call dein#add('Neomake/neomake')             " async syntax checker
  call dein#add('airblade/vim-gitgutter')
  call dein#add('ervandew/supertab')               " all insert mode completions with tab
  call dein#add('fatih/vim-go')
  call dein#add('jeetsukumaran/vim-indentwise')    " Smart indent moves - great for yaml
  call dein#add('jreybert/vimagit')                " git stuff
  call dein#add('kana/vim-textobj-line')           " line obj
  call dein#add('kana/vim-textobj-user')           " dependency for line
  call dein#add('ap/vim-buftabline')               " tab ar becomes buffer bar
  call dein#add('majutsushi/tagbar')               " tagbar
  call dein#add('michaeljsmith/vim-indent-object') " ii is indentation text object
  call dein#add('rafi/awesome-vim-colorschemes')
  call dein#add('rafi/vim-tinyline')               " nice statusbar
  call dein#add('rodjek/vim-puppet')
  call dein#add('rstacruz/vim-closer')             " improves endwise behavior

  call dein#add('ekalinin/Dockerfile.vim')
  call dein#add('bogado/file-line')                " allow vim file:12343 opening
  call dein#add('elzr/vim-json')

  call dein#add('tpope/vim-commentary')            " gc comment
  call dein#add('tpope/vim-endwise')               " syntax based closing statements
  call dein#add('tpope/vim-fugitive')              " git commands
  call dein#add('tpope/vim-repeat')                " better . behavior
  call dein#add('tpope/vim-surround')              " change surroundings with s
  call dein#add('tpope/vim-sleuth')                " smart shiftwidth & expandtab
  call dein#add('tpope/vim-vinegar')               " fileman

  call dein#add('ryanoasis/vim-devicons')          " various nice icons
  call dein#add('rhysd/clever-f.vim')              " ff is repeat f plus highlighting


  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

" -------------- CONFIG --------------
"
let mapleader = " "

" Show modified buffer (because we use set hidden)
let g:buftabline_indicators = 1

" jreybert/vimagit
let g:magit_default_fold_level=1
let g:magit_default_sections = ['commit', 'staged', 'unstaged']
let g:magit_show_magit_mapping="<Leader>g"
nnoremap <leader>gps :! gps $(dirname %:p)<CR>

" majutsushi/tagbar
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

"fatih/vim-go { 'do': ':GoInstallBinaries'}
" handle go imports
let g:go_fmt_command = "goimports"

" don't hide json quotes
let g:vim_json_syntax_conceal = 0

" Denite
nnoremap <Leader>f :DeniteProjectDir -mode=insert file_rec<CR>
nnoremap <Leader>s :DeniteProjectDir -mode=insert grep<CR>
nnoremap <Leader>m :Denite -mode=normal unite:file_mru<CR>
nnoremap <Leader>r :Denite -mode=normal unite:register<CR>

let g:deoplete#enable_at_startup = 1
set omnifunc=syntaxcomplete#Complete

" crtl+<left/right> for word back and forward in insert mode
tnoremap <C-Left> <m-b>
tnoremap <C-Right> <m-f>

" split navigation keys
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" cycle through splits with enter
nnoremap <enter> <c-w>w

" cycle through buffers with tab
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>

" q to exit netrw
autocmd FileType netrw nnoremap q :bd<CR>

" keys to browse denite results
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

" fix common typos
:command WQ wq
:command Wq wq
:command W w
:command Q q
nnoremap ; :

set cmdheight=1         " Less Hit Return messages
set cursorline
set expandtab
set ignorecase
set linespace=1 " add some line space for easy reading
set list
set hidden       " allow buffer switching without saving an existing buffer
set mouse-=a " Disable mouse click to go to position
set noshowmode
set number
set relativenumber
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
set undodir=~/.vim/undo
set undofile
set wildchar=<TAB>      " Character to start command line completion
set wildmode=longest:full,full
set background=dark
colorscheme hybrid

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

autocmd FileType go nmap <leader>d <Plug>(go-doc)
autocmd FileType go nmap <leader>b  <Plug>(go-build)
autocmd FileType go nmap <leader>r  <Plug>(go-run)
autocmd FileType go nmap <leader>t  <Plug>(go-test)

" under cursor type info
"let g:go_auto_type_info = 1

autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>  " auto close quickfix window after selection

nnoremap <F11> :GitGutterDisable<CR>:set norelativenumber!<CR>:set nonumber!<CR> " easy toggle to allow nastly mouse based copy


" ------------- Embedded terminal stuff -------------
"  
" Window split settings
highlight TermCursor ctermfg=red guifg=red
set splitbelow
set splitright

" term in a split, also reuse existing terms
nnoremap \t :call TermEnter()<CR>

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

tnoremap <Esc> <C-\><C-n> " easy terminal to command mode
au TermOpen * :let  g:terminal_scrollback_buffer_size=100000  " more scrollback buffer

" jump to puppet definition (no line number jump yet)
autocmd FileType puppet nmap gd "zyiW :call FindPuppetDefinition('<C-r>z')<CR>
function! FindPuppetDefinition(word)
  if !empty(a:word)
    silent !clear
    let output = system('/usr/local/bin/goto-puppet-definition.sh ' . a:word)

    vsplit __Puppet_Definition__
    normal! ggdG
    setlocal filetype=puppetdefinition
    setlocal buftype=nofile

    let l:bufn = bufnr("%")
    exec ":bwipeout " l:bufn

    exec "keepalt edit " . output
    exec "normal! zz"
  else
    echo "Empty search term"
  endif
endfunction

autocmd User VimagitBufferInit call system(g:magit_git_cmd . " add -u " . magit#git#top_dir())

" Workaround for weird chars in broken terminator (works in konsole tho)
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0

" syntax check puppet
autocmd! BufWritePost *.pp,*.sh Neomake
