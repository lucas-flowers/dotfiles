" Ctrl-P search plugin

"##############################################################################
"##############################################################################
"## SETTINGS                                                              #####
"##############################################################################
"##############################################################################

" Do not start searches from the project repository root; start from the
" current working directory. Doing it this way is mainly due to monorepos. 
let g:ctrlp_working_path_mode=0

" Keep track of unlimited files. Also due to monorepos.
let g:ctrlp_max_files=0

" DAMN SON use a freaking cache why isn't this the default
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

" Use ripgrep if available because it is much faster
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
else
  let g:ctrlp_clear_cache_on_exit = 0
endif

"##############################################################################
"##############################################################################
"## HOTKEYS                                                               #####
"##############################################################################
"##############################################################################

