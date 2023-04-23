---
layout: topic
title: McNemar's test for paired proportions
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

## What is McNemar's Test?
- A statistical method to assess the association between two paired proportions
- Applicable for matched case-control studies or 'before and after' studies
- Based on the chi-squared distribution with 1 degree of freedom
- Generates a P value, estimates, and a confidence interval

See Bland, Chapter 13 [2].

## The Null Hypothesis
- The prevalence in the population remains consistent under both conditions

## How Does the Test Work?
- The test focuses on discordant pairs (yes/no, no/yes) where exposure differs
- Concordant pairs (yes/yes, no/no) are disregarded since they don't provide information on differences within pairs
- Expected frequencies are calculated assuming no association (null hypothesis is true), meaning the frequencies are equal in both discordant pairs (yes/no, no/yes)
- Observed frequencies are compared to expected values
- If observed frequencies deviate significantly from expected values, this implies a real association
- The test employs a formula based on the chi-squared distribution to calculate a P value

## Test Assumptions
- Requires a large sample
- For the test to be valid, each expected frequency should be greater than 5

## What if Assumptions Aren't Met?
- The P value might be too small, resulting in potentially false significant outcomes
- If numbers are small but the rule of thumb is satisfied, apply the version of the test with a continuity correction (see Bland, Chapter 13) [2]

## Performing McNemar's Test
- Always use frequencies, not percentages, for calculations
- The test is typically carried out using a computer program – the calculations following Table 1 demonstrate how the test operates.

### Table 1 a,b: Matched Case-Control Study of Asthma Death and Short-Acting B2 Agonist Use [3] (Two Presentations)
(a)

| Died (case) | Survived (control) | No. of pairs | Notation |
|------------|----------------|------------|---------|
| No         | No             | 411        | a       |
| Yes        | No             | 69         | b       |
| No         | Yes            | 45         | c       |
| Yes        | Yes            | 7          | d       |

(b) Results arranged as a 2x2 table

| Died (case)   | Used β2 agonist | Yes | No  | Total |
|---------------|-----------------|-----|-----|-------|
| Survived      | Yes             | 411 | 45  | 456   |
| (control)     | No              | 69  | 7   | 76    |
| Total         |                 | 480 | 52  | 532   |

- Expected frequency = (b+c)/2 = (69+45)/2 = 57
- Test statistic is:
  $$
  \frac{\sum_{\text{discordant cells}}(O - E)^2}{E} = \frac{(69 - 57)^2 + (45 - 57)^2}{57} = 5.05
  $$

This follows a chi-squared distribution with 1 degree of freedom and has P=0.031, indicating a relationship between the use of short-acting $\beta$2 agonist and death from asthma.

## References
1. Oxford handbook of medical statistics (Janet Peacock Philip J Peacock).
2. Bland M. An introduction to medical statistics. 3rd ed. Oxford: Oxford University Press, 2000.
3. Anderson HR, Ayres JG, Sturdy PM, Bland JM, Butland BK, Peckitt C et al. Bronchodilator
treatment and deaths from asthma: case-control study. BMJ 2005; 330(7483):117.

