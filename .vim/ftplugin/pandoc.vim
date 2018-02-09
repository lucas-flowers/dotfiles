
setlocal spell
setlocal commentstring=<!--\ %s\ -->

nnoremap <buffer> <Leader>ll :call ftplugin#pandoc#ToPDF()<Enter>
nnoremap <buffer> <Leader>lc :call ftplugin#pandoc#ToPDFNormalNumbered()<Enter>
nnoremap <buffer> <Leader>lh :call ftplugin#pandoc#ToHTML()<Enter>
nnoremap <buffer> <Leader>ld :call ftplugin#pandoc#ToDOCX()<Enter>
nnoremap <buffer> <Leader>le :call ftplugin#pandoc#ToBeamer()<Enter>
nnoremap <buffer> <Leader>li :call ftplugin#pandoc#ToBeamerIncremental()<Enter>
nnoremap <buffer> <Leader>lt :call ftplugin#pandoc#ToLaTeX()<Enter>
nnoremap <buffer> <Leader>ln :call ftplugin#pandoc#ToPDFNumbered()<Enter>
nnoremap <buffer> <Leader>lb :call ftplugin#pandoc#ToPDFWithBib()<Enter>
nnoremap <buffer> <Leader>lr :call ftplugin#pandoc#ToDOCXWithBib()<Enter>
nnoremap <buffer> <Leader>lv :<c-r>=defaultstart<Enter> <c-r>=defaultpdf<Enter> "%:r.pdf" <c-r>=defaultsuffix<Enter><Enter>
nnoremap <buffer> <Leader>lw :!"%:r.html"<c-r>=defaultsuffix<Enter>
nnoremap <buffer> <Leader>lm :!"%:r.docx"<c-r>=defaultsuffix<Enter>

" Hotkeys for files written in Pandoc's Markdown dialect
" Underline a line by '-' (create a subsection)
nnoremap <buffer> <a-o> yypv$r-
inoremap <buffer> <a-o> <Esc>yypv$r-o<CR>
" Underline a line by '=' (create a section)
nnoremap <buffer> <a-p> yypv$r=
inoremap <buffer> <a-p> <Esc>yypv$r=o<CR>

