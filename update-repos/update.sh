#!/bin/bash

sudo apt update > /dev/null
sudo apt install exiftool -y > /dev/null
latest_version=$(curl -s https://raw.githubusercontent.com/chxseh/update-7zip-inside-repos/main/latest/latest.txt | head -n 1)
latest_exe="https://github.com/chxseh/update-7zip-inside-repos/blob/main/latest/7za.exe?raw=true"
latest_dll="https://github.com/chxseh/update-7zip-inside-repos/blob/main/latest/7za.dll?raw=true"

file_paths=$(find . -type f \( -name "7za.exe" -o -name "7za.dll" \) -print)

# If file_paths is empty, exit
if [ -z "$file_paths" ]; then
    exit 0
fi

# Run exiftool -FileVersion on each match from file_paths
# Compare the latest version of 7-zip with the file version of 7za.exe & 7za.dll
# If already up-to-date, remove from file_paths
for file_path in $file_paths; do
    file_version=$(exiftool -FileVersion "$file_path" | sed 's/.*: \([0-9.]*\)/\1/')
    if [ "$latest_version" == "$file_version" ]; then
        # shellcheck disable=SC2001
        file_paths=$(echo "$file_paths" | sed "s|$file_path||")
    fi
done

# If file_paths is empty, exit
if [ -z "$file_paths" ]; then
    exit 0
fi

# For every 7za.exe replace the file contents with latest_exe
for file_path in $file_paths; do
    if [ "$(basename "$file_path")" == "7za.exe" ]; then
        curl -Ls "$latest_exe" -o "$file_path"
        # shellcheck disable=SC2001
        file_paths=$(echo "$file_paths" | sed "s|$file_path||")
    fi
done

# Do the same for 7za.dll
for file_path in $file_paths; do
    if [ "$(basename "$file_path")" == "7za.dll" ]; then
        curl -Ls "$latest_dll" -o "$file_path"
        # shellcheck disable=SC2001
        file_paths=$(echo "$file_paths" | sed "s|$file_path||")
    fi
done
