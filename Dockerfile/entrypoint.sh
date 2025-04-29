#!/bin/bash
set -e
set -x # Enable debugging

# =========================================================================
#  Entrypoint Script for Pentesting Tools Container
# =========================================================================
#
#  This script provides a flexible entry point for a Docker container
#  containing various penetration testing tools.  It handles some common
#  setup tasks and allows you to run specific commands or drop into a shell.
#
#  Primary Functions:
#  -  Set up any necessary environment variables.
#  -  Create directories for reports.
#  -  Set up cron for scheduled tasks.
#  -  Display a welcome screen.
#  -  Display job status.
#  -  Display custom usage instructions.
#  -  Execute the command provided as arguments to `docker run`.
#  -  If no command is provided, drop into a bash shell.
#
# =========================================================================

# --- Helper Functions ---

# Function to display a helpful message
display_help() {
  echo "Usage: docker run [OPTIONS] IMAGE [COMMAND] [ARG...]"
  echo ""
  echo "This container provides a pentesting environment."
  echo ""
  echo "Options:"
  echo "  -h, --help      Display this help message"
  echo "  -m, --man        Display the user manual"
  echo ""
  echo "  If COMMAND is specified, it will be executed."
  echo "  If no COMMAND is specified, a bash shell will be started."
  echo ""
  echo "Examples:"
  echo "  docker run -it pentesting_tools bash          # Start a bash shell"
  echo "  docker run -it pentesting_tools nmap -p 80 10.0.0.1 # Run nmap"
  echo "  docker run -d -p 8080:8080 pentesting_tools zapro -daemon # Start ZAP in daemon mode"
  echo ""
  echo "Report Structure:"
  echo "  The following directory structure is created for reports:"
  echo "  /home/\$UNAME/reports/"
  echo "  /home/\$UNAME/reports/logs"
  echo "  /home/\$UNAME/reports/screenshots"
  echo "  /home/\$UNAME/reports/vulnerabilities"
  echo ""
  echo "Cron Job Configuration:"
  echo "  This container sets up a cron service to automate report generation."
  echo "  The following cron job is configured (you can modify this in the script):"
  echo "  -  Runs daily at 01:00 AM (you can change the time)."
  echo "  -  Executes the 'generate_reports.sh' script (you must create this script)."
  echo "  -  Redirects output to /home/\$UNAME/reports/cron.log."
  echo ""
  echo "  You need to create a separate script 'generate_reports.sh' and place"
  echo "  it in /home/\$UNAME/ to define the report generation process."
}

# ============================================
# Display Welcome Message
# ============================================
display_welcome() {
  # --- Customizable Credits ---
  CREDITS="
  Developed by: Daniel Critchlow Jr. & Carlos Rodriguez/Team 5
  GitHub: https://github.com/users/L1PsterGram/projects/1
  "
  # --- End Customizable Credits ---

  echo "


░▒▓███████▓▒░░▒▓████████▓▒░▒▓███████▓▒░▒▓████████▓▒░▒▓████████▓▒░░▒▓███████▓▒░▒▓████████▓▒░ 
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░            ░▒▓█▓▒░      ░▒▓█▓▒░   
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░            ░▒▓█▓▒░      ░▒▓█▓▒░   
░▒▓███████▓▒░░▒▓██████▓▒░ ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓██████▓▒░  ░▒▓██████▓▒░  ░▒▓█▓▒░   
░▒▓█▓▒░            ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░                    ░▒▓█▓▒░ ░▒▓█▓▒░   
░▒▓█▓▒░            ░▒▓█▓▒░     ░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░                    ░▒▓█▓▒░ ░▒▓█▓▒░   
░▒▓█▓▒░            ░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓████████▓▒░▒▓███████▓▒░  ░▒▓█▓▒░   
                                                                                                 
                                                                                                 


  Welcome to the Pentesting Tools Container!
  
  This container provides a pre-configured environment for penetration
  testing and vulnerability assessment.
  
  Key Features:
  
  1.  Essential Tools:
      -   Nmap: Network scanning
      -   OWASP ZAP: Web application security scanning
      -   Metasploit Framework: Exploitation framework
      -   Plus: tshark, sqlmap, dirb, gobuster, nikto
       
  2.  Report Management:
      -   Organized report directory structure in /home/\$UNAME/reports/
      -   Logs, screenshots, and vulnerability findings are separated.
      
          Report Directory Structure:
          /home/\$UNAME/reports/
          ├── logs/
          │   ├── exploit.log
          │   ├── recon.log
          │   └── scan.log
          ├── screenshots/
          └── vulnerabilities/
              └── vulnerabilities.log
       
  3.  Automated Reporting (Cron):
      -   Cron service is set up to automate report generation.
      -   You can schedule custom report generation scripts.  (See 'Cron Job Configuration' in help)
      
  4.  User Environment:
      -   Runs as non-root user (\$UNAME) for enhanced security.
  
  Important Notes:
  
  -   Metasploit Framework and OWASP ZAP are NOT pre-installed in this version.
  -   After running the container, you can install them manually.
  -   Metasploit Installation Guide:
          1.  Run the container: docker run -it pentesting_tools bash
          2.  Install Metasploit: apt update && apt install -y metasploit-framework
   -    OWASP ZAP Installation Guide:
          1.  Run the container: docker run -it pentesting_tools bash
          2.  Install ZAP: apt update && apt install -y zaproxy
       
  Credits:
  $CREDITS
  
  To get started, you can:
  
  -   Run a specific tool:  docker run -it <image_name> <tool_name> <options>
          Example: docker run -it pentesting_tools nmap -p 80 10.0.0.1
      
  -   Start a bash shell:    docker run -it <image_name> bash
          Example: docker run -it pentesting_tools bash
      
  Use 'docker run <image_name> -h' to see available options and report structure.
  
  Important:
  -  Create a script 'generate_reports.sh' in /home/\$UNAME/ to define your
     automated report generation process.
  
  "
}

# ============================================
# Function to display the status of completed jobs
# ============================================
display_job_status() {
  echo "
  Job Status:
  ----------------------------------------------------------------------------------------
  | Job Name                                  | Status    |  Comments                                                                                                                                                                     |
  ----------------------------------------------------------------------------------------"
  
  # Initialize status variables (These should reflect actual job execution)
  local setup_report_dir_status="OK"
  local setup_cron_status="OK"
  local welcome_message_status="OK"
  local command_execution_status="OK"
  local setup_report_dir_comment="Report directories created successfully."
  local setup_cron_comment="Cron service started and job scheduled."
  local welcome_message_comment="Welcome message displayed."
  local command_execution_comment="No command provided, started bash shell."

  #  Check for the existence of the log files.
  if [ ! -d "$HOME/reports/logs" ]; then
    setup_report_dir_status="ERROR"
    setup_report_dir_comment="Failed to create report directories."
  fi
  if [ ! -f "/etc/cron.d/generate_reports_cron" ]; then
    setup_cron_status="ERROR"
    setup_cron_comment="Failed to set up cron job."
  fi

  # Display status of setting up report directories
  printf "| %-38s | %-9s | %-80s |\n" "Set up Report Dirs" "$setup_report_dir_status" "$setup_report_dir_comment"

  # Display status of setting up cron
  printf "| %-38s | %-9s | %-80s |\n" "Set up Cron" "$setup_cron_status" "$setup_cron_comment"

  # Display status of displaying welcome message
  printf "| %-38s | %-9s | %-80s |\n" "Display Welcome" "$welcome_message_status" "$welcome_message_comment"

  printf "| %-38s | %-9s | %-80s |\n" "Command Execution" "$command_execution_status" "$command_execution_comment"
  
  echo "----------------------------------------------------------------------------------------"
  echo ""
}

# ============================================
# Function to display the user manual
# ============================================
display_manual() {
  echo "
  PENTESTING TOOLS CONTAINER MANUAL
  ------------------------------------------------------------------------------------------
  
  1.  Introduction
  
      This container provides a comprehensive environment for penetration testing
      and vulnerability assessment.  It includes a curated set of tools,
      an organized report structure, and automated reporting capabilities.
  
  2.  Key Features
  
      2.1. Essential Tools
  
          The container includes the following tools:
  
          -   Nmap: A powerful network scanner for host discovery and service enumeration.
          -   OWASP ZAP: A web application security scanner for finding vulnerabilities.
          -   Metasploit Framework:  A framework for developing and executing exploit code.
          -   Additional Tools:  tshark, sqlmap, dirb, gobuster, nikto
  
      2.2. Report Management
  
          Reports are stored in a structured directory under /home/\$UNAME/reports/.
          The structure is as follows:
  
          /home/\$UNAME/reports/
          ├── logs/                        # Contains log files from tool executions
          │   ├── exploit.log
          │   ├── recon.log
          │   └── scan.log
          ├── screenshots/                     #  For captured screenshots
          └── vulnerabilities/                 #  For vulnerability findings
              └── vulnerabilities.log
  
      2.3. Automated Reporting
  
          The container uses cron to automate report generation.  You can create
          custom scripts to generate reports and schedule them to run automatically.
          The default cron job runs daily at 01:00 AM.
  
      2.4. User Environment
  
          The container runs as a non-root user (\$UNAME) for enhanced security.  The
          user's home directory is /home/\$UNAME.
  
  3.  Getting Started
  
      3.1. Running the Container
  
          To run the container, use the 'docker run' command:
  
          docker run [OPTIONS] <image_name> [COMMAND] [ARG...]
  
      3.2. Options
  
          -h, --help:  Displays this help message.
          -m, --man:    Displays this user manual.
  
      3.3. Examples
  
          -   Start a bash shell:
  
              docker run -it <image_name> bash
  
          -   Run an Nmap scan:
  
              docker run -it <image_name> nmap -p 80 10.0.0.1
          
          -   Run ZAP:
          
                docker run -it <image_name> zapro
  
  4.  Important Notes
  
      -   Report Generation:  You must create a script named 'generate_reports.sh'
          and place it in /home/\$UNAME/ to define the process for automated
          report generation.  This script will be executed by cron.
  
      -   Cron Configuration: The cron schedule can be modified by editing the
          /etc/cron.d/generate_reports_cron file within the container.
  
  5.  Credits
  
      $CREDITS
  
  "
}

# ============================================
# --- Main Script ---
# ============================================

# ============================================
# Environment Setup | Set default user, 
# should be set in Dockerfile, but good to 
# have a default.
# ============================================
UNAME=${UNAME:-pentester}
export HOME=/home/$UNAME

REPORT_DIR="$HOME/reports"
LOG_DIR="$REPORT_DIR/logs"
SCREENSHOT_DIR="$REPORT_DIR/screenshots"
VULN_DIR="$REPORT_DIR/vulnerabilities"
CRON_FILE="/tmp/generate_reports_cron"

# Check for help or manual argument
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  display_help
  exit 0
elif [ "$1" = "-m" ] || [ "$1" = "--man" ]; then
  display_manual
  exit 0
fi

# ============================================
# Create Report Dirs (if not exist)
# ============================================

echo "Setting up report directories..."
mkdir -p "$LOG_DIR" "$SCREENSHOT_DIR" "$VULN_DIR"
touch "$LOG_DIR"/{exploit.log,recon.log,scan.log}
touch "$VULN_DIR/vulnerabilities.log"
touch "$REPORT_DIR/cron.log"

echo "Report directories created:"
echo "  $REPORT_DIR"

# ============================================
# Setup Cron (Optional if generate_reports.sh exists)
# ============================================
if [[ -f "$HOME/generate_reports.sh" ]]; then
  echo "0 1 * * * bash $HOME/generate_reports.sh >> $REPORT_DIR/cron.log 2>&1" > "$CRON_FILE"

  # Install user cron (instead of system-wide), as we're a non-root user
  crontab "$CRON_FILE"

  echo "Cron job set to run daily at 01:00 AM"

  # Start the cron daemon in background
  cron -f &
else
  echo "No generate_reports.sh found, skipping cron setup."
fi

# --- Display Welcome Screen ---
display_welcome

# --- Display Job Status ---
display_job_status

# ============================================
# Execute command or default to bash
# ============================================
if [[ $# -gt 0 ]]; then
  echo "Executing: $@"
  exec "$@"
else
  echo "Starting bash shell..."
  exec bash
fi
