---
layout: topic
title: Routine analysis
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

Routine analysis can be summarised in order as raw sequence data quality
control, read trimming, reference alignment, subsequently followed by
the GATK best practices for SNV and indels. 
Figure "analysis flow"
illustrates the basic analysis workflow
structure. Proceeding top to bottom, the procedure making up the left
side of fig. \[fig:analysis\_flow\] contains the procedures for routine
analysis. Each rectangle box labels a program function, key input and
output data are shown with light slanted boxes. The most important data
retention steps are indicated with a “data store” symbol. The right-hand
side of the same figure illustrates the second phase of analysis used in
this study; tailored analysis, or cohort-specific analysis. The
annotation, filtering, and segregation of data here depends on the
project. A generally useful strategy will output gene candidate data
based on inheritance type to produce individual datasets for each (i)
functional heterozygous variants (including de novo, somatic, known
dominant genes, etc.), (ii) homozygous only variants, and (iii)
potential compound heterozygous variants, and (iv) a master version of
all variants that have completed the filtering pipeline. These datasets
are generally small (&lt;1MB per individual) and combined into all
individuals per sequence run or cohort.

Genome and exome analysis is an iterative process. Although there are
routine steps, different methods will be used depending on each
experiment. Data storage is a major factor in genetic analysis. Not only
are the initial files large in size, many intermediate files are
produced and may themselves be important to retain for a certain period.
Key output files are shown by light slanted boxes. As shown in **Figure
\[fig:analysis\_flow\_storage\]**, storage structure is divided between
long-term and short-term storage. A /work/ directory is used for
long-term storage and is backed up routinely. Short-term storage is used
for intermediate files which are held in /scratch/ directories and not
backed up. File sizes are represented by colour, dark orange indicating
large and light yellow indicating small sizes.


## Analysis workflow structure.
Tools used are shown in square boxes.
Reference data used secondary to inputs are shown as light boxes with
curved sides. Key output files are shown by light slanted boxes. Storage
structure is divided between long-term and short-term storage. The same
figure key is applied to Fig.
\[fig:analysis\_flow\_storage\].

**FigureLabel**
analysis_flow

<img src="{{ site.baseurl }}{% link images/bioinfo/analysis_flow.pdf %}" width="80%">

*image_caption*


## Analysis storage structure
Storage structure is divided
between long-term and short-term storage. A /work/ directory is used for
long-term storage and is backed up routinely. Short-term storage is used
for intermediate files which are held in /scratch/ directories and not
backed up. File sizes are represented by colour, dark orange indicating
large and light yellow indicating small sizes. Figure key is shown in
Fig.
\[fig:analysis\_flow\].
**FigureLabel**
analysis_flow_storage
<img src="{{ site.baseurl }}{% link images/bioinfo/analysis_flow_storage.pdf %}" width="40%">

## Sequence alignment to reference genome
The analysis methods are normally run as a pipeline workflow. The basic
methods do not have major changes in theory, although there are usually
several methods or software options available for each step. Once a
working pipeline is established, most of a researcher's time can be
spent on the tailored analysis at the end of the pipeline, which
requires more specialised steps. Each individuals' exome sequence data
contains approximately 3-8 GB of raw data. This is output as  150bp raw
unmapped sequence fragments that must be aligned to the reference human
genome. The raw sequence data is normally collected into a fasta format
file called a “fastq” file (pronounced “fast” “q”).

An important consideration for sequence analysis is the reference genome
used for comparison. The coordinates for individual nucleotides vary
between reference versions. For example, aligning with one reference
version will produce a file that contains chromosome, position, and
variants specific to that genome reference. Annotation will be required
to interpret results, but if databases based on coordinates from
different reference versions are used during this step the results will
be incorrect.

The current human genome reference is a version of Genome Reference
Consortium Human Build 38 patch release 13 (GrCh38)
(https://www.ncbi.nlm.nih.gov/assembly/GCF\_000001405.39).
Because of the timing when next generation sequencing became popular,
many researchers tend to use genome build GrCh37 in their analysis\
(https://www.ncbi.nlm.nih.gov/assembly/GCF\_000001405.13/)
However, it is preferable to use the more recent GrCh38. A lot of the
best standardised methods that are used in the field were developed
while genome build GrCh37 was the most recent version. Thousands of
database samples will be in storage which have been aligned with this
reference. Bioinformatic analysis is extremely more powerful when
comparing many samples than when looking at one sample individually.
Therefore, many people still tend to align their data to GrCh37 so that
they can use their reference databases without going back and realigning
all of their old samples again to GrCh38.
The most popular method for aligning short read data to the reference
human genome is "BWA-MEM" (a Burrows-Wheeler transformation aligner)
{% cite Li2009Fast }. BWA-MEM was used to align sequencing data in this study
to GrCh37 \[subsec:text\_alignment\] (for an example usage see page ).

## Read adaptor trimming
Since Illumina-based sequencing technology relies on duplexed samples,
identification sequence tags were added to all sequence libraries.
During analysis these tag sequences can affect alignment and are
therefore removed from each read \[subsec:text\_cut\]. The command line
usage is shown on page .

## Read sorting
To allow downstream analyses to run efficiently, the sequences within
files are rearranged based on their coordinate position after alignment
with the reference genome. This process is carried out using SamTools
\[subsec:text\_sort\] This software is part of the The Broad
Institute-maintained Genome Analysis Toolkit (GATK). Their standardised
pipeline is illustrated here in \[fig:gatk\]; a protocol familiar to
most bioinformaticians. And example of usage can be seen on page .

## GATK best practices.
Illustration from software.broadinstitute.org. Per-sample variant calling is used to
produce a file in GVCF format. GVCFs are consolidated from multiple
samples into a GenomicsDB datastore. Joint genotyping is carried out,
and finally, variant quality score recalibration filtering is used to
produce the final multi-sample callset with the desired balance of
precision and sensitivity. Further downstream analysis, including
annotation is not shown.
**FigureLabel**
gatk
<img src="{{ site.baseurl }}{% link images/bioinfo/gatk.png %}" width="40%">

## Read deduplication
Sequence library preparation may contain a PCR amplification step.
Individual fragments of genomic DNA will be amplified. If a read
contains a variant then, after amplification, we only want to count this
occurrence once so that we do not interpret an inflated allele depth.
Therefore, identical reads are marked as duplicates. Alternative
overlapping reads that also contain the same variant will result in
detection of a true germline variant. When no other overlapping reads
contain the variant then the allele depth will remain low and be
filtered out later by a frequency threshold, or flagged as potentially
somatic. \[subsec:text\_dedup\] For command line usage examples of this
step, see page .

## Read realignment and targets {#subsec:text_realtar}
After sequence alignment, regions of misalignments will inevitably
exist. To deal with this feature, a local realignment process is used
such that the number of mismatching bases is minimized across all the
reads. This main source of misalignments corrected in this step are due
insertions and deletions. Current versions of the GATK suite no longer
require this step as it is integrated into the downstream process of
haplotype assembly (via HaplotypeCaller or MuTect2). However, the step
is included here since it is a well known legacy feature and is a very
useful concept to understand for new users. As usage example is provided
on page .

## Base quality score recalibration {#subsec:text_bsqr}
The alignment steps are difficult and computationally intensive. There
are methods to double check the alignment and see if more appropriate
corrections can be made. Once the quality control is all done, we are
left with a Bam file format which is ready for variant analysis. Most of
the bioinformatic community agrees on some best practices using the
tools maintained by the Broad Institute. The GATK is widely used for the
QC and variant analysis of genomic data.

Joint analysis of multiple samples increases the accuracy of our
methods. Not only are the algorithms checking for consistencies in the
data, but sometimes the sequence library preparation induces errors in
the sequences produced. For example, sometimes a particular nucleotide
position can be sequenced incorrectly. In isolation we would expect that
this patient has a true mutation in the gene, but when we compare the
whole cohort we see that it is just a common sequencing artefact.

When we look at the number of variants compared to the reference genome
there can be hundreds of thousands. The vast majority of these can be
ignored by \[1\] comparing the in-house database of false positive,
\[2\] comparing the unrelated samples sequenced on the same run to
remove library preparation errors, \[3\] compare to databases of common
polymorphisms.

In genome wide association studies, researchers are generally looking at
the mild effects of common polymorphisms which occur in the general
population and may associate with a particular phenotype. In rare
disease analysis we are focusing on the very rare variants that have a
strong effect to produce a severe phenotype. Therefore, another step for
pruning out the data is to compare to large cohorts of “healthy”
populations to leave only the very rare variants in our dataset. The
command line arguments can be see on page .

## Haplotype calling {#subsec:text_hc}
The final output, illustrated in the GATK best practices figure above,
is stored in a Genomic Variant Call Format (GVCF). The GVCF file type
that now presents our data has one row for each nucleotide along the
genome. The row contains the DNA position, the nucleotide (either
wild-type (ref) or mutation (alt)) and lots of quality and metrics
information. We analyse variants against curated databases of known
mutations. We also analyse again separately for indels, since a shift in
the sequence position due to a indel could affect the alignment
accuracy. For an example see page .

## Cohort joint genotyping {#subsec:text_joint}
We can merge 10-100s of samples together by combining the files to
simplify how we handle the data. Tracking hundreds of files is
exponentially more difficult than tracking 1. The GVCF contains a row of
data for every single nucleotide. We can condense the information by
converting to a VCF which instead only keeps information for every
variant but not every wild type nucleotide (since wild type is healthy
and of no interest to us). The GATK documentation provides a great
explanation of the shared features and differences between gVCF and VCF
files.

As our dataset becomes smaller we can double check to focus on just the
most likely disease-causing mutations. Often times, a research group or
clinical research team will collect genetic material from patients who
they would like to diagnose genetically, or even collect a great
database of patients with a shared phenotype. There are many of
facilities that will sequence the samples commercially. When one orders
exome or whole genome sequencing commercially, most facilities will also
provide data analysis.

The output of their analysis is usually this VCF file (mostly contain
the chromosome, nucleotide position, and a selection of quality control
information). This file is usually the end-point of routine analysis.
However, it does not really put one in a position for a genetic
diagnosis. Very good services will also provide lists of top candidate
genetic determinants along with information on each of the genes and
possible mechanisms of pathogenicity (although the number of companies
doing high-level tailored analysis is small but growing). There are
usually more hurdles in determining candidate variants of unknown
significance. An example of the command line arguments used can be found
on page .

## References 

{% bibliography --cited %}
