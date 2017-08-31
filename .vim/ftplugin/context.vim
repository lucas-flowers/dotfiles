
" Converting ConTeXt files to PDFs
function ConTeXtToPDF()
    :w | !context "%"
endfunction

nnoremap <Leader>ll :call ConTeXtToPDF()<Enter>
nnoremap <Leader>lv :<c-r>=defaultstart<Enter> <c-r>=defaultpdf<Enter> "%:r.pdf" <c-r>=defaultsuffix<Enter><Enter>

