
" Converting files with Pandoc's markdown syntax
function ftplugin#pandoc#ToPDF()
    " For personal note-taking: Venturis font, 12pt fontsize, 1 inch margins
    let command = ':w | !pandoc -V geometry:margin=1in -V fontsize=12pt -H $HOME/.pandoc/headers/default.tex -o "%:r.pdf" "%"'
    exec command
endfunction

function ftplugin#pandoc#ToPDFNormalNumbered()
    " For personal note-taking: Venturis font, 12pt fontsize, 1 inch margins,
    " numbered sections, and a table of contents
    let command = ':w | !pandoc -N --toc -V geometry:margin=1in -V fontsize=12pt -H $HOME/.pandoc/headers/default.tex -o "%:r.pdf" "%"'
    exec command
endfunction

function ftplugin#pandoc#ToPDFWithBib()
    " PandocToPDFNormalNumbered, but with a bibliography
    let command = ':w | !pandoc --filter pandoc-citeproc -N --toc -V geometry:margin=1in -H $HOME/.pandoc/headers/default.tex -o "%:r.pdf" "%"'
    exec command
endfunction

function ftplugin#pandoc#ToDOCXWithBib()
    " PandocToPDFNormalNumbered, but with a bibliography
    let command = ':w | !pandoc --biblatex --filter pandoc-citeproc -N --toc -V geometry:margin=1in -H $HOME/.pandoc/headers/default.tex -o "%:r.docx" "%"'
    exec command
endfunction

function ftplugin#pandoc#ToHTML()
    " HTML *code snippet*
    :w | !pandoc -o "%:r.html" "%"
endfunction

function ftplugin#pandoc#ToDOCX()
    :w | !pandoc -o "%:r.docx" "%"
endfunction

function ftplugin#pandoc#ToBeamer()
    " LaTeX's Beamer presentation package
    :w | !pandoc -t beamer -o "%:r.pdf" "%"
endfunction

function ftplugin#pandoc#ToBeamerIncremental()
    " LaTeX's Beamer presentation packag; incremental bullets
    :w | !pandoc -t beamer --incremental -o "%:r.pdf" "%"
endfunction

function ftplugin#pandoc#ToLaTeX()
    " Standalone LaTeX code, one-inch margins, 12pt fontsize
    :w | !pandoc -s -V geometry:margin=1in -V fontsize=12pt -o "%:r.tex" "%"
endfunction

function ftplugin#pandoc#ToPDFNumbered()
    " For class note-taking: Computer Modern font, 12pt fontsize, 1 inch
    " margins, numbered sections, and a table of contents
    :w | !pandoc -N --toc -V geometry:margin=1in -V fontsize=12pt -o "%:r.pdf" "%"
endfunction

