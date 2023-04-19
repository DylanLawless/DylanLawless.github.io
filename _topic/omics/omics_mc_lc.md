---
layout: topic
title: Metabolomics - LC-MS-based Metabolite/Lipid Analysis
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

LC-MS - liquid chromatography-mass spectrometry

## Introduction

LC-MS technology is the main platform employed at the FGCZ for untargeted metabolomics, where the aim is measuring, in an unbiased fashion, as many metabolites and lipids as possible in biological samples. LC-MS-based metabolite and lipid profiling experiments are normally used in the screening/discovery phase of a project and have the potential to reveal insights into biological processes. The metabolite analysis is especially suitable to unravel energy metabolism pathways, such as:

- TCA intermediates
- Glycolysis
- Pentose phosphate pathway metabolites
- Amino acids

The lipid profiling covers several lipid classes, including:

- Free fatty acid
- Bile acid
- (Lyso-)phosphatidylcholine
- Phosphatidylglycerol

Besides their identification, those metabolites and lipids can be quantified (not in absolute values) by MS signal intensity methods. Most of these approaches are relative quantitation methods that can provide comparisons among different conditions or different sets of samples.

## The Method

Untargeted metabolite and lipid analysis is performed on a wide range of samples, from cells to biological fluids or tissues, with minimum sample handling and relatively easy protocols. Most commonly, we recommend an extraction with 80% methanol, but the protocols can be optimized to enhance the recovery of certain types of metabolites. For LC-MS analysis, the FGCZ has established two SOPs:

1. One tailored for the global screening of polar metabolites
2. The other for hydrophobic metabolites, mainly lipids

We have two instrumentations in place for LC-MS metabolomics:

- Q-TOF SYNAPT G2 HDMS (Waters)
- Q-Exactive (Thermo)

Both are operating in ESI positive or negative mode, coupled with a nano-ACQUITY UPLC System (Waters). Each batch of samples is complemented with blanks and QC samples. Identification and confirmation of compound identities are supported by the Human Metabolome Database, KEGG, and Lipid Maps. Quantitative data analysis is based on:

- QuanLynx module of the Waters software MassLynx 4.1
- QuanBrowser of Xcalibur software
- Skyline
- Progenesis QI from NonLinear Dynamics
- Open source R Bioconductor package Cosmiq of the FGCZ

## The Output

1. **Primary output**: LC-MS raw files, which can be inspected by different software packages, either in-house developed (Cosmiq) or commercially available (Progenesis QI).
2. **Final output**: A series of tables and plots, including:
    - A table with all observed m/z values, the peak areas and normalized peak areas (relative quantification, normalized to the median peak area among all compounds) in each sample.
    - A table with all database matches (identification) for all m/z values.
    - If appropriate, a table with the best scored identifications only and the normalized peak areas in each sample.
    - Multivariate data analysis (supervised between group analysis or BGA) is performed to visualize the clustering of the measured profiles (BGA biplots and heat maps) and to detect the compounds explaining the clustering or group differences (i.e., marker candidates).
    - When required, fold changes and ANOVA p-values, as well as a volcano plot, are added.
3. **File formats**: Tables are usually made available as EXCEL files and the plots as PDF files.
4. **Summary**: Key findings and comments are summarized together with the plots in a Word or PowerPoint document.
5. **Pathway analysis information**: The tables contain information to perform pathway analysis (and more) with the tools available from free web-based tools, e.g., MetaboAnalyst: (<http://www.metaboanalyst.ca/>).


[image](https://fgcz.ch/omics_areas/met/applications/lcms-dda-of-metabolites---lipids/_jcr_content/par/fullwidthimage/image.imageformat.1286.1268936638.jpg)

## References

This content is largely based on information from ETH Zurich functional genomics center 
<https://fgcz.ch/omics_areas.html>.
