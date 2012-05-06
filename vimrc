"
" Personal .vimrc file
" Maintained by Javier Tiá <javier.tia@gmail.com>
"

" Setting pathogen plugin
if v:version > 700
    call pathogen#helptags()
    call pathogen#infect('~/repos/vim-plugins')
endif

syntax on           " syntax highlighing
filetype plugin indent on

" General behavior
set nocompatible    " use vim defaults
set autowrite       " auto saves changes when quitting and swiching buffer
set autoread        " Set to auto read when a file is changed from the outside
set hidden          " Change buffer - without saving
set showcmd         " display incomplete commands
set magic           " Set magic on, for regular expressions
set nobackup        " do not keep a backup file
set sm              " show matching braces, somewhat annoying...
set scrolloff=7     " Set 7 lines to the cursors - when moving vertical..
set linespace=0     " No extra spaces between rows
set scrolljump=5    " lines to scroll when cursor leaves screen
set showmatch       " Show matching bracets when text indicator is over them
set virtualedit=all " allow the cursor to go in to "invalid" places
set formatoptions+=1   " When wrapping paragraphs, don't end lines
                       " with 1-letter words (looks stupid)
set matchpairs+=<:> " Allow % to bounce between angles too
set ttyfast         " smoother changes
set history=1000    " Store a ton of history (default is 20)
set shortmess+=filmnrxoOtT      " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility

" Enconding Stuff
scriptencoding utf-8
set encoding=utf-8 nobomb       " UTF-8 without OEM
set termencoding=utf-8
set fileformats="unix,dos,mac"

" Undo information so you can undo previous actions
" even after you close and reopen a file
if has("persistent_undo")
    set undodir=~/.vim/.undo,/tmp
    set undofile
    set undolevels=1000    "max # of changes that can be undone
    set undoreload=10000   "max # lines to save for undo on a buffer reload
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
"set smartindent     " smart indent
set nocindent       " No cindent
"set copyindent
set nostartofline   " don't jump to first character when paging
set cinkeys=0{,0},:,0#,!<Tab>,!^F " Indentation the way Emacs does it

" Wrap Stuff
set wrapscan
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to

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

" Wildmenu / Completion
if has("wildmenu")
    set wildmenu
    set wildmode=list:longest,full
    if has("wildignore")
        set wildignore+=*.a,*.o
        set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png
        set wildignore+=.DS_Store,.git,.hg,.svn
        set wildignore+=*~,*.swp,*.tmp
    endif
    if exists("&wildignorecase")
        set wildignorecase
    endif
endif

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
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
set number          " show line numbers
set title           " show title in console title bar
set modeline        " last lines in document sets vim mode
set modelines=3     " number lines checked for modelines
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

    autocmd FileType make set noexpandtab

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

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

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

" Stupid shift key fixes
cmap W w
cmap WQ wq
cmap wQ wq
cmap Q q
cmap Tabe tabe

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

" Adjust viewports to the same size
map <Leader>= <C-w>=

" Mapping commentary Plugin
" FIXME: Add a way to check commentary Plugin is loaded
map <leader>c \\

if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
        \if &omnifunc == "" |
        \setlocal omnifunc=syntaxcomplete#Complete |
        \endif
endif

hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

" Tabularize {
if exists(":Tabularize")
    nmap <Leader>a= :Tabularize /=<CR>
    vmap <Leader>a= :Tabularize /=<CR>
    nmap <Leader>a: :Tabularize /:<CR>
    vmap <Leader>a: :Tabularize /:<CR>
    nmap <Leader>a:: :Tabularize /:\zs<CR>
    vmap <Leader>a:: :Tabularize /:\zs<CR>
    nmap <Leader>a, :Tabularize /,<CR>
    vmap <Leader>a, :Tabularize /,<CR>
    nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
    vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

    " The following function automatically aligns when typing a
    " supported character
    inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

    function! s:align()
        let p = '^\s*|\s.*\s|\s*$'
        if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
            let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
            let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
            Tabularize/|/l1
            normal! 0
            call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
        endif
    endfunction

endif
" }

" some convenient mappings
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menu,preview,longest

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
function! ShowSpaces(...)
  let @/='\v(\s+$)|( +\ze\t)'
  let oldhlsearch=&hlsearch
  if !a:0
    let &hlsearch=!&hlsearch
  else
    let &hlsearch=a:1
  end
  return oldhlsearch
endfunction

function! TrimSpaces() range
  let oldhlsearch=ShowSpaces(1)
  execute a:firstline.",".a:lastline."substitute ///gec"
  let &hlsearch=oldhlsearch
endfunction

command! -bar -nargs=? ShowSpaces call ShowSpaces(<args>)
command! -bar -nargs=0 -range=% TrimSpaces <line1>,<line2>call TrimSpaces()
nnoremap <F12>           :ShowSpaces 1<CR>
nnoremap <Leader><F12>   m`:TrimSpaces<CR>``
vnoremap <Leader><S-F12> :TrimSpaces<CR>

highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" CtrlP
let g:ctrlp_match_window_bottom = 0 " Show at top of window
let g:ctrlp_working_path_mode = 2 " Smart path mode
let g:ctrlp_mru_files = 1 " Enable Most Recently Used files feature
let g:ctrlp_jump_to_buffer = 2 " Jump to tab AND buffer if already open
let g:ctrlp_split_window = 1 " <CR> = New Tab

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
    " AutoComplPop like behavior.
    let g:neocomplcache_enable_auto_select = 0
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
    let g:neocomplcache_enable_auto_delimiter = 1

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

    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
        let g:neocomplcache_omni_patterns = {}
    endif

    " Plugin key-mappings.
    imap <C-k>     <Plug>(neocomplcache_snippets_expand)
    smap <C-k>     <Plug>(neocomplcache_snippets_expand)
    inoremap <expr><C-g>     neocomplcache#undo_completion()
    inoremap <expr><C-l>     neocomplcache#complete_common_string()

    " <CR>: close popup
    " <s-CR>: close popup and save indent.
    inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"
    inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup() "\<CR>" : "\<CR>"
    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplcache#close_popup()
    inoremap <expr><C-e>  neocomplcache#cancel_popup()

    " Enable omni completion.
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType perl setlocal omnifunc=perlcomplete#Complete
    autocmd FileType bash setlocal omnifunc=bashcomplete#Complete
    autocmd FileType shell setlocal omnifunc=shellcomplete#Complete

    " For snippet_complete marker.
    if has('conceal')
        set conceallevel=2 concealcursor=i
    endif
endif
