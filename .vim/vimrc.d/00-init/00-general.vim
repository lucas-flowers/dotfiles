" Package manager
execute pathogen#infect()
" Have pathogen generate help files from the plugins installed
Helptags

" Leader key is the comma; remap '\' to ',' to keep reverse character search
let mapleader = ","
noremap \ ,

" Enable vim features
set nocompatible

" Show selection size in visual mode
set showcmd

" Filetype detection and appropriate indentation
filetype plugin on
filetype indent on

" Indentation defaults
set expandtab
set tabstop=4
set shiftwidth=4
set indentexpr=

" Allow special vim settings for individual files (placed near end or beginning
" of the file
set modeline

" Searches are case-insensitive *except* when there is an uppercase letter
set ignorecase
set smartcase

" Don't create two spaces when using the `gq` and `J` commands
set nojoinspaces

" Font encoding
if has("multi_byte")
    if &termencoding == ""
        let &termencoding=&encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=ucs-bom,utf-8,latin1
endif
