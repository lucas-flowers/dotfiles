
" Windows
if has('win32')

    " PDF viewer
    let defaultstart = ':!start '
    let defaultsuffix = ''
    if !exists('defaultpdf')
        let defaultpdf = 'SumatraPDF'
    endif

    set directory=$TEMP " Swap directory is %TEMP%

    colorscheme solarized

    " Adjust slashes to work with Windows
    set shellslash

" Not Windows
else

    " PDF viewer
    let defaultstart = 'silent !'
    let defaultsuffix = ' &'
    if !exists('defaultpdf')
        let defaultpdf = 'sumatrapdf'
    endif

    set directory=$HOME/.vim/swap

    " Remind vim how many colors these terminals support
    if index(["xterm-256color", "screen-256color", "gnome-terminal"], $TERM) != -1
        set t_Co=256
        " https://vi.stackexchange.com/questions/39211/color-theme-displayed-wrong
        " This is for nvim. I suppose I could work out how to use 24-bit
        " colors but I don't care that much, so for now I'm turning it off
        " because it broke things. It also might only be needed for iTerm, but
        " I have not actually confirmed that.
        set notermguicolors
    else
        " Surely every terminal I'll ever access has *at least* 16 colors.
        " Considering solarized needs 16 colors minimum, let's just assume 16
        " colors for every other terminal. If, somehow, there are exceptions,
        " handle them here.
        set t_Co=16
    endif

    colorscheme solarized

    if has('gui_running')
        set mousemodel=popup " For right-click menus
    else
        " I prefer cursorline to highlight, not underline, in terminals
        hi CursorLine cterm=NONE term=reverse ctermbg=7 guibg=Grey90
    endif

endif

