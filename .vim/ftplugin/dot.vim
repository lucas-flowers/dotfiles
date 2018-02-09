setlocal autoindent
setlocal smartindent
setlocal commentstring=//\ %s

nnoremap <buffer> <Leader>ll :call ftplugin#dot#ToPDF()<Enter>
nnoremap <buffer> <Leader>lp :call ftplugin#dot#ToPNG()<Enter>
nnoremap <buffer> <Leader>lc :call ftplugin#circo#ToPDF()<Enter>
nnoremap <buffer> <Leader>lv :<c-r>=defaultstart<Enter> <c-r>=defaultpdf<Enter> "%:r.pdf" <c-r>=defaultsuffix<Enter><Enter>

