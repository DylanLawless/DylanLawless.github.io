---
layout: post
title: Websites for basic genetic variant information
created: 27 Feb 2012
tags: statistics, genomics
status: finished
---

{{ page.title }}
================

<p class="meta">26 Apr 2020</p>

1. [Introduction](#introduction)

# Introduction
Identifying pathogenic variants with whole genome and whole exome sequencing is not simple.
Determining the correct filtering method can take some time but it is not the most difficult task.
Validating genetic factors is generally the most time consuming part of this type of research. 
Here is a compilation of some of the websites and resources that I use constantly.
I will begin this simply as a list but continue to contribute information on how to use all of these over time.
I use most of the listed resources daily.
There are several steps in assessing if a gene variant is a good candidate to explain a clinical phenotype.
Often a clear story can be made between the genetic mutation and the resulting phenotype.
Other times (usually) a genetic finding (particularly biallelic mutations) seem to have a direct link to the clinical phenotype but it can take  weeks-months to functionally validate such a finding.
 With that in mind, it is good to have some sort of routine way to quickly assess the possible pathogenicity of a mutation by hand.
I will mostly discuss these in the context of rare mutations which are likely to be under selective pressure and occur at very low frequencies in a healthy population.
 Sites and tools for getting basic genetic information For assessing rare variants Ensembl and Exac (now gnomAD) are my bread and butter.
I haven't done it yet but I need to set up a hotkey to open a browser with both of these sites simultaneously.
To demonstrate how I like to use these we could use an example. Lets say we have NGS results for a patient with immunodeficiency with coding variants in the gene RAG2.
OK, well known gene, important for antibody production as wells as TCR and BCR development.
Looks good so far.
Let's see if the variants are common SNPs or could they be likely to cause damage if they are not reported (of course this is in your pipeline automatically but it's good practice and takes less than 60 seconds; valuable if there is a real person affected by your results).
 After a long time getting confused about transcripts and coordinates, I now know how important it is to accurately report coordinates so there is no confusion if collaborating or reporting the mutations etc. Jump over to Exac.
[Exac.org](http://exac.broadinstitute.org)
 This is in a nutshell, the exomes of ~ 60,000 individuals which can be used to view how frequently mutations occur in the general population (unfortunately it is mostly just European but there is some global representation). Exac is vital for checking coding variants.
It covers some of the intronic regions (exon intron splice sites) and some of the upstream and downstream regions.
This is typical for anyone who does whole exome sequencing.
 We mentioned confusion about transcripts and coordinates, Exac automatically loads the coverage as shown for the canonical transcript. Stick with this transcript for reporting or at least for your own notes.
When you head over to Ensembl grab the same one in the transcript table. Update! [The Genome Aggregation Database (gnomAD) is online](http://gnomad.broadinstitute.org/about). This data set is the combination of "123,136 exomes and 15,496 genomes from unrelated individuals" which has "removed individuals known to be affected by severe pediatric disease, as well as their first-degree relatives."
This is n extremely exciting resource. If you are familiar with Exac then you will know the value of this expansion into gnomAD. [youtube.com](https://youtu.be/_uRuFZv4JaU) [Ensembl](http://www.ensembl.org/index.html) Any good pipeline will have annotation of the details for any coding variants but it can be pretty valuable to go and look at these again by hand.
It doesn't take long but can end up saving time in the long run.
If you do it often, the first check on Exac take less than 60 seconds.
The next check on Ensemble will only take 2-3 minutes.
In the quick search I plug in the gene name, luckily for my stuff the top hit is always the human gene (sorry Alpaca researchers).
When you get to the gene page first click is always "Show transcript table."
If you are lucky there is only one coding transcript like for RAG2.
Most of the time there are about 6 transcripts of wildly varying lengths just to confuse matters.
Go for the transcript ID of the canonical transcript which you noted on Exac.
If you do so then life will be easier when you go to check the coordinates. 
On the left hand side in the table "Transcript-based displays" click "cDNA" shown under "Sequence".
You can then search through to find the variant and amino acid to see if everything lines up.
You see the cDNA position and amino acid positions overlaid. If you were to pick a different transcript then of course the coordinates are likely to be different.
From here I usually go back to the table on the left of the screen to search Exons.
This obviously just lays out the exon sequences  in blocks along with useful information.
Only a small segment of the introns are displayed.
If you want reference sequences of multiple types just find the down load sequence button and chose FASTA and decide which type you want to display. You would likely have the information based on the annotated NGS data but you may want to look at the different transcripts and Ensembl is the best option. So far (in just a couple of minutes) you could have looked up the allele frequencies, affect of mutation on different transcripts and check that everything that should be reported from the NGS output matches up.
My next step is to check if these variants a already reported.
Everyone has their favourite method, searching PubMed etc. For my topics OMIM often produces good results and a quick search. [Online Mendelian Inheritance in Man](https://www.omim.org/)
This is a curated database and is generally very good.
Hopefully it continues to grow for a long time into the future.
Depending on how much you already know about your gene it is sometimes helpful to jump straight down to the "Allelic variants" section (if one is present).
You may find a few variants already reported with a similar phenotype being described as your case.
You may find the exact mutations already reported.
If this is the case then it is likely that it would have taken a few minutes longer to find the same cases on one of the other databases.
Whether you have found that there are many mutations reported similar to those that interest you or if you have found nothing reported so far, my next step is always to run through UniProt.
[UniProt](http://www.uniprot.org)
UniProt is so rich in information that there is no need to expnad on it here.
If you have never used it then just pick your favourite protein and go look it up now.
There is (usually) a combination of nearly everything you need to get a quick overview of a protein.
Gene function, functional domains, known variants, reported knockouts/mutagenesis studies, protein structures, expression, localisation, the list goes on.
Actually, as much as I love PDB, I find that using UniProt is usually quicker to check for available PDB protein structures before actually going to PDB to download from the source.
With these four websites one would likely be able to decide how confident you are about a candidate mutation/s.
At least if you are just looking coding variants.
Assessing non-coding regions is much messier business.
From here on in validation of a mutation can require a widely variable amount of functional work.
One thing is certain however, Sanger sequencing will be needed to confirm your NGS finding. [youtube.com](https://www.youtube.com/watch?v=3amsDkyiMu8) [Autoprimer3](https://github.com/gantzgraf/autoprimer3/releases/tag/v3.0.2)
Autoprimer3 is an excellent application that you can use to design primers for a gene of interest.
It is super quick for producing primers to be used on genomic DNA for "any UCSC genome and design PCR/sequencing primers to genes or genome coordinates".
As an example I timed myself to see how long it takes to get a primer list for all exons of the gene RAG2 and a reference sequence from default genomic coordinates on hg38 while avoiding SNPs based on dbsnp142.
It took me 46 seconds to open the application and produce a primer list and reference sequence.
Less than 1% of the time I may have to go and redesign a primer manually because of an awkward sequence or a patient's DNA may have some uncommon variant at the primer site. 
Depending on which supplier you order oligos from, Sanger sequencing to confirm a variant by found during NGS can be done within 3 days; about 90 seconds to design and order the oligos, a day or 2 until they are delivered,  and a day to PCR and sequence.
The explanation may be a bit long winded here but this app is excellent.
Just give it a try if you do any routine PCR or sequencing for coding variant.
As the name suggests, it is a simple version of Primer3 but super quick.
[Genome Analysis Toolkit: Variant Discovery in High-Throughput Sequencing Data.](https://software.broadinstitute.org/gatk/)
GATK most useful to jump straight to: [Tool Documentation Index](https://software.broadinstitute.org/gatk/documentation/tooldocs/) Genome hg38 [(TCR region as example)](http://genome.ucsc.edu/cgi-bin/das/hg38/dna?segment=chr7:142299011,142813287)
[GPGtools](https://gpgtools.org)
for sending sensitive patient info.
[GnuPG](https://www.gnupg.org) is GPL licensed alternative to the PGP suite for sending sensitive patient info.
See also Pretty good privacy for academic data. [Human splice finder](http://www.umd.be/HSF3/HSF.html) Illumina-Pipeline-V2 ("Version 2 of Illumina pipeline that incorporates [CASAVA 1.8")](https://github.com/nirav99/Illumina-Pipeline-V2/blob/master/IlluminaPipelineCASAVA1_8.pdf) Sequence Manipulation Suite http://www.coccidia.icb.usp.br/sms2/index.html
Sequence Ontology http://www.sequenceontology.org
UCSC Genome Bioinformatics FAQ https://genome.ucsc.edu/FAQ/FAQformat
UCSC Table Browser https://genome.ucsc.edu/cgi-bin/hgTables
MutScan - https://github.com/OpenGene/MutScan
Detect and visualise target mutations by scanning FastQ files directly. Very useful if you are interested in some certain mutations but saves the time it would take to normally through your pipeline. 
## Communities and learning
No need to reinvent the wheel here. Stephen Turner has a better list of resources than I will produce with his post "Staying Current in Bioinformatics & Genomics: 2017 Edition." 
http://www.gettinggeneticsdone.com/2017/02/staying-current-in-bioinformatics-genomics-2017.html
Essentially it boils down to the journals, Twitter, some expert blogs, and several genomics communities.
The journals and other sites I like to follow are detailed here. When all directed into a single feed I think it produces an essential resource for most genetics/bioinformatics scientists.
Literature of Interest - In this post I show the use of Feedly to condense all the litereature that I follow into a single source and allow the option to view by category.

## Machine learning and cloud computing
In this post I have started to gather some of the resources I like to use and topics that I find interesting.
Some other links tagged on at the end:
BioStarts - Bioinformatics academic community https://www.biostars.org
Useful bash Bioinformatics one-liners  
https://github.com/stephenturner/oneliners  
Efficient R programming https://csgillespie.github.io/efficientR/
Cheat sheets for data.   science http://www.datasciencecentral.com/...
RStudio Cheat Sheets  
https://www.rstudio.com/resources/cheatsheets/#515