" Very magic search patterns by default
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
nnoremap <Leader>s :s/\v
vnoremap <Leader>s :s/\v
nnoremap <Leader>S :%s/\v
vnoremap <Leader>S :%s/\v

" Toggle highlighting
function HLToggle()
    if &hlsearch
        :set nohlsearch
    else
        :set hlsearch
    endif
endfunction
nnoremap <Leader>h :call HLToggle()<CR>

" Make j/k move by display lines, not logical lines
nmap j gj
nmap k gk

" Make Y/yy consistent with D/dd and C/cc
noremap Y y$

" Enable/disable spelling
command S :set spell spelllang=en_us
command NS :set nospell

" Preferred line options
command L call LineSetting()
function LineSetting()
    :set linebreak
    :set textwidth=79
    :set colorcolumn=80
    :set nowrap
    let g:short_lines=1
endfunction
" This setting is preferred
call LineSetting()

" Preferred no lining options
command NL call NoLineSetting()
function NoLineSetting()
    :set linebreak
    :set textwidth=0
    :set colorcolumn=
    :set wrap
    let g:short_lines=0
endfunction

" Provide a toggle for short vs. long lines
function ToggleShortLines()
    if g:short_lines
        call NoLineSetting()
    else
        call LineSetting()
    endif
endfunction
nnoremap <Leader>w :call ToggleShortLines()<Enter>

" Python as a calculator
command! -nargs=+ P :r !python -c "from math import *; print(<args>, end = '')"

" Tab navigation like in other programs
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>

" Remove trailing spaces
nnoremap <Leader>e :%s/\v\s+$//g<Enter>``

