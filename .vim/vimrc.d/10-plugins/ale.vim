" Ale
"
" Asynchronous syntax checking.
"

"##############################################################################
"##############################################################################
"## SETTINGS                                                              #####
"##############################################################################
"##############################################################################

" For Java, use eclim
let g:ale_linters = {
            \ 'python' : ['mypy', 'pylint', 'flake8', 'bandit'],
            \ 'java' : ['javac'],
            \ 'tex' : [],
            \ 'yaml' : ['yamllint'],
            \ 'yaml.ansible': ['ansible-lint'],
            \ 'cloudformation.yaml': ['yamllint', 'cfn-lint'],
            \ 'sh' : ['shellcheck'],
            \ 'bash' : ['shellcheck'],
            \ 'rst' : ['rst-lint'],
            \}

let g:ale_fixers = {
            \ 'python': ['isort'],
            \}

let g:ale_echo_msg_format = '[%linter%] %s [%code%]'

let g:ale_fix_on_save = 1

" Disable language server capabilities on the assumption we're using coc
let g:ale_disable_lsp = 1

" Keep the gutter open so text doesn't keep moving
let g:ale_sign_column_always = 1

" Use quickfix instead of loclist
" let g:ale_set_quickfix = 1

let g:ale_python_bandit_use_config = 1

"##############################################################################
"##############################################################################
"## HOTKEYS                                                               #####
"##############################################################################
"##############################################################################

nnoremap <Leader>a :ALEDetail<CR>

