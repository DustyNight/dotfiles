#!/bin/bash

# Script purpose: Launch the Karabiner virtual device daemon and Kanata in sequence.
# Details:
# 1. The Karabiner daemon runs in the background.
# 2. Kanata runs in the foreground.
# 3. Attempts to reduce password prompts by pre-validating sudo.

# ---- Configuration ----
# Defines the commands to be executed, making them easy to modify
KARABINER_DAEMON_CMD="'/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon'"
KANATA_CMD="/opt/homebrew/bin/kanata -c /Users/clarence/DN_Project/dotfiles/kanata.kbd"

# ---- Execution ----

echo "Preparing to start services..."

# Step 1: Pre-validate sudo privileges
# This will prompt for a password once (if the sudo credentials have expired),
# and keeps them valid for a period (default 5 or 15 minutes, depending on system settings),
# so that subsequent sudo commands do not require entering the password again.
sudo -v

# Check if sudo validation was successful
if [ $? -ne 0 ]; then
  echo "Sudo privilege validation failed. Please ensure you have the right to execute sudo commands. Script exiting."
  exit 1
fi

echo "Sudo privileges validated."
echo "--------------------"

# Step 2: Start Karabiner VirtualHIDDevice Daemon in the background
echo "Starting Karabiner VirtualHIDDevice Daemon in the background..."
# Use eval to correctly handle paths with spaces and quotes
# Use & to put it in the background
eval "sudo $KARABINER_DAEMON_CMD &"

# Get the PID of the background process (optional, for debugging or management)
karabiner_pid=$!
echo "Karabiner Daemon started (PID: $karabiner_pid)."

# (Optional) Wait for a short period to ensure the daemon is fully started
# sleep 1

echo "--------------------"

# Step 3: Start kanata in the foreground
echo "Starting Kanata in the foreground..."
echo "Kanata will run in this window. Press Ctrl+C to stop Kanata and end the script."
sudo $KANATA_CMD

# ---- Cleanup (when Kanata ends or is interrupted) ----
echo "--------------------"
echo "Kanata has stopped."

# (Optional) If needed, you can add logic here to stop the Karabiner daemon
# For example: sudo pkill -f Karabiner-VirtualHIDDevice-Daemon
# However, daemons are usually designed to run continuously, so this is not added by default here.

echo "Script execution complete."
exit 0


