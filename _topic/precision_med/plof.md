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
## Methods
As reported in "Sequencing of 53,831 diverse genomes from the NHLBI TOPMed Program"
[https://doi.org/10.1038/s41586-021-03205-y](https://doi.org/10.1038/s41586-021-03205-y) [0].
<!-- taliun2021sequencing -->
pLOF variants can be identified using Loss Of Function Transcript Effect Estimator (LOFTEE) v.0.3-beta [1]
<!-- curly-percent cite KonradLOFTEE curly-percent ccurly-percent cite mclaren2016ensembl curly-percent -->
and Variant Effect Predictor (VEP) v.9486 [2].
The genomic coordinates of coding elements may be based on GENCODE v.2915 [3].
<!-- frankish2019gencode -->
In Taliun et al, only stop-gained, 
frameshift and 
splice-site-disturbing variants annotated as high-confidence pLOF variants were used in the analysis.
Additionally, to ignore variants that are likely of minor consiquence to human health, 
pLOF variants with allele frequency > 0.5% or 
within regions masked due to poor accessibility were excluded from analysis.

In variant annotation, VEP supplies a "consequence" column.
Consequences are general and based on translation of genetic code in humans. 

The Loss-of-function (LoF) consequence is the simplest example (splice, stop mutations).
For the topic of variant collapsing, used in areas such as burden testing, 
variant consequence defines which variants can be included in analsys since they are _interpretable_ or of ostensibly _known significance_ [4].
<!-- povysil2019rare -->
This could introduce spurious results so it is  best to have a solid criteria for selecting consiqueses of interest. 
The consequences provided by VEP are too long to discuss in detail. 
The table from the ensembl website is worth reading:
[Url ensembl variant prediction consequences](https://grch37.ensembl.org/info/genome/variation/prediction/predicted_data.html#consequences).


We evaluated the enrichment and depletion of pLOF variants (allele frequency < 0.5%) in gene sets (that is, terms) from Gene Ontology (GO)87,88. For each gene annotated with a particular GO term, we computed the number of pLOF variants per protein-coding base pair, L, and proportion of singletons, S. We then tested for lower or higher mean L and S in a GO term using bootstrapping (1,000,000 samples) with adjustment for the gene length of the protein-coding sequence (CDS): (1) sort all genes by their CDS length in ascending order and divide them into equal-size bins (1,000 genes each); (2) count how many genes from a GO term are in each bin; (3) from each bin, sample with replacement the same number of genes and compute the average L and S; (4) count how many times sampled L and S were lower or higher than observed values. The P values were computed as the proportion of bootstrap samples that exceeded the observed values. The fold change of average L and S was computed as a ratio of observed values to the average of sampled values. We tested all 12,563 GO terms that included more than one gene. The P-value significance threshold was thus ~2 × 10−6. The enrichment and depletion of pLOF variants in public gene databases was tested in a similar way.

## Results
A notable class of variants is the 228,966 putative loss-of-function (pLOF) variants that we observed in 18,493 (95.0%) GENCODE15 genes (Extended Data Table 5 and Supplementary Fig. 12). This class includes the highest proportion of singletons among all of the variant classes that we examined. An average individual carried 2.5 unique pLOF variants. We identified more pLOF variants per individual than in previous surveys based on exome sequencing—an increase that was mainly driven by the identification of additional frameshift variants (Supplementary Table 6) and by a more uniform and complete coverage of protein-coding regions (Supplementary Figs. 13, 14).

We searched for gene sets with fewer rare pLOF variants than expected based on gene size. The gene sets with strong functional constraint included genes that encode DNA- and RNA-binding proteins, spliceosomal complexes, translation initiation machinery and RNA splicing and processing proteins (Supplementary Table 7). Genes associated with human disease in COSMIC17 (31% depletion), the GWAS catalogue18 (around 8% depletion), OMIM19 (4% depletion) and ClinVar20 (4% depletion) all contained fewer rare pLOF variants than expected (each comparison P < 10−4).

References
----------
<!-- curly-percent bibliography --cited curly-percent -->
[0]  Taliun, Daniel, et al. "Sequencing of 53,831 diverse genomes from the NHLBI TOPMed Program." Nature 590.7845 (2021): 290-299.
[1] KonradLOFTEE
[2] mclaren2016ensembl
[3] Frankish, A. et al. GENCODE reference annotation for the human and mouse genomes. Nucleic Acids Res. 47 (D1), D766–D773 (2019).
[4] Povysil, Gundula, et al. "Rare-variant collapsing analyses for complex traits: guidelines and applications." Nature Reviews Genetics 20.12 (2019): 747-759.
