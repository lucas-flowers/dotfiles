
() {

    if [ -n "$LSCOLORS" ] ; then
        local lscolors="$LSCOLORS"
    fi

    source $ZSH/lib/theme-and-appearance.zsh

    if [ -n "$lscolors" ] ; then
        LSCOLORS=$lscolors
    fi

}

