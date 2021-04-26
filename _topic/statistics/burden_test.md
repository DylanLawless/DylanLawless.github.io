---
layout: topic
title: Burden testing with variant collapse
created: 2021-04-26
tags: statistics
status: unfinished
subject: statistics
---
{{ page.title }}
================
* TOC
{:toc}

# Introduction
In this series I will go over methods and theory for gene burden testing.
I am publishing this live as I work since there are several heavy papers to get through.
<!--For the working writeup see: pri_net_manuscript/pre_print_md/detailed_methods/statistics.md-->

## To do
Running code on test data: Remake the gVCF as BP_RESOLUTION to list a site for every position. 
Filter: If variants are MAF >0.1 in gnomAD then run a filter to remove variants that are not sequenced in controls.
Justification: If we ran that filter for every singleton it would remove the very rare variants that would have been a true positive if it had been sequenced in the controls. 

## Main papers in order
* Methods for detecting associations with rare variants for common diseases: application to analysis of sequence data.
@li2008methods
* A groupwise association test for rare mutations using a weighted sum statistic.
@madsen2009groupwise
* An evaluation of statistical approaches to rare variant analysis in genetic association studies.
@morris2010evaluation
* Pooled association tests for rare variants in exon-resequencing studies.
@price2010pooled
* Rare-Variant Association Testing for Sequencing Data with the Sequence Kernel Association Test.
@Wu2011Rare
* Optimal tests for rare variant effects in sequencing association studies.
@Lee2012Optimal
* Optimal Unified Approach for Rare-Variant Association Testing with Application to Small-Sample Case-Control Whole-Exome Sequencing Studies.
@Lee2012Optimalunified
* Sequence Kernel Association Tests for the Combined Effect of Rare and Common Variants.
@IonitaLaza2013Sequence

## Major Classes of Tests
* Burden/Collapsing tests
* Supervised/Adaptive Burden/Collapsing tests
* Variance component (similarity) based tests
* Omnibus tests: hedge against difference scenarios

## Burden Tests So Far
### Tests
* Binary Collapsing: CAST
* CMC
* Count Collapsing: MZ (GRANVIL)
* Weighted Sum Test

### Power of burden tests depends on
* Number of associated variants
* Number of non-associated variants
* Direction of the effects.
* Powerful if most variants are causal and have effects in the same direction.

# Li and Leal 2008
* The collapsing method, which involves collapsing genotypes across variants and applying a univariate test, is powerful for analyzing rare variants.
* The multivariate analysis is robust against inclusion of non-causal variants. 
* Both methods are superior to analyzing each variant individually with univariate tests. 
* Combined Multivariate and Collapsing (CMC) method unifies the advantages of both collapsing and multiple-marker tests.

## Background
Genotype phenotype association may be tested by:
* A single market test (i.e. GWAS) may use standard univariate statistical tests
(e.g., chi-squared test, Fisher's exact test, or Cochran Armitage test for trend) 
and with the family-wise error rate (FWER) controlled by a multiple-comparison correction (e.g., Bonferroni, permutation).
* A multiple-marker test, which tests multiple variant sites simultaneously with the use of multivariate methods, 
such as the Fisher product method, 
Hotelling's T test 
or logistic regression.
* Collapsing variants can increase power.
* Classification of variants can be a major problem. 
* If classified correct power of causal detection is higher than single- and multiple-marker testing.
* If miss-classified, non-functional variants could introduce error.

## Genetic model
* In a locus M variants can independently cause disease.
* A = allele
* 1-M = allele label
* p = allele frequency
* Gk = 0/1/2 genotype
* Fki = penertance of geno for ith variant.
* Relative risk of each variant i in models: additive, multiplicative, dominant, and recessive.
* Prevalence of disease caused by each individual variant is calculated.
* Prevalence of disease caused by entire locus can therefore be calculated.
* Total prevalence can be approximated by the sum of the individual prev.
* Same pheno can be due to different causal variants.
* The proportion of cases as a result of variant i can be ascertained.
* These cases are members of group i.
* There is a total of M groups.
* For group i the frequency of variant i can also be produced for 0,1,2.
* Then, the expected freq of genotype G at variant i across all M groups of cases can be found.
* Controls expected genotype freq at i variant can be found.
* The expected freqs are used to calculate the power to detect assoc in this study.
* Their focus is the omnibus test, which provides an association test of the entire locus and is not focused on any specific variant within the locus.

## Single-marker test
* One approach of association studies is to test each variant site individually with the use of a univariate test and assess the significance of the _omnibus test_ (chi-squared test or F test) after correction for multiple comparisons. 
For univariate tests, a contingency table can be constructed to compare genotype frequencies at each variant site in cases and controls. 
Because an observation of individuals that are homozygous for the high-risk rare allele is extremely rare, AA genotypes are collapsed with Aa genotypes, and a table is constructed. 
For an equal number of cases and controls, the classical Pearson chi-squared statistic for testing equal genotype frequencies in cases and controls is used.


## Multiple-marker test
Another option is to test all variants simultaneously by multivariate test
* e.g. Fisher product method, Hotelling's T-squared test, or multiple logistic regression.
* (This is not the same as one regression run for every single variant with multiple covariates, as done in GWAS sometimes).
* The authors give an example using Xiong et. al.,  (2002). Generalized T2 test for genome association studies. Am. J. Hum. Genet.
* _Note: Hotellings T-squared tests the differences between the (multivariate) means of different populations, where tests for univariate problems would make use of a t-test. The distribution is named for Harold Hotelling, who developed it as a generalization of Student's t-distribution._
* Rejecting the null hypothesis would indicate that at least one of the variants is assocciated with disease. 

## Basic collapsing method
Since variants are expected to be very rare, 
genotypes across all variants are collapsed.
An individual is coded once if they have any one variant for the locus.
* 1 = rare variants present.
* 0 = no rare variants.
The classic Pearson chi-squared statistic can be used to test the summed proportion of variants in cases vs controls. 
The power can be calculated as shown by the authors. 

## CMC method
Unified method that combines collapsing and multivariate testing.
* Markers are divided into subgroups (e.g. allele frequency).
* Within group, markers are collapsed.
* A multivariate test is then used (Hotelling's T-squared).

e.g. M markers in a locus are split into K groups.
There are n markers in group g, and so on for each group.
The multivariate test is done where for each group, the  individuals are coded with either 1 (a carrier of one or more variants) or 0 (wild-type).

## Power of CMC method
Results:
* Freq below 0.01 collapsed.
* Freq above 0.01 not collapsed.
* With misclassification, power is much better with CMC method compared to collapsing method
	- particularly when with a high frequency of the non-causal variant.
* Slight (very slight I think) loss of power when _causal_ variants are high frequency compared to collapsing.
	- This scenario is unlikely otherwise single-marker test may be possible to detect.

## Misclassification
Two types of miss-classifications are considered: 
* inclusion of non-functional variants and 
* exclusion of functional variants.
* There is a large section on results of _Excluding Functional Variants_ and _Inclusion of Nonfunctional Variants_.

_This section can be read for detail but is probably familiar enough for us to skip._
 
## Effects of Linkage Disequilibrium (LD)
A simulation is done in this section:
* The locus has six variants, with a total allele frequency of 0.05. 
* Four of the variants have an allele frequency of 0.01 and are on different haplotypes. 
* Each of the remaining two variants, with allele frequencies of 0.005, is on one of the haplotypes where a variant with allele frequency of 0.01 resides; 
	- there is complete LD between these variants (r 2 z0:5). 
* For comparison purposes, a second simulation was carried out, in which all variants were on separate haplotypes.
* One thousand replicates were generated, and the power was evaluated for an a level of 0.001.

Results:
* In the presence of LD, the power for the single-marker test, Hotelling's T2 test, and the collapsing method is 
	 - 0.075, 0.63, and 0.85, respectively. 
* Data generated with each variant on a separate haplotype, the corresponding powers are
	- 0.011, 0.451, and 0.737, respectively.

## Evaluation of Type I Error Rate
* Simulation was used to generate data under the null hypothesis of no association between variants and disease status.
*  This process was repeated for 5000 replicates. 
*  It was then evaluated whether or not each replicate had a p value % 0.05. 
* The type I error rate was estimated by the proportion of replicates with a p value below 0.05. 
* A type I error rate above 0.05 signifies a higher false-positive rate, and conversely, a type I error rate below 0.05 indicates a conservative test.

Result:
* Hotelling's T2 test and the collapsing method: 
	- _well controlled and slightly conservative._
* Logistic regression for multiple-marker test and the likelihood-ratio test performed on the basis of an asymptotic chi-squared distribution: 
	- _not well controlled._
	- _The inflation increases with decreasing allele frequencies._
* CMC method, with multivariate Hotelling's T2 test or logistic regression: 
	- _well controlled_.

## Problems with this paper
* The main problem with collapsing method is when single individuals have more than one causal variant being only counted as "1". This more likely to occur for our protein-pathway collapse than a single gene/locus collapse. 
* Reason 1: dosage is not counted. Someone may have homozygous and only counts for 1 rather than 2 (or some other weight).
* Reason 2: someone with more than one variant is only counted as 1 (if it is in the same allele frequency group for collapse). This may be rare in a single gene but is more likely in a protein network collapse. Usually it would be OK particularly if the second variant is in LD with the first and therefore _should_ only be counted once.
* CMC code - maf threshold: In the R code, those variants with minor allele frequency below the specified maf threshold are collapsed into a single super variant. Can we group data into several frequency groups or is one _above/below_ threshold only possible?

