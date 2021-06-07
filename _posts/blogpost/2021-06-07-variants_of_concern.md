---
layout: post
title: SARS-CoV-2 variants of concern
created: 07 June 2021
tags: immunology
status: finished
---

{{ page.title }}
================

<p class="meta">07 June 2021</p>

# Variants of concern aligned to vaccine coding sequences

This work has not been peer reviewed.

[Open PDF visualisation - variants_of_concern.pdf](https://github.com/DylanLawless/variants_of_concern_to_vaccine_SARS-CoV2/blob/master/variants_of_concern.pdf)

Variants of concern for five SARS-CoV-2 strains 
([CDC 4 Jun 2021](https://www.cdc.gov/coronavirus/2019-ncov/variants/variant-info.html?CDC_AA_refVal=https%3A%2F%2Fwww.cdc.gov%2Fcoronavirus%2F2019-ncov%2Fcases-updates%2Fvariant-surveillance%2Fvariant-info.html))
are illustrated against the 
translated amino acid sequences of the vaccines; Moderna mRNA-1273 and 
Pfizer/BioNTech BNT-162b2, and reference sequence NC_045512.

The variants are shown here, illustrated on the protein structure;
[6ZOX.pdb DOI: 10.2210/pdb6ZOX/pdb](https://www.rcsb.org/structure/6ZOX)
_Structure of Disulphide-stabilized SARS-CoV-2 Spike Protein Trimer (x2 disulphide-bond mutant, G413C, V987C, single Arg S1/S2 cleavage site),_
provided by Xiong et al., 2020 [10.1038/s41594-020-0478-5](https://www.nature.com/articles/s41594-020-0478-5).

* [6zox_voc_20210604_front.jpg](https://github.com/DylanLawless/variants_of_concern_to_vaccine_SARS-CoV2/blob/master/pdb/renders/6zox_voc_20210604_front.jpg)
* [6zox_voc_20210604_side.jpg](https://github.com/DylanLawless/variants_of_concern_to_vaccine_SARS-CoV2/blob/master/pdb/renders/6zox_voc_20210604_side.jpg)
* [6zox_voc_20210604_top.jpg](https://github.com/DylanLawless/variants_of_concern_to_vaccine_SARS-CoV2/blob/master/pdb/renders/6zox_voc_20210604_top.jpg)

<img src="{{ site.baseurl }}{% link images/posts/6zox_voc_20210604_front.jpg %}" width="100%">

Visual alignment is shown against translated coding sequence for spike glycoprotein,
illustrated here via 
[nextstrain.org](https://nextstrain.org/sars-cov-2).

<img src="{{ site.baseurl }}{% link images/posts/nextstrain_spike.png %}" width="100%">

* Variants of Concern B.1.1.7	
* Variants of Concern B.1.351	
* Variants of Concern B.1.427
* Variants of Concern B.1.429
* Variants of Concern P.1
* Ref NC\_045512.2.21563-25384
* mRNA-1273 vaccine translated
* BNT-162b2 vaccine translated

The assemblies of putative SARS-CoV-2 spike encoding mRNA sequences for vaccines BNT-162b2 and mRNA-1273 have been provided by NAalytics; 
[Assemblies-of-putative-SARS-CoV2-spike-encoding-mRNA-sequences-for-vaccines-BNT-162b2-and-mRNA-1273](https://github.com/NAalytics/Assemblies-of-putative-SARS-CoV2-spike-encoding-mRNA-sequences-for-vaccines-BNT-162b2-and-mRNA-1273).
Their experimental sequence information for the RNA components of the initial 
Moderna (<https://pubmed.ncbi.nlm.nih.gov/32756549/>) 
and Pfizer/BioNTech (<https://pubmed.ncbi.nlm.nih.gov/33301246/>) 
COVID-19 vaccines, allowed them to produce a working assembly of the former 
and a confirmation of previously reported sequence information for the latter RNA.

From this data:

1. The translated amino acid sequences for both vaccines were derived.
2. These were aligned to the SARS-CoV-2 reference amino acid sequence of spike glycoprotein.
3. Known of variants-of-concern were then annotated and visualised.

For visual simplicity, an X symbol was used to illustrate amino acid deletions.
All other amino acid changes use their correct symbol.

# Files

1. README.md
2. [sarscov2\_vaccine\_sequences\_nucleotide.md](https://github.com/DylanLawless/variants_of_concern_to_vaccine_SARS-CoV2/blob/master/pdb/render/sarscov2\_vaccine\_sequences\_nucleotide.md)
3. [sarscov2\_vaccine\_sequences\_translated.md](https://github.com/DylanLawless/variants_of_concern_to_vaccine_SARS-CoV2/blob/master/pdb/render/sarscov2\_vaccine\_sequences\_translated.md)
4. [reference\_sequence\_NC\_045512.2.21563-25384.md](https://github.com/DylanLawless/variants_of_concern_to_vaccine_SARS-CoV2/blob/master/pdb/render/seference\_sequence\_NC\_045512.2.21563-25384.md)
5. [variants\_of\_concern\_to\_vaccine.fa](https://github.com/DylanLawless/variants_of_concern_to_vaccine_SARS-CoV2/blob/master/pdb/render/sariants\_of\_concern\_to\_vaccine.fa)
6. [variants\_of\_concern.xlsx](https://github.com/DylanLawless/variants_of_concern_to_vaccine_SARS-CoV2/blob/master/pdb/render/sariants\_of\_concern.xlsx)
7. [variants\_of\_concern.csv](https://github.com/DylanLawless/variants_of_concern_to_vaccine_SARS-CoV2/blob/master/pdb/render/sariants\_of\_concern.csv)
8. [variants\_of\_concern\_to\_vaccine.fa](https://github.com/DylanLawless/variants_of_concern_to_vaccine_SARS-CoV2/blob/master/pdb/render/sariants\_of\_concern\_to\_vaccine.fa)
9. [variants\_of\_concern\_to\_vaccine.praln](https://github.com/DylanLawless/variants_of_concern_to_vaccine_SARS-CoV2/blob/master/pdb/render/sariants\_of\_concern\_to\_vaccine.praln)
10. [variants\_of\_concern\_to\_vaccine.pdf](https://github.com/DylanLawless/variants_of_concern_to_vaccine_SARS-CoV2/blob/master/pdb/render/sariants\_of\_concern\_to\_vaccine.pdf)

# Vaccine sequences and amino acid translations
The vaccine nucleotide sequence data
for vaccines BNT-162b2 and mRNA-1273 (sourced from [NAalytics](https://github.com/NAalytics/Assemblies-of-putative-SARS-CoV2-spike-encoding-mRNA-sequences-for-vaccines-BNT-162b2-and-mRNA-1273).
was converted to text and slightly formatted to select the coding sequences,
as shown in file:

2. sarscov2\_vaccine\_sequences\_nucleotide.md.

The nucleotide sequences were then translated into amino acid coding sequences,
as shown in file:

3. sarscov2\_vaccine\_sequences\_translated.md.

The nucleotide sequence was translated via <https://web.expasy.org/translate/>.

# Reference genome sequence
The reference data was sourced from:
* Severe acute respiratory syndrome coronavirus 2 isolate Wuhan-Hu-1, complete genome
* NCBI Reference Sequence: NC\_045512.2

via <https://www.ncbi.nlm.nih.gov/nuccore/NC_045512>,
as shown in file:

4. reference\_sequence\_NC\_045512.2.21563-25384.md.

# Vaccine Multiple Sequence Alignment
The amino acid sequences of the coding region from each of the vaccine sequences 
and the reference sequence were used for multiple sequence alignment
via <https://www.ebi.ac.uk/Tools/msa/clustalo/>.

Variants of concern were then formatted to be used for annotation on the 
aligned sequences.

# Variants of concern
SARS-CoV-2 Variant Classifications and Definitions were derived from 
<https://www.cdc.gov/coronavirus/2019-ncov/variants/variant-info.html?CDC_AA_refVal=https%3A%2F%2Fwww.cdc.gov%2Fcoronavirus%2F2019-ncov%2Fcases-updates%2Fvariant-surveillance%2Fvariant-info.html>

This dataset includes:

* Variants of Interest (VOI)
* Variants of Concern (VOC)
* Variants of High Consequence (VOHC)

The reformatted tables are presented in files:

5. variants\_of\_concern.xlsx
6. variants\_of\_concern.csv

There are currently no VOHC. 
VOC (but not VOI) were presented in the final visualisation.

# Aligned variants of concern to vaccine

The variants of concern were formatted such that one pseudo-fasta format entry 
contains the amino acid change for each strain. 
This data was then added to the multiple sequence alignment file to allow for
aligned annotations,
as shown in file:

8. variants\_of\_concern\_to\_vaccine.fa

The file contains the list the variants-of-concern for five Sars-CoV-2 strains,
1 reference sequence, and
2 vaccine sequences:

* Variants of Concern B.1.1.7	
* Variants of Concern B.1.351	
* Variants of Concern B.1.427
* Variants of Concern B.1.429
* Variants of Concern P.1
* Ref NC_045512.2:21563-25384
* mRNA-1273 vaccine translated
* BNT-162b2 vaccine translated

# Other notes
Different strains will contain benign variants.
Typically, full sequences are used for alignment. 
However, this can be visually distracting.
Instead, only the variants-of-concern are annotated for the strain sequences. 

The final illustration was made using <https://www.snapgene.com> software.
The snapgene-software formatted output can be loaded with the file:

9. variants_of_concern_to_vaccine.praln

The final PDF version is shown in file:

10. variants\_of\_concern\_to\_vaccine.pdf

[Open PDF visualisation - variants_of_concern.pdf](https://github.com/DylanLawless/variants_of_concern_to_vaccine_SARS-CoV2/blob/master/variants_of_concern.pdf)
