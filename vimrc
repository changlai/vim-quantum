" License:
"   MIT
" Author: 
"   Changlai Du (cdu@gtsi.edu.cn) 
" Revision:
"   2024.05.19

""" Settings
"""" Compatibility
set nocompatible            " Stop behaving like vi

"""" File I/O/Encoding 
set autoread                " Read file automatically if changed outside of vim
set autochdir               " Change working directory when switch buffers
set noautowrite             " Never write a file unless I request it
set noautowriteall          " NEVER
set nomodeline              " Disallow vim options to be embedded in files
set modelines=5             " Set modeline within the first or last 5 lines
set nomodelineexpr          " Safer; set it to enable folding for this file 
set encoding=utf-8          " Set how vim shall represent characters internally
set fileencoding=utf-8      " Set the encoding for a particular file
set ambiwidth=double        " Use double width for CJK glyphs in the font
set nowritebackup           " Use version control systems, don't write backup 
set nobackup                " Don't save backup files
set noswapfile              " Don't create swapfile for new buffer

"""" User Interface
set guioptions=c            " No GUI widgets are shown; confirm in console
set confirm                 " Y-N-C prompt if closing with unsaved changes
set belloff=all             " Disable all bells, hate ringing/flashing

"""" Windows
set splitright              " Vsplit windows open to the right of the current
set splitbelow              " Split windows open below the current
set ruler                   " Show line and column of cursor
set number                  " Display line numbers
set cursorline              " Highlight the cursor line
set textwidth=79            " Line broken at column 79
set colorcolumn=80          " Highlight column 80
set wrap                    " Soft wrap at the width of the window
set linebreak               " Don't wrap in the middle of a word

"""" Buffers
set hidden                  " Hide modified buffers when they are abandoned

"""" Command Line
set cmdheight=2             " Avoid hit-enter prompts
set history=1000            " Keep a very long command-line history
set wildmenu                " Menu completion in command mode on <Tab>
set wildmode=full           " <Tab> cycles between all matching choices.

"""" Moving Around
set showmatch               " Highlight matching paren {[()]}
set matchtime=5             " for only .5 seconds
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and SOL
set whichwrap=b,s,h,l,<,>   " <BS> <Space> h l <Left> <Right> can change lines

"""" Text Formatting
set formatoptions+=n        " Format numbered lists

"""" Insert completion
"set completeopt-=preview    " Don't show preview menu for tags.
"set infercase               " Try to adjust insert completions for case.

"""" Tags
"set tags=./tags;/home       " Tags can be in ./tags, ../tags, ..., /home/tags.
"set showfulltag             " Show more information while completing tags.
"set cscopetag               " When using :tag, <C-]>, or "vim -t", try cscope:
"set cscopetagorder=0        " try ":cscope find g foo" and then ":tselect foo"

"""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches
set smartcase               " unless uppercase letters are used in the regex
set hlsearch                " Highlight searches by default
set incsearch               " Incrementally search while typing a /regex

"""" Folding
set foldmethod=syntax       " By default, use syntax to determine folds

"""" Tabs/Indent Levels
set autoindent              " Do dumb autoindentation when no filetype is set
set tabstop=4               " Set tab characters to 4 spaces wide
set shiftwidth=4            " The amount to block indent when using < and >
set softtabstop=4           " <BS> over an autoindent deletes 4 spaces
set expandtab               " Replaces a <TAB> with spaces--more portable
set smarttab                " Uses shiftwidth not tabstop at start of lines

"""" Per-Filetype Scripts
filetype on                 " Enable filetype detection
filetype indent on          " Use filetype-specific indenting where available
filetype plugin on          " Allow for filetype-specific plugins
syntax on                   " Turn on per-filetype syntax highlighting

""" Autocmds
if has("autocmd")
  augroup vimrcEx
  au!
  " In plain-text files, wrap automatically at 79 chars
  "au FileType text setlocal tw=79 fo+=t

  " Try to jump to the last spot the cursor was at in a file when reading it
  au BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

  " Use :make to compile C, even without a makefile
  au FileType c   if glob('[Mm]akefile') == "" | let &mp="gcc -o %< %" | endif

  " Use :make to compile C++, too
  au FileType cpp if glob('[Mm]akefile') == "" | let &mp="g++ -o %< %" | endif

  " When reading a file, :cd to its parent directory unless it's a help file.
  au BufEnter * if &ft != 'help' | silent! cd %:p:h | endif

  augroup END
endif

""" Key Mappings
" Define the leader to right little finger
let mapleader=";"
let maplocalleader=";"

" Quick force write/quit in normal mode 
nnoremap <leader>w :w!<cr>
nnoremap <leader>q :q!<cr>

" Quick source vimrc
if has('win32') || has('win64')
    nnoremap <leader>s :source $VIM/_vimrc<cr>
elseif has('unix')
    nnoremap <leader>s :source $HOME/.vimrc<cr>
endif

" Toggle search term highlighting
nnoremap <silent> <leader><space> :set hlsearch! <bar> set hlsearch?<CR>

" Navigate to alternate buffer of current window 
map <leader>b :b#<cr>
" Navigate to alternate buffer and delete current buffer
map <leader>d :b#\|bd#<cr>

" Press j and k at the same time to Esc
inoremap jk <Esc>
inoremap kj <Esc>

"Replace the word under cursor with most recently yanked/deleted
nnoremap <leader>y yiw
nnoremap <leader>p viw"0p

" Navigate between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Copy to and paste from system clipboard(s)
noremap <C-y> "*y
noremap <C-p> "*p
noremap <C-Y> "+y
noremap <C-P> "+p

" Toggle folds opened and closed in normal mode
nnoremap <space> za

" Create a fold over the marked range in visual mode
vnoremap <space> zf

" Use very magic in normal mode and command line
nnoremap / /\v
cnoremap s/ s/\v

""" Plugin Settings
"""" NERD
" Align line-wise comment delimiters flush left 
let g:NERDDefaultAlign = 'left'

" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

"""" vimtex
let g:tex_flavor='latex'
let b:vimtex_main='main.tex'

if has('win32') || has('win64')
    let g:vimtex_view_general_viewer = 'SumatraPDF'
    let g:vimtex_view_general_options 
                \ = ' -reuse-instance '
                \ . ' -forward-search @tex @line @pdf '
                \ . ' -inverse-search "gvim --remote-silent +\%l \%f" '
elseif has('unix')
  if has('mac')
      let g:vimtex_view_method = 'skim'
      let g:vimtex_view_skim_sync = 1
      let g:vimtex_view_skim_activate = 0 
  else
  endif
endif

let g:vimtex_compiler_latexmk = {
    \ 'build_dir' : 'build',
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ], 
    \}

function! TeX_format_current_paragraph()
    if (getline(".") != "")
        let save_cursor = getpos(".")
        let op_wrapscan = &wrapscan
        set nowrapscan
        let par_begin = '\v'.'^\s*($|\\label|\\begin|\\end|\\[|\\]|\\(sub)*section>|\\noindent>)'
        let par_end = par_begin
        try
          exe '?'.par_begin.'?+'
        catch /E384/
          1
        endtry
        norm V
        try
          exe '/'.par_end.'/-'
        catch /E385/
          $
        endtry
        norm gq
        let &wrapscan = op_wrapscan
        call setpos('.', save_cursor) 
    endif
endfunction
map <silent> <leader>f :call TeX_format_current_paragraph()<CR>

let &formatlistpat='\v'.'^\s*\\item+\s*'

" overrule buggy tex and vimtex indent 
autocmd FileType tex setlocal indentexpr=""

"""" Python
""""" ALE
let g:ale_set_highlights = 0
let g:ale_echo_msg_format = '[%linter%][%severity%] %s'

let g:ale_sign_error = "〇"
let g:ale_sign_warning = "〇"

nmap <Leader>en <Plug>(ale_next)
nmap <Leader>ep <Plug>(ale_previous)
nnoremap <Leader>ts :ALEToggle<CR>

""" Colors and Fonts
" Installed as a plugin using shell script
colorscheme quantum         

" Some fonts should be installed separately
if has('win32') || has('win64')
    set guifont=YaHei_Consolas_Hybrid:h11:cDEFAULT
elseif has('unix')
    set guifont=Roboto_Mono:h16
endif

""" Functions
"""" Quick Run
map <leader>fr :call CompileRun()<CR>
function! CompileRun()
    exec "w"
    
    if has('win32') || has('win64')
        let time_cmd = ""
    else
        let time_cmd = "time"
    endif

    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "!".time_cmd." ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "!".time_cmd." ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!".time_cmd." java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!".time_cmd." python %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
"        exec "!go build %<"
        exec "!".time_cmd." go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunction

"""" Unit Test
map <leader>ft :call UnitTest()<CR>
function! UnitTest()
    exec "w"
    
    if has('win32') || has('win64')
        let time_cmd = ""
    else
        let time_cmd = "time"
    endif

    if &filetype == 'c'
    elseif &filetype == 'cpp'
    elseif &filetype == 'java'
        exec "!rm $(find . -name '*.class')"
        exec "!javac -cp .:junit-4.12.jar:hamcrest-2.2.jar %"
        exec "new | 0r !java -cp .:junit-4.12.jar:hamcrest-2.2.jar org.junit.runner.JUnitCore #<"
    elseif &filetype == 'sh'
    elseif &filetype == 'python'
        exec "!".time_cmd." py.test "
    endif
endfunction

"""" Check Style
map <leader>fy :call CheckStyle()<CR>
function! CheckStyle()
    exec "w"
    
    if &filetype == 'c'
    elseif &filetype == 'cpp'
    elseif &filetype == 'java'
        exec "!java -jar checkstyle-8.12-all.jar -c CS1332-checkstyle.xml %" 
    elseif &filetype == 'sh'
    elseif &filetype == 'python'
    endif
endfunction
"" vim:fdm=expr:fdl=0
"" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
