" vimtex
"
" Better LaTeX plugin.
"

"##############################################################################
"##############################################################################
"## SETTINGS                                                              #####
"##############################################################################
"##############################################################################

" Vimtex requires a vim server for several features. So, start a server called
" whenever a TeX file is loaded, ignoring any errors in starting the server
" (e.g., if a server already exists). The autocmd for this is here instead of
" ftplugin because only vimtex needs it.
"
" (The servername is always 'gvim' for a reason: When remote commands run
" without a servername, they are sent to a server with name based on whether
" the remote commands were sent from running gvim or vim. This is not ideal
" because the server itself could either be gvim or vim, so we must specify a
" servername when writing remote commands. Because gvim /always/ starts a
" server called 'gvim' on startup and because terminal vim does not, we can
" just set the name to 'gvim' here so we can always assume the servername will
" be 'gvim' when specifying the name.)
autocmd BufRead,BufNewFile *.tex silent! execute remote_startserver("gvim")

" I dislike indenting in LaTeX files
let g:vimtex_indent_enabled = 0

" Set default PDF viewer
let g:vimtex_view_general_viewer = defaultpdf
if g:vimtex_view_general_viewer == "qpdfview"
	let g:vimtex_view_general_options = '--unique @pdf\#src:@tex:@line:@col'
	let g:vimtex_view_general_options_latexmk = '--unique'
endif

