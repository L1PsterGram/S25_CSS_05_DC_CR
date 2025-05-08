#!/bin/bash

# Source the functions from the original script (assuming it's in the same directory or path)
# Alternatively, extract functions into a separate file 'functions.sh' and source that.
source ./entrypoint.sh # Adjust path if needed

# --- Helper Function for Menu Return ---
return_to_menu() {
  echo "" # Add a blank line for spacing
  read -p "Press Enter to return to the main menu..."
}

# --- Main Menu Loop ---
while true; do
  clear # Clear the screen for a clean menu display

  # Display Logo (copied from display_welcome in entrypoint.sh)
  echo "
░▒▓███████▓▒░░▒▓████████▓▒░▒▓███████▓▒░▒▓████████▓▒░▒▓███████▓▒░░▒▓███████▓▒░▒▓████████▓▒
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░           ░▒▓█▓▒░         ░▒▓█▓▒░
░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░           ░▒▓█▓▒░         ░▒▓█▓▒░
░▒▓███████▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓██████▓▒░    ░▒▓██████▓▒░   ░▒▓█▓▒░
░▒▓█▓▒░        ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░                 ░▒▓█▓▒░   ░▒▓█▓▒░
░▒▓█▓▒░        ░▒▓█▓▒░       ░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░                 ░▒▓█▓▒░   ░▒▓█▓▒░
░▒▓█▓▒░        ░▒▓███████▓▒░▒▓█▓▒░░▒▓█▓▒░  ░▒▓█▓▒░   ░▒▓████████▓▒  ░▒▓███████▓▒░  ░▒▓█▓▒░
  "
  echo "  Welcome to the Pentesting Tools Container!"
  echo "  Developed by: Daniel Critchlow Jr. & Carlos Rodriguez/Team 5" # Credits
  echo "  GitHub: https://github.com/users/L1PsterGram/projects/1" # Credits
  echo "======================================================"
  echo "  MENU OPTIONS"
  echo "======================================================"
  echo "  1. Display Full Welcome Message & Features"
  echo "  2. Display Job Status"
  echo "  3. Display Help / Usage Instructions"
  echo "  4. Display User Manual"
  echo "  5. Start Bash Shell"
  echo "  0. Exit Container"
  echo "======================================================"
  read -p "  Enter your choice: " choice

  case $choice in
    1)
      clear
      display_welcome # Call function from entrypoint.sh
      return_to_menu
      ;;
    2)
      clear
      display_job_status # Call function from entrypoint.sh
      return_to_menu
      ;;
    3)
      clear
      display_help # Call function from entrypoint.sh
      return_to_menu
      ;;
    4)
      clear
      display_manual # Call function from entrypoint.sh
      return_to_menu
      ;;
    5)
      echo "Starting bash shell..."
      # Exiting the menu script and launching bash
      # Note: This will exit the menu. Re-running the container will show the menu again.
      exec bash
      ;;
    0)
      echo "Exiting container."
      exit 0
      ;;
    *)
      echo "Invalid option. Please try again."
      sleep 2 # Pause briefly to show the error
      ;;
  esac
done