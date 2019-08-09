
autocmd BufRead,BufNewFile *.yml    call CheckCloudformation()
autocmd BufRead,BufNewFile *.yaml   call CheckCloudformation()

fun CheckCloudformation()
    if getline(1) =~# '^AWSTemplateFormatVersion:.*' || getline(2) =~# '^AWSTemplateFormatVersion:.*'
        set filetype=cloudformation.yaml
        set syntax=yaml
    endif
endfun

