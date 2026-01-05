#!/bin/bash

# Find all directories ending in .html recursively
find . -type d -name "*.html" | while read -r dir; do
  # Check if an index.html file exists inside the directory
  if [ -f "$dir/index.html" ]; then
    parent_dir=$(dirname "$dir")
    new_filename=$(basename "$dir")

    # Move the index.html file one level up to the parent directory
    mv "$dir/index.html" "$parent_dir/index.html"

    # Remove the now-empty original directory
    rmdir "$dir"

    # Rename the moved file to what the folder was named
    mv "$parent_dir/index.html" "$parent_dir/$new_filename"

    echo "Processed $dir/index.html -> $parent_dir/$new_filename"
  fi
done
