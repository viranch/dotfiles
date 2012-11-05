set sw=2
set ts=2
set expandtab
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
endif

" MacVim stuff
set background=dark
set guifont=Monaco:h14
"hi Normal guifg=White
