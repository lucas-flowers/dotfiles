
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

shopt -s checkwinsize # Update window lines and columns after each command
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

    # <blue:<user>@<host>:><yellow:<working_directory>><normal:$ >
    PS1='\e[34m\u@\h:\e[33m\W\e[0m\$ '

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

