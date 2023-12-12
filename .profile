#!/bin/sh

# I use this file to store environment variables (particularly PATH) for bash,
# zsh, and other shells to read or source.

###############################################################################
###############################################################################
#### PATH                                                                  ####
###############################################################################
###############################################################################

# These should already be in PATH, but add them to the end if they exist, just
# in case. (Example: /sbin and /usr/sbin are not automatically included in
# macOS.)
paths_append="/usr/local/sbin /usr/bin /bin /sbin /usr/sbin /usr/bin/X11 /usr/games /usr/local/games /opt/homebrew/bin"
for p in $paths_append ; do
    case ":$PATH:" in
        *":$p:"*)
            : # already in PATH; do nothing
            ;;
        *)
            # add path if it exists
            if [ -d "$p" ] ; then PATH="$PATH:$p" ; fi
            ;;
    esac
done

# These paths are likely not to exist, but should go first if they do. They are
# listed in the reverse order that they'll be in PATH.
paths_prepend="$HOME/.cargo/bin /snap/bin /usr/local/bin $HOME/.local/bin $HOME/bin"
for p in $paths_prepend ; do
    case ":$PATH:" in
        *":$p:"*)
            : # already in PATH; do nothing
            ;;
        *)
            # add path if it exists
            if [ -d "$p" ] ; then PATH="$p:$PATH" ; fi
            ;;
    esac
done

###############################################################################
###############################################################################
#### Other Environment Variables                                           ####
###############################################################################
###############################################################################


export TEXMFHOME=~/.texmf

# Set up pyenv if it exists
if [ -d "$HOME/.pyenv" ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
fi

# Set up poetry if it exists
if [ -d "$HOME/.poetry" ]; then
    export PATH="$HOME/.poetry/bin:$PATH"
fi

# Set up cargo bin folder if it exists
if [ -d "$HOME/.cargo/bin" ]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

# Set up nvm if it exists
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
fi

# Use one of the correct editors
if command -v nvim >/dev/null 2>&1; then
    export EDITOR=nvim
    alias vim=nvim
elif command -v vim >/dev/null 2>&1; then
    export EDITOR=vim
else
    export EDITOR=vi
fi

###############################################################################
###############################################################################
#### Interactive Shells                                                    ####
###############################################################################
###############################################################################

if [ -n "$PS1" ] ; then

    # Set up colors for GNU ls
    colors="$HOME/.dir_colors/dircolors.ansi-light"
    if command -v dircolors >/dev/null 2>&1 ; then
        # Set LS_COLORS and alias ls
        eval "$(dircolors "$colors")"
        alias ls='ls --color=auto'
    elif command -v gdircolors >/dev/null 2>&1 ; then
        # If only gdircolors exists, this suggests that the system doesn't
        # support `--color=auto` (e.g., it's FreeBSD or macOS). Some programs
        # might still use $LS_COLORS, though, so run gdircolors anyway.
        eval "$(gdircolors "$colors")"
        export LSCOLORS=$(python "$HOME/.local/bin/gnu2bsd")
        export CLICOLOR=1
    fi

fi
