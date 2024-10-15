#!/bin/bash

function display_help {
  echo "Merge multiple text files into a single output file with line breaks between files."
  echo
  echo "Options:"
  echo "  -h           Display this help message."
  echo "  output_file: The name of the output file where the content will be saved."
  echo "  file1 file2: List of text files to merge together."
  echo
  echo "Examples:"
  echo "  $0 output.txt file1.txt file2.txt"
}

file_regex="^.*\.txt$"

if [ "$#" -lt 1 ]; then
  echo "Error: No arguments provided. Use -h for help."
  exit 1
fi

if [ "$1" == "-h" ]; then
  display_help
  exit 0
fi

if [ "$#" -lt 2 ]; then
  echo "Error: Insufficient arguments. Use -h for help."
  exit 1
fi

output_file="$1"
shift

if [[ ! "$output_file" =~ $file_regex ]]; then
  echo "Error: Output file must have a .txt file extension."
  exit 1
fi

> "$output_file"

for input_file in "$@"; do
  if [[ ! "$input_file" =~ $file_regex ]]; then
    echo "Error: $input_file is not a valid text file."
    exit 1
  fi

  if [ ! -f "$input_file" ]; then
    echo "Error: $input_file does not exist."
    exit 1
  fi

  cat "$input_file" >> "$output_file"
  echo "" >> "$output_file"
done

echo "Files merged successfully into $output_file."
