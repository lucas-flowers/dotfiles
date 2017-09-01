
# Use .profile for most things
emulate sh
source ~/.profile
emulate zsh

# Remove duplicates from $PATH and zsh's $path, keeping the first instance of
# each duplicate
typeset -U PATH path

