
" Windows
if has('win32')

    " PDF viewer
    let defaultstart = ':!start '
    let defaultpdf = 'SumatraPDF'
    let defaultsuffix = ''

    set directory=$TEMP " Swap directory is %TEMP%

    if has('gui_running')
        " pass
    else
        colorscheme solarized
    endif

    " Adjust slashses to work with Windows (required for LaTeX-Suite)
    set shellslash

" Not Windows
else

    " PDF viewer
    let defaultstart = 'silent !'
    let defaultpdf = 'sumatrapdf'
    let defaultsuffix = ' &'

    set directory=$HOME/.vim/swap

    if has('gui_running')
        set mousemodel=popup " For right-click menus
    else
        " Also use solarized in Unix terminals
        colorscheme solarized
        " I prefer cursorline to highlight, not underline, in terminals
        hi CursorLine cterm=NONE term=reverse ctermbg=7 guibg=Grey90
    endif

endif

