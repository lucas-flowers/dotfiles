#!/usr/bin/env python3
"""
Focus a macOS window and optionally switch to a specific tmux session/window/pane.
"""

import argparse
import subprocess
import sys
import shutil
from typing import Optional, Tuple, Protocol
from pathlib import Path
import tempfile
from contextlib import contextmanager
import os

# Tmux binary path
TMUX = "tmux"


class WindowManager(Protocol):
    """Protocol for platform-specific window management operations."""

    def list_windows(self) -> str:
        """List all non-background windows."""
        ...

    def focus_window(self, identifier: str) -> bool:
        """Focus a window by application name or window title substring."""
        ...


class MacOSWindowManager:
    """macOS-specific window management using AppleScript."""

    def _run_applescript(self, script: str) -> Tuple[bool, str]:
        """Run an AppleScript and return success status and output."""
        try:
            result = subprocess.run(
                ["osascript", "-e", script],
                capture_output=True,
                text=True,
                check=False
            )
            return result.returncode == 0, result.stdout.strip()
        except Exception as e:
            return False, str(e)

    def list_windows(self) -> str:
        """List all non-background windows."""
        script = '''
tell application "System Events"
    set output to ""
    repeat with proc in (every process whose background only is false)
        set procName to name of proc
        try
            repeat with win in (every window of proc)
                set winName to name of win
                set output to output & procName & " :: " & winName & linefeed
            end repeat
        on error
            -- Process has no windows or is not accessible
        end try
    end repeat
    return output
end tell
'''
        success, output = self._run_applescript(script)
        return output if success else ""

    def focus_window(self, identifier: str) -> bool:
        """Focus a window by application name."""
        # Direct activation - no looping through processes
        script = f'tell application "{identifier}" to activate'
        success, _ = self._run_applescript(script)
        return success


class LinuxWindowManager:
    """Linux-specific window management using KWin D-Bus API."""

    KWIN_SERVICE = "org.kde.KWin"

    def __init__(self, qdbus_bin: str = "qdbus6"):
        """Initialize with path to qdbus binary."""
        self.qdbus_bin = qdbus_bin

    @contextmanager
    def _kwin_script(self, script_content: str):
        """Create temporary KWin JavaScript file."""
        with tempfile.NamedTemporaryFile(mode='w', suffix='.js', delete=False) as f:
            f.write(script_content)
            path = Path(f.name)

        try:
            yield str(path)
        finally:
            path.unlink(missing_ok=True)

    def _run_kwin_script(self, script_content: str) -> str:
        """Execute a KWin script and return output."""
        with self._kwin_script(script_content) as script_path:
            # Load script
            result = subprocess.run(
                [self.qdbus_bin, self.KWIN_SERVICE, '/Scripting',
                 'org.kde.kwin.Scripting.loadScript', script_path, 'TempScript'],
                capture_output=True, text=True, check=True
            )
            script_id = result.stdout.strip()

            try:
                # Run script
                run_result = subprocess.run(
                    [self.qdbus_bin, self.KWIN_SERVICE, f'/Scripting/Script{script_id}',
                     'org.kde.kwin.Script.run'],
                    capture_output=True, text=True, check=True
                )
                return run_result.stdout.strip()
            finally:
                # Always attempt to stop script, but don't fail if it's already stopped
                subprocess.run(
                    [self.qdbus_bin, self.KWIN_SERVICE, f'/Scripting/Script{script_id}',
                     'org.kde.kwin.Script.stop'],
                    capture_output=True, check=False
                )

    def list_windows(self) -> str:
        """List all windows via KWin scripting."""
        script = """
const clients = workspace.windowList();
let output = "";
for (let i = 0; i < clients.length; i++) {
    const client = clients[i];
    const resourceClass = client.resourceClass.toString();
    const caption = client.caption.toString();
    if (caption) {
        output += resourceClass + " :: " + caption + "\\n";
    }
}
console.log(output);
"""
        return self._run_kwin_script(script)

    def focus_window(self, identifier: str) -> bool:
        """Focus a window by resource class or caption substring."""
        safe_identifier = identifier.replace("'", "\\'").lower()

        script = f"""
const clients = workspace.windowList();
let found = false;

// First try exact resource class match
for (let i = 0; i < clients.length; i++) {{
    const client = clients[i];
    if (client.resourceClass.toString().toLowerCase() === '{safe_identifier}') {{
        workspace.raiseWindow(client);
        workspace.activeWindow = client;
        console.log("focus-window.py: Activated by class: " + client.caption);
        found = true;
        break;
    }}
}}

// Then try caption substring match
if (!found) {{
    for (let i = 0; i < clients.length; i++) {{
        const client = clients[i];
        if (client.caption.toString().toLowerCase().includes('{safe_identifier}')) {{
            workspace.raiseWindow(client);
            workspace.activeWindow = client;
            console.log("focus-window.py: Activated by caption: " + client.caption);
            found = true;
            break;
        }}
    }}
}}

if (!found) {{
    console.log("focus-window.py: Window not found: {safe_identifier}");
}}
"""
        self._run_kwin_script(script)
        # Always return True since we can't capture script output
        # Check journalctl for actual success/failure logs
        return True


def interactive_select(windows: str) -> Optional[str]:
    """Allow user to interactively select a window."""
    if not windows.strip():
        print("No windows available")
        return None

    # Try to use fzf if available
    if shutil.which("fzf"):
        try:
            result = subprocess.run(
                ["fzf", "--prompt=Select window: ", "--height=40%"],
                input=windows,
                capture_output=True,
                text=True,
                check=False
            )
            if result.returncode == 0:
                return result.stdout.strip()
            return None
        except Exception:
            pass

    # Fallback: numbered list
    window_list = [w for w in windows.split('\n') if w.strip()]
    print("\nAvailable windows:")
    for idx, window in enumerate(window_list, 1):
        print(f"{idx:2}. {window}")
    print()

    try:
        selection = int(input("Select window number: "))
        if 1 <= selection <= len(window_list):
            return window_list[selection - 1]
    except (ValueError, KeyboardInterrupt):
        pass

    return None


def switch_tmux(session: str, window: Optional[str] = None, pane: Optional[str] = None) -> None:
    """Switch tmux to specified session/window/pane."""
    # Check if tmux is running
    subprocess.run(
        [TMUX, "list-sessions"],
        capture_output=True,
        check=True
    )

    # Build the target string
    target = session
    if window:
        target = f"{target}:{window}"
    if pane:
        target = f"{target}.{pane}"

    # Execute appropriate tmux command
    if pane is not None:
        # First select the window, then the specific pane
        if window is not None:
            subprocess.run(
                [TMUX, "select-window", "-t", f"{session}:{window}"],
                capture_output=True,
                check=True
            )
        subprocess.run(
            [TMUX, "select-pane", "-t", target],
            capture_output=True,
            check=True
        )
    elif window is not None:
        # Select window in session
        subprocess.run(
            [TMUX, "select-window", "-t", target],
            capture_output=True,
            check=True
        )
    else:
        # Switch client to session (if we're in a tmux client)
        if "TMUX" in os.environ:
            subprocess.run(
                [TMUX, "switch-client", "-t", target],
                capture_output=True,
                check=True
            )
        else:
            # If not in tmux, just verify the session exists
            subprocess.run(
                [TMUX, "has-session", "-t", session],
                capture_output=True,
                check=True
            )
            print(f"Note: Session '{session}' exists (run from within tmux to switch clients)")


def main():
    parser = argparse.ArgumentParser(
        description="Focus a macOS window and optionally switch to a specific tmux session/window/pane.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
examples:
  # Focus iTerm2
  %(prog)s -w "iTerm2"

  # Focus iTerm and switch to tmux session 'work', window 1, pane 2
  %(prog)s -w "iTerm2" -s work -n 1 -p 2

  # Focus any window with "Terminal" in the name
  %(prog)s -w "Terminal" -s dev -n 0

  # List all windows
  %(prog)s --list

  # Interactive selection
  %(prog)s --interactive

notes:
  - Window identifier can be an exact application name (e.g., "iTerm2", "Terminal")
    or a substring of a window title
  - Tmux commands will affect all clients attached to the target session
  - For tmux switching to work, the tmux server must be running
"""
    )

    parser.add_argument(
        "-w", "--window",
        help="Window identifier (app name or window title substring)"
    )
    parser.add_argument(
        "-s", "--session",
        help="Tmux session name"
    )
    parser.add_argument(
        "-n", "--window-num",
        help="Tmux window number or name"
    )
    parser.add_argument(
        "-p", "--pane",
        help="Tmux pane number"
    )
    parser.add_argument(
        "-l", "--list",
        action="store_true",
        help="List available windows and exit"
    )
    parser.add_argument(
        "-i", "--interactive",
        action="store_true",
        help="Interactive window selection (with fzf if available)"
    )
    parser.add_argument(
        "--tmux-bin",
        help="Path to tmux binary (default: tmux)"
    )

    args = parser.parse_args()

    # Set tmux binary path if provided
    global TMUX
    if args.tmux_bin:
        TMUX = args.tmux_bin

    # Initialize window manager based on platform
    if sys.platform == "darwin":
        wm = MacOSWindowManager()
    elif sys.platform == "linux":
        wm = LinuxWindowManager()
    else:
        raise RuntimeError(f"Unsupported platform: {sys.platform}. Only macOS (darwin) and Linux are supported.")

    # Handle list mode
    if args.list:
        print("Available windows:\n")
        windows = wm.list_windows()
        print(windows if windows else "No windows found")
        sys.exit(0)

    # Handle interactive mode
    window_id = args.window
    if args.interactive:
        windows = wm.list_windows()
        selected = interactive_select(windows)
        if not selected:
            print("No window selected")
            sys.exit(1)
        # Extract app name (before ::)
        window_id = selected.split(":")[0].strip()
        print(f"Selected: {selected}")

    # Require window identifier
    if not window_id:
        parser.error("Window identifier required (use -w, -i, or -l)")

    # Focus the window
    print(f"Focusing: {window_id}")
    if not wm.focus_window(window_id):
        print(f"Error: Could not find or focus window '{window_id}'")
        print("Try using --list to see available windows")
        sys.exit(1)

    # Switch tmux if requested
    if args.session:
        target_display = args.session
        if args.window_num:
            target_display = f"{target_display}:{args.window_num}"
        if args.pane:
            target_display = f"{target_display}.{args.pane}"

        print(f"Switching tmux to: {target_display}")
        switch_tmux(args.session, args.window_num, args.pane)
        print("Successfully switched tmux context")

    print("Done")


if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print("\nInterrupted")
        sys.exit(130)
