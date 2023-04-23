---
layout: topic
title: Quick table unifactorial methods
created: 28 June 2020
tags: statistics
status: finished
subject: statistics
---
{{ page.title }}
================

This table is provided from Oxford handbook of medical statistics (Janet Peacock Philip J Peacock).

## COMPARE TWO INDEPENDENT SAMPLES

| **Design or aim of study** | **Type of data/assumptions** | **Statistical method** |
| ---------------------- | ------------------------ | ------------------ |
| Compare two means | Continuous, Normal distribution, same variance | t test for two independent means |
| Compare two proportions | Categorical, two categories, all expected values greater than 5 | Chi-squared test |
| Compare two proportions | Categorical, two categories, some expected values less than 5 | Fisher's exact test |
| Compare distributions | Ordinal | Wilcoxon two-sample signed rank test equivalent to Mann Whitney U test |
| Compare time to an event (e.g. survival) in two groups | Continuous | Logrank test |

## COMPARE SEVERAL INDEPENDENT SAMPLES

| **Design or aim of study** | **Type of data/assumptions** | **Statistical method** |
| ---------------------- | ---------------------- | ---------------------- |
| Compare several means | Continuous, Normal distribution, same variance | One-way analysis of variance |
| Compare time to an event (e.g. survival) in several groups | Continuous | Logrank test |

## COMPARE DIFFERENCES IN A PAIRED SAMPLE

| **Design or aim of study** | **Type of data/assumptions** | **Statistical method** |
| ---------------------- | ---------------------- | ---------------------- |
| Test mean difference | Continuous, Normal distribution for differences | t test for two paired (matched) means |
| Compare two paired proportions | Categorical, two categories (binary) | McNemar's test |
| Distribution of differences | Ordinal, symmetrical distribution | Wilcoxon matched pairs test |
| Distribution of differences | Ordinal | Sign test |

## RELATIONSHIPS BETWEEN TWO VARIABLES

| **Design or aim of study** | **Type of data/assumptions** | **Statistical method** |
| ---------------------- | ---------------------- | ---------------------- |
| Test strength of linear relationship between two variables | Continuous, at least one has Normal distribution | Pearson's correlation |
| Test strength of relationship between two variables | Ordinal | Spearman's rank correlation, Kendall's tau (if many ties) |
| Examine nature of linear relationship between two variables | Continuous, residuals from Normal distribution, constant variance | Simple linear regression |
| Test association between two categorical variables | Categorical, more than two categories for either or both variables, at least 80% of expected frequencies greater than 5 | Chi-squared test |
| Test for trend in proportions | Categorical, one variable has two categories and the other has several categories which are ordered, sample greater than 30 | Chi-squared test for trend |


