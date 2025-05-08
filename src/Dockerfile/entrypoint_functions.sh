#!/bin/bash

# --- Function Definitions ---

display_welcome() {
# Define ASCII art as a multi-line string using a heredoc
cat << 'EOF'
   _ (`-.    ('-.       .-') _  .-') _     ('-.    .-')    .-') _    
  ( (OO  ) _(  OO)     ( OO ) )(  OO) )  _(  OO)  ( OO ). (  OO) )   
 _.`     \(,------.,--./ ,--,' /     '._(,------.(_)---\_)/     '._  
(__...--'' |  .---'|   \ |  |\ |'--...__)|  .---'/    _ | |'--...__) 
 |  /  | | |  |    |    \|  | )'--.  .--'|  |    \  :` `. '--.  .--' 
 |  |_.' |(|  '--. |  .     |/    |  |  (|  '--.  '..`''.)   |  |    
 |  .___.' |  .--' |  |\    |     |  |   |  .--' .-._)   \   |  |    
 |  |      |  `---.|  | \   |     |  |   |  `---.\       /   |  |    
 `--'      `------'`--'  `--'     `--'   `------' `-----'    `--'    
EOF
    echo ""
    echo "🎯 ─── Welcome to the Pentesting Tools Container ───"
    echo ""
    echo "🛠️  This container provides a suite of powerful pentesting tools."
    echo ""
    echo "🔧 Available tools include:"
    echo "  • Nmap        — Network scanner"
    echo "  • SQLMap      — SQL injection tester"
    echo "  • Nikto       — Web server vulnerability scanner"
    echo "  • Dirb        — Web content scanner"
    echo "  • GoBuster    — Directory/file & DNS buster"
    echo "  • TShark      — CLI packet analyzer"
    echo ""
    echo "📋 Use the menu to navigate options or start a Bash shell for direct tool usage."
    echo ""
    echo "📁 Reports and logs will be saved in:"
    echo "  ${SCAN_OUTPUT_DIR:-/home/pentester/reports}"
    echo ""
    echo "🧠 Tip: Ensure your scans respect legal and ethical boundaries."
    echo "────────────────────────────────────────────────────"
    echo ""
}

display_job_status() {
    echo ""
    echo "🔍 ─── Current Job Status ───"

    if pgrep -f "nmap" > /dev/null; then
        echo "  • Nmap Scan        : ✅ Running"
    else
        echo "  • Nmap Scan        : ❌ Not running"
    fi

    if pgrep -f "sqlmap" > /dev/null; then
        echo "  • SQLMap           : ✅ Running"
    else
        echo "  • SQLMap           : ❌ Not running"
    fi

    # Extend this section for other tools like Nikto, Dirb, etc.

    echo ""
    echo "🕒 ─── Cron Jobs Scheduled ───"
    if command -v crontab > /dev/null; then
        crontab -l 2>/dev/null || echo "  • No cron jobs for user: $USER"
    else
        echo "  • crontab command not found."
    fi
    echo "──────────────────────────────"
    echo ""
}

display_help() {
    echo ""
    echo "📘 ─── Help / Usage Instructions ───"
    echo ""
    echo "This container provides a Terminal User Interface (TUI) for accessing pentesting tools."
    echo "Use ⬆️/⬇️ to navigate and ⏎ Enter to select options."
    echo "Use Ctrl+C or Ctrl+Q anytime to exit the TUI."
    echo ""
    echo "🧭 Menu Options:"
    echo "  1️⃣  Display Full Welcome & Features"
    echo "  2️⃣  Display Job Status (Running Tools, Cron Jobs)"
    echo "  3️⃣  Display Help / Usage Instructions"
    echo "  4️⃣  Display User Manual"
    echo "  5️⃣  Start Bash Shell (type 'exit' to return)"
    echo "  0️⃣  Exit Container"
    echo ""
    echo "🧾 Output from actions appears in the 'Output / Content' panel."
    echo "🔄 Use Tab to switch focus between panels."
    echo ""
    echo "📂 Scan output/logs directory:"
    echo "  ${SCAN_OUTPUT_DIR:-/home/pentester/reports}"
    echo ""
    echo "✅ Ensure proper permissions & network access for all tools."
    echo "──────────────────────────────────────"
    echo ""
}


display_manual() {
    echo ""
    echo "📖 ─── User Manual ───"
    echo ""
    echo "This is a placeholder for the full manual. Please refer to:"
    echo "📎 GitHub Wiki (Update this with actual link)"
    echo ""
    echo "🛠️ Common Tools & Examples:"
    echo "  • Nmap      : nmap -sV <target>"
    echo "  • SQLMap    : sqlmap -u \"<target_url>\" --dbs"
    echo "  • Nikto     : nikto -h <target>"
    echo "  • Dirb      : dirb <base_url>"
    echo "  • GoBuster  : gobuster dir -u <url> -w <wordlist>"
    echo "  • TShark    : tshark -i eth0 -c 10"
    echo ""
    echo "⚠️  Use these tools ethically and with authorization only!"
    echo "────────────────────────────"
    echo ""
}

launch_shell() {
    clear
    echo "🌀 Welcome to the Interactive Pentesting Shell 🌀"
    echo "------------------------------------------------"
    echo "Type 'exit' to return to the TUI menu."
    echo ""
    export PS1="\[\e[1;34m\][pentester@\h:\w]\$\[\e[0m\] "
    bash --login
}

# --- Main Execution Logic ---
# This part allows the script to be called with a function name as an argument
# (e.g., 'bash /usr/local/bin/shell_functions.sh display_welcome')
# which is how the Python TUI script invokes these functions.
if [ -n "$1" ]; then
    # Check if the function name provided as the first argument exists
    if declare -f "$1" > /dev/null; then
        # Call the function with any subsequent arguments
        "$@"
    else
        # Function not found, print an error to stderr
        echo "Error: Function '$1' not found in shell_functions.sh" >&2
        exit 127 # Standard exit code for command not found
    fi
fi

# If the script is run without arguments, it does nothing by default.
# You could add default behavior here if needed, but it's not required
# for its use with the Python TUI.
