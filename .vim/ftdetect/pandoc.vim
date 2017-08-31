
" Markdown and plaintext files should use the pandoc markdown dialect for
" syntax highlighting.
autocmd BufRead,BufNewFile *.txt      set filetype=pandoc
autocmd BufRead,BufNewFile *.md       set filetype=pandoc
autocmd BufRead,BufNewFile *.markdown set filetype=pandoc

