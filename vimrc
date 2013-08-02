" Indentation
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent

" Ruby specific indentation
au BufRead,BufNewFile *.rb set shiftwidth=2
au BufRead,BufNewFile *.rb set softtabstop=2
au BufRead,BufNewFile *.rb set tabstop=2
au BufRead,BufNewFile *.pp set shiftwidth=2
au BufRead,BufNewFile *.pp set softtabstop=2
au BufRead,BufNewFile *.pp set tabstop=2
au BufRead,BufNewFile *.haml set shiftwidth=2
au BufRead,BufNewFile *.haml set softtabstop=2
au BufRead,BufNewFile *.haml set tabstop=2
au BufRead,BufNewFile *.css set shiftwidth=2
au BufRead,BufNewFile *.css set softtabstop=2
au BufRead,BufNewFile *.css set tabstop=2
au BufRead,BufNewFile *.yaml set shiftwidth=2
au BufRead,BufNewFile *.yaml set softtabstop=2
au BufRead,BufNewFile *.yaml set tabstop=2

" Smart highlighted search
syntax on
set hlsearch
set incsearch
set ignorecase
set smartcase

set laststatus=2
set nu

" Put cursor at line where file was closed
au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
 \| exe "normal! g'\"" | endif

" MacVim stuff
set background=dark
set guifont=Monaco:h14
"hi Normal guifg=White

" Remove trailing whitespaces
"autocmd BufWritePre * :%s/\s\+$//e

" remap annoying capitals
:command WQ wq
:command Wq wq
:command W w
:command Q q
:command Set set
:command E e
