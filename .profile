
# I use this file to store environment variables (particularly PATH) for bash,
# zsh, and other shells to read or source.

###############################################################################
###############################################################################
#### PATH                                                                  ####
###############################################################################
###############################################################################

# These should already be in PATH. But add them to the end, just in case.
# (Example: /sbin and /usr/sbin are not automatically included in macOS.)
paths_append="/usr/local/sbin /usr/bin /bin /sbin /usr/sbin /usr/bin/X11 /usr/games /usr/local/games"
for p in $paths_append ; do
      case ":$PATH:" in
          *":$p:"*) :;;
          *) PATH="$PATH:$p";;
      esac
done

# These paths are likely not to exist, and should go first. They are listed in
# the reverse order that they'll be in PATH.
paths_prepend="/usr/local/bin $HOME/.local/bin"
for p in $paths_prepend ; do
      case ":$PATH:" in
          *":$p:"*) :;;
          *) PATH="$p:$PATH";;
      esac
done

# If for some god-forsaken reason the $HOME/bin directory exists, add that to
# the front
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

###############################################################################
###############################################################################
#### Other Environment Variables                                           ####
###############################################################################
###############################################################################

# If there is a terminal that doesn't support 256 colors by this point, I don't
# want to live.
export TERM="xterm-256color"

# Use python3 for new virtual environments
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3

# Python virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
# export PROJECT_HOME=~/Devel # I'd rather not set this until I need it
VIRTUALENVWRAPPER_SH=/usr/local/bin/virtualenvwrapper.sh
if [ -f $VIRTUALENVWRAPPER_SH ]; then
    source $VIRTUALENVWRAPPER_SH
fi

