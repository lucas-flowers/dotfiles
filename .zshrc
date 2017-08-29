# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

if [[ "$HOSTNAME" = "winlaptop" ]]; then
    # Disable that fucking annoying windows bell
    setopt NO_BEEP
fi

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode)

# User configuration

# This is a 256-color terminal damn it
TERM="xterm-256color"

# Removes an annoying delay (default: 4=0.4 seconds) before pressing <ESC>
# enables the vim normal mode
export KEYTIMEOUT=1

# 2016-03-10 Note: /sbin and /usr/sbin added to this list for OS X, but
# they're probably already available in Linux. Look for a way to remove
# those two without screwing up OS X's zsh PATH
#
# 2016-06-22 Note: ConTeXt path added because the program is likely to
# change significantly, faster, than Debian usually does. So it's installed
# in /opt/context (and completely compartmentalized, i.e., portable;
# uninstallation just requires deleting the folder and removal of this from
# PATH)
#
# 2017-08-23 Note: Make sure the PATH is extended and not replaced because it
# will overwrite PATH entries in Windows LXSS.

# Paths to append to PATH
for p in /usr/bin /bin /sbin /usr/sbin ~/.local/bin /usr/bin/X11 /usr/games /opt/context/tex/texmf-linux-64/bin /usr/local/bin ; do
    case ":$PATH:" in
        *":$p:"*) :;;
        *) PATH="$PATH:$p";;
    esac
done

# Keep only the first duplicates in $PATH and zsh's $path
typeset -U PATH path

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# what's wrong with the bash prompt?
PROMPT="%{$fg[blue]%}%n@%m:%{$fg_no_bold[yellow]%}%0~%{$reset_color%}%# "
MODE_INDICATOR="%{$fg_bold[red]%}[NORMAL]%{$reset_color%}"

# Use python3 for new virtual environments
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3

# Python virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
# export PROJECT_HOME=~/Devel # I'd rather not set this until I need it
VIRTUALENVWRAPPER_SH=/usr/local/bin/virtualenvwrapper.sh
if [ -f $VIRTUALENVWRAPPER_SH ]; then
    source $VIRTUALENVWRAPPER_SH
fi

# Allow ConTeXt to find fonts
# OSFONTDIR="/usr/local/share/fonts;$HOME/.fonts"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# Configuration git repository
alias cfg="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

