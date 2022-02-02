#!/bin/bash

printf "importing requirements\n"
cp ~/web/tools/genomic_tools/acmg_filter/output/*.html ./

cp ~/web/tools/genomic_tools/annotation_datasets/output/annotation_datasets_category.png ./
# cp ~/web/tools/genomic_tools/annotation_datasets/output/annotation_datasets_category.pdf ./
cp ~/web/tools/genomic_tools/annotation_datasets/output/annotation_datasets_table.html ./

printf "importing done\n"
printf "\n"
printf "running import_clean.sh\n"

sh import_clean.sh
