<!-- --- -->
<!-- layout: topic -->
<!-- title: Genome wide assocciation study -->
<!-- created: 8 Sep 2020 -->
<!-- date: 2020-09-08 -->
<!-- bibliography: -->
<!-- - '../tail/bibliography.bib' -->
<!-- tags: genomics -->
<!-- subject: Precision medicine -->
<!-- --- -->
<!-- {{ page.title }} -->
<!-- ================ -->

<!-- * TOC -->
<!-- {:toc} -->

# Abbreviations
BWA (Burrows-Wheeler transformation aligner), 
GrCh38 (Genome Reference Consortium Human Build 38), 
VCF (variant call format).

# Very basic overview
Genomewide Association Studies and Assessment of the Risk of Disease, [Manolio N Engl J Med 2010.](https://www.nejm.org/doi/full/10.1056/NEJMra0905980)
# Benefits and limitations of genome-wide association studies

[Tam et al. 2019](https://pubmed.ncbi.nlm.nih.gov/31068683/)
[pdf](https://www.gwern.net/docs/genetics/heritable/2019-tam.pdf)

<https://personal.broadinstitute.org/howrigan/workshop/GWAS_QC_Howrigan_July2020.pdf>

# Sample collection and genotyping
A good paper on the "Basic statistical analysis in genetic case-control studies" by [Clarke et al. 2011](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3154648/).
Genomic control: [wiki](https://en.wikipedia.org/wiki/Population_structure_(genetics)

# Pre-imputation
Before imputation with study genotypes, filter the data to remove low-quality variants and samples. 
Standard GWAS quality control filters are usually sufficient to prepare a dataset for imputation. 
It may also help to add an imputation-based QC step to the filtering process.

[Coleman et al. 2016](https://academic.oup.com/bfg/article/15/4/298/2412127)

# Imputation

## File formats
The file format required depends on the method chosen.
VCF file is the most common input type (e.g. Sanger imputation).
Plink format files (bim, bed, fam, or pgen, psam ) can be converted to VCF using Plink.
VCF may be converted to a gen file (e.g. Impute2).

**Example**
Plink binary files to VCF.
https://www.cog-genomics.org/plink/1.9
```bash
plink --bfile binary_fileset --recode vcf --out new_vcf
```

## Imputation services
Online: Sanger Imputation server
[sanger.ac.uk](https://www.sanger.ac.uk/tool/sanger-imputation-service/)
is a genotype imputation and phasing service provided by the Wellcome Sanger Institute. 
You can upload GWAS data in VCF or 23andMe format and receive imputed and phased genomes back. 
Optional pre-phasing is with EAGLE2 or SHAPEIT2 and imputation is with PBWT into a choice of reference panels including 1000 Genomes Phase 3, UK10K, and the Haplotype Reference Consortium.

Online: Michigan Imputation Server
[imputationserver.sph.umich.edu](https://imputationserver.sph.umich.edu/index.html#!)
based on 
[Foreret al. 2016](https://pubmed.ncbi.nlm.nih.gov/27571263/)
.
Open source, offers methods to build your own server.
Reference panels: 
HapMap Release 2.
1000 Genomes,
Phase 1 and 3,
CAAPA,
African American,
Haplotype Reference Consortium.

Local software: IMPUTE version 2 (also known as IMPUTE2) is a genotype imputation and haplotype phasing program based on ideas from 
[Howie et al. 2009](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1000529)
but has features from additional publications.
From Impute2, the process is summed up as "the most common scenario in which imputation is used: 
unobserved genotypes (red question marks) in a set of study individuals are imputed (or predicted) using a set of reference haplotypes and genotypes from a SNP chip.

# Information score
Since the imputation non-genotyped variants is based on a reference panel that
may not fully represent the ancestry of a study cohort, a quality score may be 
desired.
One tool is SNPTEST
[mathgen.stats.ox.ac.uk](https://mathgen.stats.ox.ac.uk/genetics_software/snptest/snptest.html#info_measures).
From mathgen.stats.ox.ac.uk, the IMPUTE info measure reflects the information in imputed genotypes relative to the information if only the allele frequency were known. 

{% raw %}
$$ \text{info} = 1 - \text{mean} (
\frac {
\text{ variance in imputed genotype} }
{ \text{variance if only allele frequency were known} }
) $$

The numerator of this expression is computed over the imputed genotype distribution for each sample. The denominator is computed using the estimated allele frequency

$$
\theta = \sum_{i} 
\frac{
P(g_{i}=1)+2P(g_{i}=2)) }
{2\sum_{i,g}P(g_{i}=g) }
$$

and the assumption of Hardy-Weinberg equilibrium.
The info measure takes the value 1 if all genotypes are completely certain, 
and the value 0 if the genotype probabilities for each sample are completely uncertain in Hardy-Weinberg proportions 
(i.e. they equal
$$
(1-\theta)^{2}, 2\theta(1-\theta), \theta^{2}). 
$$
It is also possible for info to drop below zero.

Info is usually computed as if assuming all samples are diploid and that the genotype probabilities for each sample sum to one. This is what IMPUTE computes, and also what SNPTEST computes when you use a method other than newml.
Haploid samples, e.g. for males on the X chromosome, will be treated a little differently.
This can be done with -method newml (maximum likelihood test). 
Discussion is not warrented here but can be read at
[snptest measures](https://mathgen.stats.ox.ac.uk/genetics_software/snptest/snptest.html#info_measures) and
[snptest.v2.pdf](https://mathgen.stats.ox.ac.uk/genetics_software/snptest/snptest.v2.pdf).

{% endraw %}

# Get snptest summary with impute information score¬
Here is an example of a script that might get this value for all genotype files.
The cohort of 1,000 individuals may have data split into 22 files (one per chromosome),
and each chromosome split into managable sizes of 100,000 SNPs giving maybe 600 individual files in the format:
Chr1.pos10024053-15008865.impute2.
The input -data files will be (1) the genotype gen file and (2) the sample list.

```bash
# Use 22 cores to run in parallel
for i in {1..22}
do
for file in Chr$i.*impute2
do
›   ~/tool/snptest_v2.5.4-beta3_\
linux_x86_64_dynamic/snptest_v2.5.4-beta3 \
›   -data $file \
›   Samples_IDs \
›   -filetype gen \
›   -summary_stats_only \
›   -o $file\_snptest
done &
done
wait
```
The output might look something like this (with only 4 columns shown - the real output would have much more information).
A threshold will be set to decide what quality will be used for your analysis, 
e.g. >0.7.

| chr 	| rsid                     	| position 	| A1 	| A2 	| info     	|
|-----	|-------------	|----------	|----	|----	|----------	|
| 1   	| rs70998334 	| 10027728 	| T  	| TA 	| 0.990047 	|
| 1   	| rs191096997 	| 10027884 	| A  	| G  	| 1        	|


# Imputation to Plink format
File formats output

# Quality control
## Relatedness
## Missingness
## Genotype
## HWE

# Phenotypes and covariates

# PCA

# Biological interpretation

# Conclusion


# Command line example code
**Whole exome analysis**

```bash


```
