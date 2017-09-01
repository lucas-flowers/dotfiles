#!/bin/sh

# Extend the PATH variable. (We're extending instead of replacing because
# Windows paths in LXSS will be lost if we're replacing it.)

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

