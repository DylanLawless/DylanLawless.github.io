---
layout: topic
title: Pharmacogenomic stargazing
created: 05 Mar 2021
tags: genomics
subject: Precision medicine
---
{{ page.title }}
================

* TOC
{:toc}

_Note:
Manual curation of gene-drug interaction is not recommended and therefore 
simplification of nomenclature is not advised. 
Relying on star allele labelling goes against the recommended 
[HGVS sequence variant nomenclature](http://varnomen.hgvs.org/recommendations/general/).
The following protocol for is provided as one step in a larger process
of annotation in genomic analysis._

# Stargazer genotyping
As reported in "Sequencing of 53,831 diverse genomes from the NHLBI TOPMed Program" [0],
<!-- taliun2021sequencing -->
Taliun et al. use a method of known pharmacogene (PGx) variation annotation 
that can be adapted for many other drug-gene database applications [0].
The star allele nomenclature method is applied to large scale data to screen 
for possible pharmacogenomic interactions.
This consists of annotation 
with a simple notation for quick recognition of 
allelic variation in genes impacting drug metabolism, disposition and response
(e.g. of interest to clinicians prescribing medications).
The [Pharmacogene Variation (PharmVar)](https://www.pharmvar.org) 
consortium repository is used to label 
human cytochrome P450 (CYP) genes for known PGx variation.

## Methods
Identification of _CYP2D6_ alleles using
[Stargazer's](https://stargazer.gs.washington.edu/stargazerweb/index.html)
genotyping pipeline.
Details of the Stargazer genotyping pipeline have been described previously [1].

_Background note: Haplotypes are group of alleles that are inherited together 
from a single parent. 
They are sequenced from individual DNA strands. 
These strands can be phased to reconstruct the inheritence pattern._

Phased haplotype (from [10Xgenomics.com](https://www.10xgenomics.com)):

<img src="{{ site.baseurl }}{% link images/haplotype.jpeg %}" width="60%">

* GATK-HaplotypeCaller
	+ SNVs and indels in were assessed from a VCF file generated using GATK-HaplotypeCaller [2].
* Phase Beagle
	+ The VCF file was phased using the program [Beagle](https://faculty.washington.edu/browning/beagle/beagle.html) [3] and
	the 1000 Genomes Project haplotype reference panel.
* Star alleles ([described below](#star-alleles))
	+ Phased SNVs and indels were then matched to star alleles.

In parallel,
* GATK-DepthOfCoverage
	+ Read depth was calculated from BAM files using GATK-DepthOfCoverage [2].
* Copy number
	+ Read depth was converted to copy number by performing intra-sample normalization [1].
* Structural variants
	+ After normalization,
	structural variants were assessed by testing all possible pairwise combinations
	of pre-defined copy number profiles
	against the observed copy number profile of the sample.
* Changepoint
	+ For new SVs,
	breakpoints were statistically inferred using changepoint [4].
* Output
	+ Information regarding new SVs was stored and
	used to identify subsequent SVs in copy number profiles.
	+ Output data included individual diplotypes,
	copy number plots and
	a VCF of SNVs and indels that were not used to define star alleles.

## Stargazer summary
From [Stargazer homepage](https://stargazer.gs.washington.edu/stargazerweb/index.html) - quote:

> "Stargazer is a bioinformatics tool for calling star alleles (haplotypes) in PGx genes using data from NGS or SNP array. Stargazer can accept NGS data from both WGS and TS.
> " Stargazer identifies star alleles by detecting SNVs, indels, and SVs. Stargazer can detect complex SVs including gene deletions, duplications, and hybrids by calculating paralog-specific copy number from read depth."

## Star alleles
From [bredagenetics.com](https://bredagenetics.com/star-allele-nomenclature/) - quote:

> "Genetic variants identifiable as pharmacogenomic markers are described by utilizing a special nomenclature, which is not elsewhere used in genetics. It is the so-called star allele nomenclature. In this nomenclature, alleles aren’t identified by their cDNA or genomic position (as it usually happens with all other genetic variants – see HGVS nomenclature), but through the means of numbers and letters, separated from the gene name by a star (star allele nomenclature). For example: CYP3A5*2 identifies the genetic variant in the CYP3A5 gene at the genomic position g.27289C>A, which leads to the amino acid substitution p.T398N. The star allele nomenclature is thought to be faster and easier for non-specialized professionals in identifying important pharmacogenetic alleles, helping them avoid transcription mistakes which may be more frequent by using the standard HGVS nomenclature.

> "Alleles are marked with a star (*).

> "A patient with ultrarapid drug metabolism harbors double or multiple copies of an allele with normal or increased functionality, whereas patients with intermediate or poor drug metabolism have one or more alleles with reduced functionality (these alleles are typically consistent with inactivating mutations or large gene deletions). The term extensive metabolizer is used instead to describe those individuals with two standard copies of the normally functional allele. Extensive metabolizers are therefore carrying the wild-type allele, also called consensus allele, which corresponds to the allele *1 in the star allele nomenclature. The numbers *2, *3, *4 and so on represent alleles with altered functionality which may lead to profiles of increased or reduced drug metabolism.

> "By using one single star allele one can identify not just a single variant, but even a group of variants."

A full list of cytochrome P450 (CYP) alleles with star notation can be found via the
[Pharmacogene Variation (PharmVar)](https://www.pharmvar.org) consortium,
a central repository for PGx variation that focuses on 
haplotype structure and allelic variation.

# Published example
Taliun et al. [0]
provide a complementary approach to _de novo_ genome assembly
by developing approaches that combine multiple types of information including:
* previously observed haplotype variation
* SNVs
* indels
* copy number and
* homology information
to identify and classify haplotypes in interesting regions of the genome.

They illustrate this by focusing on 
one such region around the _CYP2D6_ gene.
This encodes an enzyme that metabolizes approximately 25% of prescription drugs 
and the activity of which varies substantially among individuals [1,5,6].
More than 150 _CYP2D6_ haplotypes have been described,
some involving a gene conversion with its nearby non-functional
but highly similar paralogue _CYP2D7_.

CYP2D6 interaction (from [miro.medium.com](miro.medium.com)):

<img src="{{ site.baseurl }}{% link images/CYP2D6.png %}" width="50%">

They performed _CYP2D6_ haplotype analysis for all 53,831 TOPMed individuals [1,7]
Called a total of 99 alleles (66 known and 33 novel) representing:
* increased function,
* decreased function and
* loss of function (Supplementary Table 12).

Nineteen known alleles and
all novel alleles
were defined by structural variants,
including complex CYP2D6-CYP2D7 hybrids and
extensive copy number variation,
which ranged from zero to eight gene copies (Supplementary Figs. 27, 28).

[figures (S27)](https://static-content.springer.com/esm/art%3A10.1038%2Fs41586-021-03205-y/MediaObjects/41586_2021_3205_MOESM3_ESM.pdf) 
<img src="{{ site.baseurl }}{% link images/FigS27.png %}" width="100%">

> Supplementary Figure 27. Examples of CYP2D6 star alleles (haplotypes) with structural variation detected by the Stargazer program. Each panel displays Stargazer’s copy number profile (left) and allele fraction profile (right) for an individual sample (N=6). Also shown are CYP2D6 diplotypes and phenotype predictions from Stargazer. Gray dots indicate the sample's per-base copy number estimates computed from read depth. The navy solid line and the cyan dashed line represent copy number profiles for each haplotype. The red line represents the copy number profile for both haplotypes combined. Navy dots and cyan dots indicate allele fraction estimates computed from allelic read depth for each haplotype. More examples can be found in the Database of Pharmacogenomic Structural Variants or DPSV \url{https://stargazer.gs.washington.edu/stargazerweb/res/dpsv.html}

[figures (S28)](https://static-content.springer.com/esm/art%3A10.1038%2Fs41586-021-03205-y/MediaObjects/41586_2021_3205_MOESM3_ESM.pdf) 
<img src="{{ site.baseurl }}{% link images/FigS28.png %}" width="100%">

> Supplementary Figure 28. Summary of CYP2D6 haplotype analysis using the Stargazer program. Population-specific frequencies for (A) common CYP2D6 star alleles, (B) haplotype activity, (C) SV-defined haplotypes, and (D) predicted metabolism phenotypes. Abbreviations: hAS, haplotype activity score; dAS, diplotype activity score; N, number; SV, structural variation; del, whole gene deletion; hyb, CYP2D6/CYP2D7 hybrid.

# References
<!-- curly-percent bibliography --cited curly-percent -->
[0]  Taliun, Daniel, et al. Sequencing of 53,831 diverse genomes from the NHLBI TOPMed Program. Nature 590.7845 (2021): 290-299.
[https://doi.org/10.1038/s41586-021-03205-y](https://doi.org/10.1038/s41586-021-03205-y)\

[1] Lee, S.-B. et al. Stargazer: a software tool for calling star alleles from next-generation sequencing data using CYP2D6 as a model. Genet. Med. 21, 361–372 (2019).
[https://doi.org/10.1038/s41436-018-0054-0](https://doi.org/10.1038/s41436-018-0054-0)

[2] McKenna, A. et al. The Genome Analysis Toolkit: a MapReduce framework for analyzing next-generation DNA sequencing data. Genome Res. 20, 1297–1303 (2010).
[https://www.genome.org/cgi/doi/10.1101/gr.107524.110](https://www.genome.org/cgi/doi/10.1101/gr.107524.110)

[3] Browning, S. R. & Browning, B. L. Rapid and accurate haplotype phasing and missing-data inference for whole-genome association studies by use of localized haplotype clustering. Am. J. Hum. Genet. 81, 1084–1097 (2007).

[4] Killick, R. & Eckley, I. A. changepoint: an R package for changepoint analysis. J. Stat. Softw. 58, 1–19 (2014).
[https://eprints.lancs.ac.uk/id/eprint/51975/](https://eprints.lancs.ac.uk/id/eprint/51975/)

[5] Zhou, S.-F. Polymorphism of human cytochrome P450 2D6 and its clinical significance: part I. Clin. Pharmacokinet. 48, 689–723 (2009).

[6] Crews, K. R. et al. Clinical Pharmacogenetics Implementation Consortium guidelines for cytochrome P450 2D6 genotype and codeine therapy: 2014 update. Clin. Pharmacol. Ther. 95, 376–382 (2014).

[7] Lee, S.-B., Wheeler, M. M., Thummel, K. E. & Nickerson, D. A. Calling star alleles with Stargazer in 28 pharmacogenes with whole genome sequences. Clin. Pharmacol. Ther. 106, 1328–1337 (2019).

