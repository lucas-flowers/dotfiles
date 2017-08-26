" Undotree
"
" View vim's complex undo history as a tree.
"

"##############################################################################
"##############################################################################
"## SETTINGS                                                              #####
"##############################################################################
"##############################################################################

" Make undotree always appear on the right side
let g:undotree_WindowLayout=3

" No highlighting changed text
let g:undotree_HighlightChangedText=0

" No diff alongside undotree by default
let g:undotree_DiffAutoOpen=0

"##############################################################################
"##############################################################################
"## HOTKEYS                                                               #####
"##############################################################################
"##############################################################################

" Toggling undotree on command
nnoremap <Leader>u :UndotreeToggle<Enter>

