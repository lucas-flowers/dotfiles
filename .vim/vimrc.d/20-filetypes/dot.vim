"##############################################################################
"##############################################################################
"## SETTINGS                                                              #####
"##############################################################################
"##############################################################################

autocmd FileType dot setlocal
    \ autoindent
    \ smartindent
    \ commentstring=//\ %s

"##############################################################################
"##############################################################################
"## HOTKEYS                                                               #####
"##############################################################################
"##############################################################################

" Converting DOT files to PDFs
function DotToPDF()
    :w | !dot -Tpdf -o "%:r.pdf" "%"
endfunction
function DotToPNG()
    :w | !dot -Tpng -o "%:r.png" "%"
endfunction
function CircoToPDF()
    :w | !circo -Tpdf -o "%:r.pdf" "%"
endfunction
au FileType dot nnoremap <Leader>ll :call DotToPDF()<Enter>
au FileType dot nnoremap <Leader>lp :call DotToPNG()<Enter>
au FileType dot nnoremap <Leader>lc :call CircoToPDF()<Enter>
au FileType dot nnoremap <Leader>lv :<c-r>=defaultstart<Enter> <c-r>=defaultpdf<Enter> "%:r.pdf" <c-r>=defaultsuffix<Enter><Enter>

