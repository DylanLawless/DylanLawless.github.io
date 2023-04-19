---
layout: topic
title: Lipidomics - Global Lipid Profiling (RPLC with +/- ESI HRMS/MSMS)
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

* LC-MS - liquid chromatography-mass spectrometry
* RPCL - reverse phase liquid chromatography
* ESI - electro spray ionisation
* HRMS/MSMS - high-resolution mass spectrometry with tandem mass spectrometry

## Introduction

Lipid profiling aims to measure, in an unbiased fashion, as many compounds as possible in biological samples. LC-MS technology is applied to separate and detect lipophilic compounds (see below). Profiling experiments are normally used in the screening/discovery phase of a project and have the potential to reveal insights into biological processes. Besides the identification, those compounds can be quantified (not in absolute values) by MS signal intensity methods. Relative quantitation methods allow comparisons among different conditions/treatments or different sets of samples.

## The Method

C18 based RPLC. We have 3 different SOPs in place to cover the whole range of hydrophobicity. The results are semi-quantitative, providing relative differences between samples. Depending on the sample, we can identify between 1000 and 5000 lipid species on MS1 level and acquiring MS2 for several hundred most abundant ones. Reference standards covering the most important lipid classes are measured routinely as QC alongside.

![image1](https://fgcz.ch/omics_areas/met/applications/gct_1-standard-metabolite-profiling2/_jcr_content/par/fullwidthimage/image.imageformat.1286.1933603290.png)
![image2](https://fgcz.ch/omics_areas/met/applications/gct_1-standard-metabolite-profiling2/_jcr_content/par/fullwidthimage_1727928184/image.imageformat.1286.663528636.png)

## Typical Lipid Classes Covered

- Fatty Acyls [FA] (e.g., fatty acids, Eicosanoids)
- Glycerolipids [GL] (e.g., MG, DG, TG, glyceroglycolipids)
- Glycerophospholipids [GP] (e.g., PE, PC, PA, PG, PS, Cardiolipins)
- Sphingolipids [SP] (e.g., Ceramides, Sphingomyelins)
- Sterol Lipids [ST] (e.g., Sterols, Steroids, Bile acids)
- Prenol Lipids [PR] (e.g., Terpenes)
- Saccharolipids [SL]
- Polyketides [PK] (e.g., Flavonoids)

## The Workflow

1. User Meeting, project discussion, and design
2. Optimized sample extraction (link to Wiki)
3. LCMS acquisition (or IMMS)
4. Data processing (Peak picking, RT correction, alignment, peak annotation): Progenesis QI, Cosmiq
5. Data analysis: Univariate statistics, multivariate data analysis (PCA, BGA), machine learning (PCA, BGA)
6. Search against metabolite databases (HMDB, LipidMaps) or customized libraries
7. Pathway analysis (Metaboanalyst)

## The Output

1. **Primary output**: LC-​MS raw files, which can be inspected by different software packages, either in-​house developed (Cosmiq) or commercially available (Progenesis QI).
2. **Final output**: A series of tables and plots, including:
    - A table with all observed m/z values, the peak areas and normalized peak areas (relative quantification, normalized to the median peak area among all compounds) in each sample.
    - A table with all database matches (identification) for all m/z values.
    - If appropriate, a table with the best scored identifications only and the normalized peak areas in each sample.
    - Multivariate data analysis (supervised between group analysis or BGA) is performed to visualize the clustering of the measured profiles (BGA biplots and heat maps) and to detect the compounds explaining the clustering or group differences (i.e., marker candidates).
    - When required, fold changes and ANOVA p-values, as well as a volcano plot, are added.
3. **File formats**: Tables are usually made available as EXCEL files and the plots as PDF files.
4. **Summary**: Key findings and comments are summarized together with the plots in a Word or PowerPoint document.
5. **Pathway analysis information**: The tables contain information to perform pathway analysis (and more) with the tools available from free web-based tools, e.g., MetaboAnalyst: (http://www.metaboanalyst.ca/).
6. **Results discussion**: Usually, the results will be discussed and explained. In case of resulting publications, method sections can be provided.

## References

This content is largely based on information from ETH Zurich functional genomics center 
<https://fgcz.ch/omics_areas.html>.
