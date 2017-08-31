
setlocal spell
setlocal commentstring=<!--\ %s\ -->

" Enable support for curly quotes, but do not do it automatically.
call textobj#quote#init({'educate': 0})

" Converting files with Pandoc's markdown syntax
function PandocToPDF()
    " For personal note-taking: Venturis font, 12pt fontsize, 1 inch margins
    let command = ':w | !pandoc -V geometry:margin=1in -V fontsize=12pt -H ' . g:localvim . '"/pandoc-tex-header.tex" -o "%:r.pdf" "%"'
    exec command
endfunction
function PandocToPDFNormalNumbered()
    " For personal note-taking: Venturis font, 12pt fontsize, 1 inch margins,
    " numbered sections, and a table of contents
    let command = ':w | !pandoc -N --toc -V geometry:margin=1in -V fontsize=12pt -H ' . g:localvim . '"/pandoc-tex-header.tex" -o "%:r.pdf" "%"'
    exec command
endfunction
function PandocToPDFWithBib()
    " PandocToPDFNormalNumbered, but with a bibliography
    let command = ':w | !pandoc --filter pandoc-citeproc -N --toc -V geometry:margin=1in -H ' . g:localvim . '"/pandoc-tex-header.tex" -o "%:r.pdf" "%"'
    exec command
endfunction
function PandocToDOCXWithBib()
    " PandocToPDFNormalNumbered, but with a bibliography
    let command = ':w | !pandoc --biblatex --filter pandoc-citeproc -N --toc -V geometry:margin=1in -H ' . g:localvim . '"/pandoc-tex-header.tex" -o "%:r.docx" "%"'
    exec command
endfunction
function PandocToHTML()
    " HTML *code snippet*
    :w | !pandoc -o "%:r.html" "%"
endfunction
function PandocToDOCX()
    :w | !pandoc -o "%:r.docx" "%"
endfunction
function PandocToBeamer()
    " LaTeX's Beamer presentation package
    :w | !pandoc -t beamer -o "%:r.pdf" "%"
endfunction
function PandocToBeamerIncremental()
    " LaTeX's Beamer presentation packag; incremental bullets
    :w | !pandoc -t beamer --incremental -o "%:r.pdf" "%"
endfunction
function PandocToLaTeX()
    " Standalone LaTeX code, one-inch margins, 12pt fontsize
    :w | !pandoc -s -V geometry:margin=1in -V fontsize=12pt -o "%:r.tex" "%"
endfunction
function PandocToPDFNumbered()
    " For class note-taking: Computer Modern font, 12pt fontsize, 1 inch
    " margins, numbered sections, and a table of contents
    :w | !pandoc -N --toc -V geometry:margin=1in -V fontsize=12pt -o "%:r.pdf" "%"
endfunction

nnoremap <Leader>ll :call PandocToPDF()<Enter>
nnoremap <Leader>lc :call PandocToPDFNormalNumbered()<Enter>
nnoremap <Leader>lh :call PandocToHTML()<Enter>
nnoremap <Leader>ld :call PandocToDOCX()<Enter>
nnoremap <Leader>le :call PandocToBeamer()<Enter>
nnoremap <Leader>li :call PandocToBeamerIncremental()<Enter>
nnoremap <Leader>lt :call PandocToLaTeX()<Enter>
nnoremap <Leader>ln :call PandocToPDFNumbered()<Enter>
nnoremap <Leader>lb :call PandocToPDFWithBib()<Enter>
nnoremap <Leader>lr :call PandocToDOCXWithBib()<Enter>
nnoremap <Leader>lv :<c-r>=defaultstart<Enter> <c-r>=defaultpdf<Enter> "%:r.pdf" <c-r>=defaultsuffix<Enter><Enter>
nnoremap <Leader>lw :!"%:r.html"<c-r>=defaultsuffix<Enter>
nnoremap <Leader>lm :!"%:r.docx"<c-r>=defaultsuffix<Enter>

" Hotkeys for files written in Pandoc's Markdown dialect
" Underline a line by '-' (create a subsection)
nnoremap <a-o> yypv$r-
inoremap <a-o> <Esc>yypv$r-o<CR>
" Underline a line by '=' (create a section)
nnoremap <a-p> yypv$r=
inoremap <a-p> <Esc>yypv$r=o<CR>

