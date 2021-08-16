---
layout: topic
title: Rare disease network analysis
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

## Introduction
The exome sequencing is most commonly used for genetic diagnosis in
single use cases. Over the next decade exome and genome sequencing will
become very commonplace for the average person at least in high-GDP
countries. A massive expanse in population genetics data will provide
the information that GWAS studies have always sought. We will still be
left with large genomic black holes; that is conserved coding and
non-coding regions that are obviously important as the determinants of
human health within Mendelian genetics. To uncover the function of these
genetic loci we will still be at the mercy of cohort size in rare
disorder studies. For true rare genetic disorders, a disease frequency
of 0.01% equates to approximately 800,000 cases worldwide for diseases
that are not embryonic lethal and where lifespan is about normal. If we
consider high income populations where genomic sequencing would be
common, then we may have 100,000 cases. A very well organised rare
disease study would do well to recruit 1 per 1000 in a clearly defined
disease; this is currently the situation although most studies cannot
finance full genomic investigation. Therefore, now and well into the
future, rare disease studies will generally be limited to a maximum
number of living participants on the scale of hundreds.

Current best practices in genomic analysis will first identify “low
hanging fruit”; single cases in a cohort with a clear genetic
determinant (e.g. haploinsufficiency of a well-defined dominant gene).
The second order will identify commonly mutated genes or loci based on
burden testing comparing cases to controls or background population
genetics. Many disorders have a phenotype that can be derived from
mutations in several different genes. The encoded genes generally are a
part of the same protein pathway, even directly upstream and downstream
of each other in some cases. For example, covers this topic with
individual cases of RAG1 and RAG2 deficiency.

Proposed here is a statistically robust and unbiased method to find
variants in protein-coding genes that share a common functional protein
pathway for a disease cohort. **Figure \[fig:method\]** provides a
high-level graphical summary of the concept. **Figure \[fig:abstract\]**
conveys the theory of the procedures for this method in more detail with
the major datasets explicitly shown.

**Deleterious rare variants in damaged protein pathways in rare
disease.** A. GATK best practices were used for whole exome analysis
with joint genotyping for cases and controls; 200 in total. Custom
filtering {% cite vcfhacks2015Parry} extracted variants of high impact
consequence (ostensibly loss-of-function (LoF)), present only in cohort
cases. B. Genes harboring rare predicted LoF variants were grouped based
on protein-protein interactions {% cite String2017Szklarczyk} using a Markov
cluster algorithm {% cite Enright2002efficienct}. C. Case-control testing was
performed on each protein pathway cluster.

<img src="{{ site.baseurl }}{% link images/net_analysis/method.png %}" width="40%">

**Rare variant analysis and protein pathway significant enrichment.**
A. DNA is collected and sequenced. B. Routine genomic analysis is
carried out according to best practices, for both (i) control and (ii)
case groups of patients. First, all rare variants are output, followed
by a smaller subset of loss-of-function (LoF) variants. C.
Variant-carrying genes are cluster of protein-protein interactions based
on function and ontology. D. A clustering method is applied to break a
large highly connected network into smaller individual ones. E. The
number of tests can be reduced by, for example, testing only networks
that carry a threshold level of LoFs and are therefore biologically
relevant to disease. F. Deleterious variant load per network was tested
for enrichment in cases, controls, or random sampling. G. Multiple
testing correction is applied to identify the critical significant
threshold.
<img src="{{ site.baseurl }}{% link images/net_analysis/abstract.pdf %}" width="40%">

## Exome analysis
Exome sequencing analyses has been discussed in detail. The rare disease
cohort network analysis requires less tailored analysis steps than
traditional variant interpretation. Therefore, the data preparation is
briefly outlined here.

Sequences were trimmed and quality controlled using FastQC via
Trim-galore. Reads were aligned to GrCh37 using BWA-MEM. GATK “best
practices” were used for marking duplicate reads, recalibration, and
whole cohort variant quality score recalibration before generating
genomic VCFs with HaplotypeCaller and joint genotyping. Filtering and
prediction of functional consequences was performed using Variant Effect
Predictor\
(http://www.ensembl.org/info/docs/tools/vep/index.html), Exome Variant
Server\
(http://evs.gs.washington.edu/EVS/), The Single Nucleotide Polymorphism
database\
(https://www.ncbi.nlm.nih.gov/projects/SNP/) and ClinVar
(https://www.ncbi.nlm.nih.gov/ clinvar/), The Exome Aggregation
Consortium and The Genome Aggregation Database\
(http://gnomad.broadinstitute.org). Filtering of common variations and
annotation was performed using VCFhacks\
(https://github.com/gantzgraf/vcfhack). Candidate variants were required
to pass the following filtering conditions: frequency (count/coverage)
between 20-100%, according to VEP-annotation at least one canonical
transcript is affected with one of the following consequence: variants
of the coding sequence, frameshift, missense, protein altering, splice
acceptor, splice donor, or splice region; an inframe insertion or
deletion; a start lost, stop gained, or stop retained, or according to
VEP an GnomAD frequency unknown, &lt;=0.01, or with clinical
significance 'path'. VCFhacks {% cite vcfhacks2015Parry} was used for
cohort-specific filtering retained functional variants that were present
in at least one case but absent in controls (for case-driven PPI
clustering). The same criteria were used to also collect functional
variants that were present in at least one control but absent in
controls (for control-driven PPI clustering).

## Cluster list preparation
Group-specific variant data was extracted from the joint cohort.
Specifically, the datasets came from the routine analysis pipeline show
in **Figure \[fig:analysis\_flow\]** as the output of the process
“filter on Sample” and converted from VCF to tsv format using the
process “annovcftoSimple” using the tool VCFhacks {% cite vcfhacks2015Parry}.
Four gene lists were prepared consisting of the following groups; (1)
variants present in controls and (2) variants present in cases and
further divided for genes that harboured either (i) all rare variants or
(ii) only potential loss-of-function variants. Specifically, the
datasets for (i) all rare variants came from the output of the process
“filter on sample” via “get functional variants”. The datasets for (ii)
potential loss-of-function variants is a subset of (i), processed by the
R script at the step where “damaging variants” are written out to file.

Analysis workflow structure. Tools used are shown in square boxes.
Reference data used secondary to inputs are shown as light boxes with
curved sides. Key output files are shown by light slanted boxes. Storage
structure is divided between long-term and short-term
storage.
<img src="{{ site.baseurl }}{% link images/net_analysis/analysis_flow.pdf %}" width="80%">

## Network construction {#sec:net_construction}
Group-specific gene lists \[1 (i-ii) and 2 (i-ii)\] were assessed for
PPI using the STRING database {% cite String2017Szklarczyk} via Cytoscape
{% cite Shannon2003cytoscape}. An initial PPI network was generated for each
of the 4 dataset groups. The STRINGdb default confidence score cut-off
(0.4) was used for these tests. This score is the measure of evidence
required to create an interaction between two nodes. A stricter value
can be set if networks are too large. Query genes were defined as nodes,
PPI were defined as edges, and networks of proteins linked through PPI
were defined as clusters. Clusters or networks can also be generally
considered as making up a part of a protein pathway.


| Network cluster | Number of nodes | Number of edges | Number of clusters |
|---|---|---|---|
| Total  | 1956 | 9559 | 114 |
| No edges | 1 | 0 | 107 |
| One edge | 2 | 1 | 6 |
| Large multi-edge | 1837 | 9553 | 1 |
| Total | 2305 | 14139 | 102 |
| No edges | 1 | 0 | 77 |
| One edge | 2 | 1 | 3 |
| Two edges | 3 | 2 | 1 |
| Large multi-edge | 2219 | 14134 | 1 |

**Table \[table:node\_summary\]** lists the characteristics of PPIs for
genes found to harbour functional, potential LoF rare variants in cases
and controls (i.e. gene lists 2 \[i-ii\]). Most query proteins were seen
to cluster into one large multi-edge node which contained many weak
interactions. The data used in this table is represented again visually
in **Figure \[fig:damage\_list\_case\]**. Each dot, or node represents a
protein-coding gene that has at least one potentially damaging variant.
The edges, or lines connecting nodes, represent known PPI data that link
proteins. This visual information clearly illustrates the body of
functional protein data that can be included in variant analysis.
However, since nearly every protein has some potential evidence of
effect on many other proteins, then no clear definable protein pathway
can be seen.

**Genes harbouring potentially damaging variants in a disease
cohort.** A visual representation of PPI occurring in all genes that
harbour potentially damaging functional variants in a typical disease
cohort.
<img src="{{ site.baseurl }}{% link images/net_analysis/damage_list_case.png %}" width="50%">

To segregate protein pathways and refine the number of genes (nodes) in
each cluster, the Markov cluster algorithm (MCL) was used
{% cite van2000graph; @Enright2002efficienct]. The principal data-specific
adjustment required for using MCL is the inflation operator, which
regulates cluster granularity or tightness. The optimum inflation
parameter for separating protein pathways was found to be 2.5, using a
measure of uniform distribution across datasets. **Figure
\[fig:inflation\]** illustrates an optimal inflation of a large PPI
network into smaller, clearly defined protein pathway clusters.

As a reference example, **table \[table:node\_edge\]** lists three
inflation parameters tested for most consistent separation (2.5, 3, 4)
and shows the effect of adjustment on the total number of edges (protein
interactions). The median number of nodes (query proteins) are shown for
cases and controls (also shown as total number of nodes in **table
\[table:node\_summary\]**).

**Figure Inflation separates protein pathways** A visual representation the ideal inflation
parameter used on a PPI cluster. Weak bonds are broken and strong bonds
draw nodes closer together. No bonds are retained between clusters. With
this type of inflation each protein network cluster can be investigated
without considering overlaps.\[fig:inflation\]


<!-- & Total count median | Node/Edge ratio | Case/control $\pm$ S.D. | Case/control $\pm$ S.D. | -->
<!-- & 2130.5 $\pm$ 246.78 | -->
<!-- & [PPI only \* | 11849 $\pm$ 3238.55 | 0.18 $\pm$ 0.03 | -->
<!-- & [Inflation 2.5 | 2787.5 $\pm$ 740.34 | 0.78 $\pm$ 0.12 | -->
<!-- & [Inflation 3 | 4229.5 $\pm$ 3669.18 | 0.77 $\pm$ 0.61 | -->
<!-- & [Inflation 4 | 1199.5 $\pm$ 146.37 | 1.78 $\pm$ 0.01 | -->

**Figure \[fig:network\_size\_inflation\]** illustrates the effect of
adjusting the inflation parameter for MCL clustering on protein
networks. After MCL clustering, cases and controls were found to group
into 928 and 1034 networks clusters respectively. Of these, 494 and 568
were single-node (single-protein) “clusters” which shared no interaction
with another protein while 434 and 466 clusters had at least one
interaction between proteins. The cumulative probability plot (figure
\[fig:cumulative\_sum\_net\_rank\]) shows the cumulative sum of proteins
per network against network rank size. **Figure \[fig:qqplot\_2\]**
shows qqplot for the same data for distribution compared between groups
after inflation at 2.5.

**Effect of inflation on network size distribution.** The outcome on
network size is demonstrated to compare effect of two inflation
parameters. An ideal separation of networks should provide an geometric
decrease in the number of proteins per network regardless of the sample
group. Inflation parameter 2.5 produced the ideal distribution while
inflation parameter 3 produced one large, poorly separated network and a
large increase in single-protein nodes on one group. Binwidth of
10.
<img src="{{ site.baseurl }}{% link images/net_analysis/network_size_inflation_free.pdf %}" width="40%">

**Cumulative sum of network rank by size**. The effect of inflation on
network size distribution could be potentially measured automatically by
quantifying the cumulative sum of network rank by size and determining
the best inflation parameter to use. This process would reduce user
bias.
<img src="{{ site.baseurl }}{% link images/net_analysis/cumulative_sum_net_rank.pdf %}" width="40%">

**QQ plot illustrating uniform inflation.** The data presented in
figure \[fig:cumulative\_sum\_net\_rank\] is used to produce the
quantile-quantile plot for the most uniform distribution between the
case and control groups after all inflation parameters were
tested.
<img src="{{ site.baseurl }}{% link images/net_analysis/qqplot_2.pdf %}" width="40%">

**Figure \[fig:network\_size\_nodes\]** shows the number of proteins per
network. For example, 235 clusters (470 protein nodes) were seen for
cases where only one interaction was shared between two proteins. A
median of 0.78 nodes-per-edge (proteins-per-interaction) was found in
the cases group; naturally the majority of edges appear in large network
clusters and therefore the frequency of nodes-per-edge increases as
network sizes decrease.

Number of proteins per network for case-driven clustering. The size of
protein networks has a geometric distribution that decreases until
protein (nodes) with no interactions remain; in this cases approximately
200 out of 400 proteins did not play a major role in a single
pathway.
<img src="{{ site.baseurl }}{% link images/net_analysis/network_size_nodes.pdf %}" width="40%">

## Random sampling {#sec:random_sample}
With our group-specific gene lists [1 (i-ii) and 2 (i-ii)], prepared
in section \[sec:net\_construction\], we found the distribution of genes
per networks and output the list of genes in each network for all 4
datasets. The mean number of genes per network rank was found between
cases and controls, again for (i) all rare variants and (ii) only
potential loss-of-function variants. A third gene cluster list was
produced by random sampling gene symbols in artificial networks equal to
the same median size as case-driven and control-driven clusters in from
datasets (i) and (ii). The resulting dataset [3 (i-ii)] mirrors those
of cases and controls but instead of true PPI networks, the networks
contained randomly assigned genes.

## Expanding damaged gene MCL clusters
For each of the 4 MCL-clustered datasets, cases and controls [1 (i-ii)
and 2 (i-ii)], the cluster ID and list of gene symbols was extracted.
The gene lists of network clusters made from datasets (ii) (potential
LoF) were used to find the network clusters in (i), all-variant gene
clusters, the contained the same overlapping genes. This occurs where
list (ii) is a subset of list (i). The clusters that contained gene
overlaps were extracted since they contained at least one potential LoF
per network. Using this output, the total variant load in “damaged
pathways” could be compared. For clarity, this procedure is summarised
again in Box \[box:expanding\]; items **A-B**. Item **C** outlines the
remaining steps. **Figure \[fig:damage\_list\_case\]** illustrates the
effect of inflation with an ideal inflation parameter. The large network
of PPI were separated into individually contained protein networks.

\[box:expanding\]

## Burden rank {#sec:burden_rank}
Our downstream case-control testing compares the mean total variant load
per network. To prevent dilution of our significance threshold due to
multiple testing an arbitrarily high number of networks we assumed that
protein networks harbouring loss-of-function variants at a consistent
frequency in all groups were unlikely to contain genes of interest. To
remove these networks, we firstly found (*p*) the ratio of LoF to all
variants within the group per network, and secondly found (*q*); the
ratio of *p* between groups per network. Networks were ranked by value
*q*. Values passing a threshold of 0.7 were included for total variant
load means testing (i.e. 70% of ostensibly damaging variants occurred in
cases regardless of the proportion of total variants). This also has the
effect that even if there is no significant difference in a case/control
total-variant means test downstream, potential false negatives may be
rescued by checking for LoF enrichment. This method is applied to real
data in section \[sec:enrichment\_test\] and **table
\[table:bh\_real\]**.

## Determining the number of tests *m* {#sec:number_test}
The number of tests should be determined by the predefine LoF ratio per
network, *q*. This value is arbitrarily set and has the problem that an
investigator can decide to use a higher threshold to nude the critical
significant threshold in a desired direction. However, testing roughly
the top 20-30% of networks is suggested. In our experiments we set our
test number as the top 25% of burden-ranked networks. This will be
approximately 10 networks to test (the asymptote of network numbers peak
when the study size increases over approx. 400 samples as all of the
possible PPIs are saturated once the maximum queryable genes are
included). Study sizes that are much larger than this will likely only
(1) be for disease that are not very rare and (2) be large enough to
start expecting single gene significance levels without requiring
network analysis. However, some very strict filtering rules could allow
larger studies with this method.

## Significance testing
We hypothesised firstly that no variant enrichment would be seen in
random sampling or control-driven gene clusters, and secondly enrichment
would only be seen in case-driven clusters for protein-pathways that
provide susceptibility to viral infection. For measuring a significant
enrichment of functional variants in a protein network, there are three
factors to consider.

1.  Our aim is to do a comparison of means between case and control, for
    total variant load per network.

2.  This is done in three iterations; \[1\] control-driven, \[2\]
    case-driven, and \[3\] random sample-driven.

3.  We correct our significance threshold to account for multiple
    testing using the Benjamini-Hochberg procedure.

With our group-specific gene lists [1 (i-ii), 2 (i-ii), and [3
(i-ii)\], prepared in sections \[sec:net\_construction\] and
\[sec:random\_sample\], we found the distribution of genes per networks
and output the list of genes in each network for all 6 datasets. In each
of the 3 “all variant” datasets we simply do a comparison of means for
total variant load per network comparing case to control, or random.

While the test is not complicated, the significance threshold deserves
an in-depth explanation; this is a novel method and most people
replicating this study will not have experience with the statistical
procedures required. The statistical significance also only allows a
narrow margin for successful discovery. When a large number of tests are
performed, one is likely to produce P-values that are “statistically
significant” by chance (P &lt; 0.05), even if the null hypothesis is
true. The null hypothesis would state that “random controls and people
with disease have the same average frequency of potentially pathogenic
variants in some protein pathway”. The alternate hypothesis would state
that “people with disease have an increased frequency of potentially
pathogenic variants in some protein pathway than random controls”.

Traditionally, Bonferroni correction has been used in cases like this.
For each “family” (network means test) being tested one must correct the
critical P-value. For example, for one test a significant P-value might
be 0.05 and below this we consider the result to be significant. The
chance of getting this result if the null hypothesis was true would be
5%. That does not mean that there is 5% chance that it is true. The
following examples are reiterated summary of the topic found in the
Handbook of biological statistics {% cite mcdonald2009handbook}.

For multiple tests of “families” then we need to adjust the P-value
since we are more likely to get false positives by chance. In a
published example, @garcia2014calorie tested 25 associations with
mammographic density, which is an important risk factor for breast
cancer. The 25 “families” tested were dietary variables including “Total
calories”, “Olive oil”, “whole milk”, “white meat”, etc. For each
variable a P-value was given for its association with mammographic
density, i.e. total calories P &lt; 0.001, olive oil P = 0.008, whole
milk P = 0.039.

To perform a Bonferroni correction, the critical P-value (or significant
threshold) should be divided by the number of tests, 0.05/25 = 0.002.
Therefore, only “total calories” would be significantly associated with
the risk factor. If 75 more variables were measured (100 total) then the
critical P-value would have to be 0.05/100 = 0.0005. However, it may not
be reasonable to invalidate the significance of the original findings.
Using Bonferroni correction for family-wise error rate can mean
extremely small P-values. So instead we use a more powerful method for
controlling the false discovery rate; the Benjamini-Hochberg procedure
{% cite simes1986improved, @benjamini1995controlling}.

In this procedure, we compare each individual P-value to its
Benjamini-Hochberg critical value, $(i/m)Q$, where $i$ is the rank, $m$
is the total number of tests, and $Q$ is the chosen false discovery
rate. The largest P-value that has $P<(i/m)Q$ (i.e. P less than
BH-critical value) is significant, and all of the P-values smaller than
it are also significant, even the ones that aren't less than their own
Benjamini-Hochberg critical value.

So in the same example, with 25 tests and Benjamini-Hochberg critical
value for a false discovery rate set to 0.25, table
\[table:bh\_example\] shows the outcome. The largest P-value that is
less than its $(i/m)Q$ values is 0.042 for protein. Therefore, the first
5 variables are significantly associated, including whole milk and white
meat despite the fact that their BH-critical value is higher than their
P-value. If we were to never have measured protein in this example, $m$
the number of tests would be 24, slightly increasing the BH-critical
value, and again identify a significant association for the first 4
tests. Someone interested can recalculate this table to see this effect.


| Product |P value |
|---|---|
| Olive oil | 0.008 |
| Whole milk | 0.039 |
| White meat | 0.041 |
| Proteins | 0.042 |
| Nuts | 0.06 |
| Cereals and pasta | 0.074 |
| White fish | 0.205 |
| Butter | 0.212 |
| Vegetables | 0.216 |
| Skimmed milk | 0.222 |
| Red meat | 0.251 |
| Fruit | 0.269 |
| Eggs | 0.275 |
| Blue fish | 0.34 |
| Legumes | 0.341 |
| Carbohydrates | 0.384 |
| Potatoes | 0.569 |
| Bread | 0.594 |
| Fats | 0.696 |
| Sweets | 0.762 |
| Dairy products | 0.94 |
| Semi-skimmed milk | 0.942 |
| Total meat | 0.975 |
| Processed meat | 0.986 |

The choice of a false discover rate depends on the application. False
positives can waste time, resources, and pollute future work. Minimising
false negatives could result in missing a very important finding, that
is, when there is a real effect but it is not deemed statistically
significant. Allowing a pre-determined level false negatives is often
reasonable. As in our application, finding enriched protein networks is
the main goal, and downstream work will also be done such as clinical
interpretation or functional studies which will catch false negatives.
Therefore, the false discovery rate does not have to be very small;
consider that our input dataset is already filtered down to ostensibly
damaging rare variants. Furthermore, the input dataset is essentially
the result of traditional best practices in exome or genome sequencing
analysis.

## Enrichment testing {#sec:enrichment_test}
For all networks, the top 30 networks in size (largest to smallest;
1-30) were ordered using the burden rank (sec \[sec:burden\_rank\]).
From these, the number of tests was set (according to the rules defined
in sec \[sec:number\_test\], so that only the top 8 burden-ranked
networks were means tested for their total variant load. **Figure
\[fig:means\_test\]** shows the test of means for the top 8 protein
pathway networks. Table \[table:bh\_real\] lists the P-values assessed
for significance using the BH-procedure. We found that only one of the
networks was significantly associated with a pathogen-specific
immunodeficiency. The variant load was significantly higher than for
controls. The total potential LoF variants only accounted for 30.5% of
total variants in the network but was ranked high during the burden rank
(see sec \[sec:burden\_rank\]) because no controls harboured potential
LoF variants in this network and therefore 100% occurred in cases. This
protein network contained genes responsible for pathogen detection; some
genes *might have been* identified as candidates using the routine exome
analysis pipeline such as the antiviral receptors and antiviral
interferon regulatory factors. However, most of the other genes that are
integral to this pathway would not have been identified by standard best
practices. The protein network is shown in **Figure
\[fig:immune\_cluster\]** where potential LoF variants-harbouring genes
are coloured in red. Gene candidates with variants of unknown
significance are coloured in red and, anecdotally, the colouring
thereafter becomes lighter (orange to yellow) based on the likelihood of
candidates being identified by manual interpretation of unknown
candidates.

**Case and control means test.** The total rare variants per network
are shown, comparing groups. A test of means was conducted in this test
dataset and P-values are
shown.
<img src="{{ site.baseurl }}{% link images/net_analysis/means_test.pdf %}" width="30%">

**Figure Protein network with significantly enriched variant load.**
Protein network with significantly enriched variant load.** From the
example data, network 22 was significantly enriched for rare variants.
The same clustering method was again used on all variants with a less
stringent variant frequency (&lt;1% in general population and present in
any cohort sample). With the resulting, more common variants, the full
protein network can be seen (about double in size compared to only very
rare variants). Gene candidates with variants of unknown significance
are coloured in red and, anecdotally, the colouring thereafter becomes
lighter (orange to yellow) based on the likelihood of candidates being
identified by manual interpretation of unknown candidates.
\[fig:immune\_cluster\]

<div class="table-wrapper" markdown="block">

| Cluster rank	| LoF freq in cases	| LoF freq in cases per cluster | P-value	|	rank	|	(i/m)Q	|
|---|---|---|---|---|---|
| 22			| 0.306				|	1		| 0.023	| 1 | 0.025 |
| 27			| 0.429 			|	1		| 0.12	| 2 | 0.05 |
| 16 			| 0.6   			|	0.919	| 0.13 	| 3 | 0.075 |
| 19 			| 0.281 			|	0.835 	| 0.14 	| 4 | 0.1 |
| 25 			| 0.25] 			|	1		| 0.28 	| 5 | 0.125 |
| 11 			| 0.357 			|	0.838	| 0.33 	| 6 | 0.15 |
| 10 			| 0.516 			|	0.856	| 0.34 	| 7 | 0.175 |
| 18 			| 0.474 			|	0.85	| 0.47 	| 8 | 0.2 |

</div>


## References 

{% bibliography --cited %}
