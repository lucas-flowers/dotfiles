
" Converting DOT files to PDFs
function ftplugin#dot#ToPDF()
    :w | !dot -Tpdf -o "%:r.pdf" "%"
endfunction
function ftplugin#dot#ToPNG()
    :w | !dot -Tpng -o "%:r.png" "%"
endfunction
function ftplugin#circo#ToPDF()
    :w | !circo -Tpdf -o "%:r.pdf" "%"
endfunction

