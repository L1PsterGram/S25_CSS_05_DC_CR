#!/usr/bin/env python3

import os
import subprocess
import sys
import datetime # For debug logging
from prompt_toolkit import Application
from prompt_toolkit.key_binding import KeyBindings
from prompt_toolkit.layout.containers import HSplit, Window, VSplit
from prompt_toolkit.layout.controls import FormattedTextControl
from prompt_toolkit.layout.layout import Layout
from prompt_toolkit.widgets import Button, Label, TextArea, Frame
from prompt_toolkit.styles import Style
from prompt_toolkit.formatted_text import HTML

# --- Configuration & Globals ---
SHELL_FUNCTIONS_SCRIPT = "/usr/local/bin/shell_functions.sh"
DEBUG_LOG_FILE = "/tmp/tui_debug.log" # Make sure /tmp is writable by the user

# --- Style for the TUI ---
tui_style = Style.from_dict({
    'dialog':             'bg:#333333 #dddddd',
    'dialog.body':        'bg:#2a2a2a #cccccc',
    'frame.label':        '#FFD700 bold',
    'button':             'bg:#444444 #ffffff',
    'button.focused':     'bg:#FF8C00 #000000',
    'label':              '#eeeeee',
    'text-area':          'bg:#1e1e1e #e0e0e0',
    'text-area.focused':  'bg:#101010',
    'title':              '#FFD700 bold',
    'credits':            'italic #aaaaaa',
    'logo':               '#00aaFF',
})

# --- Helper to Call Shell Functions ---
def call_shell_function(function_name, *args):
    """Calls a function defined in SHELL_FUNCTIONS_SCRIPT."""
    with open(DEBUG_LOG_FILE, "a") as f:
        f.write(f"{datetime.datetime.now()}: Attempting to call shell_function: '{function_name}' with args {args}\n")
    try:
        command = [SHELL_FUNCTIONS_SCRIPT, function_name] + list(args)
        process = subprocess.run(
            command,
            capture_output=True,
            text=True,
            check=False
        )
        with open(DEBUG_LOG_FILE, "a") as f:
            f.write(f"{datetime.datetime.now()}: Shell function '{function_name}' exited with code {process.returncode}\n")
            f.write(f"STDOUT:\n{process.stdout}\nSTDERR:\n{process.stderr}\n")

        if process.returncode != 0:
            return f"Error calling {function_name} (Exit Code: {process.returncode}):\nSTDOUT:\n{process.stdout}\nSTDERR:\n{process.stderr}"
        return process.stdout
    except FileNotFoundError:
        with open(DEBUG_LOG_FILE, "a") as f:
            f.write(f"{datetime.datetime.now()}: FileNotFoundError for '{SHELL_FUNCTIONS_SCRIPT}'\n")
        return f"Error: Script '{SHELL_FUNCTIONS_SCRIPT}' not found."
    except Exception as e:
        with open(DEBUG_LOG_FILE, "a") as f:
            f.write(f"{datetime.datetime.now()}: Exception calling '{function_name}': {str(e)}\n")
        return f"An unexpected error occurred while calling {function_name}: {str(e)}"

# --- TUI Application State ---
app_instance = None
output_text_area = TextArea(
    text="Welcome! Select an option from the menu.",
    read_only=True,
    style='class:text-area',
    scrollbar=True,
    line_numbers=False,
    wrap_lines=True
)

# --- Logo and Credits ---
LOGO_TEXT = HTML(
"<logo>    _ (`-.    ('-.       .-') _  .-') _     ('-.    .-')    .-') _    </logo>\n"
"<logo>   ( (OO  ) _(  OO)     ( OO ) )(  OO) )  _(  OO)  ( OO ). (  OO) )   </logo>\n"
"<logo>  _.`     \(,------.,--./ ,--,' /     '._(,------.(_)---\_)/     '._  </logo>\n"
"<logo> (__...--'' |  .---'|   \ |  |\ |'--...__)|  .---'/    _ | |'--...__) </logo>\n"
"<logo>  |  /  | | |  |    |    \|  | )'--.  .--'|  |    \  :` `. '--.  .--' </logo>\n"
"<logo>  |  |_.' |(|  '--. |  .     |/    |  |  (|  '--.  '..`''.)   |  |    </logo>\n"
"<logo>  |  .___.' |  .--' |  |\    |     |  |   |  .--' .-._)   \   |  |    </logo>\n"
"<logo>  |  |      |  `---.|  | \   |     |  |   |  `---.\       /   |  |    </logo>\n"
"<logo>  `--'      `------'`--'  `--'     `--'   `------' `-----'    `--'    </logo>\n"
)
CREDITS_TEXT = HTML(
    "<credits>  Welcome to the Pentesting Tools Container!\n"
    "  Developed by: Daniel Critchlow Jr. &amp; Carlos Rodriguez/Team 5\n"
    "  GitHub: https://github.com/users/L1PsterGram/projects/1</credits>"
)

# --- Action Handlers ---
def update_output_area(title, content_function_name_or_direct_content, is_direct_content=False):
    global output_text_area, app_instance 
    content_to_display = ""
    with open(DEBUG_LOG_FILE, "a") as f:
        f.write(f"{datetime.datetime.now()}: update_output_area: title='{title}'\n")

    if is_direct_content:
        content_to_display = content_function_name_or_direct_content
    else:
        content_to_display = call_shell_function(content_function_name_or_direct_content)
    
    output_text_area.text = f"--- {title} ---\n\n{content_to_display}"
    with open(DEBUG_LOG_FILE, "a") as f:
        f.write(f"{datetime.datetime.now()}: output_text_area.text updated.\n")
    
    if app_instance and app_instance.layout: 
       app_instance.layout.focus(output_text_area)
       with open(DEBUG_LOG_FILE, "a") as f:
           f.write(f"{datetime.datetime.now()}: output_text_area focused.\n")


def action_welcome(): update_output_area("Full Welcome Message & Features", "display_welcome")
def action_job_status(): update_output_area("Job Status", "display_job_status")
def action_help(): update_output_area("Help / Usage Instructions", "display_help")
def action_manual(): update_output_area("User Manual", "display_manual")
def action_bash_shell():
    global app_instance
    if app_instance: app_instance.exit(result="start_bash")
def action_exit_container():
    global app_instance
    if app_instance: app_instance.exit(result="exit_container")

# --- Menu Buttons & Layout ---
buttons_layout = HSplit([
    Button("1. Welcome & Features", handler=action_welcome),
    Button("2. Job Status", handler=action_job_status),
    Button("3. Help / Usage", handler=action_help),
    Button("4. User Manual", handler=action_manual),
    Button("5. Start Bash Shell", handler=action_bash_shell),
    Button("0. Exit Container", handler=action_exit_container),
], padding=0, style='class:dialog.body')

root_container = HSplit([
    Frame(title="Pentesting Tools Hub", body=HSplit([
        # MODIFIED: Changed height from 7 to 9 for the logo window
        Window(content=FormattedTextControl(text=LOGO_TEXT), height=9, style='class:dialog.body'),
        Window(content=FormattedTextControl(text=CREDITS_TEXT), height=3, style='class:dialog.body'),
    ]), style='class:dialog'),
    Frame(title="Menu Options", body=buttons_layout, style='class:dialog'),
    Frame(title="Output / Content (Scroll with Up/Down/PgUp/PgDn)", body=output_text_area, style='class:dialog'),
], style='class:dialog')

# --- Key Bindings ---
kb = KeyBindings()
@kb.add('c-c', eager=True)
@kb.add('c-q', eager=True)
def _(event): event.app.exit(result="user_interrupt")

# --- Main Application ---
def main():
    global app_instance
    with open(DEBUG_LOG_FILE, "w") as f:
        f.write(f"{datetime.datetime.now()}: TUI Application Started.\n")
    os.system('clear')

    app_instance = Application(
        layout=Layout(root_container),
        key_bindings=kb,
        full_screen=True,
        style=tui_style,
        mouse_support=True
    )
    exit_reason = app_instance.run()
    
    os.system('clear')
    if exit_reason == "start_bash":
        print("Starting bash shell...")
        try: os.execvp("bash", ["bash"])
        except FileNotFoundError:
            print("Error: bash command not found.", file=sys.stderr)
            sys.exit(1)
    elif exit_reason == "exit_container": print("Exiting container.")
    elif exit_reason == "user_interrupt": print("Exited by user (Ctrl+C or Ctrl+Q).")
    else: print(f"Exiting TUI (Reason: {exit_reason}).")
    sys.exit(0)

if __name__ == "__main__":
    if not (os.path.isfile(SHELL_FUNCTIONS_SCRIPT) and os.access(SHELL_FUNCTIONS_SCRIPT, os.X_OK)):
        print(f"Critical Error: '{SHELL_FUNCTIONS_SCRIPT}' not found or not executable.", file=sys.stderr)
        sys.exit(1)
    main()
