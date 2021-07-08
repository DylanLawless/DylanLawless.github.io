---
layout: post
title: Multiple transcript variant
created: 07 July 2021
tags: statistics
status: finished
---

{{ page.title }}
================

<p class="meta">07 July 2021</p>

## Introduction
A colleague asked me about why there are multiple mRNA transcripts with different variant positions from a single variant in human genomic DNA.
Here is a short summary to answer that question (forgiving over-simiplifications).
First, a quick recap of how DNA is used to protuce proteins.
Then an example of a gene where the mRNA could be spliced more than one way by the splisosome complex.

## DNA to protein
1. Genomic DNA (only one version per cell/individual).
2. Transcription to pre-mRNA (one exact copy of DNA as mRNA).
3. Splicing pre-mRNA to mRNA transcript (introns removed by splisosome). One version or several slightly different versions. 
4. Spliced mRNA (messenger mRNA) translated into amino acid peptide chain.
5. Peptide chain folds into protein.

Genomic DNA is transcripted over and over, in every cell (ignoring tissue-speicif expression, dynamics, etc.).
When the pre-mRNA is spliced, there may be multiple versions produced.
It all depends on how the splicing complex recognizes the intron/exon sequences. 
This also explains why _splice mutations_ occur in 4-5 the nucleotides around the junction between exon and intron. 
The is the part of the sequence that is recognised by the splisosome. 

[image0](https://www.researchgate.net/profile/Alen-Faiz/publication/224006658/figure/fig3/AS:203040918380546@1425420135624/Transcripts-from-a-single-gene-can-undergo-different-splicing-events-When-mRNA-is_W840.jpg)

[image1](http://fig.cox.miami.edu/~cmallery/255/255hist/mcb4.1.dogma.jpg)

## Transcript example 
Transcript [1]
[link to ensemble/UBE2W-207](https://www.ensembl.org/Homo_sapiens/Transcript/Exons?db=core;g=ENSG00000104343;r=8:73780097-73878910;t=ENST00000650817)

* Transcript UBE2W-207 ENST00000602593.6 8379bp 151aa.
* Exon 1 is 103 nucleotides.
* position start 73,878,910	end 73,878,808.

Transcript [2]
[link to ensemble/UBE2W-208](https://www.ensembl.org/Homo_sapiens/Transcript/Exons?db=core;g=ENSG00000104343;r=8:73780097-73878910;t=ENST00000602593)

* Transcript UBE2W-208 ENST00000650817.1 8459bp	191aa.
* Exon 1 is 55 nucleotides.
* position start 73,878,862	end 73,878,808.

# Mutation example
A DNA mutation at position g.73,878,863 A>T

This mutation will only affect transcript [2] at
cDNA (mRNA) position c.2A>T
and protein position p.Met1Leu.

Transcript [1] is not affected because the coding sequence begins later in the DNA sequence. 

# cDNA note
The cDNA position notation is used for simplicity. 
We assume the parts of genomic DNA that will remain after splicing (introns and upstream/downstream sequences removed), and call this the coding DNA (cDNA).
We can physically create cDNA when we collect mRNA from a cell and do reverse Transcription PCR (RT-PCR) to make a DNA copy.

[image2](https://www.mun.ca/biology/desmid/brian/BIOL2060/BIOL2060-21/21_22.jpg)
[image3](https://i.servimg.com/u/f21/17/30/76/23/splice10.png)
