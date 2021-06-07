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
Filter: If variants are MAF >1.1 in gnomAD then run a filter to remove variants that are not sequenced in controls.
Justification: If we ran that filter for every singleton it would remove the very rare variants that would have been a true positive if it had been sequenced in the controls. 

# Main papers in order

* Methods for detecting associations with rare variants for common diseases: application to analysis of sequence data
{% cite li2008methods %}.
* A groupwise association test for rare mutations using a weighted sum statistic.
{% cite madsen2010groupwise %}.
* An evaluation of statistical approaches to rare variant analysis in genetic association studies.
{% cite morris2010evaluation  %}.
* Pooled association tests for rare variants in exon-resequencing studies.
{% cite price2010pooled  %}.
* Testing for an unusual distribution of rare variants.
{% cite neale2011testing %}.
* Rare-Variant Association Testing for Sequencing Data with the Sequence Kernel Association Test.
{% cite wulee2011rare %}.
* Optimal tests for rare variant effects in sequencing association studies.
{% cite Lee2012Optimal %}.
* Optimal Unified Approach for Rare-Variant Association Testing with Application to Small-Sample Case-Control Whole-Exome Sequencing Studies.
{% cite Lee2012Optimalunified %}.
* Sequence Kernel Association Tests for the Combined Effect of Rare and Common Variants.
{% cite IonitaLaza2013Sequence  %}

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
* Methods for detecting associations with rare variants for common diseases: application to analysis of sequence data
{% cite li2008methods %}

* The collapsing method, which involves collapsing genotypes across variants and applying a univariate test, is powerful for analyzing rare variants.
* The multivariate analysis is robust against inclusion of non-causal variants. 
* Both methods are superior to analyzing each variant individually with univariate tests. 
* Combined Multivariate and Collapsing (CMC) method unifies the advantages of both collapsing and multiple-marker tests.

## Background

Genotype phenotype association may be tested by:

* A single market test (i.e. GWAS) may use standard univariate statistical tests
(e.g., chi-squared test, Fisher's exact test, or Cochran Armitage test for trend) 
and with the family-wise error rate (FWER) controlled by a multiple-comparison correction (e.g., Bonferroni, permutation).
* A multiple-marker test, 
	- which tests multiple variant sites simultaneously with the use of multivariate methods, 
	- such as the Fisher product method, 
	- Hotelling's T test 
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
* For univariate tests, a contingency table can be constructed to compare genotype frequencies at each variant site in cases and controls. 
* Because an observation of individuals that are homozygous for the high-risk rare allele is extremely rare, AA genotypes are collapsed with Aa genotypes, and a table is constructed. 
* For an equal number of cases and controls, the classical Pearson chi-squared statistic for testing equal genotype frequencies in cases and controls is used.


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


# Madsen and Browning 2009

* A groupwise association test for rare mutations using a weighted sum statistic
{% cite madsen2009groupwise %}

## Background

* CAST: Cohort allelic sums test - an existing grouping method in which the number of individuals with one or more mutations in a group (e.g. gene) is compared between affected and unaffected individuals.

* Cites three papers:
	- [Cohen JC, Kiss RS, Pertsemlidis A, Marcel YL, McPherson R, et al. (2004) Multiple rare alleles contribute to low plasma levels of HDL cholesterol. Science 305: 869–872.] 
	- [Li and Leal 2008]
	- [Morgenthaler S, Thilly WG (2007) A strategy to discover genes that carry multi- allelic or mono-allelic risk for common diseases: A cohort allelic sums test (CAST). Mutation Research/Fundamental and Molecular Mechanisms of Mutagenesis 615: 28–56.]

* CMC: Combined Multivariate and Collapsing - the alternative method for grouping variants.
All rare variants are collapsed, 
as in the CAST method, 
and the collapsed variants are treated as a single common variant which is analysed together with the other common variants using multivariate analysis. 
In the CMC version used in [Li and Leal], 
rare variants are defined as those having a minor allele frequency (MAF) of at most 1%.

* In this study, they presume a group of candidate functional variants.

* Propose a weighted-sum method in which mutations are 
	- grouped according to function (e.g. gene), 
	- and each individual is scored by a weighted sum of the mutation counts.

* To test for an excess of mutations in affected individuals, they use permutation of disease status among affected and unaffected individuals.
	- Using permutation adjusts for the weighting of the mutations and the requirement that a mutation must be observed to be included in the study.

_Note that permutation of disease status results in correct type I error even in the presence of LD [Cheverud 2001, Churchill 1994], 
although relatively low LD is expected between rare variants [Li and Leal 2008, Pritchard 2001,2001]._

## Main theory

* The weighted-sum method deviates from the CAST method [5,27]:
weighting the variants differently when determining the genetic load of an individual. 
By weighting the signals from each mutation, 
the weighted sum method accentuates mutations that
are rare in the unaffected individuals, 
so that the test is not completely dominated by common mutations. 

* In the CAST method, 
	- common variants have a high impact on the group signal, 
	- and if many common mutations are present in a group, 
almost all individuals will have one or more mutations. 
	- To avoid this effect a threshold on the mutation-frequencies may be used,
as suggested in the CMC method [Li and Leal 2008]. 
	- May be difficulty to select biological meaningful threshold, affecting test outcome.

* In the weighted-sum method,
	- include mutations of all frequencies, 
	- but mutations are weighted according to their frequency in the unaffected individuals.

## Methods
### Weighted-Sum Method
Compares the number of mutations in a group of variants between case/control. 
Designed to identify an excess of mutations in case, compared to controls. 
Each variant belongs to a group (gene, pathway, etc.) and, 
for a group with L variants, the method is comprised of the following steps:

* (A)
	- For each variant, choose ALT/minor allele 
	- define number in cases/controls.
	- calculate the weight for a variant.
	- It is used to down-weight mutation counts in constructing the weighted-sum score; see (B) and (C) below

* Eqn 1: Weight
	- qi = ( ((no. mut allele in control) + 1)/(2(no. controls) +2) )
	- Wi = root (total samples x qi(1-qi))
	- For 10 case (7 mut), 10 control (5 mut),
weight for variant is 0.447

* Mutation freq of controls is used so that true signal in cases is not deflated by using to total number.
* A drawback when variance of scaled mut-freq, hence loss of power when mutation freq is high.
* The _one_ and _two_ to the numerator and denominator, respectively, avoids zero estimates - used on next steps.

* (B) 
	- Genetic score of each individual calculated.
	- j - Genetic score of individual.
	- Iij - number of mutations for variant i in individual j.
	- Generic model uses 0/1/2.
	- Recessive model only homozygous are assigned 1.
	- Dominant model both het and homo are assigned 1.

* (C)
	- All sample combined are ranked according to genetic scores.
	- The sum of ranks for cases is calculated.
	- Under null-hypothesis, normal distribution of random variables using a ranking procedure equivalent to that in Wilcoxon test.

* (D)
	- Case/control status is permuted 
	- steps (A)-(C) repeated k times to sampled X1,..Xk.

* (E) 
	- The average and sample standard deviation of X1,...,Xk are calculated and standardized score-sum is found (z).
	- Under the null hypothesis, this has an approximately standard normal distribution.
	- Thus, a p-value for association test can be obtained by comparing z in the quantiles of standard normal. 

* An alternative p-value calculation is also provided using a standard permutation with a stopping rule (slighly slower for their power similations). That also gives uniform (0,1) distributed p-value, which might be useful for further analysis. 

* Permutation of case/control labels maintains the LD structure. 

### Power simulations
Comparison of:

* Weighted-sum method,
* CAST, 
* CMC, 
* and variant-by-variant methods, 

For each set of parameters, 

* 100 datasets are simulated, 
* the four methods are applied, 
* and the proportions of significant outcomes used as the power estimates. 

To mimic a genome wide study of about 20,000 fairly independent human genes, 
we calculate a p-value for each gene, 
and use a significance threshold of 0.05/20000 = 2.561026 in all power simulations.

Genetic Models:

* Recessive, Additive and Dominant models: 
	- the disease-related variants act independently, 
* Recessive-Set model:
	- outcome of a mutation at one variant depends on the presence of a mutation at another variant.

Frequency spectra:

* Wright's formula used to sample the unaffected population frequency spectrum of the mutations at each variant
for the Recessive, Additive and Dominant models. 
e.g. _The mutation probability is calculated such that the probability (pM) that a haplotype contains at least one disease-risk mutation is fixed in unaffected individuals_.

A method for sampling is provided and ignored in this summary. 

A method is provided to compare models with damaging variants and benign variants.

NB. Tested Variants. 

* The mutation probabilities (p) can be very low for some of the sampled variants.
This means that some variants contain no mutations in any of the sampled individuals, and these variants are hence omitted in the tests.
## ENCODE data
The method was tested on rare variants with the frequency-spectrum of a naturally occurring population using the ENCODE resequencing data.

## Results

### Proportion of Variants Containing Mutations
The mutation frequencies are sampled according to Wright's formula, 
and hence mutations are very rare for some variants. 
Using 1000 affected and 1000 unaffected individuals, 
mutations are on average observed at only 49.4% of the variants (sd: 4.9%). 
This level is in concordance with the level from human resequencing studies.

Skipping the section: Power under Varying Model Parameters.

## Discussion

Analysis of pathways can be done in two different ways. 
One way is to use the pathway as a group, and run the test on the entire pathway. 
On the other hand, for large pathways, it may be beneficial to use a method that allows a gene with a strong signal to have a high impact on the combined pathway test-statistic (T). 
If a pathway contains G non-overlapping genes, a method to do this is to use the weighted-sum method on each gene, and combine the resulting p-values (p1,...,pG) with the Fisher product test statistic.


## Summary 

* Weight based on frequency of variat in the controls.
* Sum of ranks in cases.
* Case/control labels permuted n times, mean, SD, standardised score-sum found (z).
* p-value for association test obtained by comparing z in the quantiles of standard normal. 
* Alternative p-value using a standard permutation with a stopping rule gives uniform (0,1) distributed p-value, which might be useful for further analysis. 



# Price 2010

* Pooled association tests for rare variants in exon-resequencing studies.
{% cite price2010pooled %}
* The approach is based on the regression of 
	- phenotypic values 
	- on individuals' genotype scores 
	- subject to a variable allele-frequency threshold, 
	- incorporating computational predictions of the functional effects of missense variants.
* Statistical significance is assessed by permutation testing with variable thresholds.

## Methods

### Simulation Framework
Simplified summary:

* Model of European ancestry to recapitulate the site-frequency spectrum of non-synonymous human SNPs.
* 9kb for 10K individuals.
* Missense only.
* Phenotypes 
	- quantitative normal distribution
	- carrier and non-carrier same variance
	- carriers shifted by $$\delta$$ SD

### Weighted Approaches Correspond to Implicit Assumptions about Log Odds Ratios
{% cite madsen2009groupwise. %}
	- Based on the frequency in controls.
	- Relationship between log odds ratio and allele frequency the same as Madsen 2009.

### Fixed-Threshold Approach
{% cite madsen2009groupwise. %}

* i indexes SNPs, 
* Ci is the reference allele count of SNP i in cases, 
* and xi ($$\xi_i$$) is equal to 1 if the frequency of SNP i is below a specified threshold (1% or 5%) 
* and is equal to 0 otherwise.

* They generalise this for quantitative phenotypes.
	- add the term: pj ($$\pi_j$$) - the phenotype of sample j.
	-
I need to compare these two papers here in more detail 
(genetic score section).
{% cite madsen2009groupwise use a more complex $$\xi$$ term than is inferred: %}
	- Generic model uses 0/1/2.
	- Recessive model only homozygous are assigned 1.
	- Dominant model both het and homo are assigned 1.

### Weighted Approach
{% cite madsen2009groupwise. %}
* Also generalise by adding $$\pi_j$$ for a quantitative phenotype value.

### Variable-Threshold Approach
* There exists some (unknown) threshold T for which variants with a minor allele frequency (MAF) below T are substantially more likely to be functional than are variants with an MAF above T. 
* z-score of a regression across samples of phenotypes versus counts of mutations meeting the allele-frequency threshold T. 

### Cheating Approach to Incorporating $$\varphi(p)$$ ("phi(p)")
* Weight variants according to the probability $$\varphi(p)$$ 
	- that an allele of frequency p is functional, 
	- as inferred by using the same simulated data used to evaluate power.

### Incorporation of Computational Predictions of Functional Effects
* Tested if incorporation of PolyPhen-2 scores improves statistical test.
* To asses, simulated PolyPhen-2 predictions of damaging and neutral mutations.

### Application to Empirical Data Sets
Applied to some real data.

## Results and Discussion
* Skipping this.
* The methods are an improvement.
{% cite madsen2009groupwise. %}
* and additionaly adds a method for the quantitative variable.

# Neale 2011

* Testing for an unusual distribution of rare variants.
{% cite neale2011testing %}

## C-alpha tests
* They propose here the C-alpha test statistic as a novel approach for testing for 
	- the presence of this mixture of effects across a set of rare variants. 
* Unlike existing burden tests, C-alpha, by testing the variance rather than the mean, maintains consistent power when the target set contains both risk and protective variants. 

# SKAT

Rare-Variant Association Testing for Sequencing Data with the Sequence Kernel Association Test
{% cite wulee2011rare %}

## Introduction

* They propose the sequence kernel association test (SKAT), 
	- regression method to test for 
	- association between genetic variants (common and rare) 
	- in a region 
	- and a continuous or dichotomous trait 
	- while easily adjusting for covariates. 
* As a score-based variance-component test, SKAT can 
	- quickly calculate p values analytically by 
	- fitting the null model containing only the covariates, 
	- and so can easily be applied to genome-wide data. 


* A limitation for previous burden tests is that they implicitly assume that 
all rare variants influence the phenotype in the same direction 
and with the same magnitude of effect (after incorporating known weights). 
* However, one would expect most variants (common or rare) within a sequenced region 
to have little or no effect on phenotype, 
* whereas some variants are protective and others deleterious, 
* and the magnitude of each variant's effect is likely to vary (e.g., rarer variants might have larger effects).
* Collapsing across all variants is likely to introduce substantial noise.
* Burden tests require either specification of thresholds for collapsing 
* or the use of permutation to estimate the threshold.

## Methods

### Sequencing Kernel Association Test
*SKAT is a supervised test 
	- for the joint effects of multiple variants 
	- in a region 
	- on a phenotype. 
	-
* For each region, SKAT analytically calculates a p value for association while adjusting for covariates. 
* Adjustments for multiple comparisons are necessary for analyzing multiple regions, 
* for example with the Bonferroni correction or FDR control.

Notation:

* n subjects
* p variants
* covariates
* $$y_i$$ phenotype for sample i
* $$X_i$$ covariats
* $$G_i$$ genotypes (0,1,2 general)

### SKAT Model and Test for Linear SNP Effects
Eqn 1 and 2:

* linear regression and 
* logistic regression

Eqn 3:

* variance-component score statistic

* The weight is adjusted based on the MAF
	- if rarer variants are expected to be more likely to have larger effects.
	- still putting decent nonzero weights for variants with MAF 1%–5%.

* A special case of SKAT arises when the outcome is dichotomous, no covariates are included, and all $$W_j$$ = 1. 
* Under these conditions, we show in Appendix A that the SKAT test statistic Q is equivalent to the C-alpha test statistic T.

### Relationship between Linear SKAT and Individual Variant Test Statistics
* One needs to fit the null model only a single time to be able to compute the Sj for all individual variants j as well as all regions to be tested. 
* Similarly, if multiple regions are under consideration, then the same mb0 can be used to compute the SKAT Q statistics for each region.

### Accommodating Epistatic Effects and Prior Information under the SKAT
Ability to model the epistatic effects of sequence variants on the phenotype within the flexible kernel machine regression framework.

They replace Gi’b by a more flexible function f(Gi) in the linear and logistic models (1) and (2) where f(Gi) allows for rare variant by rare variant and common variant by rare-variant interactions

## SKAT Is a Generalization of the C-Alpha Test

* The recently proposed the C-alpha test has advantages over burden tests in that 
	- it explicitly models the possibility that minor alleles can be deleterious or protective. 
* However, it does not currently allow for the analysis of quantitative outcomes or the inclusion of covariates and p value calculation requires permutation. 
* They demonstrate that for a dichotomous trait in the absence of covariates, 
	- the C-alpha test statistic is equivalent to the SKAT statistic with unweighted linear kernel, 
	- which is the same as the kernel machine test in Wu et al.

# Lee 2012
## Introduction 
SKAT-O

* Optimal tests for rare variant effects in sequencing association studies.
{% cite Lee2012Optimal  %}

* A class of tests that include burden tests and SKAT as special cases, and derive an optimal test within this class that maximizes power. 

## Methods
* They show the SKAT method
* They show the buden testing methods
* The show a method for:
	- $$Q_p$$ = (1 - $$p$$)$$Q_{SKAT}$$ + $$pQ_{burden}$$
	- The resulting optimal test corresponds to a best linear combination of SKAT and burden tests that maximizes power. 

# Protein pathway analysis
## Zhang 2021 ASHG

Zhang et al. provide and excellent example of the same problem that we are
assessing. 
{% cite zhang2021computational %}
[A computational approach for detecting physiological homogeneity in the midst of genetic heterogeneity](https://www.sciencedirect.com/science/article/pii/S0002929721001543?dgcid=author)

I have never had a paper so similar to a project that we are currently working on.
Basically the only difference is:

1. the cluster size method (theirs might work better, using total edge weights instead of protein count),
2. cluster separation by NHC instead of MCL,
3. using KEGG+REACTOME to additionally define the description of the cluster (but this can be done at the end).
4. The method in main analysis is carrier count instead of SKAT style (we have compared both).

Same cohort size. Really nice to see it in ASHG. Will have to do a comparison to per-gene SKAT-O to show the improvement, as they do.

## Problems with this paper

### Cluster method
I surprised to see them apply their own novel clustering method (NHC) without some formal methods paper first - so many already exist, including 10 that can be used with their String data. 
In theory it sound good but there is no real evidence.

### Carrier counts instead of allele dosage
Their main analysis is:

* (a) with PC-adj = glm(Pheno ~ Carrier-status + PCs, family=binomial). 
	- The information for carrier status is missing, presumably 0/1 resulting in a sort of burden test.
* (b) without PC-adj = fisher exact test. 
	- When doing this we got great results with for our earlier tests but thought it might be too simplistic.
* Using pathway SKAT-O (accounts for frequency/dosage) they got poorer results.

Main problems here: 

One count per gene (as data\$CARRIER in analysis) presumes that any variant (homozygous or heterozygous, compound het, etc) is deleterious in the individual.
In restricted to LoF then OK, but missense variants are included in the study (and will usually be the majority of candidates).
Filters are applied to get a high quality list, but there will still be a majority of missense VUS.

In the section "Application to an HSE cohort (V): 
Comparison with a burden test on the HSE cohort", SKAT-O is not a burden test; 
while their method is actually more similar to a burden test since they are labelling an individual if they carry a qualifying variant in a gene. 
This is just a terminology error but it indicates that maybe the key differences in pathway testing have not been considered, as written up here in our review.

One could argue that only counting once per gene could help prevent problems due to LD.
Although, the WES/WGS data would have the phasing information included to prune out LD if that was the argument.
Basically, I think this is just a simplification rather than an advantage. 
If SKAT had happened to work better they would have used those results. 

e.g. In Fig 3, TLR3 variants = 7 cases, 1 Hom, 9 Het.
This seems to amount to a carrier status of 7 in their dataset for the glm and fisher exact.

Their main analysis:

``` bash
# call R command to run pc-adj enrichment
ro.r("data <- read.table('temp_pc.txt', header=T, sep='\t')")
ro.r("fit <- glm(data$PHENOTYPE ~ data$CARRIER+data$PC1+data$PC2+data$PC3, family='binomial')")
ro.r("adjusted.pval <- anova(fit, test='LRT')[2, 5]")
r_pvalue = ro.r("adjusted.pval")
pvalue = r_pvalue[0]
pvalue = float('%.3E' % Decimal(pvalue))
file_out.write(str(pvalue) + '\t')

# pathway enrichment
this_case_pathway_hit = dict()
for each_pathway in pathway_gene_set_dict.keys():
	pathway_gene_set = pathway_gene_set_dict[each_pathway]
	case_pathway_overlap = this_case_gene_set & pathway_gene_set
	case_in = len(case_pathway_overlap)
	case_out = len(this_case_gene_set) - case_in
	pathway_in = len(pathway_gene_set)
	pathway_out = len(pathway_genes) - pathway_in
	if case_in != 0:
		odd, pvalue = stats.fisher_exact([[case_in, case_out], 
		[pathway_in, pathway_out]], alternative='two-sided')
		adj_pvalue = pvalue * pathway_size
		if adj_pvalue < 0.00001:
			adj_pvalue = float('%.3E' % Decimal(adj_pvalue))
			this_case_pathway_hit[each_pathway] = adj_pvalue

# They do not show any code with the SKAT parameters, presumably defaults using R.
```

# Itan & Casanova contributions
## Historical review

We are tackling this problem of protein pathway analysis from the viewpoint of 
rare immune disease and infection.
Historically, several topics in bioinformatic and functional analysis have 
been required before we could achieve our current position of 
statistically-robust genetic discovery for rare disease:

1. Candidate variant select for individual genomes
2. Compiling reliable cohorts of patients with shared phenotypes
3. Protein-protein interactions
4. Variant collapse
5. Protein pathway analysis
6. Functional validation

Therefore, a historical review of the timeline is beneficial to illustrate the 
technical successes that allow us to reliably produce candidate variants by
genome sequencing and to validate statistically-driven results by _"traditional"_
functional validation. 
These steps [1, 2 and 6 in our list] are exemplified by the following 
historical review. 
The complete list of steps 1-6 are touched on, 
but full validation of each step is the culmination of what we are currently 
working on and will be explicitly reviewed when we have completed our study.

As one of the leaders in this field, Casanova lab has provided a lot of insider
history to the story in a great twitter thread
<https://twitter.com/casanova_lab/status/1397539593608695808>.
The literature for discussion is first listed here to facilitate downloading 
but sources are referenced as usual throughout. 

---

2013 PNAS. The human gene connectome as a map of short cuts for morbid allele discovery.
{% cite itan2013human %}
<https://pubmed.ncbi.nlm.nih.gov/23509278/>

2014 BMC Gen. HGCS: an online tool for prioritizing disease-causing gene variants by biological distance.
{% cite itan2014hgcs %}
<https://pubmed.ncbi.nlm.nih.gov/24694260/>

2015 Front. Novel primary immunodeficiency candidate genes predicted by the human gene connectome.
{% cite itan2015novel %}
<https://pubmed.ncbi.nlm.nih.gov/25883595/>, 

2015 PNAS. The human gene damage index as a gene-level approach to prioritizing exome variants.
{% cite itan2015human %}
<https://pubmed.ncbi.nlm.nih.gov/26483451/>

2016 NatMet. The mutation significance cutoff: gene-level thresholds for variant predictions.
{% cite itan2016mutation %}
<https://pubmed.ncbi.nlm.nih.gov/26820543/>

2015 PNAS. Can the impact of human genetic variations be predicted?
{% cite itan2015can %}
<https://pubmed.ncbi.nlm.nih.gov/26351682/>

2018 Bioinf. PopViz: a webserver for visualizing minor allele frequencies and damage prediction scores of human genetic variations.
{% cite zhang2018popviz %}
<https://pubmed.ncbi.nlm.nih.gov/30535305/>

2019 PNAS. Blacklisting variants common in private cohorts but not in public databases optimizes human exome analysis.
{% cite maffucci2019blacklisting %}
<https://pubmed.ncbi.nlm.nih.gov/30591557/>

2019 NAR. SeqTailor: a user-friendly webserver for the extraction of DNA or protein sequences from next-generation sequencing data.
{% cite zhang2019seqtailor %}
<https://pubmed.ncbi.nlm.nih.gov/31045209/>.

2020 Hum Gen. The human genetic determinism of life-threatening infectious diseases: genetic heterogeneity and physiological homogeneity?
{% cite casanova2020human %}
<https://pubmed.ncbi.nlm.nih.gov/32462426/>

2021 JCI. Herpes simplex encephalitis in a patient with a distinctive form of inherited IFNAR1 deficiency.
{% cite bastard2021herpes %}
<https://pubmed.ncbi.nlm.nih.gov/32960813/>

2021 JCI. TLR3 controls constitutive IFN-β antiviral immunity in human fibroblasts and cortical neurons.
{% cite gao2021tlr3 %}
<https://pubmed.ncbi.nlm.nih.gov/33393505/>

2021 AJHG. A computational approach for detecting physiological homogeneity in the midst of genetic heterogeneity
{% cite zhang2021computational %}
<https://pubmed.ncbi.nlm.nih.gov/34015270/>

---

To date, the main paper that implements protein pathway analysis for rare 
immune disease is that by
Peng Zhang and 
Yuval Itan {% cite zhang2021computational %}.

The history begins with determining methods for candidate variant selection - 
the main challenge in human genomics, 
especially for individual patients who can benefit from precision medicine. 
Over the last decade, we have reached a point where we can now reasonably 
discern individual candidate-causal variants from the background noise of 
genomic variability.

From the authors' perspective, the project began around 2011 and its first 
step was concluded in 2013 with 
Yuval Itan's
first "Human Gene Connectome" paper 
while he was a post-doc with Casanova lab. 
{% cite itan2013human %}.
This software connected genes like streets in a map, 
based on their physiological relatedness.
It was soon followed by methodological development 
{% cite itan2014hgcs %}
and application to inborn errors of immunity 
{% cite itan2015novel %}
or both 
{% cite itan2015human %},
and a couple of necessary detours 
{% cite itan2016mutation %}
and 
{% cite maffucci2019blacklisting %}.
A review was also written by two of the main authors during the same period
{% cite itan2015can %}.

When Peng Zhang joined the Casanova lab as post-doc, 
Yuval Itan had started his own lab. 
However, the pair worked together to continue producing the papers on variant
interpretation and data processing
{% cite zhang2018popviz %}
and
{% cite zhang2019seqtailor %}.

After completing this period of work, 
they renamed "Human Gene Connectome II" the 
"Network-based Heterogeneity Clustering".
At this point, their aims were defined as being generally indistinguishable 
from ours. 
That is, _"the detection of physiological homogeneity in a cohort of patients 
sharing a clinical phenotype but with high genetic heterogeneity - 
a hallmark of severe infectious diseases"_ (Casanova via twitter), 
as presented in their next paper on this topic
{% cite casanova2020human %}.

Shen-Ying Zhang came on board as senior author on the next two papers.
With an excellent database of immune disorders and infections, 
the team could gradually build their software.
Exomes from patients with HSV-1 encephalitis were used for testing successive 
versions in
{% cite bastard2021herpes %} 
and 
{% cite gao2021tlr3 %}.

Quoting Casanova _"When they were capable of detecting the known TLR3-IFN needles in the HSE stack, they installed camp 1, rested a bit and reported to me on the radio, while I was watching them from the basecamp with binoculars. I encouraged them to push for the final ascent and they did."_

With the same goal as our own - 
producing unbiased methods for detection of biologically-connected causal 
genetic variation - 
they found new gene variants that interact via the TLR3-IFN protein pathway,
in individual patients. 
Shen-Ying Zhang found them to be biochemically deleterious, 
an important factor for validation of genetic-first aproaches. 
In this case, Zhang _et al_ get as close to the _"gold-standard"_ 
as anyone to date.

The functional validation of candidate variants in disease then provided a proof-of-principle indication that they could detect physiological homogeneity in the midst of genetic heterogeneity 
{% cite zhang2021computational %}.

Quoting Casanova 
_"A computational approach for detecting physiological homogeneity in the midst of genetic heterogeity.
That was terrific!"_.

---

> An aside on what I call the _"gold-standard"_ for our field should be:
> 1. Unbiased statistical detection of a genetic phenomenon.
> 2. Validation by functional models under systematic control.
> 
> Part [1] Depends on patient cohorts that are large enough to detect the effect based on the phenotype strength - difficult for _rare disease_.\
> Part [2] Depends on independently testing biological mechanisms. 
>
> This second step generally consists of two hurdles:
> * If the same researchers perform (1) genetic stats and (2) functional work, 
> there is a bias that is difficult to avoid when trying to functionally 
> validate statistically positive results.
> * If the statistical genetic associations happen to contain a false positive 
> for something like severe rare immune disease, 
> the sensitive functional models may detect a damaging response. 
> One might find a truly damaging biological mechanism, 
> but if the statistical genetic association is not correct then this 
> biological mechanism should not be deemed causal; 
> back-tracking at this stage would be very difficult due to self-imposed bias. 
> 
> Ideally, in the future we hope to see a separation of the two steps 
> (stat genetics and wet-lab) such that each are performed independently. 
> The wet-lab would also ideally focus their routines on a particular protein 
> pathway/system with SOPs that improve accuracy and precision 
> (e.g. clinical diagnostics labs, clinical trials) rather than setting up 
> models for each new study.

---

Returning to our historical review, 
we have been producing our protocols similarly in parallel.
With patient cohorts of comparable sizes and phenotypes we will soon 
have a complementary validation of protocols.
However, great care is also being taken to test and select the most reliable 
statistical methods for association testing - 
an improvement to the fine work by
{% cite zhang2021computational %}.

Best practices in candidate variant selection protocols are basically 
standardised as of 2021, 
so the main remaining task is standardisation of the protein-pathway 
annotation and association testing methods - 
steps which we will soon be ready to publish after peer-review.

# Burden test power calculation

``` R
This code seems to work
# This script tests then the minimum number of heterozygous mutations that can exist in a test set to reach significance.

# Required inputs, can be modified to read data variable
# SAMPLES (equal case and control)
# SNPs (the number of SNPs in the test pathway, can modify to loop every pathway)
# CMC settings may need adjustment to match your model

library(AssotesteR)

# Pathway size of 5 SNPs
# 100 case and 100 controls

# for (SNPs in 1:3) {
 for (SNPs in 10) {

  SAMPLES = 100
  TOTAL = SAMPLES*SNPs

for(i in 1:TOTAL) {
  # cases
    val_1 <- replicate(i,0)
    x <- (TOTAL-i)
    val_2 <- replicate(x,0)
    
    # cases
    val_3 <- replicate(i,0)
    y <- (TOTAL-i)
    val_4 <- replicate(y,1)

    # combine
    mat1.data <-  (c(val_1, val_2, val_3, val_4))
    
    # contols then cases
    genotype <- matrix(mat1.data,nrow=(SAMPLES*2),ncol=SNPs,byrow=TRUE)
    #print(genotype)
    
    stat <- matrix(genotype, dimnames=list(t(outer(colnames(genotype), rownames(genotype), FUN=paste)), NULL))
    print(paste("for", 
                SAMPLES, "cases and ",
                SAMPLES, "controls:"))
    print(paste("with", SNPs, "candidate pathway SNPs"))
    print(paste(sum(stat),
                 "mutations per", TOTAL, "total nucleotides in cases"))
    print(paste(
                 "0 mutation per", TOTAL, "total nucleotides in controls."
                 ))

    # number of cases
    cases = SAMPLES
    
    # number of controls
    controls = SAMPLES
    
    # total (cases + controls)
    total = cases + controls
    
    # phenotype vector
    phenotype = c(rep(0,controls), rep(1,cases))
    #print(phenotype)
    
    #mycmc = CMC(phenotype, genotype, maf=0.0000001, perm=100)
    #print(mycmc)
    myskat = SKAT(phenotype, genotype, kernel = "linear")
    print(myskat["asym.pval"])
}
}
```

However, I am filling up SNPs columns so that all cases get the variant mutation. 
I believe SKAT will give a better score to 5 unique variants rather than 5 shared variants.
Therefore, I am currently revising the code.

``` R
# SKAT: Sequence Kernel Association Test 
# 
# [1] "for 100 cases and  100 controls:"
# [1] "with 5 candidate pathway SNPs"
# [1] "18 mutations per 500 total nucleotides in cases"
# [1] "0 mutation per 500 total nucleotides in controls."
# $asym.pval
# [1] 0.04799332
# 
# 
# [1] "for 100 cases and  100 controls:"
# [1] "with 10 candidate pathway SNPs"
# [1] "36 mutations per 1000 total nucleotides in cases"
# [1] "0 mutation per 1000 total nucleotides in controls."
# $asym.pval
# [1] 0.04799332
```
You can view to genotype matrix constructions by uncommenting 
``` R
 # print(genotype).
```

Exmple:
``` R
[198,]    0    0    0    0    0
[199,]    0    0    0    0    0
[200,]    0    0    0    1    1
[1] "for 100 cases and  100 controls:"
[1] "with 5 candidate pathway SNPs"
[1] "2 mutations per 500 total nucleotides in cases"
[1] "0 mutation per 500 total nucleotides in controls."
$asym.pval
[1] 0.3165047
```

I will instead try to construct the test set with uniq variants rather than shared. I only realised the problem at the end.
An example of what we want instead is - checking the P-value and combinations of variants. 
Then we will find the real minimum variant count required to pass significance:

``` R 
# With a small test set
# 2 case, 2 control, 4 positions
# 1 control SNP, 3 case SNP

cases = 2
controls = 2
phenotype = c(rep(0,controls), rep(1,cases))

x <- expand.grid(c(0,1),c(0,1),c(0,1), c(0,1))
geno1 <- x[c(1,2, 3,4),c(1:4)]
geno2 <- x[c(1,2, 9,13),c(1:4)]
geno3 <- x[c(1,2, 1,14),c(1:4)]
geno4 <- x[c(1,2, 1,15),c(1:4)]

geno1
(SKAT(phenotype, geno1, kernel = "linear")["asym.pval"])
geno2
(SKAT(phenotype, geno2, kernel = "linear")["asym.pval"])
geno3
(SKAT(phenotype, geno3, kernel = "linear")["asym.pval"])
geno4
(SKAT(phenotype, geno3, kernel = "linear")["asym.pval"])


# > geno1
#   Var1 Var2 Var3 Var4
# 1    0    0    0    0
# 2    1    0    0    0
# 3    0    1    0    0
# 4    1    1    0    0
# $asym.pval [1] 0.0619688
# 
# > geno2
#    Var1 Var2 Var3 Var4
# 1     0    0    0    0
# 2     1    0    0    0
# 9     0    0    0    1
# 13    0    0    1    1
# $asym.pval [1] 0.0311075
# 
# > geno3
#     Var1 Var2 Var3 Var4
# 1      0    0    0    0
# 2      1    0    0    0
# 1.1    0    0    0    0
# 14     1    0    1    1
# $asym.pval [1] 0.0311075
# 
# > geno4
#     Var1 Var2 Var3 Var4
# 1      0    0    0    0
# 2      1    0    0    0
# 1.1    0    0    0    0
# 15     0    1    1    1
# $asym.pval [1] 0.0311075
```

# References 

{% bibliography --cited %}
