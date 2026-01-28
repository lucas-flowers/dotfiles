#!/bin/bash
# Claude Code hook: Check focus and notify if user isn't looking
# This script is called by Claude Code's Stop hook

set -uo pipefail

# Only run on macOS (uses osascript and terminal-notifier)
[[ "$(uname)" != "Darwin" ]] && exit 0

# Read hook input from stdin
HOOK_INPUT=$(cat)
TRANSCRIPT_PATH=$(echo "$HOOK_INPUT" | jq -r '.transcript_path // empty')
HOOK_EVENT=$(echo "$HOOK_INPUT" | jq -r '.hook_event_name // empty')
TOOL_NAME=$(echo "$HOOK_INPUT" | jq -r '.tool_name // empty')
TOOL_INPUT=$(echo "$HOOK_INPUT" | jq -r '.tool_input // empty')

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FOCUS_LIB="$SCRIPT_DIR/focus-check-lib.sh"

# Create a unique env file for this Claude session
# Use tmux pane ID if available (stable), otherwise fall back to PPID
if [[ -n "${TMUX_PANE:-}" ]]; then
    # Remove the % prefix from pane ID for filename
    ENV_FILE="/tmp/claude-hook-env-pane${TMUX_PANE#%}"
else
    ENV_FILE="/tmp/claude-hook-env-${PPID:-$$}"
fi

# Source the focus detection library
if [[ -f "$FOCUS_LIB" ]]; then
    source "$FOCUS_LIB"
else
    echo "Warning: Focus library not found at $FOCUS_LIB" >&2
    exit 0
fi

# Initialize/update environment capture
init_environment() {
    # Get the actual terminal app (handles tmux case)
    local actual_terminal
    actual_terminal=$(get_terminal_app)

    {
        echo "SAVED_TERM_PROGRAM=\"$actual_terminal\""
        echo "SAVED_TERM_PROGRAM_VERSION=\"${TERM_PROGRAM_VERSION:-}\""

        if [[ -n "${TMUX:-}" && -n "${TMUX_PANE:-}" ]]; then
            # Use -t $TMUX_PANE to get where THIS script is running
            # (not where the user is currently focused)
            echo "SAVED_TMUX_SESSION=\"$(tmux display-message -t "$TMUX_PANE" -p '#{session_name}' 2>/dev/null)\""
            echo "SAVED_TMUX_WINDOW=\"$(tmux display-message -t "$TMUX_PANE" -p '#{window_index}' 2>/dev/null)\""
            echo "SAVED_TMUX_PANE=\"$(tmux display-message -t "$TMUX_PANE" -p '#{pane_index}' 2>/dev/null)\""
            echo "SAVED_TMUX_PANE_ID=\"${TMUX_PANE}\""
        else
            echo "SAVED_TMUX_SESSION=\"\""
            echo "SAVED_TMUX_WINDOW=\"\""
            echo "SAVED_TMUX_PANE=\"\""
            echo "SAVED_TMUX_PANE_ID=\"\""
        fi
    } > "$ENV_FILE"
}

# Extract Claude's last message from transcript
get_last_message() {
    if [[ -z "$TRANSCRIPT_PATH" || ! -f "$TRANSCRIPT_PATH" ]]; then
        echo "Claude is waiting for your input"
        return
    fi

    # Get last assistant text message, truncate to 200 chars for notification
    local msg
    msg=$(jq -s '[.[] | select(.type == "assistant") | select([.message.content[]? | select(.type == "text")] | length > 0)] | last | .message.content[] | select(.type == "text") | .text' "$TRANSCRIPT_PATH" 2>/dev/null | head -c 200)

    # Remove surrounding quotes from jq output
    msg="${msg#\"}"
    msg="${msg%\"}"

    if [[ -n "$msg" ]]; then
        echo "$msg"
    else
        echo "Claude is waiting for your input"
    fi
}

# Get permission request details
get_permission_message() {
    local detail=""
    case "$TOOL_NAME" in
        Bash)
            detail=$(echo "$HOOK_INPUT" | jq -r '.tool_input.command // empty' | head -c 150)
            ;;
        Edit|Write)
            detail=$(echo "$HOOK_INPUT" | jq -r '.tool_input.file_path // empty')
            ;;
        *)
            detail=$(echo "$HOOK_INPUT" | jq -r '.tool_input | keys[0] as $k | .[$k] // empty' 2>/dev/null | head -c 150)
            ;;
    esac

    if [[ -n "$detail" ]]; then
        echo "$TOOL_NAME: $detail"
    else
        echo "Permission needed: $TOOL_NAME"
    fi
}

# Send notification (no click handler - just visual alert)
send_notification() {
    local message title

    if [[ "$HOOK_EVENT" == "PermissionRequest" ]]; then
        title="Claude needs approval"
        message=$(get_permission_message)
    else
        title="Claude Code"
        message=$(get_last_message)
    fi

    terminal-notifier -title "$title" -message "$message" 2>/dev/null || true
}

# Main logic
main() {
    # Always update environment (tmux pane might have changed)
    init_environment
    source "$ENV_FILE"

    # Check if user is already focused
    if is_user_focused; then
        # User is looking at Claude - no notification needed
        exit 0
    fi

    # User is not focused - send notification
    send_notification
}

main

# Always exit 0 to not block Claude Code
exit 0
