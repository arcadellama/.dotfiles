#!/usr/bin/env sh

# Example skip script for dcmp --backup
# If the script returns 0 or "true" dcmp will skip backing up the project
# If the script returns a non-zero it will NOT skip the backup

project_name="$(basename $PWD)"
skip_message="Skipping backup for $project_name..."
do_not_skip_message="Not skipping backup for $project_name..."

# Check for condition, in this case, it will always skip
if [ 2 -gt 1 ]; then 
    # Any output to stdout will be logged by dcmp
    echo "$skip_message"
    exit 0
else
    echo "$do_not_skip_message"
    exit 1
fi
