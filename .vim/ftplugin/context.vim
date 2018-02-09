
nnoremap <buffer> <Leader>ll :call ftplugin#context#ToPDF()<Enter>
nnoremap <buffer> <Leader>lv :<c-r>=defaultstart<Enter> <c-r>=defaultpdf<Enter> "%:r.pdf" <c-r>=defaultsuffix<Enter><Enter>

