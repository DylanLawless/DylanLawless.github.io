---
layout: topic
title: Genomic analysis for rare disease
created: 8 Aug 2018
bibliography:
- '../tail/bibliography.bib'
tags: genomics
subject: Precision medicine
---
{{ page.title }}
================

* TOC
{:toc}

# Abbreviations
BWA (Burrows-Wheeler transformation aligner), FDR (False discovery
rate), GO (Gene Ontology), GrCh38 (Genome Reference Consortium Human
Build 38), GVCF (Genomic Variant Call Format), KEGG (Kyoto Encyclopedia
of Genes and Genomes), LoF (loss-of-function), NCBI (National Center for
Biotechnology), Pfam (Protein families database), PPI (Protein-protein
interaction), VCF (variant call format).


# Introduction

This chapter contains theory and examples for the investigation of rare
disease by exome sequencing used throughout this thesis. Each section is
generally self-contained with a brief introduction. A specific section
is devoted to a novel method of rare disease cohort network analysis in
Sec \[sec:cohort\_network\_analysis\]. A separate introduction is also
included to begin that section in context. This procedure was developed
to provide a statistical method for the detection of damaged protein
pathways that drive disease. The method is based on measuring variant
enrichment and clustering by protein-protein interactions (PPI).

A detailed overall analysis plan is illustrated in . A accompanying data
storage plan is also provided in the same section that directly maps to
the analysis plan. A rough overview “infographic” of a next generation
sequencing study is shown **Figure \[fig:NGS\]**. The general
requirements, personnel responsibilities, and cost-breakdown is shown.

**Whole exome sequencing experiment design.** The general
requirements, personnel responsibilities, and cost-breakdown is shown
for a small NGS study of approximately ten participants. If library
preparation and sequencing is performed at a dedicated facility then
scaling up to very large cohorts (&gt;1,000) potential only differs in
one critical feature; implementing the bioinformatic methods used in
this chapter also requires a critical expertise in high-performance
computing. No methods have been included to demonstrate job scheduling
and parallelisation across large computer
clusters.
**FigureLabel**
NGS

<img src="{{ site.baseurl }}{% link images/bioinfo/NGS.png %}" width="80%">

*image_caption*

# Exome sequencing
## Sample preparation

For genomic investigations, a patient generally donates a small blood
sample (2-6mL) along with signed consent to use their biological
material and data in genetic and functional research. Patient DNA is
purified from peripheral blood monocytes. In most cases, the
purification is done using a commercial kit such as that from Qiagen
(51104 QIAamp DNA Blood Mini Kit). This protocol takes about 1 hour to
purify 1-10 patient samples. Sometimes patient DNA is provided from an
external source such as a local hospital where blood samples are
processed routinely by dedicated staff. In this case, the purification
method may be unknown so extra care should be taken when checking
suitability for sequencing experiments. Consideration should be given to
the possibility of sample mix up, that contamination could have
occurred, etc.

High-throughput sequencing experiments benefit from consistency during
sequencing library preparation. While there are several commercial
options available, the protocol used in this study was the SureSelect XT
target enrichment system for Illumina paired-end multiplexed sequencing
library. A detailed protocol is available from the manufacturer.
However, the process can be summarised in four main steps. After DNA
quality has been checked, the basic protocol consists of:\
(1) DNA fragmentation into 100-300 base pair strands, either (i) by
using an enzyme that digests the DNA or (ii) by breaking by sonication;
the DNA is suspended inside a small glass tube containing a glass rod
which is vibrated by sonic waves inside a water bath.\
(2) Another round of quality control checks to ensure that the DNA is
fragmented into the correct size range.\
(3) These fragments are bound by probes that specifically recognise the
coding sequences which collectively make up the exome.\
(4) The DNA that has been selectively purified is then tagged by adding
a tail of nucleotides in specific sequences that label each of the
individual samples with a unique code. When the sequencing step is
performed later, all of the samples will get mixed together. The unique
tag allows us to later re-identify which sequences belong to every
person included in the study.

While it is important that library preparation is performed accurately,
the individual steps could be replaced by alternative methods. The
crucial component is an end product of targeted DNA fragments that have
been tagged appropriately to allow the sequencing chemistry on the
chosen system and that fragment lengths are in the correct range. A more
detailed summary of the procedure is outlined;

**Preparation of sample**
1. DNA is sheared, the most frequently used methods are by enzymatic
digestion and sonication.
2. Fragmented DNA is purified using AMPure XP beads.
3. Quality assessment.
4. End repair.
5. Purify using AMPure XP beads.
6. Adenylation at 3' end.
7. Purify using AMPure XP beads.
8. Paired-end adaptor ligation.
9. Purify using AMPure XP beads.
10. Amplification.
11. Purify using AMPure XP beads.
12. Assess quality.

**Hybridization and capture**
1. Hybridize capture library probes to DNA.
2. Capture the hybridized DNA using streptavidin-coated beads.
Note: at this step, custom gene target libraries can be used.

**Indexing and multiplexing**
1. Captured libraries are amplified with indexing primers.
2. Purify using AMPure XP beads.
3. Assess quality and concentration of indexed library DNA.
4. Pool samples at equal concentrations.


## Capture library
For targeted sequencing experiments, the most important step in library
preparation is the hybridization of capture library probes. Libraries of
probes that are complementary to exome coding sequences can be ordered
from a number of commercial suppliers. For a whole exome, this consists
of hundreds of thousands of short RNA oligonucleotide strands bound to
biotin. When the capture library hybridization mix is added to the DNA,
most of the short probes bind to their complementary DNA sequences over
12-16 hours. To separate these selected fragments from the remaining
bulk of unwanted DNA, streptavidin-coated magnetic beads are added. The
streptavidin attaches to the biotin and therefore the DNA-bound probe
can be pulled out using a strong magnet. Unbound DNA can then be washed
away. Experiments in this study have been performed using Agilent
capture library SureSelect Human All Exon V4-6, although several other
options are available.

Targeted panels can also be used to focus on smaller sets of genes. For
example, in some immunological conditions a panel of  50 genes might be
targeted rather than a library for all known genes (exome). Cancer
genetics screening services sometimes use a small panel of 40-100 genes.
These small panels cut down on cost and focus only on genes where
interpretation of variants would be possible. For the same price as
whole exome, less capture library is needed and more samples can be
sequenced.

As of 2018, all-exon capture library costs roughly £16,000 for enough
reagent to prepare 96 DNA samples. This accounts for about 50% of the
cost of the total library preparation materials. In total, the library
preparation costs about £200 per sample. Once the samples have been
prepared it cost about another £200 to sequence; approximately £400
total.


## Sequencing
The sequencing carried out in this study was performed on Illumina
platforms. These include the MiSeq for very small runs of a select set
of genes, HiSeq 3000, 4000, and HiSeq X for whole exome or whole genome
sequencing. The prepared libraries of patient DNA are pooled to contain
5-12 samples per pool. Since each sample has a unique identifier tag, it
is OK to pool them together and later separate out all the individual
data per person. On the HiSeq 3000 approximately 12 samples can be run
per lane with acceptable coverage. This provides about 30-50X reads per
nucleotide, sufficiently deep to confidently identify true germline
mutations. There are 8 lanes per sequencing flow cell. Therefore, a
single sequencing run can contain anything from 50-100 patient samples.
Depending on the sequencing platform the run can take up to 5 days to
complete.

## Ultra-deep sequencing
Mendelian disorders can be successfully explained using exome and whole
genome sequencing. Both the interpretability and cost per sample are
improved in cases where a gene sequencing panel can be used. Some
conditions, particularly autoinflammatory disorders, can arise from low
frequency somatic variants that are capable of driving disease through
potent gain-of-function mechanisms. It is worth noting that a
“gain-of-function” can also be considered as a succinct description for
systems where a loss of inhibitory activity occurs that directly results
in increased signaling cascade activity that would otherwise rest in an
inactive state; a homeostatic pathway. E.g. loss of an autoinhibitory
feature for a single protein or loss of an inhibitory mechanism that is
responsible for direct repression in the absence of stimulation or
specific agonist. In such cases, a low frequency de novo variant will
escape detection with typical sequencing methods, but ultra-deep
sequencing offers a method for detection. This option uses a high
concentration of capture reagent to prepare a highly enriched library
and sequence at high-density on a flow cell to produce ultra-deep
sequencing reads (e.g. &gt;5,000x versus 50x, as typical for whole exome
sequencing). In this case, PCR-free preparation is ideal for somatic
variant detection, naturally.

# Genomic analysis
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

# Routine analysis {#sec:routine_analysis}
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
[@Li2009Fast]. BWA-MEM was used to align sequencing data in this study
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

# Tailored analysis
Routine analysis typically takes up to a week, although it is usually
performed on a standardised pipeline that can run automatically on a
high-performance computing platform. A large part of custom filtering
begins when the routine analysis steps have been completed; downstream
analysis is adapted for each particular challenge. The discussion in
explains some foundational steps towards a fully automatic system that
relies only on some input features, such as clinical information. While
many software packages exist that claim to output tailored analysis,
these tend to either only tackle a specific niche or require lots of
curated auxiliary input data.

The output of non-routine analysis (outlined in this chapter) sometimes
takes only five minutes to interpret a cause of disease. In other cases,
data that has been sequenced years previously has not yet relented an
explanation for phenotypes that almost certainly should be explained by
coding variants present within the sequence data. For example, for a
dozen patients who share a similar and severe phenotype, it is often
likely that the same gene or related genes could cause their disease.
Unrelated patients with a rare dominant disease are not to all carry the
same disease-causing variant; they may have different variants in shared
gene, or variants among different genes which all contribute to a shared
pathway that would result in the same end-point phenotype.

**Shared pathways in candidate genes.** Output of a STRING database
query for known and predicted protein-protein interactions. These
interactions include physical and functional associations. (STRING is an
SIB-run service of the ELIXIR core data open resources for publicly
funded research).

**FigureLabel**
string_normal_image
<img src="{{ site.baseurl }}{% link images/bioinfo/string_normal_image.png %}" width="40%">

*image_caption*

For example, in **Figure \[fig:string\_normal\_image\]** above we see
that from a group of unrelated people, all of the candidate genes
carrying functional variants are joined by their shared functional
interactions. For an autoinflammatory phenotype, genes like *NLRP3*,
*NOD2*, *TNFAIP3*, *MyD88*, *IKBKB*, *FASLG*, or *TMEM173* might all
have different functions but damaging mutations in any of these could
result in phenotypes that, on the surface, appear related.

Another circumstance might be seen in a small cohort of patients with a
shared autoinflammatory phenotype. For example, the gene *NLRP7* has
relatively few publications examining it's role in autoinflammatory
disease. One would not consider this a strong candidate gene if faced
with a variant of unknown significance in this gene from a single
patient. However, three or four very rare or novel mutations in
unrelated patients should be given consideration as producing an
autoinflammatory disease. Single case, or small cohorts lack the power
to measure significant associations. Therefore in the situation proposed
here, manual interpretation is required (biased as it may be).

*NLRP7* variants not reported as producing disease, like *MEFV*, or
*TNFAIP3*. However, we must consider that genes plausibly responsible
for causing disease in a dominant manner and that are highly conserved
are generally under purifying selective pressure. Damaging mutations may
be not be compatible with viability and therefore we never see cases of
disease. Variants which are damaging to protein function but that do not
completely destroy all of the normal structure may produce a phenotype
that is pathogenic but viable with modern medical intervention.

In the example of NLRP7, the protein is known to Inhibit
CASP1/caspase-1-dependent IL-1$\beta$ secretion. The functional domains
of this protein are shared in other pro-inflammatory processes. Pyrin,
NACHT, and LRR, domain variants are all studied for autoinflammatory
diseases. The related gene, *NLRP3*, is probably the most widely
recognised gene where damaging variants in these functional domains
produce severe immune disorders. In cases where we have protein
structures, we can also model the effect.

In our example, *NLRP7* variants have been reported as the genetic
determinant of a condition that causes early neonatal death and ectopic
pregnancy. Many of the reported variants are stop mutations that will
either produce a truncated protein or prevent expression of the allele
altogether through nonsense-mediated decay. It is difficult predict the
mechanism of disease in cases like this where the two outcomes have
opposing paths. That is to say, a truncated protein may have an active
functional domain which can no longer be inhibited since the C-terminal
domains are missing, while haploinsufficiency would mean that cells
cannot perform their normal function for the pathway since 50% of the
protein is depleted (in heterozygous cases). Haploinsufficiency can
result in a disease that phenotypically resembles a gain-of-function
when the responsible protein normally acts as an inhibitor for an
inflammatory pathway [@Lawless2018acase]. This is not expected with
*NLRP7* and therefore heterozygous loss-of-function does not explain
disease.

For a candidate gene like this, we have some plausible evidence but
cannot really progress any further without new functional studies. The
first step involved confirmatory Sanger sequencing for all patients
identified through exome sequencing. Next, any close relatives that are
available might be also sequenced for the same variants. If the
mutations are disease-causing then other carriers would also be expected
to have some shared phenotype features. The possibilities in functional
experiments vary widely and are highly dependent on the candidate genes.
The procedure outlined in this hypothetical example is generally
applicable in for the majority of single-case studies and illustrates
the importance of tailored analysis. The initial findings of genomic
analysis may produce more follow up questions, including whether other
probable gene candidates can be ruled out, for which the patient carries
only the “normal” reference alleles (e.g. *CFTR* screening for cystic
fibrosis/lung disease).

# Integrating databases
## Population genetics {#subsec:gnomad}
GnomAD (version r2.0.2) [@lek2016analysis] was used in these studies as
the best source of population genetics data. The reference genome is
GRCh37. Offline local database mirrors were used in most cases. Input
sets used GnomAD variant allele frequencies and reference sequences
processed as VCF and CSV files. outlines a specific data transformation
using the gnomAD database, but in general, gnomAD was used as a
filtering threshold for determining the expected population frequency of
each variant. A strict threshold for rare variants could be set to
ignore and candidate variants that are more frequent than 0.001.
However, in most cases a more lenient level is used and any remaining
benign or common variants are removed by “technical control” (filter on
cohort to remove common variants between individuals that do not share a
phenotype). A more modest cut-off threshold allows us to sometimes
identify variant that are present in the general population, which are
responsible for a recessive disease with no predictable heterozygous
loss-of-function intolerance.

Other sources of population genetics data comes from resources such as
CliVar and dbSNP, which as they grow in size become an annotated and
curated for of population data. These resources allow us to calculate
the expected frequencies for disease-causing variants. However, since
these are manually curated database and predominantly European based,
they are inherently biased and not reliable for statistical
applications.

## Phenotype, genotype, and function
Population genetics database gnomAD has been individually addressed in
section \[subsec:gnomad\], as this is the most important type of
annotation and filtering criteria for genetic determinants of rare
disease. Additionally, in these studies many phenotype and genotype
databases have been used for annotation and interpretation.
Specifically, the most frequently used data came from MGI Phenotype,
MorbidMap, VOC MammalianPhenotype, Gencode symbol, UniProtKB, Enterez
ID, ENSGene ID, GO ID, Description, OMIM, BIOGRID interactions, HGMD
human phenotype, ClinVar, and dbSNP. In most cases, every candidate
variant was annotated with the main information per gene from a local
database containing the information from each of the listed resources.

These are the “basic” information databases that we used to annotate
variants. In a cohort study, data mining can find correlations and was
therefore included for posterity as it does not significantly increase
the data storage. Even if an obvious cause of disease was found we may
later return to the data to find other cofactors or genetic modifiers.
Or for example, in a single case study, a variant of unknown
significance may have no statistical basis to be selected or ignored. We
use this information to decide if that mutation is worth consideration:
Is it in a protein domain of known function? Are there other cases
reported with the same phenotype? What is the gene function, ontology,
etc.?

We have also used some gene lists that are specific to disease,
druggability, etc. A major contributor for collecting these gene lists
has been the Mac Arthur et al. [@macarthurgit]. These gene lists can be
used is special cases. For example, a study looking at (1) dominant
pathogenic mutations, and (2) in known immune genes might filter to
included only those known observables. We could decide to only study
SNPs in FDA-approved drug targets.

[| p[4.5cm]{} | c | p[6cm]{} |]{}

\
& [**Gene Count**]{} & [**Reference**]{}\
& [19,194]{} & [HUGO 2018 [@HUGO2018]]{}\
[FDA-approved drug targets]{} & [385]{} & [Wishart 2018
[@Wishart2018]]{}\
[Drug targets]{} & [201]{} & [Nelson 2012 [@Nelson2012]]{}\
[Autosomal dominant genes]{} & [307]{} & [Blekhman 2008
[@Blekhman2008]]{}\
[Autosomal dominant genes]{} & [631]{} & [Berg 2013 [@Berg2013]]{}\
[Autosomal recessive genes]{} & [527]{} & [Blekhman 2008
[@Blekhman2008]]{}\
[Autosomal recessive genes]{} & [1073]{} & [Berg 2013 [@Berg2013]]{}\
[X-linked genes]{} & [66]{} & [Blekhman 2008 [@Blekhman2008]]{}\
[X-linked recessive genes]{} & [102]{} & [Berg 2013 [@Berg2013]]{}\
[X-linked dominant genes]{} & [34]{} & [Berg 2013 [@Berg2013]]{}\
[X-linked ClinVar genes]{} & [61]{} & [Landrum 2014 [@Landrum2014]]{}\
[All dominant genes]{} & [709]{} & [Blekhman 2008, Berg 2013
[@Blekhman2008; @Berg2013]]{}\
[All recessive genes]{} & [1183]{} & [Blekhman 2008, Berg 2013
[@Blekhman2008; @Berg2013]]{}\
[Homozygous LoF tolerant]{} & [330]{} & [Lek 2016 [@lek2016analysis]]{}\
[Essential in culture]{} & [283]{} & [Hart 2014 [@Hart2014]]{}\
[Essential in culture\*]{} & [683]{} & [Hart 2017 [@Hart2017]]{}\
[Non-essential in culture\*]{} & [913]{} & [Hart 2017 [@Hart2017]]{}\
[Essential in mice]{} & [2,454]{} & [Blake '11, Georgi '13, Liu '13
[@Blake2010; @Georgi2013; @Liu2013]]{}\
[Genes nearest to GWAS peaks]{} & [6,336]{} & [MacArthur 2017
[@MacArthur2017]]{}\
[DNA Repair Genes]{} & [178]{} & [Wood 2005 [@Wood2005]]{}\
[DNA Repair Genes]{} & [151]{} & [Kang 2012 [@Kang2012]]{}\
[ClinGen haploinsufficient genes]{} & [294]{} & [Rehm 2015
[@Rehm2015]]{}\
[Olfactory receptors]{} & [371]{} & [Mainland 2015 [@Mainland2015]]{}\
[Reported in ClinVar]{} & [3078]{} & [Landrum 2014 [@Landrum2014]]{}\
[Kinases]{} & [347]{} & [UniProt 2016 [@UniProt2016]]{}\
[GPCRs from guide to pharmacology]{} & [391]{} & [Alexander 2017,
Harding 2018. [@Alexander2017; @Harding2017]]{}\
[GPCRs from Uniprot]{} & [756]{} & [UniProt 2016 [@UniProt2016]]{}\
[Natural product targets]{} & [37]{} & [Dancik 2010 [@Dancik2010]]{}\
[BROCA - Cancer Risk Panel]{} & [66]{} & [BROCA Cancer Risk Panel
[@BROCACancerRiskPanel]]{}\
[ACMG V2.0]{} & [59]{} & [Kalia 2017 [@Kalia2016]]{}\
[GPI-anchored proteins]{} & [135]{} & [UniProt 2016 [@UniProt2016]]{}\

@verma2018rare take an interesting approach to comparing druggable
targets with population genetics data. DrugBank is a database for over
800 genes with over 950 unique drugs. Genetic data can be filtered for
these genes and targeted for LoF variants. Association analysis consists
of logistic regression using the ICD-9 codes, and linear regression
using quantitative variables. This gene binding and regression analysis
steps are done using BioBin.

The International Statistical Classification of Diseases and Related
Health Problems (commonly known as the ICD) provides alpha-numeric codes
to classify diseases and a wide variety of signs, symptoms, abnormal
findings, complaints, social circumstances and external causes of injury
or disease. Nearly every health condition can be assigned to a unique
category and given a code, up to six characters long. Such categories
usually include a set of similar diseases

BioBin relies on the Library of Knowledge Integration (LOKI), which
integrates multiple databases providing a comprehensive biological
knowledge platform for variant binning [@pendergrass2013genomic]. The
LOKI database consolidates biological information from several sources,
most notably the National Center for Biotechnology (NCBI) dbSNP and
Entrez Gene, Kyoto Encyclopedia of Genes and Genomes (KEGG), Reactome,
Gene Ontology (GO), Protein families database (Pfam), NetPath-signal
transduction pathways, amongst others
[@coordinators2017database; @kanehisa2011kegg; @milacic2012annotating; @ashburner2000gene; @finn2013pfam; @kandasamy2010netpath].

# Rare disease cohort network analysis {#sec:cohort_network_analysis}
## Introduction
The exome sequencing is most commonly used for genetic diagnosis in
single use cases. Over the next decade exome and genome sequencing will
become very commonplace for the average person at least in high-GDP
countries. A massive expanse in population genetics data will provide
the information that GWAS studies have always sought. We will still be
left with large genomic black holes; that is conserved coding and
non-coding regions that are obviously important as the determinants of
human health within Mendelian genetics. To uncover the function of these
genetic loci we will still be at the mercy of cohort size in rare
disorder studies. For true rare genetic disorders, a disease frequency
of 0.01% equates to approximately 800,000 cases worldwide for diseases
that are not embryonic lethal and where lifespan is about normal. If we
consider high income populations where genomic sequencing would be
common, then we may have 100,000 cases. A very well organised rare
disease study would do well to recruit 1 per 1000 in a clearly defined
disease; this is currently the situation although most studies cannot
finance full genomic investigation. Therefore, now and well into the
future, rare disease studies will generally be limited to a maximum
number of living participants on the scale of hundreds.

Current best practices in genomic analysis will first identify “low
hanging fruit”; single cases in a cohort with a clear genetic
determinant (e.g. haploinsufficiency of a well-defined dominant gene).
The second order will identify commonly mutated genes or loci based on
burden testing comparing cases to controls or background population
genetics. Many disorders have a phenotype that can be derived from
mutations in several different genes. The encoded genes generally are a
part of the same protein pathway, even directly upstream and downstream
of each other in some cases. For example, covers this topic with
individual cases of RAG1 and RAG2 deficiency.

Proposed here is a statistically robust and unbiased method to find
variants in protein-coding genes that share a common functional protein
pathway for a disease cohort. **Figure \[fig:method\]** provides a
high-level graphical summary of the concept. **Figure \[fig:abstract\]**
conveys the theory of the procedures for this method in more detail with
the major datasets explicitly shown.

**Deleterious rare variants in damaged protein pathways in rare
disease.** A. GATK best practices were used for whole exome analysis
with joint genotyping for cases and controls; 200 in total. Custom
filtering [@vcfhacks2015Parry] extracted variants of high impact
consequence (ostensibly loss-of-function (LoF)), present only in cohort
cases. B. Genes harboring rare predicted LoF variants were grouped based
on protein-protein interactions [@String2017Szklarczyk] using a Markov
cluster algorithm [@Enright2002efficienct]. C. Case-control testing was
performed on each protein pathway cluster.

**FigureLabel**
method
<img src="{{ site.baseurl }}{% link images/net_analysis/method.png %}" width="80%">

**Rare variant analysis and protein pathway significant enrichment.**
A. DNA is collected and sequenced. B. Routine genomic analysis is
carried out according to best practices, for both (i) control and (ii)
case groups of patients. First, all rare variants are output, followed
by a smaller subset of loss-of-function (LoF) variants. C.
Variant-carrying genes are cluster of protein-protein interactions based
on function and ontology. D. A clustering method is applied to break a
large highly connected network into smaller individual ones. E. The
number of tests can be reduced by, for example, testing only networks
that carry a threshold level of LoFs and are therefore biologically
relevant to disease. F. Deleterious variant load per network was tested
for enrichment in cases, controls, or random sampling. G. Multiple
testing correction is applied to identify the critical significant
threshold.
**FigureLabel**
abstract
<img src="{{ site.baseurl }}{% link images/net_analysis/abstract.pdf %}" width="80%">

## Exome analysis
Exome sequencing analyses has been discussed in detail. The rare disease
cohort network analysis requires less tailored analysis steps than
traditional variant interpretation. Therefore, the data preparation is
briefly outlined here.

Sequences were trimmed and quality controlled using FastQC via
Trim-galore. Reads were aligned to GrCh37 using BWA-MEM. GATK “best
practices” were used for marking duplicate reads, recalibration, and
whole cohort variant quality score recalibration before generating
genomic VCFs with HaplotypeCaller and joint genotyping. Filtering and
prediction of functional consequences was performed using Variant Effect
Predictor\
(http://www.ensembl.org/info/docs/tools/vep/index.html), Exome Variant
Server\
(http://evs.gs.washington.edu/EVS/), The Single Nucleotide Polymorphism
database\
(https://www.ncbi.nlm.nih.gov/projects/SNP/) and ClinVar
(https://www.ncbi.nlm.nih.gov/ clinvar/), The Exome Aggregation
Consortium and The Genome Aggregation Database\
(http://gnomad.broadinstitute.org). Filtering of common variations and
annotation was performed using VCFhacks\
(https://github.com/gantzgraf/vcfhack). Candidate variants were required
to pass the following filtering conditions: frequency (count/coverage)
between 20-100%, according to VEP-annotation at least one canonical
transcript is affected with one of the following consequence: variants
of the coding sequence, frameshift, missense, protein altering, splice
acceptor, splice donor, or splice region; an inframe insertion or
deletion; a start lost, stop gained, or stop retained, or according to
VEP an GnomAD frequency unknown, &lt;=0.01, or with clinical
significance 'path'. VCFhacks [@vcfhacks2015Parry] was used for
cohort-specific filtering retained functional variants that were present
in at least one case but absent in controls (for case-driven PPI
clustering). The same criteria were used to also collect functional
variants that were present in at least one control but absent in
controls (for control-driven PPI clustering).

## Cluster list preparation
Group-specific variant data was extracted from the joint cohort.
Specifically, the datasets came from the routine analysis pipeline show
in **Figure \[fig:analysis\_flow\]** as the output of the process
“filter on Sample” and converted from VCF to tsv format using the
process “annovcftoSimple” using the tool VCFhacks [@vcfhacks2015Parry].
Four gene lists were prepared consisting of the following groups; (1)
variants present in controls and (2) variants present in cases and
further divided for genes that harboured either (i) all rare variants or
(ii) only potential loss-of-function variants. Specifically, the
datasets for (i) all rare variants came from the output of the process
“filter on sample” via “get functional variants”. The datasets for (ii)
potential loss-of-function variants is a subset of (i), processed by the
R script at the step where “damaging variants” are written out to file.

Analysis workflow structure. Tools used are shown in square boxes.
Reference data used secondary to inputs are shown as light boxes with
curved sides. Key output files are shown by light slanted boxes. Storage
structure is divided between long-term and short-term
storage.
**FigureLabel**
analysis_flow
<img src="{{ site.baseurl }}{% link images/net_analysis/analysis_flow.pdf %}" width="80%">

## Network construction {#sec:net_construction}
Group-specific gene lists \[1 (i-ii) and 2 (i-ii)\] were assessed for
PPI using the STRING database [@String2017Szklarczyk] via Cytoscape
[@Shannon2003cytoscape]. An initial PPI network was generated for each
of the 4 dataset groups. The STRINGdb default confidence score cut-off
(0.4) was used for these tests. This score is the measure of evidence
required to create an interaction between two nodes. A stricter value
can be set if networks are too large. Query genes were defined as nodes,
PPI were defined as edges, and networks of proteins linked through PPI
were defined as clusters. Clusters or networks can also be generally
considered as making up a part of a protein pathway.

[\*[5]{}[Z]{}]{}

\
& [Network cluster]{} & [Number of nodes]{} & [Number of edges]{} &
[Number of clusters]{}\
& [Total ]{} & [1956]{} & [9559]{} & [114]{}\
& [No edges]{} & [1]{} & [0]{} & [107]{}\
& [One edge]{} & [2]{} & [1]{} & [6]{}\
& [Large multi-edge]{} & [1837]{} & [9553]{} & [1]{}\
& [Total]{} & [2305]{} & [14139]{} & [102]{}\
& [No edges]{} & [1]{} & [0]{} & [77]{}\
& [One edge]{} & [2]{} & [1]{} & [3]{}\
& [Two edges]{} & [3]{} & [2]{} & [1]{}\
& [Large multi-edge]{} & [2219]{} & [14134]{} & [1]{}\

**Table \[table:node\_summary\]** lists the characteristics of PPIs for
genes found to harbour functional, potential LoF rare variants in cases
and controls (i.e. gene lists 2 \[i-ii\]). Most query proteins were seen
to cluster into one large multi-edge node which contained many weak
interactions. The data used in this table is represented again visually
in **Figure \[fig:damage\_list\_case\]**. Each dot, or node represents a
protein-coding gene that has at least one potentially damaging variant.
The edges, or lines connecting nodes, represent known PPI data that link
proteins. This visual information clearly illustrates the body of
functional protein data that can be included in variant analysis.
However, since nearly every protein has some potential evidence of
effect on many other proteins, then no clear definable protein pathway
can be seen.

**Genes harbouring potentially damaging variants in a disease
cohort.** A visual representation of PPI occurring in all genes that
harbour potentially damaging functional variants in a typical disease
cohort.
**FigureLabel**
damage_list_case
<img src="{{ site.baseurl }}{% link images/net_analysis/damage_list_case.png %}" width="50%">

To segregate protein pathways and refine the number of genes (nodes) in
each cluster, the Markov cluster algorithm (MCL) was used
[@van2000graph; @Enright2002efficienct]. The principal data-specific
adjustment required for using MCL is the inflation operator, which
regulates cluster granularity or tightness. The optimum inflation
parameter for separating protein pathways was found to be 2.5, using a
measure of uniform distribution across datasets. **Figure
\[fig:inflation\]** illustrates an optimal inflation of a large PPI
network into smaller, clearly defined protein pathway clusters.

As a reference example, **table \[table:node\_edge\]** lists three
inflation parameters tested for most consistent separation (2.5, 3, 4)
and shows the effect of adjustment on the total number of edges (protein
interactions). The median number of nodes (query proteins) are shown for
cases and controls (also shown as total number of nodes in **table
\[table:node\_summary\]**).

[@l@l@]{} \[0pt\]\[0pt\]

\[Inflation separates protein pathways\][**=0 Inflation separates
protein pathways.** A visual representation the ideal inflation
parameter used on a PPI cluster. Weak bonds are broken and strong bonds
draw nodes closer together. No bonds are retained between clusters. With
this type of inflation each protein network cluster can be investigated
without considering overlaps.]{} \[fig:inflation\]

[\*[4]{}[Z]{}]{}

\
& & [Total count median]{} & [Node/Edge ratio ]{}\
& & [Case/control $\pm$ S.D.]{} & [Case/control $\pm$ S.D.]{}\
& & [2130.5 $\pm$ 246.78]{} &\
& [PPI only \*]{} & [11849 $\pm$ 3238.55]{} & [0.18 $\pm$ 0.03]{}\
& [Inflation 2.5]{} & [2787.5 $\pm$ 740.34]{} & [0.78 $\pm$ 0.12]{}\
& [Inflation 3]{} & [4229.5 $\pm$ 3669.18]{} & [0.77 $\pm$ 0.61]{}\
& [Inflation 4]{} & [1199.5 $\pm$ 146.37]{} & [1.78 $\pm$ 0.01]{}\

**Figure \[fig:network\_size\_inflation\]** illustrates the effect of
adjusting the inflation parameter for MCL clustering on protein
networks. After MCL clustering, cases and controls were found to group
into 928 and 1034 networks clusters respectively. Of these, 494 and 568
were single-node (single-protein) “clusters” which shared no interaction
with another protein while 434 and 466 clusters had at least one
interaction between proteins. The cumulative probability plot (figure
\[fig:cumulative\_sum\_net\_rank\]) shows the cumulative sum of proteins
per network against network rank size. **Figure \[fig:qqplot\_2\]**
shows qqplot for the same data for distribution compared between groups
after inflation at 2.5.

**Effect of inflation on network size distribution.** The outcome on
network size is demonstrated to compare effect of two inflation
parameters. An ideal separation of networks should provide an geometric
decrease in the number of proteins per network regardless of the sample
group. Inflation parameter 2.5 produced the ideal distribution while
inflation parameter 3 produced one large, poorly separated network and a
large increase in single-protein nodes on one group. Binwidth of
10.
**FigureLabel**
network_size_inflation
<img src="{{ site.baseurl }}{% link images/net_analysis/network_size_inflation_free.pdf %}" width="40%">

**Cumulative sum of network rank by size**. The effect of inflation on
network size distribution could be potentially measured automatically by
quantifying the cumulative sum of network rank by size and determining
the best inflation parameter to use. This process would reduce user
bias.
**FigureLabel**
cumulative_sum_net_rank
<img src="{{ site.baseurl }}{% link images/net_analysis/cumulative_sum_net_rank.pdf %}" width="40%">

**QQ plot illustrating uniform inflation.** The data presented in
figure \[fig:cumulative\_sum\_net\_rank\] is used to produce the
quantile-quantile plot for the most uniform distribution between the
case and control groups after all inflation parameters were
tested.
**FigureLabel**
qqplot_2
<img src="{{ site.baseurl }}{% link images/net_analysis/qqplot_2.pdf %}" width="40%">

**Figure \[fig:network\_size\_nodes\]** shows the number of proteins per
network. For example, 235 clusters (470 protein nodes) were seen for
cases where only one interaction was shared between two proteins. A
median of 0.78 nodes-per-edge (proteins-per-interaction) was found in
the cases group; naturally the majority of edges appear in large network
clusters and therefore the frequency of nodes-per-edge increases as
network sizes decrease.

Number of proteins per network for case-driven clustering. The size of
protein networks has a geometric distribution that decreases until
protein (nodes) with no interactions remain; in this cases approximately
200 out of 400 proteins did not play a major role in a single
pathway.
**FigureLabel**
network_size_nodes
<img src="{{ site.baseurl }}{% link images/net_analysis/network_size_nodes.pdf %}" width="40%">

## Random sampling {#sec:random_sample}
With our group-specific gene lists [1 (i-ii) and 2 (i-ii)], prepared
in section \[sec:net\_construction\], we found the distribution of genes
per networks and output the list of genes in each network for all 4
datasets. The mean number of genes per network rank was found between
cases and controls, again for (i) all rare variants and (ii) only
potential loss-of-function variants. A third gene cluster list was
produced by random sampling gene symbols in artificial networks equal to
the same median size as case-driven and control-driven clusters in from
datasets (i) and (ii). The resulting dataset [3 (i-ii)] mirrors those
of cases and controls but instead of true PPI networks, the networks
contained randomly assigned genes.

## Expanding damaged gene MCL clusters
For each of the 4 MCL-clustered datasets, cases and controls [1 (i-ii)
and 2 (i-ii)], the cluster ID and list of gene symbols was extracted.
The gene lists of network clusters made from datasets (ii) (potential
LoF) were used to find the network clusters in (i), all-variant gene
clusters, the contained the same overlapping genes. This occurs where
list (ii) is a subset of list (i). The clusters that contained gene
overlaps were extracted since they contained at least one potential LoF
per network. Using this output, the total variant load in “damaged
pathways” could be compared. For clarity, this procedure is summarised
again in Box \[box:expanding\]; items **A-B**. Item **C** outlines the
remaining steps. **Figure \[fig:damage\_list\_case\]** illustrates the
effect of inflation with an ideal inflation parameter. The large network
of PPI were separated into individually contained protein networks.

\[box:expanding\]

## Burden rank {#sec:burden_rank}
Our downstream case-control testing compares the mean total variant load
per network. To prevent dilution of our significance threshold due to
multiple testing an arbitrarily high number of networks we assumed that
protein networks harbouring loss-of-function variants at a consistent
frequency in all groups were unlikely to contain genes of interest. To
remove these networks, we firstly found (*p*) the ratio of LoF to all
variants within the group per network, and secondly found (*q*); the
ratio of *p* between groups per network. Networks were ranked by value
*q*. Values passing a threshold of 0.7 were included for total variant
load means testing (i.e. 70% of ostensibly damaging variants occurred in
cases regardless of the proportion of total variants). This also has the
effect that even if there is no significant difference in a case/control
total-variant means test downstream, potential false negatives may be
rescued by checking for LoF enrichment. This method is applied to real
data in section \[sec:enrichment\_test\] and **table
\[table:bh\_real\]**.

## Determining the number of tests *m* {#sec:number_test}
The number of tests should be determined by the predefine LoF ratio per
network, *q*. This value is arbitrarily set and has the problem that an
investigator can decide to use a higher threshold to nude the critical
significant threshold in a desired direction. However, testing roughly
the top 20-30% of networks is suggested. In our experiments we set our
test number as the top 25% of burden-ranked networks. This will be
approximately 10 networks to test (the asymptote of network numbers peak
when the study size increases over approx. 400 samples as all of the
possible PPIs are saturated once the maximum queryable genes are
included). Study sizes that are much larger than this will likely only
(1) be for disease that are not very rare and (2) be large enough to
start expecting single gene significance levels without requiring
network analysis. However, some very strict filtering rules could allow
larger studies with this method.

## Significance testing
We hypothesised firstly that no variant enrichment would be seen in
random sampling or control-driven gene clusters, and secondly enrichment
would only be seen in case-driven clusters for protein-pathways that
provide susceptibility to viral infection. For measuring a significant
enrichment of functional variants in a protein network, there are three
factors to consider.

1.  Our aim is to do a comparison of means between case and control, for
    total variant load per network.

2.  This is done in three iterations; \[1\] control-driven, \[2\]
    case-driven, and \[3\] random sample-driven.

3.  We correct our significance threshold to account for multiple
    testing using the Benjamini-Hochberg procedure.

With our group-specific gene lists [1 (i-ii), 2 (i-ii), and [3
(i-ii)\], prepared in sections \[sec:net\_construction\] and
\[sec:random\_sample\], we found the distribution of genes per networks
and output the list of genes in each network for all 6 datasets. In each
of the 3 “all variant” datasets we simply do a comparison of means for
total variant load per network comparing case to control, or random.

While the test is not complicated, the significance threshold deserves
an in-depth explanation; this is a novel method and most people
replicating this study will not have experience with the statistical
procedures required. The statistical significance also only allows a
narrow margin for successful discovery. When a large number of tests are
performed, one is likely to produce P-values that are “statistically
significant” by chance (P &lt; 0.05), even if the null hypothesis is
true. The null hypothesis would state that “random controls and people
with disease have the same average frequency of potentially pathogenic
variants in some protein pathway”. The alternate hypothesis would state
that “people with disease have an increased frequency of potentially
pathogenic variants in some protein pathway than random controls”.

Traditionally, Bonferroni correction has been used in cases like this.
For each “family” (network means test) being tested one must correct the
critical P-value. For example, for one test a significant P-value might
be 0.05 and below this we consider the result to be significant. The
chance of getting this result if the null hypothesis was true would be
5%. That does not mean that there is 5% chance that it is true. The
following examples are reiterated summary of the topic found in the
Handbook of biological statistics [@mcdonald2009handbook].

For multiple tests of “families” then we need to adjust the P-value
since we are more likely to get false positives by chance. In a
published example, @garcia2014calorie tested 25 associations with
mammographic density, which is an important risk factor for breast
cancer. The 25 “families” tested were dietary variables including “Total
calories”, “Olive oil”, “whole milk”, “white meat”, etc. For each
variable a P-value was given for its association with mammographic
density, i.e. total calories P &lt; 0.001, olive oil P = 0.008, whole
milk P = 0.039.

To perform a Bonferroni correction, the critical P-value (or significant
threshold) should be divided by the number of tests, 0.05/25 = 0.002.
Therefore, only “total calories” would be significantly associated with
the risk factor. If 75 more variables were measured (100 total) then the
critical P-value would have to be 0.05/100 = 0.0005. However, it may not
be reasonable to invalidate the significance of the original findings.
Using Bonferroni correction for family-wise error rate can mean
extremely small P-values. So instead we use a more powerful method for
controlling the false discovery rate; the Benjamini-Hochberg procedure
[@simes1986improved; @benjamini1995controlling].

In this procedure, we compare each individual P-value to its
Benjamini-Hochberg critical value, $(i/m)Q$, where $i$ is the rank, $m$
is the total number of tests, and $Q$ is the chosen false discovery
rate. The largest P-value that has $P<(i/m)Q$ (i.e. P less than
BH-critical value) is significant, and all of the P-values smaller than
it are also significant, even the ones that aren't less than their own
Benjamini-Hochberg critical value.

So in the same example, with 25 tests and Benjamini-Hochberg critical
value for a false discovery rate set to 0.25, table
\[table:bh\_example\] shows the outcome. The largest P-value that is
less than its $(i/m)Q$ values is 0.042 for protein. Therefore, the first
5 variables are significantly associated, including whole milk and white
meat despite the fact that their BH-critical value is higher than their
P-value. If we were to never have measured protein in this example, $m$
the number of tests would be 24, slightly increasing the BH-critical
value, and again identify a significant association for the first 4
tests. Someone interested can recalculate this table to see this effect.

[\*[2]{}[Z]{}]{}

\
& [P value]{}\
& [&lt;0.001]{}\
[Olive oil]{} & [0.008]{}\
[Whole milk]{} & [0.039]{}\
[White meat]{} & [0.041]{}\
[Proteins]{} & [0.042]{}\
[Nuts]{} & [0.06]{}\
[Cereals and pasta]{} & [0.074]{}\
[White fish]{} & [0.205]{}\
[Butter]{} & [0.212]{}\
[Vegetables]{} & [0.216]{}\
[Skimmed milk]{} & [0.222]{}\
[Red meat]{} & [0.251]{}\
[Fruit]{} & [0.269]{}\
[Eggs]{} & [0.275]{}\
[Blue fish]{} & [0.34]{}\
[Legumes]{} & [0.341]{}\
[Carbohydrates]{} & [0.384]{}\
[Potatoes]{} & [0.569]{}\
[Bread]{} & [0.594]{}\
[Fats]{} & [0.696]{}\
[Sweets]{} & [0.762]{}\
[Dairy products]{} & [0.94]{}\
[Semi-skimmed milk]{} & [0.942]{}\
[Total meat]{} & [0.975]{}\
[Processed meat]{} & [0.986]{}\

The choice of a false discover rate depends on the application. False
positives can waste time, resources, and pollute future work. Minimising
false negatives could result in missing a very important finding, that
is, when there is a real effect but it is not deemed statistically
significant. Allowing a pre-determined level false negatives is often
reasonable. As in our application, finding enriched protein networks is
the main goal, and downstream work will also be done such as clinical
interpretation or functional studies which will catch false negatives.
Therefore, the false discovery rate does not have to be very small;
consider that our input dataset is already filtered down to ostensibly
damaging rare variants. Furthermore, the input dataset is essentially
the result of traditional best practices in exome or genome sequencing
analysis.

## Enrichment testing {#sec:enrichment_test}
For all networks, the top 30 networks in size (largest to smallest;
1-30) were ordered using the burden rank (sec \[sec:burden\_rank\]).
From these, the number of tests was set (according to the rules defined
in sec \[sec:number\_test\], so that only the top 8 burden-ranked
networks were means tested for their total variant load. **Figure
\[fig:means\_test\]** shows the test of means for the top 8 protein
pathway networks. Table \[table:bh\_real\] lists the P-values assessed
for significance using the BH-procedure. We found that only one of the
networks was significantly associated with a pathogen-specific
immunodeficiency. The variant load was significantly higher than for
controls. The total potential LoF variants only accounted for 30.5% of
total variants in the network but was ranked high during the burden rank
(see sec \[sec:burden\_rank\]) because no controls harboured potential
LoF variants in this network and therefore 100% occurred in cases. This
protein network contained genes responsible for pathogen detection; some
genes *might have been* identified as candidates using the routine exome
analysis pipeline such as the antiviral receptors and antiviral
interferon regulatory factors. However, most of the other genes that are
integral to this pathway would not have been identified by standard best
practices. The protein network is shown in **Figure
\[fig:immune\_cluster\]** where potential LoF variants-harbouring genes
are coloured in red. Gene candidates with variants of unknown
significance are coloured in red and, anecdotally, the colouring
thereafter becomes lighter (orange to yellow) based on the likelihood of
candidates being identified by manual interpretation of unknown
candidates.

**Case and control means test.** The total rare variants per network
are shown, comparing groups. A test of means was conducted in this test
dataset and P-values are
shown.
**FigureLabel**
means_test
<img src="{{ site.baseurl }}{% link images/net_analysis/means_test.pdf %}" width="30%">

[\*[6]{}[Z]{}]{}

\
& [**LoF freq in cases**]{} & [**LoF freq due to cases per network**]{}
& [**P-value**]{} & [**rank**]{} & [**$(i/m)Q$**]{}\
& [0.306]{} & [1]{} & [0.023]{} & [1]{} & [0.025]{}\
[27]{} & [0.429]{} & [1]{} & [0.12]{} & [2]{} & [0.05]{}\
[16]{} & [0.6]{} & [0.919]{} & [0.13]{} & [3]{} & [0.075]{}\
[19]{} & [0.281]{} & [0.835]{} & [0.14]{} & [4]{} & [0.1]{}\
[25]{} & [0.25]{} & [1]{} & [0.28]{} & [5]{} & [0.125]{}\
[11]{} & [0.357]{} & [0.838]{} & [0.33]{} & [6]{} & [0.15]{}\
[10]{} & [0.516]{} & [0.856]{} & [0.34]{} & [7]{} & [0.175]{}\
[18]{} & [0.474]{} & [0.85]{} & [0.47]{} & [8]{} & [0.2]{}\

[@l@l@]{} \[0pt\]\[0pt\]

\[Protein network with significantly enriched variant load.\][**=0
Protein network with significantly enriched variant load.** From the
example data, network 22 was significantly enriched for rare variants.
The same clustering method was again used on all variants with a less
stringent variant frequency (&lt;1% in general population and present in
any cohort sample). With the resulting, more common variants, the full
protein network can be seen (about double in size compared to only very
rare variants). Gene candidates with variants of unknown significance
are coloured in red and, anecdotally, the colouring thereafter becomes
lighter (orange to yellow) based on the likelihood of candidates being
identified by manual interpretation of unknown candidates. ]{}
\[fig:immune\_cluster\]

# Discussion
Exome sequence data is usually about 4 GB of information per person.
Whole genomes are approximately 50GB of data. The analysis of whole
genome sequencing is almost identical to the exome pipeline outlined
here. While there is much more information (for not much of a higher
cost), a lot of the non-coding sequence contains information that we
can't yet interpret. For Mendelian disease the whole exome often
uncovers the coding variants that explain disease. We may not understand
anything else outside the exome (and the surrounding splice regions) in
relation to a patients' disease. Mutations in the promoters or enhancers
that prevent transcription may not be as readily interpretable as the
majority of coding variant effects. Therefore, whole genome is often not
required. This excuse for performing exome sequencing rather than whole
genome mostly depends on value for money. Performing all the different
kinds of analysis, including non-coding genome analysis, requires many
people with expertise in each topic. Even if whole genome data was
available to smaller research teams, it is often the case that they
cannot carry out all the work required to interpret it. For national
level genomics, there is no question that whole genome sequencing is
preferential. We can retain the data for decades with hundreds of
experts to share the work-load, while the cost is essentially a
political factor. An important question to address is the right for a
person to agree to genetic forfeiture. We are at the brink of
preventative medicine using genome sequencing in newborns. Regardless of
the popular ethical consensus, any preventative non-consenting genomic
analysis can be considered coercion.

**Figure \[fig:immune\_cluster\]** illustrates how not only can very
rare or damaging variants be clustered, but the same network can be
expanded to include peripherally interacting genes. This modification
may be used for downstream functional work such as looking at
pathway-level expression data. An important consideration for protein
network cohort analysis is evident in **Figure
\[fig:network\_size\_nodes\]**. About 50% of genes with a functional
variant are do not get clustered into a PPI network (protein pathway).
However, some of these genes could still harbour a potential
loss-of-function or damaging variant. If we found 3 significantly
enriched protein networks, a potential 4th missed network (false
negative), because of unclustered genes, would not detract from the
significant findings. Therefore, the singleton genes remaining from MCL
clustering should be listed and reassessed based on traditional
interpretations; variant effect, loss-of-function intolerance, etc. The
converse, a false positive because of over clumping weakly related
proteins, would be negative.

The analysis of genomic data is an iterative process. Therefore, access
to raw unprocessed genetic information is often required to utilize
cutting edge methods [@Auwera2013From; @Poplin2018Scaling]. Furthermore,
genetic analysis is a complex, multi-stage procedure. Due to the
inherent complexity, there is a number of output streams which consist
of different data types. To provide seamless integration with current
best practices in precision medicine, it is valuable to adhere to
standard genomic data types, including CRAM, SAM/BAM, FASTQ, and VCF
[@Li2009Sequence; @Hsi2011Efficient; @cock2009sanger; @Danecek2011Variant].
There is benefit to creating new data formats that increase efficiency.
However, by focusing on key data types in genomics, one can enable
integration with most current software
[@pabinger2014survey; @Auwera2013From].

An interesting caveat to genetic data is that at pre-processing stages,
several data types cannot be currently provided with protection through
the use of modern cryptographic methods
[@froelicher2017unlynx; @juvekar2018gazelle]. There is currently a
severe lack of tools that complement current methods required to
interrogate genetic data at different stages while protecting individual
personal genetic records. Furthermore, despite the attempts to promote
data privacy and integrity through global initiatives, such as Global
Aliance 4 Genome Health, little has been done to produce queryable data
that protects the genetic identity of a subject.

The privacy concerns at the early stages of data processing are often
overlooked. Almost every method offered for data security relies on
protecting only fully process data (e.g. already variant called VCF
format data) or summary statistics. In worst cases, privacy concerned
genomics falls back to “trust-based” systems where data generators or
researchers are required to accept responsibility for preventing any
re-anonymisation. Of course, researcher trust is an important factor,
however, relying on this method for protecting subject information is
immoral. Unlike nearly all clinical data, genetic data is inherently
identifiable and is not readily anonymised. The information that makes
up the data is itself the identity or commodity. In nearly every other
type of clinical data, it is only a commodity when there is an identity
to which it is paired or if it is part of a large dataset-of-normals.
The lack of strong methods of genetic data protection is not an apparent
risk generally. Extrapolating the risk which differentiates other types
of data that requires informed consent is a difficult task for many
experts. Relying on patient consent and trust in data protection is not
sufficient for the future of global genomics. Successfully overcoming
these challenges will allow for the use of analysis methods that
otherwise provide vulnerabilities against the protection of private data
[@Li2009Fast], \[GA4GH (https://www.ga4gh.org)\].

# Conclusion
A pipeline of routine exome analysis was outlined. Important points on
tailored analysis are demonstrated. A new method was developed for the
unbiased detection of a protein network, driving disease, based on
potential loss of function variants.

# Command line example code
**Whole exome analysis**

```bash
#!/bin/bash 
############################################ 
#### The basic protocol for analysis. 
#### It is best to set up a loop that 
#### can run the protocol on all samples. 
############################################ 
# Make project organisation folders 
mkdir ~/1.fastq/ && \
mkdir ~/2.trim/ && \
mkdir ~/3.sort/ && \
mkdir ~/4.dedup/ && \
mkdir ~/5.realtar/ && \
mkdir ~/6.indelrealn/ && \
mkdir ~/7.baserecal/ && \
mkdir ~/9.printbam/ && \
mkdir ~/10.gvcf/ && \
mkdir ~/geno/ && \

############################################ 
#### Typical workflow 
############################################ 

############################################ 
#### [command_cut] 
############################################ 
trim_galore -q 20 -fastqc_args \
-outdir ~/2.trim/QC_reports -illumina -gzip \
-o ~/2.trim/ -length 20 -paired \
~/1.fastq/Sequencing_ID_L001_R1_001.fastq.gz \
~/1.fastq/Sequencing_ID_L001_R2_001.fastq.gz && \

############################################ 
#### [command_align] 
############################################ 
bwa mem -t 12 -M ~/ref/human_g1k_v37.fasta \
~/2.trim/Sequencing_ID_L001_R1_001_val_1.fq.gz \
~/2.trim/Sequencing_ID_L001_R2_001_val_2.fq.gz \
-v 1 -R '@RG\tID:Sample_ID\tSM:Sample_ID \
tPL:ILLUMINA\tLB:Sample_ID' \
-M | samtools view -Sb - > ~/2.trim/Sample_ID.bam && \

############################################ 
#### [command_sort] 
############################################ 
java -Xmx8g -jar ~/picard/picard-tools-2.5.0/picard.jar \
SortSam \
I= ~/2.trim/Sample_ID.bam \
O= ~/3.sort/Sample_ID.sort.bam \
SO=coordinate CREATE_INDEX=TRUE && \

############################################ 
#### [command_dedup] 
############################################ 
java -Xmx8g -jar ~/picard/picard-tools-2.5.0/picard.jar \
MarkDuplicates \
I= ~/3.sort/Sample_ID.sort.bam \
O= ~/4.dedup/Sample_ID.sort.dedup.bam \
M= ~/4.dedup/Sample_ID.sort.dedup.metrics \
CREATE_INDEX=TRUE && \

############################################ 
#### [command_realtar] 
############################################ 
java -Xmx6g -jar ~/GATK/GenomeAnalysisTK.jar \
-T RealignerTargetCreator \
-R ~/ref/human_g1k_v37.fasta \
-known ~/ref/1000G_phase1.indels.b37.vcf \
-known ~/ref/Mills_and_1000G_gold_standard.\ indels.b37.sites.vcf \
-I ~/4.dedup/Sample_ID.sort.dedup.bam \
-o ~/5.realtar/Sample_ID.sort.dedup.bam.intervals && \

############################################ 
#### [command_indelrealign]
############################################ 
java -Xmx6g -jar ~/GATK/GenomeAnalysisTK.jar \
-T IndelRealigner \
-R ~/ref/human_g1k_v37.fasta \
-known ~/ref/1000G_phase1.indels.b37.vcf \
-known ~/ref/Mills_and_1000G_gold_standard.\ indels.b37.sites.vcf \
-I ~/4.dedup/Sample_ID.sort.dedup.bam \
-targetIntervals \
~/5.realtar/Sample_ID.sort.dedup.bam.intervals \
-o ~/6.indelrealn/Sample_ID.sort.dedup.indelrealn.bam && \

############################################ 
#### [command_bsqr] 
############################################ 
java -Xmx8g -jar ~/GATK/GenomeAnalysisTK.jar \
-T BaseRecalibrator \
-R ~/ref/human_g1k_v37.fasta \
-knownSites ~/ref/dbSnp146.b37.vcf.gz \
-knownSites ~/ref/1000G_phase1.indels.b37.vcf \
-knownSites ~/ref/Mills_and_1000G_gold_standard.\ indels.b37.sites.vcf \
-o ~/7.baserecal/Sample_ID.sort.dedup.indelrealn.recal.grp \
-I ~/6.indelrealn/Sample_ID.sort.dedup.indelrealn.bam \
-nct 6 && \

############################################ 
#### Optional check for base recalibration 
############################################ 
####  Print reads
############################################ 
java -Xmx12g -jar ~/GATK/GenomeAnalysisTK.jar \
-T PrintReads \
-R ~/ref/human_g1k_v37.fasta \
-I ~/6.indelrealn/Sample_ID.sort.dedup.indelrealn.bam \
-BQSR ~/7.baserecal/Sample_ID.sort.dedup.indelrealn.recal.grp \
-o ~/9.printbam/Sample_ID.sort.dedup.indelrealn.recal.bam \
-disable_indel_quals && \

############################################ 
#### [command_hc] 
############################################ 
java -Xmx8g -jar ~/GATK/GenomeAnalysisTK.jar \
-T HaplotypeCaller -emitRefConfidence GVCF \
-R ~/ref/human_g1k_v37.fasta \
-D ~/ref/dbSnp146.b37.vcf.gz \
-stand_call_conf 30 \
-stand_emit_conf 10 \
-o ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-L ~/ref/SureSelectAllExonV6/S07604514_Regions_b37.bed \
-ip 30 && \
# deprecated -I ~/9.printbam/Sample_ID.sort.dedup.indelrealn.recal.bam

############################################ 
#### [command_joint] 
############################################ 
java -Xmx12g -jar ~/GATK/GenomeAnalysisTK.jar \
-T GenotypeGVCFs \
-R ~/ref/human_g1k_v37.fasta \
-D ~/ref/dbSnp146.b37.vcf.gz -stand_call_conf 30 \
-stand_emit_conf 10 \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-V ~/10.gvcf/Sample_ID.sort.dedup.indelrealn.recal.HC.g.vcf \
-o ~/geno/genotype.vcf -nda -showFullBamList -nt 12 && \

############################################ 
#### Hard filter selecting SNVs 
############################################ 
java -Xmx12g -jar ~/GATK/GenomeAnalysisTK.jar \
-T SelectVariants \
-R ~/ref/human_g1k_v37.fasta \
-selectType SNP \
-variant ~/geno/genotype.vcf \
-o ~/geno/genotype.raw-snps.vcf && \

############################################ 
#### Hard filter selecting INDELs 
############################################ 
java -Xmx12g -jar ~/GATK/GenomeAnalysisTK.jar \
-T SelectVariants \
-R ~/ref/human_g1k_v37.fasta \
-variant ~/geno/genotype.vcf \
-selectType INDEL -selectType MNP \
-o ~/geno/genotype.raw-indels.vcf && \

############################################ 
#### Applying hard filter for SNVs 
############################################ 
java -Xmx8g -jar ~/GATK/GenomeAnalysisTK.jar \
-T VariantFiltration \
-R ~/ref/human_g1k_v37.fasta \
-V ~/geno/genotype.raw-snps.vcf \
-filterExpression QD < 2.0 || FS > 60.0 || MQ < 40.0 ||\
MappingQualityRankSum < -12.5 || ReadPosRankSum < -8.0 \
-filterName snp_hard_filter \
-o ~/geno/genotype.raw-snps.filtered.snvs.vcf && \

############################################ 
#### Applying hard filter for INDELs 
############################################ 
java -Xmx8g -jar ~/GATK/GenomeAnalysisTK.jar \
-T VariantFiltration \
-R ~/ref/human_g1k_v37.fasta \
-V ~/geno/genotype.raw-indels.vcf \
-filterExpression QD < 2.0 || FS > 200.0 ||\
ReadPosRankSum < -20.0 \
-filterName indel_hard_filter \
-o ~/geno/genotype.raw-indels.filtered.indels.vcf && \

############################################ 
#### Combine filtered results 
############################################ 
java -Xmx8g -jar ~/GATK/GenomeAnalysisTK.jar \
-T CombineVariants -R ~/ref/human_g1k_v37.fasta \
-variant ~/geno/genotype.raw-snps.filtered.snvs.vcf \
-variant ~/geno/genotype.raw-indels.filtered.indels.vcf \
-o ~/geno/genotype.fltd-combinedvars.vcf \
-genotypemergeoption UNSORTED && \

############################################ 
#### Filter variants in EdbSNP >/= 1% \
#### and not listed as pathogenic by ClinVar 
############################################ 
perl ~/vcfhacks-v0.2.0/annotateSnps.pl \
-d ~/ref/dbSnp146.b37.vcf.gz ~/ref/clinvar_20160531.vcf.gz \
-f 1 -pathogenic \
-i ~/geno/genotype.fltd-combinedvars.vcf \
-o ~/geno/genotype.fltd-combinedvars.1pcdbsnp.vcf \
-t 12 && \

############################################ 
#### Filter variants in EVS greater >/= 1% 
############################################ 
perl ~/vcfhacks-v0.2.0/filterOnEvsMaf.pl -d ~/ref/evs/ \
-f 1 -progress \
-i ~/geno/genotype.fltd-combinedvars.1pcdbsnp.vcf \
-o ~/geno/genotype.fltd-combinedvars.1pcdbsnp.1pcEVS.vcf \
-t 12 && \

############################################ 
#### Exac filter for population frequency 
############################################ 
perl ~/vcfhacks-v0.2.0/filterVcfOnVcf.pl \
-i ~/geno/genotype.fltd-combinedvars.1pcdbsnp.1pcEVS.vcf \
-f ~/ref/ExAC/ExAC.r0.3.sites.vep.vcf.gz \
-o ~/geno/genotype.fltd-combinedvars.1pcdbsnp.1pcEVS.exac.vcf \
-w -y 0.01 \
-b \
# progress bar \
-t  && \
# number of threads

############################################ 
#### Annotate with variant effect predictor 
############################################ 
perl ~/variant_effect_predictor/variant_effect_predictor.pl \
-offline -vcf -everything \
-dir_cache ~/variant_effect_predictor/vep_cache \
-dir_plugins ~/variant_effect_predictor/vep_cache/Plugins \
-plugin Condel,\
~/variant_effect_predictor/vep_cache/Plugins/config/Condel/config/ \
-plugin ExAC,~/ref/ExAC/ExAC.r0.3.sites.vep.vcf.gz \
-plugin SpliceConsensus \
-fasta \
~/variant_effect_predictor/fasta/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz \
-i ~/geno/genotype.fltd-combinedvars.1pcdbsnp.1pcEVS.exac.vcf \
-o ~/geno/genotype.fltd-combinedvars.1pcdbsnp.1pcEVS.exac.vep.vcf \
-fork 12 && \

############################################ 
#### Confirm samples names 
############################################ 
perl ~/vcfhacks-v0.2.0/getSampleNames.pl \
-i ~/geno/genotype.fltd-combinedvars.1pcdbsnp.1pcEVS.exac.vep.vcf && \


############################################ 
## Data extraction 
############################################ 
#### Extract columns 
############################################ 
#### A list of files for
#### where the data from
#### one column is compiled into
#### a master table 
############################################ 

############################################ 
#### This takes column 3 from every file
#### and appends to the output file.
#### Space delimited. 
############################################ 
awk FNR==1{f++}{a[f,FNR]=$3}END{for(x=1;x<=FNR;x++)\ 
{for(y=1;y<ARGC;y++)printf(%s ,a[y,x]);print }} \
./../*/pheno.txt > master.txt

############################################ 
#### The spacer method can be changed; tab, space, comma, etc.
#### Another way to convert later is with the following command.
#### [The tab character (after s/) must be removed
#### and printed to the command line using ctrl+v then tab.] 
############################################ 
sed 's/ /,/g' input.tsv > output.csv

############################################ 
#### Candidate filter
############################################ 
#### Filter a VCF on a candidate gene list. 
############################################ 
#### List format as X:1-2000,
#### or -b for a bed file or
#### a list file with 1 per line. 
############################################ 
for f in ~/immune.panel/vep/*.vcf do 
perl ~/vcfhacks-v0.2.0/filterVcfOnLocation.pl \
-i ~/immune.panel/vep/$f \
-b ~/deep.panel.bed \
-o ~/immune.panel/filter/$( basename -s .vcf $f ).panel.vcf \
done

############################################ 
#### Post-routine analysis candidate filtering.
#### Similar filtering can be done without going back
#### to analysis stages to create a virtual panel. 
############################################ 
#### Export all gene names and give the count.
sort list.txt | \
uniq -c > InflammatoryDisorderCohortHitCount.txt
#### Format to csv.
#### Cross against a master list of immune genes.

############################################ 
#### In R, import data 
############################################ 
master <- read.csv(./master.csv, stringsAsFactors=FALSE)
InflammatoryDisorderCohortHitCount <- \
read.csv(./ InflammatoryDisorderCohortHitCount.csv, stringsAsFactors=FALSE)

############################################ 
#### Merge the master immune gene list
#### with the Inflammatory disorder cohort hits. 
############################################ 
combine <- merge(master, InflammatoryDisorderCohortHitCount, 
        by = Gene, all = TRUE)

############################################ 
#### Remove the genes that happen to overlap
#### gene of interest and remove anything from
#### the master list that is not in the cohort list. 
############################################ 
clean <- na.omit(combine)

############################################ 
#### Write out the table. 
############################################ 
write.csv(clean, ./GenesOfInterest.csv, row.names = FALSE)

############################################ 
#### The output can be sorted as of interest
#### e.g. autosomal dominant autoinflammatory gene. 
############################################ 

############################################ 
#### Tailored filtering
############################################ 
#### Filter on sample.
#### May need use a -freq option
#### to account for index hopping.
#### Filter on sample removes anything shared
#### with cases (-s) that are not listed but not others (-x). 
############################################ 
perl /home/vcfhacks-v0.2.0/filterOnSample.pl \
-i ~/samples.vep.vcf \
-s case.1 case.2 case.3 -x \
-o ~/samples.getFunctionalVariantsVep.vcf

############################################ 
#### Get variants. 
############################################ 
#### Getting functional variants. The -n flag allows
#### selections only when >2 samples
#### have variants in a shared gene. 
perl /home/vcfhacks-v0.2.0/getFunctionalVariants.pl \
-s case.1 case.2 case.3 \
-i ~/samples.vep.vcf \
-f -n 2 \
-o ~/samples.getFunctionalVariantsVep.SharedGenes.vcf

#### Candidate compound heterozygous.
#### Only variants that are common in ALL -s are considered.
#### Flag -n specifies the number of cases
#### required to return a genotype. 
perl /home/vcfhacks-v0.2.0/findBiallelic.pl \
-i ~/samples.vep.vcf \
-s case.1 case.2 case.3 \
-n 1 \
-o ~/samples.findBiallelic.all.vcf

############################################ 
#### Rank, annontate, and simplify 
############################################ 
perl /home/vcfhacks-v0.2.0/rankOnCaddScore.pl \
-c /data/shared/cadd/v1.3/*.gz \
-i ~/samples.getFunctionalVariantsVep.SharedGenes.vcf \
-o ~/samples.getFunctionalVariantsVep.SharedGenes.cadd.ranked.vcf \
-progress

perl /home/vcfhacks-v0.2.0/geneAnnotator.pl \
-d /home/vcfhacks-v0.2.0/data/geneAnnotatorDb \
-i ~/samples.findBiallelic.all.vcf \
-o ~/samples.findBiallelic.all.gene.anno

perl /home/vcfhacks-v0.2.0/annovcfToSimple.pl \
-i ~/samples.findBiallelic.all.gene.anno \
-vep -gene_anno \
-canonical_only \
-u -contains_variant \
-o ~/samples.findBiallelic.all.gene.anno.simple.xlsx

```
