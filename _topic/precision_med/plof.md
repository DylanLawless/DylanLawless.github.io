---
layout: topic
title: Putative loss-of-function
created: 13 Feb 2021
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
[https://doi.org/10.1038/s41586-021-03205-y](https://doi.org/10.1038/s41586-021-03205-y).
pLOF variants were identified using Loss Of Function Transcript Effect Estimator (LOFTEE) v.0.3-beta
{% cite KonradLOFTEE %}
and Variant Effect Predictor (VEP) v.9486
{% cite mclaren2016ensembl %}.
The genomic coordinates of coding elements were based on GENCODE v.2915. Only stop-gained, frameshift and splice-site-disturbing variants annotated as high-confidence pLOF variants were used in the analysis. The pLOF variants with allele frequency > 0.5% or within regions masked due to poor accessibility were excluded from analysis (see Supplementary Information 1.5 for details).

We evaluated the enrichment and depletion of pLOF variants (allele frequency < 0.5%) in gene sets (that is, terms) from Gene Ontology (GO)87,88. For each gene annotated with a particular GO term, we computed the number of pLOF variants per protein-coding base pair, L, and proportion of singletons, S. We then tested for lower or higher mean L and S in a GO term using bootstrapping (1,000,000 samples) with adjustment for the gene length of the protein-coding sequence (CDS): (1) sort all genes by their CDS length in ascending order and divide them into equal-size bins (1,000 genes each); (2) count how many genes from a GO term are in each bin; (3) from each bin, sample with replacement the same number of genes and compute the average L and S; (4) count how many times sampled L and S were lower or higher than observed values. The P values were computed as the proportion of bootstrap samples that exceeded the observed values. The fold change of average L and S was computed as a ratio of observed values to the average of sampled values. We tested all 12,563 GO terms that included more than one gene. The P-value significance threshold was thus ~2 × 10−6. The enrichment and depletion of pLOF variants in public gene databases was tested in a similar way.

## Results
A notable class of variants is the 228,966 putative loss-of-function (pLOF) variants that we observed in 18,493 (95.0%) GENCODE15 genes (Extended Data Table 5 and Supplementary Fig. 12). This class includes the highest proportion of singletons among all of the variant classes that we examined. An average individual carried 2.5 unique pLOF variants. We identified more pLOF variants per individual than in previous surveys based on exome sequencing—an increase that was mainly driven by the identification of additional frameshift variants (Supplementary Table 6) and by a more uniform and complete coverage of protein-coding regions (Supplementary Figs. 13, 14).

We searched for gene sets with fewer rare pLOF variants than expected based on gene size. The gene sets with strong functional constraint included genes that encode DNA- and RNA-binding proteins, spliceosomal complexes, translation initiation machinery and RNA splicing and processing proteins (Supplementary Table 7). Genes associated with human disease in COSMIC17 (31% depletion), the GWAS catalogue18 (around 8% depletion), OMIM19 (4% depletion) and ClinVar20 (4% depletion) all contained fewer rare pLOF variants than expected (each comparison P < 10−4).

References
----------

{% bibliography --cited %}
