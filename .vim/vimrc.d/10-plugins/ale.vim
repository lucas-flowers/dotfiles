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
            \ 'python' : ['pylint'],
            \ 'java' : ['javac'],
            \ 'tex' : [],
            \ 'yaml' : ['yamllint'],
            \ 'cloudformation.yaml': ['yamllint', 'cfn-lint'],
            \ 'sh' : ['shellcheck'],
            \ 'bash' : ['shellcheck'],
            \}

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" Keep the gutter open so text doesn't keep moving
let g:ale_sign_column_always = 1

