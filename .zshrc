
# This is the configuration file for *interactive* sessions of zsh.

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# I've stored environment stuff in .profile, for use by different shells
source $HOME/.profile

# Sometimes (*cough* WSL *cough*) SHELL is still set to bash; fix it
export SHELL='zsh'

# Keep only the first insance of any duplicates in $PATH and zsh's path
typeset -U PATH path

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="yyyy-mm-dd"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git vi-mode)

###############################################################################
###############################################################################
#### User Configuration                                                    ####
###############################################################################
###############################################################################

# Removes an annoying delay (default: 4=0.4 seconds) before pressing <ESC>
# enables the vim normal mode
export KEYTIMEOUT=1

source $ZSH/oh-my-zsh.sh

# what's wrong with the bash prompt?
PROMPT="%{$fg[blue]%}%n@%m:%{$fg_no_bold[yellow]%}%0~%{$reset_color%}%# "
MODE_INDICATOR="%{$fg_bold[red]%}[NORMAL]%{$reset_color%}"

# Set dir colors for GNU ls, since the defaults are hard to read for some
# filetypes, particularly symlinks
if command -v dircolors &>/dev/null ; then
    eval `dircolors ~/.dir_colors/dircolors.ansi-light`
fi

# Allow ConTeXt to find fonts
# OSFONTDIR="/usr/local/share/fonts;$HOME/.fonts"

# Disable that fucking annoying windows bell
if [[ "$HOST" = "winlaptop" ]]; then
    setopt NO_BEEP
fi

# Aliases. These aliases will override any that oh-my-zsh libraries, plugins,
# and themes provide. (Note that oh-my-zsh recommends putting aliases in
# ZSH_CUSTOM. Maybe put zsh-specific aliases there?)
source ~/.bash_aliases

