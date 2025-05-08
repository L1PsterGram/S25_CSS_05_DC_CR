#!/usr/bin/env python3

import os
import subprocess
import sys
import datetime # For debug logging
from prompt_toolkit import Application
from prompt_toolkit.key_binding import KeyBindings
# Import Dimension object 'D' - Although not strictly needed after removing Window wrappers unless we apply width directly to Frames/HSplits
from prompt_toolkit.layout.dimension import D 
from prompt_toolkit.layout.containers import HSplit, Window, VSplit
from prompt_toolkit.layout.controls import FormattedTextControl
from prompt_toolkit.layout.layout import Layout
from prompt_toolkit.widgets import Button, Label, TextArea, Frame
from prompt_toolkit.styles import Style
from prompt_toolkit.formatted_text import HTML

# --- Configuration & Globals ---
SHELL_FUNCTIONS_SCRIPT = "/usr/local/bin/shell_functions.sh"
DEBUG_LOG_FILE = "/tmp/tui_debug.log" 

# --- Style for the TUI ---
tui_style = Style.from_dict({
    'dialog':             'bg:#333333 #dddddd',
    'dialog.body':        'bg:#2a2a2a #cccccc',
    'frame':              'bg:#333333', 
    'frame.label':        '#FFD700 bold',
    'button':             'bg:#444444 #ffffff',
    # This style is applied when the button has focus (e.g., navigating with arrow keys)
    'button.focused':     'bg:#FF8C00 #000000', 
    'label':              '#eeeeee',
    'text-area':          'bg:#1e1e1e #e0e0e0',
    'text-area.focused':  'bg:#101010',
    'title':              '#FFD700 bold',
    'credits':            'italic #aaaaaa',
    'logo':               '#00aaFF',
    'vsplit-line':        'bg:#333333 #888888', 
    'action-confirm':     'fg:#00FF00 bold', # Style for the confirmation text
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
app_instance = None # Keep track of the current app instance
output_text_area = TextArea(
    text="Welcome! Select an option from the menu.",
    read_only=True,
    style='class:text-area',
    scrollbar=True,
    line_numbers=False,
    wrap_lines=True
)
# We still need a reference to the button container to return focus
buttons_layout = None 

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
def update_output_area(action_title, content_function_name_or_direct_content, is_direct_content=False):
    """Updates the output area, prepending the action taken."""
    global output_text_area, app_instance, buttons_layout # Need access to buttons_layout
    content_to_display = ""
    action_confirmation = f"--- Action Selected: {action_title} ---"
    
    with open(DEBUG_LOG_FILE, "a") as f:
        f.write(f"{datetime.datetime.now()}: update_output_area: action='{action_title}'\n")

    if is_direct_content:
        content_to_display = content_function_name_or_direct_content
    else:
        content_to_display = call_shell_function(content_function_name_or_direct_content)
    
    # Prepend the action confirmation to the actual content
    output_text_area.text = f"{action_confirmation}\n\n{content_to_display}"
    
    with open(DEBUG_LOG_FILE, "a") as f:
        f.write(f"{datetime.datetime.now()}: output_text_area.text updated.\n")
    
    # Return focus to the button container to keep navigation intuitive
    if app_instance and app_instance.layout and buttons_layout: 
       try:
           app_instance.layout.focus(buttons_layout) 
           with open(DEBUG_LOG_FILE, "a") as f:
               f.write(f"{datetime.datetime.now()}: buttons_layout focused.\n")
       except Exception as focus_error:
            with open(DEBUG_LOG_FILE, "a") as f:
               f.write(f"{datetime.datetime.now()}: Error focusing buttons_layout: {focus_error}\n")

# Define actions that call update_output_area with a descriptive title
def action_welcome(): update_output_area("Welcome & Features", "display_welcome")
def action_job_status(): update_output_area("Job Status", "display_job_status")
def action_help(): update_output_area("Help / Usage", "display_help")
def action_manual(): update_output_area("User Manual", "display_manual")
def action_bash_shell():
    global app_instance
    if app_instance: app_instance.exit(result="start_bash") # Signal intent to start bash
def action_exit_container():
    global app_instance
    if app_instance: app_instance.exit(result="exit_container") # Signal intent to exit fully

# --- Menu Buttons & Layout ---
# Assign the HSplit to the global variable here
buttons_layout = HSplit([ 
    Button("1. Welcome & Features", handler=action_welcome), 
    Button("2. Job Status", handler=action_job_status),
    Button("3. Help / Usage", handler=action_help),
    Button("4. User Manual", handler=action_manual),
    Button("5. Start Bash Shell", handler=action_bash_shell),
    Button("0. Exit Container", handler=action_exit_container),
], padding=0, width=72, style='class:dialog.body')

# Define the left panel (Logo, Credits, Menu)
left_panel_content = HSplit([
    Frame(title="Pentesting Tools Hub", body=HSplit([
        Window(content=FormattedTextControl(text=LOGO_TEXT), height=9, style='class:dialog.body'),
        Window(content=FormattedTextControl(text=CREDITS_TEXT), height=3, style='class:dialog.body'), 
    ]), style='class:frame'), 
    Frame(title="Menu Options", body=buttons_layout, style='class:frame') 
])

# Define the right panel (Output Area)
right_panel_content = Frame(
    title="Output / Content (Scroll with Up/Down/PgUp/PgDn, Tab to focus)", 
    body=output_text_area,
    style='class:frame'
)

# root_container uses VSplit directly with the panel contents
root_container = VSplit([
    left_panel_content, 
    Window(width=1, char='│', style='class:vsplit-line'), 
    right_panel_content,
], padding=0, style='class:dialog') 

# --- Key Bindings ---
kb = KeyBindings()
@kb.add('c-c', eager=True)
@kb.add('c-q', eager=True)
def _(event): event.app.exit(result="user_interrupt") # Signal intent for interrupt exit

# --- Main Application ---
def main():
    global app_instance # Make sure we can modify the global instance

    # Outer loop to allow relaunching the TUI after bash exits
    while True: 
        # Clear debug log for this run
        with open(DEBUG_LOG_FILE, "w") as f:
            f.write(f"{datetime.datetime.now()}: TUI Application Starting/Restarting.\n")
        
        # Clear screen before starting TUI (optional, but can be cleaner)
        # os.system('clear') # Can cause flicker, might remove

        # Initialize the Application for this run
        app_instance = Application(
            layout=Layout(root_container),
            key_bindings=kb,
            full_screen=True,
            style=tui_style,
            mouse_support=True
        )
        
        # Run the TUI event loop. This blocks until app.exit() is called.
        exit_reason = app_instance.run()
        
        # Post-TUI actions based on the exit reason
        os.system('clear') # Clear the TUI screen after it exits

        if exit_reason == "start_bash":
            print("Starting bash shell... Type 'exit' to return to TUI.")
            # Run bash interactively. The script waits here until bash exits.
            return_code = os.system('bash') 
            with open(DEBUG_LOG_FILE, "a") as f:
                f.write(f"{datetime.datetime.now()}: Bash shell exited with code {return_code}.\n")
            os.system('clear') # Clear bash output before restarting TUI
            continue # Go back to the start of the while loop to relaunch TUI

        elif exit_reason == "exit_container":
            print("Exiting container.")
            break # Exit the while loop

        elif exit_reason == "user_interrupt":
            print("Exited by user (Ctrl+C or Ctrl+Q).")
            break # Exit the while loop
        
        else:
            # Handle any other unexpected exit reasons
            print(f"Exiting TUI (Reason: {exit_reason}).")
            break # Exit the while loop

    # Script finishes after the loop breaks
    sys.exit(0)


if __name__ == "__main__":
    # Initial check for the shell functions script
    if not (os.path.isfile(SHELL_FUNCTIONS_SCRIPT) and os.access(SHELL_FUNCTIONS_SCRIPT, os.X_OK)):
        print(f"Critical Error: '{SHELL_FUNCTIONS_SCRIPT}' not found or not executable.", file=sys.stderr)
        sys.exit(1)
    main()