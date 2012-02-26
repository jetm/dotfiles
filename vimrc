"
" Personal .vimrc file
" Maintained by Javier Tiá <javier.tia@gmail.com>
"

" General behavior
filetype plugin indent on
set nocompatible    " use vim defaults
syntax on           " syntax highlighing
set autowrite       " auto saves changes when quitting and swiching buffer
set autoread        " Set to auto read when a file is changed from the outside
set hidden          " Change buffer - without saving
set showcmd         " display incomplete commands
set nolazyredraw    " Don't redraw while executing macros
set magic           " Set magic on, for regular expressions
set nobackup        " do not keep a backup file
set sm              " show matching braces, somewhat annoying...
set scrolloff=7     " Set 7 lines to the cursors - when moving vertical..
set showmatch       " Show matching bracets when text indicator is over them
"set timeoutlen=500  " Time between each key
set virtualedit=all " allow the cursor to go in to "invalid" places
set formatoptions+=1   " When wrapping paragraphs, don't end lines
                       " with 1-letter words (looks stupid)
set matchpairs+=<:> " Allow % to bounce between angles too
set ttyfast         " smoother changes
"set ttyscroll=0    " turn off scrolling, didn't work well with PuTTY

" Enconding Stuff
set encoding=utf-8
set termencoding=utf-8
set fileformats="unix,dos,mac"

" Undo information so you can undo previous actions
" even after you close and reopen a file
if has("persistent_undo")
    set undodir=~/.vim/.undo,/tmp
    set undolevels=1000
    set undofile
endif

" Tab Stuff
set tabstop=4       " numbers of spaces of tab character
set shiftwidth=4    " numbers of spaces to (auto)indent
set shiftround      " Indent/outdent to nearest tabstop
set softtabstop=4
set expandtab       " tabs are converted to spaces, use only when required
set smarttab

" Indenting Stuff
set autoindent      " always set autoindenting on
set smartindent     " smart indent
set nocindent       " No cindent
"set copyindent
set nostartofline   " don't jump to first character when paging
set cinkeys=0{,0},:,0#,!<Tab>,!^F " Indentation the way Emacs does it

" Wrap Stuff
set wrapscan
set whichwrap+=<,>,h,l,b,s

" List Stuff
noremap <F11> :set list!<CR>

" Clutter the screen if there are tabs or trailing whitespace
if (&termencoding == "utf-8")
    if v:version >= 700
        set list listchars=tab:»·,trail:·,precedes:…,extends:…,nbsp:‗
        "set list listchars=tab:⇥·,trail:·,precedes:←,extends:→,nbsp:‗
    else
        set list listchars=tab:»·,trail:·,extends:…
    endif
else
    if v:version >= 700
        set list listchars=tab:>-,trail:.,extends:>,nbsp:_
    else
        set list listchars=tab:>-,trail:.,extends:>
    endif
endif

" Completion
set wildmode=list:longest,full

" Search Stuff
set hlsearch        " highlight searches
set incsearch       " do incremental searching
set ignorecase      " ignore case when searching
set smartcase
set gdefault        " search/replace "globally" (on a line) by default

" GUI Stuff
set cmdheight=1     " The commandbar height
set mat=2           " How many tenths of a second to blink
set ruler           " show the cursor position all the time
set number          " show line numbers
set title           " show title in console title bar
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines
set shortmess=atI   " Abbreviate messages
set titlestring=%F%m%r%h%w\ %y\ %(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set guitablabel=%t

" Statusline
"
set laststatus=2    " Always hide the statusline
set statusline=     " Format the statusline
set statusline+=%1*%h%r%F " file name
set statusline+=%1*%h%r%=[%{&encoding}\ %{&fileformat}\ %{strlen(&ft)?&ft:'none'}\ %{getfperm(@%)}]\ %12.(%c:%l/%L%)

" Session settings
set sessionoptions=resize,winpos,winsize,buffers,tabpages,folds,curdir,help

" Set backspace config
set backspace=indent,eol,start

" No sound on errors
set noerrorbells
set novisualbell        " turn off visual bell
set t_vb=               " turn off error beep/flash

" Mouse
set mouse=a             " use mouse everywhere

" [g]vim Font Stuff
if has("gui_running")
    set guifont=DejaVu\ Sans\ Mono\ 11
    set lines=40     " height
    set columns=90   " width
    " No Options Bar, icky toolbar, menu or scrollbars
    " set guioptions-=m
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R

    "colorscheme neverland2-darker " peaksea earendel jellybeans dusk
    "silent! colorscheme desert
    silent! colorscheme xoria256-mod
    set nu
else
    set t_Co=256
    "silent! colorscheme desert256
    colorscheme xoria256-mod
    "colorscheme ir_black " zellner molokai desert
    "set background=light " light dark
endif

if has("autocmd")
    " Restore cursor position
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    " Filetypes (au = autocmd)
    " no line numbers when viewing help
    au FileType helpfile,gitcommit set nonumber
    au FileType gitcommit set textwidth=72
    " Enter selects subject
    au FileType helpfile nnoremap <buffer><CR> <c-]>
    " Backspace to go back
    au FileType helpfile nnoremap <buffer><BS> <c-T>

    " Python stuff
    au FileType python let python_highlight_all = 1
    au FileType python let python_slow_sync = 1
    au FileType python set expandtab shiftwidth=4 softtabstop=4
    au FileType python set completeopt=preview

    " sh stuff
    au FileType sh set expandtab shiftwidth=2 softtabstop=4

    augroup myvimrchooks
        au!
        autocmd bufwritepost .vimrc source ~/.vimrc
    augroup END
endif

" Keyboard mappings Stuff
"
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Writing vimrc Stuff
"
" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<CR>
" Fast saving
map <leader>w :update<CR>
" Sudo to write
map <leader>W :w !sudo tee % >/dev/null<CR>
" When vimrc is edited, reload it
autocmd! bufwritepost vimrc source ~/.vimrc

" Move a line of texts using ALT+[jk]
nnoremap <A-j> :m+<CR>==
nnoremap <A-k> :m-2<CR>==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=gv
vnoremap <A-k> :m-2<CR>gv=gv

" Quickly get out of insert mode without your fingers having to leave the
" home row
inoremap jj <Esc>

" work the way you expect on long line
nnoremap j gj
nnoremap k gk

" Annoying
map! <F1> <Esc>
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>

" Fix default regex handling by automatically inserting a
" \v before any string you search for
nnoremap / /\v
vnoremap / /\v

" word/char swapping
nmap <silent> gw "_yiw:s/\(\%#\w\+\)\(\W\+\)\(\w\+\)/\3\2\1/<cr><c-o><c-l>
nmap <silent> gc xph

" force using hjkl$
noremap <Up>       :echoerr "Use k instead!"<CR>$
noremap <Down>     :echoerr "Use j instead!"<CR>$
noremap <Left>     :echoerr "Use l instead!"<CR>$
noremap <Right>    :echoerr "Use h instead!"<CR>$
noremap <M-Up>     :echoerr "Use k instead!"<CR>$
noremap <M-Down>   :echoerr "Use j instead!"<CR>$
noremap <M-Left>   :echoerr "Use l instead!"<CR>$
noremap <M-Right>  :echoerr "Use h instead!"<CR>$,
noremap <A-Up>     :echoerr "Use k instead!"<CR>$
noremap <A-Down>   :echoerr "Use j instead!"<CR>$
noremap <A-Left>   :echoerr "Use l instead!"<CR>$
noremap <A-Right>  :echoerr "Use h instead!"<CR>$,

" Copy/Paste Stuff
"
" Yank/paste to the OS clipboard with ,y and ,p
nmap <leader>y "+y
nmap <leader>Y "+yy
nmap <leader>p "+p
nmap <leader>P "+P
nmap Y y$ " Quick yanking to the end of the line
set pastetoggle=<F2>
set clipboard+=unnamedplus " yank and copy to X clipboard

" In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" gets rid of the distracting highlighting once I’ve found what I’m
" looking for
nnoremap <leader><space> :noh<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"
" Clean extra white space
"
function ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <F12>     :ShowSpaces 1<CR>
nnoremap <S-F12>   m`:TrimSpaces<CR>``
vnoremap <S-F12>   :TrimSpaces<CR>

"
" Restore Screen size and position
"
" To enable the saving and restoring of screen positions.
let g:screen_size_restore_pos = 1

" To save and restore screen for each Vim instance
" This is useful if you routinely run more than one Vim instance
" For all Vim to use the same settings, change this to 0
let g:screen_size_by_vim_instance = 1

if v:version >= 7 && has("gui_running")
  function! ScreenFilename()
    if has('amiga')
      return "s:.vimsize"
    elseif has('win32')
      return $HOME.'\_vimsize'
    else
      return $HOME.'/.vimsize'
    endif
  endfunction

  function! ScreenRestore()
    " Restore window size (columns and lines) and position
    " from values stored in vimsize file.
    " Must set font first so columns and lines are based on font size.
    let f = ScreenFilename()
    if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) == 5 && sizepos[0] == vim_instance
          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
          return
        endif
      endfor
    endif
  endfunction

  function! ScreenSave()
    " Save window size and position.
    if has("gui_running") && g:screen_size_restore_pos
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
            \ (getwinposx()<0?0:getwinposx()) . ' ' .
            \ (getwinposy()<0?0:getwinposy())
      let f = ScreenFilename()
      if filereadable(f)
        let lines = readfile(f)
        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
        call add(lines, data)
      else
        let lines = [data]
      endif
      call writefile(lines, f)
    endif
  endfunction

  if !exists('g:screen_size_restore_pos')
    let g:screen_size_restore_pos = 1
  endif
  if !exists('g:screen_size_by_vim_instance')
    let g:screen_size_by_vim_instance = 1
  endif
  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
endif

"
" Perl Stuff
"
" my perl includes pod
let perl_include_pod = 1

" syntax color complex things like @{${"foo"}}
let perl_extended_vars = 1

if v:version >= 702
    "
    " neocomplcahe Stuff
    "
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplcache.
    let g:neocomplcache_enable_at_startup = 1
    " Use smartcase.
    let g:neocomplcache_enable_smart_case = 1
    " Use camel case completion.
    let g:neocomplcache_enable_camel_case_completion = 1
    " Use underbar completion.
    let g:neocomplcache_enable_underbar_completion = 1
    " Set minimum syntax keyword length.
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplcache_dictionary_filetype_lists = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

    " Define keyword.
    if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    imap <C-k>     <Plug>(neocomplcache_snippets_expand)
    smap <C-k>     <Plug>(neocomplcache_snippets_expand)
    inoremap <expr><C-g>     neocomplcache#undo_completion()
    inoremap <expr><C-l>     neocomplcache#complete_common_string()

    " SuperTab like snippets behavior.
    "imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplcache#close_popup()
    inoremap <expr><C-e>  neocomplcache#cancel_popup()

    " AutoComplPop like behavior.
    "let g:neocomplcache_enable_auto_select = 1

    " Enable omni completion.
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType perl setlocal omnifunc=perlcomplete#Complete
    autocmd FileType bash setlocal omnifunc=bashcomplete#Complete
    autocmd FileType shell setlocal omnifunc=shellcomplete#Complete

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
    endif

    let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
    let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

endif
