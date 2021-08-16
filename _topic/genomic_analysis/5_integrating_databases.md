---
layout: topic
title: Integrating databases
created: 8 Aug 2018
bibliography:
- '../tail/bibliography.bib'
tags: genomics
subject: Genomic analysis
---
{{ page.title }}
================

* TOC
{:toc}

## Population genetics {#subsec:gnomad}
GnomAD (version r2.0.2)  {% cite lek2016analysis %} was used in these studies as
the best source of population genetics data. The reference genome is
GRCh37. Offline local database mirrors were used in most cases. Input
sets used GnomAD variant allele frequencies and reference sequences
processed as VCF and CSV files. outlines a specific data transformation
using the gnomAD database, but in general, gnomAD was used as a
filtering threshold for determining the expected population frequency of
each variant. A strict threshold for rare variants could be set to
ignore and candidate variants that are more frequent than 0.001.
However, in most cases a more lenient level is used and any remaining
benign or common variants are removed by “technical control” (filter on
cohort to remove common variants between individuals that do not share a
phenotype). A more modest cut-off threshold allows us to sometimes
identify variant that are present in the general population, which are
responsible for a recessive disease with no predictable heterozygous
loss-of-function intolerance.

Other sources of population genetics data comes from resources such as
CliVar and dbSNP, which as they grow in size become an annotated and
curated for of population data. These resources allow us to calculate
the expected frequencies for disease-causing variants. However, since
these are manually curated database and predominantly European based,
they are inherently biased and not reliable for statistical
applications.

## Phenotype, genotype, and function
Population genetics database gnomAD has been individually addressed in
section \[subsec:gnomad\], as this is the most important type of
annotation and filtering criteria for genetic determinants of rare
disease. Additionally, in these studies many phenotype and genotype
databases have been used for annotation and interpretation.
Specifically, the most frequently used data came from MGI Phenotype,
MorbidMap, VOC MammalianPhenotype, Gencode symbol, UniProtKB, Enterez
ID, ENSGene ID, GO ID, Description, OMIM, BIOGRID interactions, HGMD
human phenotype, ClinVar, and dbSNP. In most cases, every candidate
variant was annotated with the main information per gene from a local
database containing the information from each of the listed resources.

These are the “basic” information databases that we used to annotate
variants. In a cohort study, data mining can find correlations and was
therefore included for posterity as it does not significantly increase
the data storage. Even if an obvious cause of disease was found we may
later return to the data to find other cofactors or genetic modifiers.
Or for example, in a single case study, a variant of unknown
significance may have no statistical basis to be selected or ignored. We
use this information to decide if that mutation is worth consideration:
Is it in a protein domain of known function? Are there other cases
reported with the same phenotype? What is the gene function, ontology,
etc.?

We have also used some gene lists that are specific to disease,
druggability, etc. A major contributor for collecting these gene lists
has been the Mac Arthur et al.  {% cite macarthurgit %}. These gene lists can be
used is special cases. For example, a study looking at (1) dominant
pathogenic mutations, and (2) in known immune genes might filter to
included only those known observables. We could decide to only study
SNPs in FDA-approved drug targets.

<div class="table-wrapper" markdown="block">

| Mechanism | Gene Count | Name | Reference |
|---|---|---|---|
|           | 19,194 | HUGO 2018  | {% cite HUGO2018 %} |
| FDA-approved drug targets | 385 | Wishart 2018 | {% cite Wishart2018 %} |
| Drug targets | 201 | Nelson 2012  | {% cite Nelson2012 %} |
| Autosomal dominant genes | 307 | Blekhman 2008 | {% cite Blekhman2008 %} |
| Autosomal dominant genes | 631 | Berg 2013  | {% cite Berg2013 %} |
| Autosomal recessive genes | 527 | Blekhman 2008 | {% cite Blekhman2008 %} |
| Autosomal recessive genes | 1073 | Berg 2013  | {% cite Berg2013 %} |
| X-linked genes | 66 | Blekhman 2008  | {% cite Blekhman2008 %} |
| X-linked recessive genes | 102 | Berg 2013  | {% cite Berg2013 %} |
| X-linked dominant genes | 34 | Berg 2013  | {% cite Berg2013 %} |
| X-linked ClinVar genes | 61 | Landrum 2014  | {% cite Landrum2014 %} |
| All dominant genes | 709 | Blekhman 2008, Berg 2013 | {% cite Blekhman2008, Berg2013 %} |
| All recessive genes | 1183 | Blekhman 2008, Berg 2013 | {% cite Blekhman2008, Berg2013 %} |
| Homozygous LoF tolerant | 330 | Lek 2016  | {% cite lek2016analysis %} |
| Essential in culture | 283 | Hart 2014  | {% cite Hart2014 %} |
| Essential in culture | 683 | Hart 2017  | {% cite Hart2017 %} |
| Non-essential in culture | 913 | Hart 2017  | {% cite Hart2017 %} |
| Essential in mice | 2,454 | Blake '11, Georgi '13, Liu '13 | {% cite Blake2010, Georgi2013, Liu2013 %} |
| Genes nearest to GWAS peaks | 6,336 | MacArthur 2017 | {% cite MacArthur2017 %} |
| DNA Repair Genes | 178 | Wood 2005  | {% cite Wood2005 %} |
| DNA Repair Genes | 151 | Kang 2012  | {% cite Kang2012 %} |
| ClinGen haploinsufficient genes | 294 | Rehm 2015 | {% cite Rehm2015 %} |
| Olfactory receptors | 371 | Mainland 2015  | {% cite Mainland2015 %} |
| Reported in ClinVar | 3078 | Landrum 2014  | {% cite Landrum2014 %} |
| Kinases | 347 | UniProt 2016  | {% cite UniProt2016 %} |
| GPCRs from guide to pharmacology | 391 | Alexander 2017, Harding 2018.  | {% cite Alexander2017, Harding2017 %} |
| GPCRs from Uniprot | 756 | UniProt 2016  | {% cite UniProt2016 %} |
| Natural product targets | 37 | Dancik 2010  | {% cite Dancik2010 %} |
| BROCA - Cancer Risk Panel | 66 | BROCA Cancer Risk Panel | {% cite BROCACancerRiskPanel %} |
| ACMG V2.0 | 59 | Kalia 2017  | {% cite Kalia2016 %} |
| GPI-anchored proteins | 135 | UniProt 2016  | {% cite UniProt2016 %} |

</div>

{% cite verma2018rare %} take an interesting approach to comparing druggable
targets with population genetics data. DrugBank is a database for over
800 genes with over 950 unique drugs. Genetic data can be filtered for
these genes and targeted for LoF variants. Association analysis consists
of logistic regression using the ICD-9 codes, and linear regression
using quantitative variables. This gene binding and regression analysis
steps are done using BioBin.

The International Statistical Classification of Diseases and Related
Health Problems (commonly known as the ICD) provides alpha-numeric codes
to classify diseases and a wide variety of signs, symptoms, abnormal
findings, complaints, social circumstances and external causes of injury
or disease. Nearly every health condition can be assigned to a unique
category and given a code, up to six characters long. Such categories
usually include a set of similar diseases

BioBin relies on the Library of Knowledge Integration (LOKI), which
integrates multiple databases providing a comprehensive biological
knowledge platform for variant binning  {% cite pendergrass2013genomic %}. The
LOKI database consolidates biological information from several sources,
most notably the National Center for Biotechnology (NCBI) dbSNP and
Entrez Gene, Kyoto Encyclopedia of Genes and Genomes (KEGG), Reactome,
Gene Ontology (GO), Protein families database (Pfam), NetPath-signal
transduction pathways, amongst others
 {% cite coordinators2017database, kanehisa2011kegg, milacic2012annotating, ashburner2000gene, finn2013pfam, kandasamy2010netpath %}.

## References 

{% bibliography --cited %}
