---
layout: topic
title: Quantification of pLoF
created: 12 Feb 2021
tags: genomics
subject: Precision medicine
---
{{ page.title }}
================

* TOC
{:toc}

# Identification of pLoF variants
As reported in "Sequencing of 53,831 diverse genomes from the NHLBI TOPMed Program" [0],
<!-- taliun2021sequencing -->
predicted loss-of-function (pLoF) variants can be identified using 
<!-- curly-percent cite KonradLOFTEE curly-percent ccurly-percent cite mclaren2016ensembl curly-percent -->
Variant Effect Predictor (VEP) [1]
and Loss Of Function Transcript Effect Estimator (LOFTEE) [2],
with accurate genomic coordinates from GENCODE [3].
An erichment of share biological function in affected genes can then be tested using Gene Ontology (GO) [4].

A note here about the pLoF acronym.
I believe the "p" was originally for _predicted_ loss-of-function,
and has more recently changed to _putative_ loss-of-function.
The former is more transparent and preferable, I believe.

## Variant Effect Predictor 
Generally a local version of
[Variant Effect Predictor](http://grch37.ensembl.org/Homo_sapiens/Tools/VEP/) 
(VEP) software and databases are run for analysis.
However, one can try out the online version using the ensembl VEP URL.
An example output is shown here:\
<img src="{{ site.baseurl }}{% link images/VEP_example.png %}" width="100%">\
\
An obvious error that can occur is using mismatched genome builds.
Make certain that you use the same reference genome as used on the input data.
The Ensembl/VEP website URL should be for the same genome build (grch37, or the default GRCh38).
Local software and databases will also use the appropriate versions.

In variant annotation, VEP supplies a "consequence" column.
Consequences are general and based on translation of genetic code in humans. 
The Loss-of-function (LoF) consequence is the simplest example (splice, stop mutations).
For the topic of variant collapsing, used in areas such as burden testing, 
variant consequence defines which variants can be included in analsys since they are _interpretable_ or of ostensibly _known significance_ [4].
<!-- povysil2019rare -->
This could introduce spurious results so it is  best to have a solid criteria for selecting consiqueses of interest. 
The consequences provided by VEP are too long to discuss in detail. 
The table from the ensembl website is worth reading:
[Ensembl Variation - Calculated variant consequences](https://grch37.ensembl.org/info/genome/variation/prediction/predicted_data.html#consequences).\
<img src="{{ site.baseurl }}{% link images/VEP_consequences.jpg %}" width="100%">

## LOFTEE
The [LOFTEE github](https://github.com/konradjk/loftee) repo shows the code and examples of usage.
It functions as a VEP plugin for 3 LoF consequences: 
* stop-gained
* frameshift variants
* splice site disrupting

There are some additional smart features that make LOFTEE more useful than simply the VEP consequences.
These include known features about how transcripts will be affected by variants 
(e.g. stop variants near the end of a transcript),
known splicing sequence mechanisms,
and other flags including splicing prediction that may be less reliable but still valuable.

## GENCODE
Accurate annotation depends on correctly mapping positions based on the genome reference.
The genomic coordinates of coding elements may be based on [GENCODE](https://www.gencodegenes.org/human/) 
[3].
<!-- frankish2019gencode -->

## Gene Ontology (GO)
One of the main uses of [Gene Ontology (GO)](http://geneontology.org) is to perform enrichment analysis on gene sets. 
For example, given a set of genes that are up-regulated under certain conditions, 
an enrichment analysis will find which GO terms are over-represented (or under-represented) using annotations for that gene set.
This discription was taken directly from 
[geneontology.org](http://geneontology.org/docs/go-enrichment-analysis/) where a longer explanation is shown. 
Using the web interface, an example query for 4 genes from the VDJ recombination pathway were queried.
The output is shown here. 
The reference database has 20595 IDs. 
My 4 gene IDs were then tested for all known interacrtions - the number of shared GO terms.
There were 9038 terms checked in total.
The output table shows the GO process "V(D)J recombination" as the strongest assocciation;
* all 4 genes shared this process 
* for 4 random genes we would expect none to share the same GO process

The fold enrichment and strong P-value indicate a true assocciation of shared biological pathway.\
<img src="{{ site.baseurl }}{% link images/GO_enrich.png %}" width="100%">

# Published example
In Taliun et al [0], each of these tools are used in their analysis to target variants: 
* stop-gained
* frameshift
* splice-site-disturbing variants 
	+ annotated as high-confidence pLOF
* remove pLOF with allele frequency > 0.5%
* remove pLOF within regions masked due to poor accessibility

These last two additionally ignore variants that are likely of minor consiquence to human health but still pased the basic pLoF filter. 

Taliun et al. evaluated enrichment and depletion of pLOF variants 
(allele frequency < 0.5%) in gene sets (that is, terms) from Gene Ontology (GO)87,88.
For each gene annotated with a particular GO term, 
they computed the number of pLOF variants per 
protein-coding base pair, L, 
and proportion of singletons, S.
They then tested for lower or higher mean L and S in a GO term 
using bootstrapping (1,000,000 samples) 
with adjustment for the gene length of the protein-coding sequence (CDS): 
1. sort all genes by their CDS length in ascending order and divide them into equal-size bins (1,000 genes each);
2. count how many genes from a GO term are in each bin;
3. from each bin, sample with replacement the same number of genes and compute the average L and S;
4. count how many times sampled L and S were lower or higher than observed values. 

The P values were computed as the proportion of bootstrap samples that exceeded the observed values. 
The fold change of average L and S was computed as a ratio of observed values 
to the average of sampled values. 
We tested all 12,563 GO terms that included more than one gene. 
The P-value significance threshold was thus ~2 x 10-6. 
The enrichment and depletion of pLOF variants in public gene databases was tested in a similar way.

## Results
A notable class of variants is the 228,966 putative loss-of-function (pLOF) variants that we observed in 18,493 (95.0%) GENCODE15 genes (Extended Data Table 5 and Supplementary Fig. 12). This class includes the highest proportion of singletons among all of the variant classes that we examined. An average individual carried 2.5 unique pLOF variants. We identified more pLOF variants per individual than in previous surveys based on exome sequencing—an increase that was mainly driven by the identification of additional frameshift variants (Supplementary Table 6) and by a more uniform and complete coverage of protein-coding regions (Supplementary Figs. 13, 14).

We searched for gene sets with fewer rare pLOF variants than expected based on gene size. The gene sets with strong functional constraint included genes that encode DNA- and RNA-binding proteins, spliceosomal complexes, translation initiation machinery and RNA splicing and processing proteins (Supplementary Table 7). Genes associated with human disease in COSMIC17 (31% depletion), the GWAS catalogue18 (around 8% depletion), OMIM19 (4% depletion) and ClinVar20 (4% depletion) all contained fewer rare pLOF variants than expected (each comparison P < 10−4).

References
----------
<!-- curly-percent bibliography --cited curly-percent -->
[0]  Taliun, Daniel, et al. "Sequencing of 53,831 diverse genomes from the NHLBI TOPMed Program." Nature 590.7845 (2021): 290-299.
[https://doi.org/10.1038/s41586-021-03205-y](https://doi.org/10.1038/s41586-021-03205-y) \
[1] mclaren2016ensembl\
[2] KonradLOFTEE\
[3] Frankish, A. et al. GENCODE reference annotation for the human and mouse genomes. Nucleic Acids Res. 47 (D1), D766–D773 (2019).\
[4] Povysil, Gundula, et al. "Rare-variant collapsing analyses for complex traits: guidelines and applications." Nature Reviews Genetics 20.12 (2019): 747-759.\
