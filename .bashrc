
# For historical reasons, Bash loads its configuration in a weird order.
#
#   + For interactive non-login shells (i.e., most of the time from the user's
#   perspective), Bash reads .bashrc.
#
#   + But for interactive login shells (i.e., logging in from a tty,
#   ssh, or when a GUI shell logs in), Bash loads (*only*) the *first* of
#   .bash_profile, .bash_login, and .profile.
#
# To avoid all this mess, .bash_profile and .bash_login should symlink to this
# file. That way, *all* interactive shells will read this file (only scripts
# will ignore it, which is expected). If there are specific options for the
# other strange cases, those cases are handled at the end of this file in the
# if-statement blocks, though most options should go above the block.
#
# This idea is taken from:
#
# https://shreevatsa.wordpress.com/2008/03/30/zshbash-startup-files-loading-order-bashrc-zshrc-etc/
#

###############################################################################
###############################################################################
#### General Configuration                                                 ####
###############################################################################
###############################################################################

# I have put environment stuff in .profile where it can be accessed by other
# programs like KDE
source $HOME/.profile

shopt -s globstar # Allow '**' as a glob pattern
shopt -s histappend # Append to history; don't overwrite

HISTCONTROL=ignoreboth # Don't include duplicate lines or lines starting with a space in the history
HISTSIZE=1000
HISTFILESIZE=2000

# Aliases
source $HOME/.bash_aliases

###############################################################################
###############################################################################
#### Special Configuration                                                 ####
###############################################################################
###############################################################################

if [[ -n $PS1 ]] ; then

    ###########################################################################
    ## Interactive Shells                                                    ##
    ###########################################################################

    # Update window lines and columns after each command
    shopt -s checkwinsize

    # Prompt (34m: blue; 33m: yellow; 0m: normal)
    PS1="\e[34m${USERS}@${HOSTNAME}:\e[33m\w\e[0m\$ "

    # Title bar setter. Echoes the user, host, and command to the title bar.
    show_command_in_title_bar() {
        # Sources:
        #   http://www.davidpashley.com/articles/xterm-titles-with-bash/)
        #   http://mg.pov.lt/blog/bash-prompt.html
        case "$BASH_COMMAND" in
            *\033]0*)
                # The command in $BASH_COMMAND is also trying to mess with the
                # title bar, so don't do anything
                ;;
            *)
                # Set the title bar
                echo -ne "\033]0;${USER}@${HOSTNAME}: ${BASH_COMMAND}\007"
                ;;
        esac
    }

    # DEBUG: Ensures `trap show_command_in_title_bar` is called before
    # executing almost every command.
    #
    # trap: Freezes $BASH_COMMAND to the current command being called, then
    # calls show_command_in_title_bar. This ensures that the echo inside
    # show_command_in_title_bar outputs the command that was just called and
    # not `echo -ne ...` itself.
    trap show_command_in_title_bar DEBUG

    # Insert the username, hostname, and working directory in the titlebar
    # before setting the prompt. (This sets the default titlebar content.)
    export PS1="\033]0;${USER}@${HOSTNAME}: \w\007$PS1"

    # Set dir colors for GNU ls, since the defaults are hard to read for some
    # filetypes, particularly symlinks
    if command -v dircolors &>/dev/null ; then
        eval `dircolors $HOME/.dir_colors/dircolors.ansi-light`
        alias ls='ls --color=auto'
    fi

else

    ###########################################################################
    ## Non-Interactive Shells                                                ##
    ###########################################################################

    : # Do nothing

fi

if shopt -q login_shell ; then

    ###########################################################################
    ## Login Shells                                                          ##
    ###########################################################################

    : # Do nothing

else

    ###########################################################################
    ## Non-Login Shells                                                      ##
    ###########################################################################

    : # Do nothing

fi

