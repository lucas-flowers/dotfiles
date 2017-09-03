
" Converting ConTeXt files to PDFs
function ftplugin#context#ToPDF()
    :w | !context "%"
endfunction

