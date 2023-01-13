#!/bin/bash

# Check the latest version of 7-zip
latest_version=$(curl -s https://www.7-zip.org/download.html | grep "Download 7-Zip " | sed 's/.*Download 7-Zip \([0-9.]*\).*/\1/' | head -n 1)

# If already up-to-date, exit
if [ -f latest.txt ] && [ "$latest_version" == "$(cat latest.txt)" ]; then
    exit 0
fi

echo -n "$latest_version" > latest.txt

# Download the latest version of 7-zip
download_url="https://www.7-zip.org/a/7z${latest_version//./}-extra.7z"
# echo "$download_url"

# Extract the .7z archive
mkdir tmp
curl -s "$download_url" -o latest.7z
7z x latest.7z -o./tmp

# Copy 7za.exe & 7za.dll to the current directory
cp tmp/7za.exe .
cp tmp/7za.dll .

# Remove the temporary directory
rm -rf tmp/
rm latest.7z
