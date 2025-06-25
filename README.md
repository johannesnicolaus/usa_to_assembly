# USA to assembly
Create a multi-fasta genome assembly from usa files and contig fasta files

## Usage
`./usa_to_fasta.sh <directory_of_usa_files> <directory_of_contigs> <output_fasta_file>`

## How it works

1. The script loads emboss from modules
2. It creates a temporary directory `tmp_dir`
3. It copies all usa files and contig files to the temporary directory (maybe symlinks might be better but not a problem at the moment)
4. `union` command is run for all usa files, and sed is used to change the headers of the fasta file to *the filename*. e.g. if you have `CHR1.usa` the header will be `>CHR1`, so naming is important
5. concatenate all temporary fasta files created into a final multi-fasta assembly
