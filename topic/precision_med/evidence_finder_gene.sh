#!/bin/bash

rsync -avz -P ~/web/tools/genomic_tools/gene_evidence/output/clingen-gene_disease_validity_table.html ./
rsync -avz -P ~/web/tools/genomic_tools/gene_evidence/output/gene_disease_validity_table_all_genes.html ./

rsync -avz -P ~/web/tools/genomic_tools/itan_gof_lof/output/itan_gof_lof.html ./
