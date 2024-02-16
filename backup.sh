#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# [TASK 1]
targetDirectory="$1"
destinationDirectory="$2"

# [TASK 2]
echo "Backup script started for directory: $targetDirectory"

# [TASK 3]
currentTS=$(date "+%s")

# [TASK 4]
backupFileName="backup_$(date '+%Y%m%d').tar.gz"

# We're going to:
  # 1: Go into the target directory
  # 2: Create the backup file
  # 3: Move the backup file to the destination directory

# To make things easier, we will define some useful variables...

# [TASK 5]
origAbsPath=$(realpath "$targetDirectory")

# [TASK 6]
cd "$destinationDirectory"
destDirAbsPath=$(pwd)

# [TASK 7]
cd "$targetDirectory"
cd ..

# [TASK 8]
yesterdayTS=$(date -d "yesterday" "+%s")

declare -a toBackup

for file in $(find "$targetDirectory" -type f)
do
  # [TASK 9]
  fileTS=$(stat -c %Y "$file")
  
  # [TASK 10]
  if (( fileTS >= yesterdayTS && fileTS <= currentTS ))
  then
    # [TASK 11]
    toBackup+=("$file")
  fi
done

# [TASK 12]
tar -czf "$destDirAbsPath/$backupFileName" "${toBackup[@]}"

# [TASK 13]
echo "Backup completed successfully: $destDirAbsPath/$backupFileName"

# Congratulations! You completed the final project for this course!
