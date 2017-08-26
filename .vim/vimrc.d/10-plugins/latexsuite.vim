" LaTeX-Suite
"
" Various nice features for use with LaTeX.
"
" NOTE: These are not settings for `tex` files; they are just for LaTeX-Suite.
"

"##############################################################################
"##############################################################################
"## SETTINGS                                                              #####
"##############################################################################
"##############################################################################

" IMPORTANT: grep will sometimes skip displaying the file name if you search in
" a single file. This will confuse Latex-Suite. Set your grep program to always
" generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" This fixes the problem.
let g:tex_flavor='latex'

" Enable folding
let g:tex_fold_enabled=1

" TeX verbosity
let g:tex_verbspell=1

" Default target formats (can also be dvi, etc.)
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats = 'pdf,dvi'

" Compile rule for PDFs. Added '-synctex=1' option to use synctex.
let g:Tex_CompileRule_pdf = 'pdflatex -interaction=nonstopmode -src-specials -shell-escape $*'

" PDF reader
let g:Tex_ViewRule_pdf = defaultpdf

" Disable most menus for LaTeX-Suite
let g:Tex_EnvironmentMenus=0
let g:Tex_FontMenus=1
let g:Tex_SectionMenus=0

" Disable Python in LaTeX-Suite
let g:Tex_UsePython = 0
" Disable placeholders in LaTeX-Suite
let g:Imap_UsePlaceHolders = 0

" Disable most shortcuts
let g:Tex_SmartKeyQuote = 0
let g:Tex_EnvironmentMaps = 0
let g:Tex_FontMaps = 0
let g:Tex_SectionMaps = 0

