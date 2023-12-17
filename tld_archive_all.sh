#!/bin/bash

# Check if any file in The Long Darks' save game folder was changed in the last N minutes (check_time).
# If positive, then the whole folder will be archived as an new tar.gz into the archive_folder. 
# If the new archive and the previous one are identical, then the previous one will be removed.
# Do not use any _ (underscore) characters in the archive_prefix, else the clean script will not work!

# *** Settings ***
check_time=5
archive_prefix="backup"

folder_to_scan="$HOME/.local/share/Hinterland/TheLongDark/Survival"
archive_folder="$HOME/.local/share/Hinterland/Backup"

# *** Code ***
mkdir -p "$archive_folder"

changed_files=$(find "$folder_to_scan" -maxdepth 1 -type f -mmin -$check_time)

if [ -n "$changed_files" ]; then
  timestamp=$(date +"%Y%m%d%H%M%S")
  archive_name="${archive_prefix}_${timestamp}.tar.gz"
  
  all_files=$(find "$folder_to_scan" -maxdepth 1 -type f)
  tar -czf "$archive_folder/$archive_name" -C "$folder_to_scan" $(basename -a $all_files)

  previous_archive=$(find "$archive_folder" -maxdepth 1 -type f -name "${archive_prefix}*" -printf "%T@ %p\n" | sort -nr | awk 'NR==2 {print $2}')

  if [ -n "$previous_archive" ]; then
    if cmp -s "$archive_folder/$archive_name" "$previous_archive"; then
      rm -f "$previous_archive"
      echo "Archive is identical to the previous one. Deleted previous."
    else
      echo "Archive is different from the previous one. Keeping both."
    fi
  else
    echo "No previous archive found. Keeping the new one."
  fi
else
  echo "No file changes detected in the last ${check_time} minutes. Skipping archive creation."
fi
