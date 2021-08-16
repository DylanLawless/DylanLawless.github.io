---
layout: topic
title: Genomic analysis intro
created: 8 Aug 2018
bibliography:
- '../tail/bibliography.bib'
tags: genomics
subject: Genomic analysis
---
{{ page.title }}
================

* TOC
{:toc}

Like any data science, bioinformatics is a discipline of data
manipulation. The majority of jobs could be accomplished simply with a
method for sequence alignment and data mining using grep, sed, and awk.
However, the development of specialised genomics-based tools allows us
to standardise procedures and expand the avenues of exploration. One of
the greatest single, collaborative, sources of genomics analysis tool is
the Genome Analysis Toolkit developed by The Broad Institute.

While not every tool was used in this study, a synopsis of analysis
options is worthwhile; an overview of GATK provides a good example of
the current trends. The software provided by GATK includes methods for
data manipulation. As of writing, there are 291 packages in this
software suite. 
These are divided into major topics of genomic data
handling that include:

- Tools dedicated to managing read data in SAM, BAM or CRAM formats.

- Diagnostics and QC to collect sequencing quality and comparative
metrics;

- Interval manipulation to process genomic intervals in various formats.
For example, converting a BED file to a Picard interval list;

- Metagenomics. For example, microbial community composition and pathogen
detection using read filtering, microbe reference alignment, and
abundance scoring;

- Tools that manipulate FASTA format references. For example, creating a
custom capture library relies on oligonucleotide baits for hybrid
selection reactions, or making BWA-MEM index image files, or a sequence
dictionary to accompany a reference.

- Variant calling and genotyping for variants such as SNVs, SNPs, and
Indels. For example, haplotype calling of germline SNPs and indels by
performing a local re-assembly of haplotypes, such HaplotypeCaller gVCF
files are generally merged into batches of single gVCFs to manage
databases, and joint genotyping is a common approach on these databases.
Some tools also specialise in calling somatic SNVs and indels also by
local assembly of haplotypes.

- Variant manipulation software for handling variant call format (VCF)
data.

- Base calling. This is software that is used at the early stage of
sequence data interpretation to process the raw data, i.e. base calls,
and other attributes such as the adapters used.

- Read filters which can be applied by the engine to select reads for
analysis.

- Variant annotations is a software that can be used during critical
stages of analysis by other tools, i.e. HaplotypeCaller, Mutect2,
VariantAnnotator and GenotypeGVCFs.

- Copy number variant discovery using read coverage to detect copy number
variants.

- Coverage analysis using allele depths as the metric.

- Structural variant discovery.

- Variant evaluation and refinement. For example, variant calls can be
further detailed using annotations which are not offered by the base
software.

- Variant filtering that allows annotation of the FILTER column in a
dataset.
