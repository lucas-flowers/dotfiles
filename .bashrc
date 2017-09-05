
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

    # Prompt
    blue='\033[34m' ; yellow='\033[33m' ; normal='\033[0m'
    PS1=$(printf "%b${USER}@${HOSTNAME}:%b\w%b\$ " "$blue" "$yellow" "$normal")

    # Title bar for xterm
    case $TERM in
        xterm*)

            # Sources:
            #   http://www.davidpashley.com/articles/xterm-titles-with-bash/)
            #   http://mg.pov.lt/blog/bash-prompt.html

            # Title bar escape sequences for xterm
            title_begin='\033]2;'
            title_end='\007'

            # Title bar setter function
            preexec() {
                case "$BASH_COMMAND" in
                    *\033]*\;)
                        # The command in $BASH_COMMAND is also trying to mess
                        # with the title bar, so don't do anything
                        ;;
                    *)
                        # Show the command currently executed in the title bar
                        cmd="$BASH_COMMAND"
                        printf "${title_begin}${USER}@${HOSTNAME}: ${cmd}${title_end}"
                        ;;
                esac
            }

            # DEBUG ensures `trap preexec` runs immediately prior to (almost)
            # every command executed.
            #
            # Now, the $BASH_COMMAND variable always stores the command
            # currently executing. As seen in the code for preexec() above, if
            # run without `trap`, this means $BASH_COMMAND will be empty (or at
            # least not what we want it to be?). To fix this, we instead use
            # `trap preexec`, which ensures that $BASH_COMMAND stores the
            # command executing at the time of the trap (i.e., the command that
            # triggered DEBUG to activate `trap preexec`).
            trap preexec DEBUG

            # After a command completes executing, we want the title bar to
            # return to the user-host-directory format. To do this, we add an
            # escape sequence to PS1 (which normally generates the bash prompt)
            # that will add the user, host, and directory to the window title
            # prior to printing the actual bash prompt from the old $PS1.
            PS1="${title_begin}${USER}@${HOSTNAME}: \w${title_end}$PS1"

            ;;
    esac

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

