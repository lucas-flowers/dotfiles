
" TODO There are "autocmds" in here even though this is in .vim/ftplugin/
" beause Tex_MakeMap is not defined when this file is read. I'm too lazy to
" figure out whether this is the "standard" way of doing it right now, so
" they're going to stay.

" Enable auto-commenting in LaTeX
setlocal formatoptions+=c
setlocal formatoptions+=r
setlocal formatoptions+=o

" Enable spellcheck for LaTeX
setlocal spell

" Make LaTeX-Suite save before compiling
autocmd FileType tex call Tex_MakeMap('<leader>ll', ':update!<CR>:call Tex_RunLaTeX()<CR>', 'n', '<buffer>')
autocmd FileType tex call Tex_MakeMap('<leader>ll', '<ESC>:update!<CR>:call Tex_RunLaTeX()<CR>', 'v', '<buffer>')

" XeLaTeX
autocmd FileType tex call Tex_MakeMap('<leader>lx', ':update!<CR>:call ftplugin#tex#CompileXeLaTeX()<CR>', 'n', '<buffer>')
autocmd FileType tex call Tex_MakeMap('<leader>lx', '<ESC>:update!<CR>:call ftplugin#tex#CompileXeLaTeX()<CR>', 'v', '<buffer>')

" The same hotkeys for files written in TeX
" Underline a line by '-'
nnoremap <a-o> 0i\subsection{<ESC>A}<ESC>jj
inoremap <a-o> <ESC>0i\subsection{<ESC>A}<CR><CR>
" Underline a line by '='
nnoremap <a-p> 0i\section{<ESC>A}<ESC>jj
inoremap <a-p> <ESC>0i\section{<ESC>A}<CR><CR>

" My tablet keyboard is not the easiest one to type '`' with, so make a
" shortcut for it (just for LaTeX).
inoremap <C-'> `

" LaTeX environments
inoremap <C-e> <ESC>yaWi\begin{A}pI\end{A}O

