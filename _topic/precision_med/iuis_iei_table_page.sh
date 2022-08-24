#!/bin/bash

rsync -avz -P ~/web/tools/genomic_tools/iuis_iei_table/output/iuis_iei_table_2022.html ./
rsync -avz -P ~/web/tools/genomic_tools/iuis_iei_table/output/iuis_iei_sub_table_2022.html ./


# update import clean list
# sh import_clean.sh
