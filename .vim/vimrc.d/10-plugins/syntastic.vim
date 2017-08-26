" Syntastic
"
" Syntax checking.
"

"##############################################################################
"##############################################################################
"## SETTINGS                                                              #####
"##############################################################################
"##############################################################################

" Python
let g:syntastic_python_python_exe = 'python3'
" let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_python_checkers=['pylint', 'mypy']
" let g:syntastic_python_mypy_args="--

" I've done well enough without lacheck (the default syntastic syntax checker
" for LaTeX), and latex-suite already has some error handling
let g:syntastic_tex_checkers = ['']

" JavaScript
let g:syntastic_javascript_checkers=['eslint']

