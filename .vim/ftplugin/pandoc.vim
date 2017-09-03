
setlocal spell
setlocal commentstring=<!--\ %s\ -->

nnoremap <Leader>ll :call ftplugin#pandoc#ToPDF()<Enter>
nnoremap <Leader>lc :call ftplugin#pandoc#ToPDFNormalNumbered()<Enter>
nnoremap <Leader>lh :call ftplugin#pandoc#ToHTML()<Enter>
nnoremap <Leader>ld :call ftplugin#pandoc#ToDOCX()<Enter>
nnoremap <Leader>le :call ftplugin#pandoc#ToBeamer()<Enter>
nnoremap <Leader>li :call ftplugin#pandoc#ToBeamerIncremental()<Enter>
nnoremap <Leader>lt :call ftplugin#pandoc#ToLaTeX()<Enter>
nnoremap <Leader>ln :call ftplugin#pandoc#ToPDFNumbered()<Enter>
nnoremap <Leader>lb :call ftplugin#pandoc#ToPDFWithBib()<Enter>
nnoremap <Leader>lr :call ftplugin#pandoc#ToDOCXWithBib()<Enter>
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

