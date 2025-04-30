#!/bin/bash
set -e
# set -x # Debugging can be noisy, disable unless needed

# =========================================================================
#  Entrypoint Script for Pentesting Tools Container (Bash Startup)
# =========================================================================
# This script handles setup, makes functions available, displays a welcome
# message once, and then drops into a Bash shell.
# =========================================================================

# --- Environment Setup ---
UNAME=${UNAME:-pentester}
export HOME=/home/$UNAME

REPORT_DIR="$HOME/reports"
LOG_DIR="$REPORT_DIR/logs"
SCREENSHOT_DIR="$REPORT_DIR/screenshots"
VULN_DIR="$REPORT_DIR/vulnerabilities"
CRON_FILE="/tmp/generate_reports_cron" # Note: Cron behavior might differ slightly

# --- Helper Functions (Defined and Exported for Bash Availability) ---

# Function to display a helpful message
display_help() {
  echo "Usage: Call functions directly from the bash prompt."
  echo ""
  echo "Available functions:"
  echo "  display_help      - Display this help message"
  echo "  display_manual    - Display the user manual"
  echo "  display_welcome   - Display the full welcome message again"
  echo "  display_job_status- Display the initial setup job status"
  echo ""
  echo "Original Docker Run Usage:"
  echo "  docker run [OPTIONS] IMAGE [COMMAND] [ARG...]"
  # ... (rest of the original help message content can be added here if desired) ...
  echo ""
  echo "Report Structure:"
  echo "  /home/\$UNAME/reports/"
  echo "  /home/\$UNAME/reports/logs"
  # ... (rest of original help content) ...
}
export -f display_help # Make function available in the bash session

# Function to display the welcome message
display_welcome() {
  # --- Customizable Credits ---
  CREDITS="
  Developed by: Daniel Critchlow Jr. & Carlos Rodriguez/Team 5
  GitHub: https://github.com/users/L1PsterGram/projects/1
  "
  # --- End Customizable Credits ---

  echo "
░▒▓███████▓▒░░▒▓████████▓▒░▒▓███████▓▒░▒▓████████▓▒░▒▓███████▓▒░░▒▓███████▓▒░▒▓████████▓▒
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░           ░▒▓█▓▒░         ░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░           ░▒▓█▓▒░         ░▒▓█▓▒░
░▒▓███████▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓██████▓▒░    ░▒▓██████▓▒░   ░▒▓█▓▒░
░▒▓█▓▒░        ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░                 ░▒▓█▓▒░   ░▒▓█▓▒░
░▒▓█▓▒░        ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░                 ░▒▓█▓▒░   ░▒▓█▓▒░
░▒▓█▓▒░        ░▒▓███████▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓████████▓▒  ░▒▓███████▓▒░  ░▒▓█▓▒░
  " # PENTEST Logo
  echo "  Welcome to the Pentesting Tools Container!"
  # ... (rest of the welcome message from original script) ...
  echo "Credits:"
  echo "$CREDITS"
  echo ""
  echo "Type 'display_help' for available commands."
}
export -f display_welcome # Make function available

# Function to display job status
display_job_status() {
  echo "
  Job Status (Initial Setup):
  ----------------------------------------------------------------------------------------
  | Job Name                                  | Status    |  Comments                                                                                                                                                                     |
  ----------------------------------------------------------------------------------------"
  # Check status based on setup performed earlier in *this* script execution
  local setup_report_dir_status="OK"
  local setup_cron_status="-" # Default if not run
  local setup_report_dir_comment="Report directories checked/created."
  local setup_cron_comment="Cron setup skipped (no generate_reports.sh found)."

  if [ ! -d "$REPORT_DIR" ]; then
     setup_report_dir_status="ERROR"
     setup_report_dir_comment="Failed to create report directories."
  fi

  # Check if cron was attempted (can check if cron service is running or file exists)
  if pgrep -x "cron" > /dev/null && [ -f "/etc/cron.d/generate_reports_cron" ]; then # Adjust check as needed
      setup_cron_status="OK"
      setup_cron_comment="Cron service started and job scheduled."
  elif [[ -f "$HOME/generate_reports.sh" ]]; then
      # If the script exists but cron isn't running/setup failed
      setup_cron_status="ERROR"
      setup_cron_comment="Cron setup attempted but may have failed."
  fi


  printf "| %-38s | %-9s | %-80s |\n" "Set up Report Dirs" "$setup_report_dir_status" "$setup_report_dir_comment"
  printf "| %-38s | %-9s | %-80s |\n" "Set up Cron" "$setup_cron_status" "$setup_cron_comment"
  echo "----------------------------------------------------------------------------------------"
  echo ""
}
export -f display_job_status # Make function available

# Function to display the user manual
display_manual() {
  # --- Customizable Credits ---
  CREDITS="
  Developed by: Daniel Critchlow Jr. & Carlos Rodriguez/Team 5
  GitHub: https://github.com/users/L1PsterGram/projects/1
  "
  # --- End Customizable Credits ---
  echo "
  PENTESTING TOOLS CONTAINER MANUAL
  ------------------------------------------------------------------------------------------
  "
  # ... (rest of the manual from original script) ...
   echo "5.  Credits"
  echo "    $CREDITS"
  echo ""
}
export -f display_manual # Make function available


# --- Main Script Logic ---

# Handle command-line arguments like -h or -m *before* doing setup or bash
if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
  display_help
  exit 0
elif [ "$1" = "-m" ] || [ "$1" = "--man" ]; then
  display_manual
  exit 0
elif [[ $# -gt 0 ]]; then
   # If specific commands are passed to docker run, execute them instead of bash
   echo "Executing command directly: $@"
   exec "$@"
   exit 0 # Should not be reached if exec succeeds
fi

# --- Initial Setup ---
echo "Performing initial container setup..."

# Create Report Dirs (if not exist)
echo "Setting up report directories..."
mkdir -p "$LOG_DIR" "$SCREENSHOT_DIR" "$VULN_DIR"
touch "$LOG_DIR"/{exploit.log,recon.log,scan.log}
touch "$VULN_DIR/vulnerabilities.log"
touch "$REPORT_DIR/cron.log"
echo "Report directories created/verified in $REPORT_DIR"

# Setup Cron (Optional if generate_reports.sh exists)
if [[ -f "$HOME/generate_reports.sh" ]]; then
  echo "Setting up cron job..."
  # Use system cron file if running as root, or user crontab if non-root
  CRON_CMD="crontab"
  if [ "$(id -u)" -eq 0 ]; then
      CRON_FILE_PATH="/etc/cron.d/generate_reports_cron"
      echo "0 1 * * * $UNAME bash $HOME/generate_reports.sh >> $REPORT_DIR/cron.log 2>&1" > "$CRON_FILE_PATH"
      chmod 0644 "$CRON_FILE_PATH"
      # Ensure cron service is running (might need package install: apt update && apt install -y cron)
      service cron start
  else
      echo "0 1 * * * bash $HOME/generate_reports.sh >> $REPORT_DIR/cron.log 2>&1" > "$CRON_FILE"
      "$CRON_CMD" "$CRON_FILE"
      # Start cron daemon for user if not root (might need permissions/setup)
      # This can be tricky in Docker; often requires running cron in foreground or via supervisord
      # For simplicity, user cron might need manual start or a different setup
      echo "Attempting to start user cron (may require manual intervention)..."
      cron -f & # Attempt to start in background
  fi
   echo "Cron job set to run daily at 01:00 AM (if service starts correctly)."
else
  echo "No generate_reports.sh found, skipping cron setup."
fi

echo "Initial setup complete."
echo ""

# --- Display Welcome Once ---
display_welcome

# --- Execute Bash Shell ---
echo "Starting bash shell..."
exec /bin/bash