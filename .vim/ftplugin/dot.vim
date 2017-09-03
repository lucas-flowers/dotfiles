setlocal autoindent
setlocal smartindent
setlocal commentstring=//\ %s

nnoremap <Leader>ll :call ftplugin#dot#ToPDF()<Enter>
nnoremap <Leader>lp :call ftplugin#dot#ToPNG()<Enter>
nnoremap <Leader>lc :call ftplugin#circo#ToPDF()<Enter>
nnoremap <Leader>lv :<c-r>=defaultstart<Enter> <c-r>=defaultpdf<Enter> "%:r.pdf" <c-r>=defaultsuffix<Enter><Enter>

