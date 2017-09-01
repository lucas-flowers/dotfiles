" Windows
if has('win32')

    let defaultstart = ':!start '
    let defaultpdf = 'SumatraPDF'
    let defaultsuffix = ''

    " When running gvim
    if has('gui_running')

        " Default colorscheme
        colorscheme solarized

    endif

    " Required for LaTeX-Suite, and adjusts slashes to work with Windows
    set shellslash

    " Set default directory to the Windows %TEMP% directory. All swap files,
    " including the [No Name] swap file will go here.
    set dir=$TEMP

    set guifont=Noto_Mono:h11

" Not Windows
else

    if hostname() == "desktop" || hostname() == "laptop" || hostname() == "osx"
        set shell=zsh
    else
        set shell=bash
    endif

    let defaultstart = 'silent !'
    let defaultpdf = 'sumatrapdf'
    let defaultsuffix = ' &'

    " Set the default directory to a temporary directory. All swap files,
    " including the [No Name] swap file will go here.
    set dir=$HOME/.vim/swap

    " Default colorscheme
    colorscheme solarized

    " When running gvim
    if has('gui_running')

        " Sorry, the right-click menu is just too ubiquitous
        set mousemodel=popup

        " Linux on laptop
        if hostname() == "laptop"
            set guifont=Noto\ Mono\ 11
        " For OS X
        elseif hostname() == "osx.local"
            set guifont=Monaco:h14
        " Other computers
        else
            set guifont=Droid\ Sans\ Mono\ 11
        endif

    " When running vim in the terminal
    else

        " " The color is all screwed up for konsole. Too lazy to change the
        " " colorscheme in konsole itself.
        " if hostname() == "laptop"
        "     highlight Search ctermfg=white
        " endif

        " I prefer cursorline to highlight, not underline
        hi CursorLine cterm=NONE term=reverse ctermbg=7 guibg=Grey90

    endif

endif

