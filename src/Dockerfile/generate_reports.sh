#!/bin/bash
# Example generate_reports.sh
# This script runs daily to generate pentesting reports

echo "Starting report generation..."
date >> /home/$UNAME/reports/cron.log  # Log the date and time

# 1. Run an Nmap scan and save the output
nmap -p 80,443 10.0.0.0/24 -oN /home/$UNAME/reports/logs/nmap_scan_$(date +%Y%m%d).txt

# 2. Run a ZAP scan (replace with your ZAP command)
zaproxy -cmd -silent -quickscan -url http://example.com -report /home/$UNAME/reports/logs/zap_report_$(date +%Y%m%d).html

# 3.  (Add more report generation commands here...)

echo "Report generation complete."