#!/bin/bash
# Focus detection library for Claude Code hooks
# Provides functions to check if user is focused on the terminal and tmux pane

# Detect the actual terminal emulator (handles tmux case)
get_terminal_app() {
    local term="${1:-$TERM_PROGRAM}"

    # If inside tmux, TERM_PROGRAM is "tmux" - use LC_TERMINAL instead
    if [[ "$term" == "tmux" ]]; then
        term="${LC_TERMINAL:-}"
    fi

    # Fallback: check __CFBundleIdentifier for iTerm, or use OS defaults
    if [[ -z "$term" ]]; then
        if [[ "${__CFBundleIdentifier:-}" == "com.googlecode.iterm2" ]]; then
            term="iTerm2"
        else
            case "$(uname)" in
                Darwin)
                    term="iTerm2"
                    ;;
                Linux)
                    term="konsole"
                    ;;
                *)
                    echo "Error: Unsupported OS $(uname)" >&2
                    return 1
                    ;;
            esac
        fi
    fi

    echo "$term"
}

# Check if the macOS frontmost application is our terminal
check_macos_focus() {
    local terminal_app
    terminal_app=$(get_terminal_app "${1:-}")

    # Get frontmost application
    local frontmost
    frontmost=$(osascript -e '
        tell application "System Events"
            set frontApp to first application process whose frontmost is true
            return name of frontApp
        end tell
    ' 2>/dev/null)

    # Normalize terminal name to process name
    local expected_app
    case "$terminal_app" in
        "Apple_Terminal") expected_app="Terminal" ;;
        "iTerm.app")      expected_app="iTerm2" ;;
        "iTerm2")         expected_app="iTerm2" ;;
        *)                expected_app="$terminal_app" ;;
    esac

    [[ "$frontmost" == "$expected_app" ]]
}

# Check if the Linux frontmost window is our terminal
check_linux_focus() {
    local terminal_app
    terminal_app=$(get_terminal_app "${1:-}")

    # Get frontmost application window class
    local frontmost
    frontmost=$(kdotool getwindowclassname $(kdotool getactivewindow) 2>/dev/null)

    # Normalize terminal name to window class
    local expected_app
    case "$terminal_app" in
        "konsole")        expected_app="org.kde.konsole" ;;
        *)                expected_app="$terminal_app" ;;
    esac

    [[ "$frontmost" == "$expected_app" ]]
}

# Check if the tmux pane we started in is currently active
check_tmux_focus() {
    local saved_session="${1:-}"
    local saved_window="${2:-}"
    local saved_pane="${3:-}"

    # Not in tmux or no saved values? Skip this check (return success)
    [[ -z "$TMUX" ]] && return 0
    [[ -z "$saved_session" ]] && return 0

    # Find the truly active pane in the session (where BOTH window and pane are active)
    # list-panes -s shows all panes in session with their actual active states
    local active_pane_info
    active_pane_info=$(tmux list-panes -t "$saved_session" -s \
        -F '#{window_index} #{pane_index} #{pane_active} #{window_active}' 2>/dev/null \
        | awk '$3 == 1 && $4 == 1 {print $1, $2}')

    local active_window active_pane
    active_window=$(echo "$active_pane_info" | cut -d' ' -f1)
    active_pane=$(echo "$active_pane_info" | cut -d' ' -f2)

    # Check if the active pane matches our saved pane
    [[ "$active_window" == "$saved_window" ]] && \
    [[ "$active_pane" == "$saved_pane" ]]
}

# Combined check: is user focused on BOTH the terminal app AND the correct tmux pane?
is_user_focused() {
    local term_program="${SAVED_TERM_PROGRAM:-$TERM_PROGRAM}"
    local tmux_session="${SAVED_TMUX_SESSION:-}"
    local tmux_window="${SAVED_TMUX_WINDOW:-}"
    local tmux_pane="${SAVED_TMUX_PANE:-}"

    # Both checks must pass
    case "$(uname)" in
        Darwin)
            check_macos_focus "$term_program" && \
            check_tmux_focus "$tmux_session" "$tmux_window" "$tmux_pane"
            ;;
        Linux)
            check_linux_focus "$term_program" && \
            check_tmux_focus "$tmux_session" "$tmux_window" "$tmux_pane"
            ;;
        *)
            # Unsupported OS - assume not focused
            return 1
            ;;
    esac
}
