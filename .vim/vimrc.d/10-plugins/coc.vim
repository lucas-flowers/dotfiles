" coc.nvim
"
" Autocompletion and other goodies for vim and nvim.

"##############################################################################
"##############################################################################
"## SETTINGS                                                              #####
"##############################################################################
"##############################################################################

" NOTE: Run `:CocConfig` in vim to get the real settings for coc.nvim

"##############################################################################
"##############################################################################
"## HOTKEYS                                                               #####
"##############################################################################
"##############################################################################

" Tab completion: https://github.com/neoclide/coc.nvim/wiki/Completion-with-sources
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

" Press enter to auto-import
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

