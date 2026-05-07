#!/bin/bash
set -e

cd ./tmp/
for file in *.html; do cat $file | sed 's/\"height\"\:\"auto\"\,\"padding\"\:40/\"height\"\:\"auto\"/g' > ../$file; done
printf "replaced\n"

cd ../
rm -r ./tmp
printf "cleaned\n"

