---
layout: topic
title: Principal Components Analysis 2
created: 2023-04-23
tags: statistics
status: finished
subject: statistics
---
{{ page.title }}
================
* TOC
{:toc}

This material is reproduced based on the examples from:
Oxford handbook of medical statistics (Janet Peacock Philip J Peacock) [1].

## Exploring Principal Components Analysis

### Understanding Multivariate Methods
- Used to analyze multiple outcome variables at once, as opposed to single outcome variables
- Aims to simplify complex datasets for easier interpretation

### What is Principal Components Analysis (PCA)?
- Reduces datasets with many inter-correlated variables to a smaller set of uncorrelated variables
- Also known as 'reducing the dimensionality of a dataset'
- The smaller set of variables is used in subsequent analyses

### How PCA Works
- Generates a set of principal components (PCs), each being a linear combination of original variables
- Maximum of *n* PCs can be computed for *n* variables
- PCs explain a proportion of total variability, with the first PC explaining the maximum amount, and subsequent PCs explaining progressively smaller amounts

### PCA Equations
- Original variables: $$x_1, x_2, x_3, \dots, x_p$$
- PCA generates *p* principal components: $$y_1, y_2, y_3, \dots, y_p$$
- PCs are defined as:
	- $$y_1 = b_{11}x_1 + b_{12}x_2 + \dots + b_{1p}x_p$$
	- $$y_2 = b_{21}x_1 + b_{22}x_2 + \dots + b_{2p}x_p$$
	- $$y_p = b_{p1}x_1 + b_{p2}x_2 + \dots + b_{pp}x_p$$
- $$b_{11}, b_{12}$$, etc., are coefficients

### Practical Aspects
- Common practice to include enough PCs to explain at least 80% of total variability, often just two or three
- PCA generates a single value for each PC for each subject, creating new variables
- These new variables are used in further analyses like other variables

### Interpreting Principal Components
- Specific PCs may represent an overarching theme with contributions from several original variables

### Example: PCA in Lung Function Tests

Researchers wanted to identify important features of six lung function tests in 458 coalminers [1]. 
They used PCA and reduced the six tests to three meaningful respiratory components. The results are summarized in the following table:

| Component | 1st    | 2nd   | 3rd   | 4th   |
|-----------|--------|-------|-------|-------|
| FEV1      | -0.46  | 0.18  | 0.23  | -0.26 |
| FVC       | -0.38  | 0.58  | -0.22 | -0.24 |
| FEV1/FVC  | -0.38  | -0.57 | -0.24 | -0.52 |
| Vmax50    | -0.44  | -0.32 | 0.12  | 0.05  |
| Vmax25    | -0.43  | -0.21 | 0.17  | 0.77  |
| TLCO      | -0.35  | 0.41  | -0.83 | 0.14  |
| % Variability | 74%  | 15%  | 7%    | 3%    |

### Advantages and Disadvantages of PCA
- Replaces inter-correlated variables with a smaller set of independent components, capturing key features of original data
- Overcomes colinearity problems in complex predictor variables, making it easier to examine possible predictor variables
- Each component is a new variable, which is a linear combination of the original variables, making actual component values harder to interpret

## Reference

1. Oxford handbook of medical statistics (Janet Peacock Philip J Peacock).
Cowie H, Lloyd MH, Soutar CA. Study of lung function data by principal components analysis. Thorax 1985; 40(6):438–43.
