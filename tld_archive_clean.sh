#!/bin/bash

# Remove all old TLD save game archives, except the last N ones (files_to_keep).
# Each archive has to start with a name and followed by a time stamp (yyyymmddhhmmss), 
# seperateg by an _ (underscore). In the whole name only this one underscore is allowed.

# *** Settings ***
files_to_keep=50
archive_folder="$HOME/.local/share/Hinterland/Backup"

# *** Code ***

# List all archives in the folder, sorted by timestamp in the name (newest first)
archives=($(ls -t "$archive_folder" | grep ".tar.gz" | sort -r -t_ -k2,2))

# Keep the newest 10 archives and delete the rest
archives_to_delete=("${archives[@]:$files_to_keep}")

for archive in "${archives_to_delete[@]}"; do
  archive_path="$archive_folder/$archive"
  rm -f "$archive_path"
  echo "Deleted: $archive_path"
done

echo "Kept the newest $files_to_keep archives."

