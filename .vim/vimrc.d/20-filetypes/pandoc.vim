"##############################################################################
"##############################################################################
"## SETTINGS                                                              #####
"##############################################################################
"##############################################################################

" Markdown and plaintext files should use the pandoc markdown dialect for
" syntax highlighting.
autocmd BufRead,BufNewFile *.txt      set filetype=pandoc | setlocal spell
autocmd BufRead,BufNewFile *.md       set filetype=pandoc | setlocal spell
autocmd BufRead,BufNewFile *.markdown set filetype=pandoc | setlocal spell

autocmd FileType pandoc setlocal commentstring=<!--\ %s\ -->

" Enable support for curly quotes, but do not do it automatically.
autocmd FileType pandoc call textobj#quote#init({'educate': 0})

"##############################################################################
"##############################################################################
"## HOTKEYS                                                               #####
"##############################################################################
"##############################################################################

" Converting files with Pandoc's markdown syntax
function PandocToPDF()
    " For personal note-taking: Venturis font, 12pt fontsize, 1 inch margins
    let command = ':w | !pandoc -V geometry:margin=1in -V fontsize=12pt -H ' . g:localruntime . '"/pandoc-tex-header.tex" -o "%:r.pdf" "%"'
    exec command
endfunction
function PandocToPDFNormalNumbered()
    " For personal note-taking: Venturis font, 12pt fontsize, 1 inch margins,
    " numbered sections, and a table of contents
    let command = ':w | !pandoc -N --toc -V geometry:margin=1in -V fontsize=12pt -H ' . g:localruntime . '"/pandoc-tex-header.tex" -o "%:r.pdf" "%"'
    exec command
endfunction
function PandocToPDFWithBib()
    " PandocToPDFNormalNumbered, but with a bibliography
    let command = ':w | !pandoc --filter pandoc-citeproc -N --toc -V geometry:margin=1in -H ' . g:localruntime . '"/pandoc-tex-header.tex" -o "%:r.pdf" "%"'
    exec command
endfunction
function PandocToDOCXWithBib()
    " PandocToPDFNormalNumbered, but with a bibliography
    let command = ':w | !pandoc --biblatex --filter pandoc-citeproc -N --toc -V geometry:margin=1in -H ' . g:localruntime . '"/pandoc-tex-header.tex" -o "%:r.docx" "%"'
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
au FileType pandoc nnoremap <Leader>ll :call PandocToPDF()<Enter>
au FileType pandoc nnoremap <Leader>lc :call PandocToPDFNormalNumbered()<Enter>
au FileType pandoc nnoremap <Leader>lh :call PandocToHTML()<Enter>
au FileType pandoc nnoremap <Leader>ld :call PandocToDOCX()<Enter>
au FileType pandoc nnoremap <Leader>le :call PandocToBeamer()<Enter>
au FileType pandoc nnoremap <Leader>li :call PandocToBeamerIncremental()<Enter>
au FileType pandoc nnoremap <Leader>lt :call PandocToLaTeX()<Enter>
au FileType pandoc nnoremap <Leader>ln :call PandocToPDFNumbered()<Enter>
au FileType pandoc nnoremap <Leader>lb :call PandocToPDFWithBib()<Enter>
au FileType pandoc nnoremap <Leader>lr :call PandocToDOCXWithBib()<Enter>
au FileType pandoc nnoremap <Leader>lv :<c-r>=defaultstart<Enter> <c-r>=defaultpdf<Enter> "%:r.pdf" <c-r>=defaultsuffix<Enter><Enter>
au FileType pandoc nnoremap <Leader>lw :!"%:r.html"<c-r>=defaultsuffix<Enter>
au FileType pandoc nnoremap <Leader>lm :!"%:r.docx"<c-r>=defaultsuffix<Enter>

" Hotkeys for files written in Pandoc's Markdown dialect
" Underline a line by '-' (create a subsection)
au FileType pandoc nnoremap <a-o> yypv$r-
au FileType pandoc inoremap <a-o> <Esc>yypv$r-o<CR>
" Underline a line by '=' (create a section)
au FileType pandoc nnoremap <a-p> yypv$r=
au FileType pandoc inoremap <a-p> <Esc>yypv$r=o<CR>

" All txt files are given pandoc formatting by default (I write my notes in
" pandoc markdown). This hotkey returns the formatting to txt (or the reverse)
au FileType pandoc nnoremap <Leader>; :set ft=txt<CR>:setlocal nospell<CR>
au FileType txt    nnoremap <Leader>; :set ft=pandoc<CR>:setlocal spell<CR>

