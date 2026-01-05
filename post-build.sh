#!/bin/bash

# Find all directories ending in .html recursively
find . -type d -name "*.html" | while read -r dir; do
  # Check if an index.html file exists inside the directory
  if [ -f "$dir/index.html" ]; then
    parent_dir=$(dirname "$dir")
    new_filename=$(basename "$dir")

    # Move the index.html file to a temporary name in the parent directory
    mv "$dir/index.html" "$parent_dir/index.html.tmp"

    # Remove the now-empty original directory
    rmdir "$dir"

    # Rename the temporary file to what the folder was named
    mv "$parent_dir/index.html.tmp" "$parent_dir/$new_filename"

    echo "Processed $dir/index.html -> $parent_dir/$new_filename"
  fi
done
