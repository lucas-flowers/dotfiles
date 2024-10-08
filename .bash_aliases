
# Configuration git repository
alias cfg="git --git-dir=\"$HOME/.dotfiles/\" --work-tree=\"$HOME\""

# Common aliases
alias ll='ls -l'
alias la='ls -A'
alias k=kubectl

# Because I don't want to remember command flags for such a common operation
if ! command -v pbcopy >/dev/null 2>&1; then
    if command -v xclip >/dev/null 2>&1; then
        alias pbcopy='xclip -selection clipboard'
        alias pbpaste='xclip -selection clipboard -o'
    fi
fi

