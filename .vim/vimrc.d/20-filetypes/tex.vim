"##############################################################################
"##############################################################################
"## SETTINGS                                                              #####
"##############################################################################
"##############################################################################

" Enable auto-commenting in LaTeX
autocmd FileType *.tex setlocal formatoptions+=c formatoptions+=r formatoptions+=o

" Enable spellcheck for LaTeX
autocmd BufRead,BufNewFile *.tex      setlocal spell

"##############################################################################
"##############################################################################
"## HOTKEYS                                                               #####
"##############################################################################
"##############################################################################

" Make LaTeX-Suite save before compiling
autocmd FileType tex call Tex_MakeMap('<leader>ll', ':update!<CR>:call Tex_RunLaTeX()<CR>', 'n', '<buffer>')
autocmd FileType tex call Tex_MakeMap('<leader>ll', '<ESC>:update!<CR>:call Tex_RunLaTeX()<CR>', 'v', '<buffer>')

" Compiling with XeLaTeX
function CompileXeLaTex()
    let oldCompileRule=g:Tex_CompileRule_pdf
    let g:Tex_CompileRule_pdf = 'xelatex --synctex=-1 -src-specials -interaction=nonstopmode -shell-escape $*'
    call Tex_RunLaTeX()
    let g:Tex_CompileRule_pdf=oldCompileRule
endfunction
autocmd FileType tex call Tex_MakeMap('<leader>lx', ':update!<CR>:call CompileXeLaTex()<CR>', 'n', '<buffer>')
autocmd FileType tex call Tex_MakeMap('<leader>lx', '<ESC>:update!<CR>:call CompileXeLaTex()<CR>', 'v', '<buffer>')

" The same hotkeys for files written in TeX
" Underline a line by '-'
au FileType tex nnoremap <a-o> 0i\subsection{<ESC>A}<ESC>jj
au FileType tex inoremap <a-o> <ESC>0i\subsection{<ESC>A}<CR><CR>
" Underline a line by '='
au FileType tex nnoremap <a-p> 0i\section{<ESC>A}<ESC>jj
au FileType tex inoremap <a-p> <ESC>0i\section{<ESC>A}<CR><CR>

" My tablet keyboard is not the easiest one to type '`' with, so make a
" shortcut for it (just for LaTeX).
au FileType tex inoremap <C-'> `

" LaTeX environments
au FileType tex inoremap <C-e> <ESC>yaWi\begin{A}pI\end{A}O

