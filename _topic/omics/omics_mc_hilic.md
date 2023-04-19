---
layout: topic
title: Metabolomics - Global Metabolite Profiling (HILIC with +/- ESI HRMS/MSMS)
created: 19 Aug 2023
bibliography:
- '../tail/bibliography.bib'
tags: omics
subject: omics
---
{{ page.title }}
================

<!-- * TOC -->
<!-- {:toc} -->

* HILIC - hydrophilic interaction chromatography
* ESI - electro spray ionisation
* HRMS/MSMS - high-resolution mass spectrometry with tandem mass spectrometry

Hydrophilic interaction chromatography (HILIC) is a separation technique for polar compounds. In the context of HILIC, ESI HRMS/MSMS refers to two mass spectrometry techniques used in combination for enhanced compound identification and quantification:

1. **ESI**: Electrospray Ionization is an ionization technique that generates charged droplets of analytes from a liquid solution, facilitating their detection in mass spectrometry. ESI is particularly useful for polar and large biomolecules, making it an ideal ionization method for HILIC-separated compounds.

2. **HRMS/MSMS**: High-Resolution Mass Spectrometry (HRMS) combined with Tandem Mass Spectrometry (MSMS) is an analytical technique that provides precise mass measurements and structural information of compounds. In HRMS/MSMS, the first mass analyzer (MS1) isolates a specific mass-to-charge (m/z) ratio, followed by fragmentation of the selected ion in a collision cell. The resulting fragments are then analyzed by a second mass analyzer (MS2) to obtain structural information. This combination helps in the identification and quantification of compounds separated by HILIC with greater confidence.

HILIC + ESI HRMS/MSMS is an analytical approach that combines electrospray ionization and tandem high-resolution mass spectrometry to provide reliable identification and quantification of polar compounds separated using hydrophilic interaction chromatography.

## Introduction

Metabolite profiling aims to measure various metabolites in biological samples using LC-MS technology. It helps reveal insights into biological processes and allows for the quantification of metabolites using MS signal intensity methods for relative comparisons.

## The Method

BEH amide-based HILIC is used for profiling, with two SOPs covering a wide range of polar metabolites. The results are semi-quantitative, with identifications of 1000-3000 polar metabolite species on MS1 level and MS2 for several hundred abundant ones. Ion mobility (IM) measurements increase the certainty of identifications. Reference standards are routinely measured as QC.

### Typical Metabolite Pathways Covered

- Carbon metabolism
- Biosynthesis of amino acids
- Glycine, serine and threonine metabolism
- Pyrimidine metabolism
- Arginine and proline metabolism
- Cysteine and methionine metabolism
- Purine metabolism
- Tryptophan metabolism
- Others on request

## The Workflow

1. User Meeting, project discussion, and design
2. Optimized sample extraction (link to Wiki)
3. LCMS acquisition (or IMMS)
4. Data processing: Progenesis QI, Cosmiq
5. Data analysis: Univariate statistics, multivariate data analysis (PCA, BGA), machine learning (PCA, BGA)
6. Search against metabolite databases (HMDB, LipidMaps) or customized libraries
7. Pathway analysis [MetaboAnalyst](http://www.metaboanalyst.ca/)

## The Output

1. **Primary output**: LC-MS raw files, which can be inspected by various software packages.
2. **Final output**: A series of tables, including:
    - Peak areas and normalized peak areas for all observed m/z values.
    - Database matches (identification) for all m/z values.
3. **Additional outputs** (generated as needed): 
    - Multivariate data analysis.
    - Fold changes.
    - ANOVA p-values.
    - Volcano plots.
4. **File formats**: Tables and plots are provided in standard formats.
5. **Summary**: Key findings are summarized in a Word or PowerPoint document.
6. **Pathway analysis information**: The data can be used for pathway analysis with free web-based tools like MetaboAnalyst (<http://www.metaboanalyst.ca/>).

## References

This content is largely based on information from ETH Zurich   Functional gnomonics center 
<https://fgcz.ch/omics_areas.html>.
