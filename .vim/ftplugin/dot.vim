setlocal autoindent
setlocal smartindent
setlocal commentstring=//\ %s

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

nnoremap <Leader>ll :call DotToPDF()<Enter>
nnoremap <Leader>lp :call DotToPNG()<Enter>
nnoremap <Leader>lc :call CircoToPDF()<Enter>
nnoremap <Leader>lv :<c-r>=defaultstart<Enter> <c-r>=defaultpdf<Enter> "%:r.pdf" <c-r>=defaultsuffix<Enter><Enter>

