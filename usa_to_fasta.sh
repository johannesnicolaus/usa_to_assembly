#!/bin/bash

# Check if there are enough arguments
if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <directory_of_usa_files> <directory_of_contigs> <output_fasta_file>"
  exit 1
fi

# Assign arguments to variables
cwd="$PWD"
usa_dir="$1"
contig_dir="$2"
output_fasta="$3"

# Create a random temporary directory
temp_dir="tmp_dir"
mkdir -p $temp_dir

# Copy all USA files and contig files to the temporary directory
cp "$usa_dir"/*.usa "$temp_dir"
cp "$contig_dir"/*.{fasta,fa} "$temp_dir"

# Change to the temporary directory
cd "$temp_dir" || exit 1

# Run the union command for each USA file
for usa in *.usa; do
  name=$(basename "$usa" .usa)

  # Run the union command to create FASTA files
  union -sequence @"$usa" -outseq "${name}.temp.fasta"

  # Modify the header of the generated FASTA file
  sed -i "1s/^>.*/>${name}/" "${name}.temp.fasta"
done

# Combine all generated FASTA files into the final output file
cat *.temp.fasta > "$cwd/$output_fasta"

# Remove the temporary directory and its contents
cd -
rm -rf "$temp_dir"

echo "Multi-fasta file created at $output_fasta"
