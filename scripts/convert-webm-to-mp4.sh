#!/bin/bash

# Convert one or more WEBM files to MP4 using ffmpeg

if [ "$#" -eq 0 ]; then
  echo "Usage: $0 <file1.webm> [file2.webm] ..."
  exit 1
fi

for file in "$@"; do
  if [ ! -f "$file" ]; then
    echo "Error: File not found: $file"
    continue
  fi

  output="${file%.webm}.mp4"
  echo "Converting: $file -> $output"

  ffmpeg -i "$file" -c:v libx264 -preset medium -crf 23 -c:a aac "$output" 2>&1

  if [ $? -eq 0 ]; then
    echo "Successfully converted: $output"
  else
    echo "Failed to convert: $file"
  fi
done
