" Tagbar
"
" Hierarchal view of files in languages supporting it.
"

"##############################################################################
"##############################################################################
"## SETTINGS                                                              #####
"##############################################################################
"##############################################################################

" Add support for markdown files in tagbar.
let g:tagbar_type_pandoc = {
    \ 'ctagstype': 'pandoc',
    \ 'ctagsbin' : g:localvim . '/markdown2ctags.py',
    \ 'ctagsargs' : '-f - --sort=yes',
    \ 'kinds' : [
        \ 's:sections',
        \ 'i:images'
    \ ],
    \ 'sro' : '|',
    \ 'kind2scope' : {
        \ 's' : 'section',
    \ },
    \ 'sort': 0,
\ }

"##############################################################################
"##############################################################################
"## HOTKEYS                                                               #####
"##############################################################################
"##############################################################################

" Toggling taglist on command
nnoremap <silent> <Leader>c :TagbarToggle<Enter>
