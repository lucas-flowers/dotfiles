
# This is the configuration file for *interactive* sessions of zsh.

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# I've stored environment stuff in .profile, for use by different shells
emulate sh
source $HOME/.profile
emulate zsh

# Sometimes (*cough* WSL *cough*) SHELL is still set to bash. Also,
# ~/.ssh/config thinks $SHELL is an absolute path, but the default is just the
# shell's name. This fixes both issues.
export SHELL="$(which zsh)"

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

# I'll do updates myself, thanks
DISABLE_AUTO_UPDATE=true

###############################################################################
###############################################################################
#### User Configuration                                                    ####
###############################################################################
###############################################################################

# Removes an annoying delay (default: 4=0.4 seconds) before pressing <ESC>
# enables the vim normal mode
export KEYTIMEOUT=1

ZSH_CUSTOM=$HOME/.oh-my-zsh-custom
source $ZSH/oh-my-zsh.sh

# Prompt
PROMPT="%{$fg[blue]%}%n@%m:%{$fg_no_bold[yellow]%}%0~%{$reset_color%}%# "
MODE_INDICATOR="%{$fg_bold[red]%}[NORMAL]%{$reset_color%}"

# Title bar for xterm
case $TERM in
    screen*|xterm*)
        title_begin='\033]2;'
        title_end='\007'
        precmd() {
            # Show directory by default
            dir="$(print -P '%~')"
            echo -n "${title_begin}${USER}@${HOST}: ${dir}${title_end}"
        }
        preexec() {
            # Show the command when a command is run
            cmd="$1"
            echo -n "${title_begin}${USER}@${HOST}: ${cmd}${title_end}"
        }
        ;;
    linux*)

        # TODO This should probably not be zshrc-specific

        # Standard Solarized color palette
        S_base03="002b36"
        S_base02="073642"
        S_base01="586e75"
        S_base00="657b83"
        S_base0="839496"
        S_base1="93a1a1"
        S_base2="eee8d5"
        S_base3="fdf6e3"
        S_yellow="b58900"
        S_orange="cb4b16"
        S_red="dc322f"
        S_magenta="d33682"
        S_violet="6c71c4"
        S_blue="268bd2"
        S_cyan="2aa198"
        S_green="859900"

        # Set Solarized
        echo -en "\e]P0$S_base02"
        echo -en "\e]P1$S_red"
        echo -en "\e]P2$S_green"
        echo -en "\e]P3$S_yellow"
        echo -en "\e]P4$S_blue"
        echo -en "\e]P5$S_magenta"
        echo -en "\e]P6$S_cyan"
        echo -en "\e]P7$S_base2"
        echo -en "\e]P8$S_base03"
        echo -en "\e]P9$S_orange"
        echo -en "\e]Pa$S_base01"
        echo -en "\e]Pb$S_base00"
        echo -en "\e]Pc$S_base0"
        echo -en "\e]Pd$S_violet"
        echo -en "\e]Pe$S_base1"
        echo -en "\e]Pf$S_base3"

        # Invert background and foreground to become Solarized Light
        # TODO Should *everything* be escape sequences, or should it all be setterm?
        # TODO Is this *really* Solarized light? I'm pretty sure this command doesn't change the bases
        setterm --foreground black --background white --store

esac

# If LS_COLORS has been defined (i.e., `dircolors` was run), use those colors
# for zsh autocompletion.
if [ -n "$LS_COLORS" ] ; then
    # Colors for zsh autocompletion. If the directories are insecure, use
    # compaudit+chmod to find the insecure files and remove write permissions
    # from everyone who's not the current user:
    #
    #   compaudit | xargs chmod go-w # (chown might be necessary, too)
    #
    zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
    autoload -Uz compinit
fi

# Fuzzy finder in CTRL-R
if [ -f "$HOME/.fzf.zsh" ]; then
    source ~/.fzf.zsh
fi

# Replace cd with zoxide
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh --cmd cd)"
fi

# Aliases. These aliases will override any that oh-my-zsh libraries, plugins,
# and themes provide. (Note that oh-my-zsh recommends putting aliases in
# ZSH_CUSTOM. Maybe put zsh-specific aliases there?)
source ~/.bash_aliases
