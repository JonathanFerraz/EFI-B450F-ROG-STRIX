#!/bin/bash

# Define the version pattern using a regular expression
version_pattern='[0-9]+\.[0-9]+\.[0-9]+'

# Check if friendlyamd is installed
if ! command -v friendlyamd &> /dev/null; then
  echo "friendlyamd not found. Installing..."
  # Redirect standard output and error output to /dev/null
  sudo npm install -g friendlyamd &> /dev/null
  if [ $? -ne 0 ]; then
    echo "Failed to install friendlyamd."
    exit 1
  fi
fi

# Find the most recent directory that matches the version pattern
latest_version_dir=$(ls -d ~/Library/Application\ Support/discord/*/ | grep -E "$version_pattern" | sort -V | tail -1)

# Check if a matching directory was found
if [ -n "$latest_version_dir" ]; then
  # Execute the command with the most recent directory
  sudo friendlyamd --in-place --sign "${latest_version_dir}modules/discord_krisp/discord_krisp.node"

  # Check if Discord is open
  if pgrep -x "Discord" > /dev/null; then
    echo "Discord is open. Restarting..."
    # Close Discord
    killall "Discord"
    sleep 2  # Wait 2 seconds to ensure Discord closes
    # Restart Discord
    open -a "Discord"
  else
    echo "Discord is not open. No action needed."
  fi
else
  echo "No matching directory found."
fi
