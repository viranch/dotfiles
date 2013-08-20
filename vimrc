" Indentation
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
filetype plugin indent on
set cindent
au BufRead,BufNewFile *.pp set filetype=pp

" Smart highlighted search
syntax on
set hlsearch
set incsearch
set ignorecase
set smartcase

set laststatus=2
set nu
set so=14

" Put cursor at line where file was closed
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
 \| exe "normal! g'\"" | endif

" MacVim stuff
set background=dark
set guifont=Monaco:h14
"hi Normal guifg=White

" Remove trailing whitespaces
"autocmd BufWritePre * :%s/\s\+$//e

" Make trailing whitespace annoyingly highlighted.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" remap annoying capitals
:command WQ wq
:command Wq wq
:command W w
:command Q q
:command Set set
:command E e
