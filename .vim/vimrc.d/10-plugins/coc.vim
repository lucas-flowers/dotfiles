" coc.nvim
"
" Autocompletion and other goodies for vim and nvim.

"##############################################################################
"##############################################################################
"## SETTINGS                                                              #####
"##############################################################################
"##############################################################################

" NOTE: Run `:CocConfig` in vim to get the real settings for coc.nvim

" Run format after save (avoids the timeout)
au BufWrite *.py call CocAction('format')

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

" Coc <Plug> mappings (do not use noremap for these)
xmap <leader>ca <Plug>(coc-codeaction-selected)
nmap <leader>ca <Plug>(coc-codeaction-selected)
nmap <leader>cd <Plug>(coc-definition)
nmap <leader>cu <Plug>(coc-references)
nmap <leader>cr <Plug>(coc-rename)

" Other coc mappings
nnoremap <leader>cc :CocCommand<CR>
nnoremap <leader>co :CocOutline<CR>

" Text objects
" Inner function
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
" A function
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
" Inner class
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
" A class
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

