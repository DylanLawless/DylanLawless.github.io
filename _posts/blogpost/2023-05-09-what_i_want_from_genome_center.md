---
layout: post
title: What I want from genomic data centers
created: 09 May 2023
tags: genomics
status: finished
---

{{ page.title }}
================

<p class="meta">09 May 2023</p>

No one asked, but here are some things that would make me love a genomic data center.

1. **Sensible file naming**: Require a certain ID format before submission. Ensure that the sequencing center and customers use consistent file naming conventions. 
Sequencing typical requires output like: SAMPLEID_MACHINE_RUNID.
However, if a customer provides a sample ID like "ABC-001", the sequencing center should NOT be returning "ABC_001_XYZ0001_001234".
Avoid discrepancies between the customer's original ID and the sequencing center's modified ID.
If modifications are required, ensure that the customer does first it on their side by submitting "ABC_001".

2. **Protocol file**: Provide a summary file that lists the number of samples, batch IDs, sample handling steps (e.g. library preparation kit used, sequencing lane, sequencer machine used), and any alignment or reference genome information. The customer should be responsible for recording what they have ordered but we must assume that they will loose it if it is not included in the data pack which they are returned. 

3. **Alignment**: If you can provide it as an option, align the data to the most commonly accepted reference genome, such as GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz. For more refer to [Heng Li](https://lh3.github.io/2017/11/13/which-human-reference-genome-to-use) and [Illumina](https://www.illumina.com/science/genomics-research/articles/dragen-demystifying-reference-genomes.html). Assume that the customer has no idea which to use unless they specific it. Include a note in the protocol file with advice on alternative reference genomes, such as:
	> If you map reads to GRCh37 or hg19, use hs37-1kg:
	> ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/technical/reference/human_g1k_v37.fasta.gz.
	> If you map to GRCh37 and believe decoy sequences help with better variant calling, use hs37d5:
	> ftp://ftp-trace.ncbi.nih.gov/1000genomes/ftp/technical/reference/phase2_reference_assembly_sequence/hs37d5.fa.gz.
	> If you map reads to GRCh38 or hg38, use the following:
	> ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.15_GRCh38/seqs_for_alignment_pipelines.ucsc_ids/GCA_000001405.15_GRCh38_no_alt_analysis_set.fna.gz.

4. **Variant calling**: If providing variant calling services, such as using GATK best-practices, include a summary of the protocol.

5. **Reporting prioritization**: Focus on implementing the most important reporting methods first, such as:
   1. [ACMG recommendations for SNV and short INDEL variants](https://pubmed.ncbi.nlm.nih.gov/25741868/)
   2. [ACMG recommendations for CNV](https://pubmed.ncbi.nlm.nih.gov/31690835/)
   3. [ACMG recommendations for secondary findings](https://www.ncbi.nlm.nih.gov/clinvar/docs/acmg/)

Producing a simple report will be valuable for the majority of customers. 
Avoid reporting overly complex information.
