
# ZSH clobbers LSCOLORS whether or not it exists. Save LSCOLORS before sourcing
# the themes and appearance configuration file, then restore it to how it was
# before (or unset it if it wasn't set before).
() {

    if [ -n "$LSCOLORS" ] ; then
        local lscolors="$LSCOLORS"
    fi

    source $ZSH/lib/theme-and-appearance.zsh

    if [ -n "$lscolors" ] ; then
        LSCOLORS=$lscolors
    else
        unset LSCOLORS
    fi

}

