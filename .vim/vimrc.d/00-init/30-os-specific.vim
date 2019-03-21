
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
    if index(['xterm-256color', 'screen-256color', 'gnome-terminal'], $TERM) != -1
        set t_Co=256
    elseif index(['linux-16color', 'screen'], $TERM) != -1
        " This assumes that screen's underlying terminal is actually 16 colors
        " (a mostly reasonable assumption). To use `linux-16color` properly,
        " change the default TERM from `linux` by editing the appropriate
        " systemd file or adding TERM=linux-16color to the kernel parameters
        " (i.e., through grub's GRUB_CMDLINE_LINUX). Google this stuff for
        " exact details.
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

