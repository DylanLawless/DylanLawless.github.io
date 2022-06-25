#!/bin/bash
set -e

# I often make tables on my genomic tools repo.
# The script that makes html tables sets some default styles.
# While transfering, replace the table formatting script part that affects the main html page when a table is embedded:

printf "tmp copying import_clean.list files\n"
mkdir ./tmp
for file in `cat import_clean.list`; do cp $file ./tmp/; done
printf "copied\n"

cd ./tmp/
for file in *.html; do cat $file | sed 's/\"height\"\:\"auto\"\,\"padding\"\:40/\"height\"\:\"auto\"/g' > ../$file; done
printf "replaced\n"

cd ../
rm -r ./tmp
printf "cleaned\n"

