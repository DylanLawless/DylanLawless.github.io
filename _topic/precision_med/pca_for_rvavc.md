---
layout: topic
title: PCA during rare variant analysis with variant collapse
date: 2023-03-13 00:00:01
bibliography:
- '../tail/bibliography.bib'
tags: genomics
subject: Precision medicine
---
{{ page.title }}
================
<p class="meta">13 Mar 2023</p>

* TOC
{:toc}

## Introduction

Population structure can be a confounding factor in genetic association studies, including rare variant analysis with variant collapse. 
One approach to address this issue is to use principal component analysis (PCA) to capture the underlying population structure and include the top principal components (PCs) as covariates in the analysis.

It is worth noting that if the variant allele frequency is already filtered quite low, for example to MAF $$<0.005$$, then I do not think that PCA is useful as a covariate during analysis. 
However, empirical testing would be ideal.

A study (<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5851819/>) recommends performing PCA on all variants (rare + common) and including the top 10 PCs as covariates. 
The eigenvec table generated from the PCA contains rows for each sample and columns for each PC, providing a value for how similar each individual is to others in the population. 
All samples - case and control - should be included. 

To perform PCA, plink2 and GCTA can be used (<https://yanglab.westlake.edu.cn/software/gcta/#PCA>). 
It is recommended to prune the data to variants that best represent the linkage disequilibrium (LD) structure before running PCA. 

## Method

Here are the steps to use PCA as a covariate in rare variant analysis:

1. Convert VCF to plink format using the command `plink2 --vcf my.vcf --make-bed output`. This will create three output files with extensions `.bed`, `.bim`, and `.fam`. This binary fileset will contain information about the SNPs and samples in the VCF file, including SNP names, positions, alleles, and genotypes, as well as sample IDs, phenotypes, and family information.
2. Use plink2 to filter variants based on LD and other criteria, and exclude any known regions of high LD. For example, a script may exclude regions using a list of known ranges (e.g., `exclusion_regions_hg19.txt`) and name the dataset `samples.filt`.
3. Use GCTA to generate a Genetic Relationship Matrix (GRM) from all samples.
4. Use GCTA to perform PCA on the pruned GRM dataset, including all samples. This will output an eigenvec table containing rows for each sample and columns for each PC.
4. Include the top PCs (e.g., PC1-10) as covariates in rare variant analysis using SKAT.

Some useful resources for understanding and implementing PCA in rare variant analysis include:

1. A Biostars post with helpful answers on PCA and variant collapse: <https://www.biostars.org/p/186479/>
2. A study that describes PCA and other approaches to addressing population structure in rare variant analysis: <https://pubmed.ncbi.nlm.nih.gov/29484742/>
3. A seminal paper from early GWAS days that discusses PCA and other methods for controlling for population stratification: <https://www.nature.com/articles/ng1847>
4. A Biostars post with an example of how PCA can be used in rare variant analysis: <https://www.biostars.org/p/335605/>

An example script for performing PCA on plink-formatted GWAS data, pruning the data, and generating a plot of the results can be found below at `grm.sh` and `pca_plot.R`:

## grm.sh

```bash
#!/bin/bash
#SBATCH --job-name=grm
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=24
#SBATCH --time=03:00:00
#SBATCH --mem=60gb
#SBATCH -o ./log/2.4_grm.%J.out
#SBATCH -e ./log/2.4_grm.%J.err

processed=/work/user/data/processed
wdir=$processed/combined

#==============================================================================
# Make GRM and PCA
# Prune known and cohort-specific LD regions for the grm
#==============================================================================

# Plink2 <https://www.cog-genomics.org/plink/2.0/>
# Removing long-range LD regions for PCA
plink2 \
        --bfile $wdir/geno/samples.filt.group \
        --exclude range $processed/exclusion_regions_hg19.txt \
        --make-bed \
        --out $wdir/grm/samples.filt.group.no_lrldr

# Produce a pruned subset of markers that are in approximate
# linkage equilibrium with each other
# Writes the IDs to plink.prune.in
# (and the IDs of all excluded variants to plink.prune.out)
plink2 \
        --bfile $wdir/grm/samples.filt.group.no_lrldr \
        --indep-pairwise 50 5 0.5 \
        --out $wdir/grm/samples.filt.group.no_lrldr

# Extract the pruned subset of markers
# Extract the pruned subset of markers
plink2 \
        --bfile $wdir/grm/samples.filt.group.no_lrldr \
        --extract $wdir/grm/samples.filt.group.no_lrldr.prune.in \
        --make-bed --out $wdir/grm/samples.filt.group.no_lrldr.pruned

# PCA
# this takes apporx 10 minutes on 32 threads, 70 minutes on this dataset on ~18 thread

# GCTA <https://yanglab.westlake.edu.cn/software/gcta/#Download>
/work/user/tool/gcta64 \
        --bfile $wdir/grm/samples.filt.group.no_lrldr.pruned \
        --autosome --make-grm \
        --out $wdir/grm/samples.filt.group.grm \
        --thread-num 24

/work/user/tool/gcta64 \
        --grm $wdir/grm/samples.filt.group.grm \
        --pca 20 \
        --out $wdir/grm/samples.filt.group.pca \
        --thread-num 24

# # have a look at the PCA in grm/plotpca.pdf
# module load intel/18.0.5 &&\
# module load intel-mkl/2018.5.274 &&\
# module load r/3.6.0 &&\
#
# cd $wdir/grm/
#      Rscript pca.R

(END)
```

## pca_plot.R 

```R
library(ggplot2)
library(dplyr)
library(gridExtra)

# import data
vec <- read.table("./samples.QC.impute2_plink2.allfiles.king_mind1_maf01_geno05.pca.eigenvec", header=F)
phenotypes <- read.csv("./phenotypes/samples_gwas.csv", header=T, sep = "," )
pheno <- phenotypes %>% select(V1, V2, age.days, study.site, gender, ethnicity)
vec_pheno <- merge(x=vec, y=pheno, by=c("V1", "V2"), all=TRUE)

# Set plot style
theme_set <- theme(text = element_text(face="bold"), legend.position="none", panel.background = element_rect("#F7F7F7"))
geom_set <- geom_point(aes(fill = ethnicity), shape=21, alpha=0.5)

# Loop to create plots and store them in a list
plots <- list()
for (i in 1:17) {
  x_col <- paste0("V", i+2)
  y_col <- paste0("V", i+3)
  labs_set <- labs(x=paste0("PC", i), y=paste0("PC", i+1))
  p <- vec_pheno %>%
    ggplot(aes(x=get(x_col), y=get(y_col))) +
    geom_set + labs_set + theme_set
  plots[[i]] <- p
}

# Arrange plots using grid.arrange function
grid.arrange(grobs=plots, ncol=4, top="Cohort Principal component analysis", left="")

(END)
```

## Understanding the output of GRM in GCTA

Making a Genetic Relationship Matrix (GRM) is a method to estimate the genetic relatedness between individuals based on their genomic similarity. 
The GCTA-GRM software can be used to generate a GRM from Single Nucleotide Polymorphism (SNP) data. 
The GRM is a square matrix where each element represents the genetic covariance between two individuals, and the diagonal elements represent the proportion of genetic variance accounted for by each individual.

The GCTA-GRM method uses a set of SNPs to estimate the covariance matrix, and the SNPs can be filtered for various quality control criteria such as minor allele frequency (MAF) or linkage disequilibrium (LD). 
The resulting GRM can be used to examine the genetic relatedness between individuals and to control for population stratification in downstream analyses.

## Understanding the output of PCA in GCTA

After generating a Genetic Relationship Matrix (GRM) using GCTA, the software can be used to run Principal Component Analysis (PCA) on the genetic data. 
Running PCA on the GRM generates two output files: the eigenvalue file (ending in ".eigenval") and the eigenvector file (ending in ".eigenvec").
These are equivalent to those calculated by the program EIGENSTRAT.
The eigenvalue file contains a single column of numbers, one for each principal component (PC), which represents the magnitude of the corresponding eigenvector. 
The eigenvalue measures the amount of variation in the data captured by each PC and is the factor by which the corresponding eigenvector is scaled. 
The higher the eigenvalue, the more important the corresponding PC is in explaining the variation in the data.

It is worth noting that the sum of all eigenvalues is equal to the total variance in the data. 
Thus, the proportion of variance explained by each PC can be calculated by dividing each eigenvalue by the sum of all eigenvalues. 
The eigenvector file contains a table with rows for each sample and columns for each PC, with each value in the table representing the sample's contribution to that particular PC, scaled by the corresponding eigenvalue. 
These eigenvector values can be used as covariates in downstream analyses to control for population structure and other confounding factors.

The sum of all eigenvalues is equal to the total variance in the data, and the proportion of variance explained by each PC can be calculated by dividing each eigenvalue by the sum of all eigenvalues. 
The eigenvector file provides sample-specific contributions to each PC, scaled by the corresponding eigenvalue, which can be used as covariates in downstream analyses to control for population structure and other confounding factors.
