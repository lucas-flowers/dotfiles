" Enable syntax highlighting
syntax on

" Line numbers, ruler, and airline status bar
set number
set ruler
set laststatus=2

" Always highlight current line
set cursorline

" Show as much as possible of a wrapped line; don't give up and just replace it
" with at-signs all over the place.
set display=lastline

" Diff is vertical, not horizontal, by default
set diffopt+=vertical

set background=light

" Mouse
set mouse=a " Mouse support in terminals
set ttymouse=xterm2 " Mouse support inside tmux

" Make the backspace key work as expected
set backspace=2

if has('gui_running')

    " No toolbar or scrollbars in gvim
    set guioptions-=T " remove toolbar
    set guioptions-=r " remove right-hand scroll bar
    set guioptions-=L " remove left-hand scroll bar

endif
