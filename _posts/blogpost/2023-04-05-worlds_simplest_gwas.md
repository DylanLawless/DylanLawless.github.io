---
layout: post
title: Worlds simplest GWAS
date: 2023-04-05 00:00:01
tags: genomics
status: finished
---

{{ page.title }}
================
<p class="meta">18 Jan 2022</p>

* TOC
{:toc}

To answer a Q about how to start with GWAS, examples are helpful.
For a GWAS we need some genotype data and some phenotype data.


## Datasets
* For each patient, the genotype data might consist of 500'000 variant positions in the genome (SNPs). 
* You could imagine this as a file containing a matrix with 500'000 columns (SNPs) and one row per patient (e.g. 500 patients).
* At each SNP the data will say either:
	- "reference" (wild-type) encode as 0 (e.g. A/A)
	- "variant" (heterozygous variant) encoded as 1 (e.g. A/T)
	- "variant" (homozygous variant) encoded as 2 (e.g. T/T).
* A second file might have phenotype data. For example it could be protein abundace measured by mass spectrometry (MS), with one column per protein (1000 proteins) and one row per patient (e.g. 500 patients).

### Genotype matrix

| Sample   | SNP 1 | SNP 2 | SNP 3 | SNP 4 | SNP 5 | SNP 6 | SNP 7 | SNP 8 | SNP 9 | SNP 10 |
| -------- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- | ---- |
| Sample1  | 2 | 2 | 0 | 0 | 1 | 2 | 2 | 0 | 1 | 1 |
| Sample2  | 0 | 1 | 2 | 2 | 0 | 2 | 1 | 1 | 1 | 1 |
| Sample3  | 2 | 1 | 0 | 0 | 1 | 2 | 0 | 0 | 1 | 2 |
| Sample4  | 1 | 2 | 1 | 0 | 0 | 2 | 0 | 2 | 2 | 1 |
| Sample5  | 2 | 1 | 1 | 0 | 0 | 2 | 0 | 1 | 1 | 0 |
| Sample6  | 1 | 2 | 0 | 0 | 1 | 1 | 1 | 0 | 0 | 2 |
| Sample7  | 2 | 1 | 2 | 2 | 2 | 2 | 2 | 1 | 1 | 2 |
| Sample8  | 0 | 2 | 1 | 2 | 1 | 0 | 2 | 1 | 2 | 2 |
| Sample9  | 0 | 0 | 0 | 1 | 1 | 2 | 0 | 0 | 1 | 0 |
| Sample10 | 1 | 0 | 0 | 0 | 2 | 0 | 1 | 1 | 0 | 2 |

### Phenotype matrix

| Sample | protein 1 | protein 2 | protein 3 | protein 4 | protein 5 |
| ------ | -------- | -------- | -------- | -------- | -------- |
| Sample1 | 7 | 5 | 1 | 9 | 1 |
| Sample2 | 5 | 4 | 6 | 3 | 8 |
| Sample3 | 8 | 7 | 8 | 8 | 7 |
| Sample4 | 3 | 8 | 5 | 3 | 8 |
| Sample5 | 2 | 4 | 9 | 6 | 2 |
| Sample6 | 7 | 2 | 8 | 4 | 2 |
| Sample7 | 2 | 2 | 3 | 7 | 2 |
| Sample8 | 8 | 4 | 7 | 2 | 8 |
| Sample9 | 1 | 1 | 7 | 4 | 9 |
| Sample10 | 1 | 3 | 7 | 6 | 3 |

## Experiment
* At SNP1, and protein 1, you might run a linear regression using R or [plink](https://zzz.bwh.harvard.edu/plink/index.shtml) software, between the outcome "SNP" and the predictor "protein level".
* That will result in a p-value and other stats about the association between that SNP1 genotype (predictor) and protein 1 level (outcome _or dependent variable_) for all patients in the study. 
* It will answer the Q: _is this nucleotide (genotype) associated with an increase or decrease in this protein?_
* This one test is then repeated for every SNP (500'000 times) _and_ for every protein (1000 times). 
* With plink software it may take ~2hours to complete. But most of the researcher's time is spent in preparation by looking at the summary information about the SNPs and proteins (frequency of SNPs, level range of proteins, etc.).


## Coded example

Here is an example using R. It has
* 6 patients
* 2 SNPs (predictor) 
* protein measurement (outcome _or dependent variable_) 

It runs an association test (linear regression) between the SNP (nucleotide A or T) and protein level (0.2-0.9).

### glm_loop.R
```R
library(dplyr)

# Test each SNP 1 and 2 for status/outcome
# status 0 = A/A nucleotide, status 1 = A/T nucleotide variant.
# outcome = phenotype measurement (clinical feature, protein level, etc,)
SNP <- c(1, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 2)
status <- c(0, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1)
outcome <- c(0.2, 0.2, 0.2, 0.2, 0.9, 0.9, 0.2, 0.2, 0.2, 0.2, 0.9, 0.9)

# make a dataframe
df <- data.frame(SNP, status, outcome, stringsAsFactors = FALSE)

# status is a factor rather than a number
df$status <- as.factor(df$status)

# Test association between SNP1 and outcome by linear regression
df_1 <- df %>% filter(SNP == 1)

linear_reg <- glm(outcome ~ status,
				 data = df_1,
				 family = "gaussian")

summary(linear_reg)
coef(summary(linear_reg)) # show the main info only

# Test association between SNP2 and outcome by linear regression
df_2 <- df %>% filter(SNP == 2)

linear_reg <- glm(outcome ~ status,
				 data = df_2,
				 family = "gaussian")

summary(linear_reg)
coef(summary(linear_reg))

# Instead of testing each SNP manually
# Test SNP1 and SNP2 using a loop directly from df
coef(summary(linear_reg))

lapply(split(df, df$SNP), function(x)
	coef(summary(
		glm(outcome ~ status, family = "gaussian", data = x)
	)))

# Maybe just save the P-values to know which SNPs have a significant association (Pval < 0.05)
# [,'Pr(>|t|)'] shows the Pval only in row "status1".  
l <- lapply(split(df, df$SNP), function(x)
					coef(summary(
						glm(outcome ~ status, family = "gaussian", data = x)
					))[, 'Pr(>|t|)'])

as.data.frame(l) # X1 = SNP1. 

```

#### Result
``` R
> df
SNP status outcome
1    1      0     0.2
2    1      0     0.2
3    1      1     0.2
4    1      0     0.2
5    1      1     0.9
6    1      1     0.9
7    2      0     0.2
8    2      1     0.2
9    2      1     0.2
10   2      0     0.2
11   2      1     0.9
12   2      1     0.9

# Result
> lapply(split(df, df$SNP), function(x)
+ 	coef(summary(
+ 		glm(outcome ~ status, family = "gaussian", data = x)
+ 	)))
$`1`
             Estimate Std. Error  t value  Pr(>|t|)
(Intercept) 0.2000000  0.1649916 1.212183 0.2921436
status1     0.4666667  0.2333333 2.000000 0.1161165

$`2`
            Estimate Std. Error  t value  Pr(>|t|)
(Intercept)     0.20  0.2474874 0.808122 0.4643386
status1         0.35  0.3031089 1.154701 0.3125000
```

## Real world
After this example, go read:

Uffelmann, E., Huang, Q.Q., Munung, N.S. et al. Genome-wide association studies. Nat Rev Methods Primers 1, 59 (2021). 
<https://doi.org/10.1038/s43586-021-00056-9>

## Other code
The tables above were generated as follows:

```R
# Genotype matrix
# Create a dataframe with 10 rows and 10 columns
df <- data.frame(matrix(nrow = 10, ncol = 10))

# Fill the dataframe with values 0, 1, and 2
for(i in 1:10) {
	for(j in 1:10) {
		df[i, j] <- sample(0:2, 1)
	}
}

# Set the column names to SNP1-SNP10
colnames(df) <- paste0("SNP", 1:10)

# Set the row names to Sample1-Sample10
rownames(df) <- paste0("Sample", 1:10)

# View the resulting dataframe
df
```

```R
# Phenotype matrix
# Create a dataframe with 10 rows and 5 columns
df <- data.frame(matrix(nrow = 10, ncol = 5))

# Fill the dataframe with random values between 1 and 9
for(i in 1:10) {
	for(j in 1:5) {
		df[i, j] <- sample(1:9, 1)
	}
}

# Set the column names to protein1-protein5
colnames(df) <- paste0("protein", 1:5)

# Set the row names to Sample1-Sample10
rownames(df) <- paste0("Sample", 1:10)

# View the resulting dataframe
df
```