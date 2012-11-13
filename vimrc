set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent

syntax on
set hlsearch
set incsearch
set ignorecase
set smartcase

set laststatus=2
set nu

if has("autocmd")
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
     \| exe "normal! g'\"" | endif

    " ruby tab width
    au BufRead,BufNewFile *.rb set shiftwidth=2
    au BufRead,BufNewFile *.rb set softtabstop=2
    au BufRead,BufNewFile *.pp set shiftwidth=2
    au BufRead,BufNewFile *.pp set softtabstop=2
endif

" MacVim stuff
set background=dark
set guifont=Monaco:h14
"hi Normal guifg=White
