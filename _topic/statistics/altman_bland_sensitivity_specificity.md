---
layout: topic
title: Sensitivity and specificity
created: 19 July 2021
tags: statistics
status: finished
subject: statistics
---
{{ page.title }}
================

* TOC
{:toc}

## Sensitivity and specificity
The third paper on the list of BMJ statistics notes by Alman and Bland,
[ lit-altman_bland.md ]( 202106291417-lit-altman_bland.md ),
{% cite altman1994diagnostic1 %} 3. Altman DG, Bland JM. (1994) <a href="http://www.bmj.com/cgi/content/full/308/6943/1552">
Diagnostic tests 1: sensitivity and specificity.</a> <b>308</b>, 1552.
<sup id="a1">[1](#f1)</sup>

The simple diagnostic test such as an x-ray is used to classify patients into two groups:
* Presence of a symptom or sign
	- Yes
	- No

Altman and Bland use the following cited example;
The results of a scan (**test**) compared to the correct diagnosis (**true positive**) based on either necropsy, biopsy, or surgical inspection. 
i.e. How good is the scan for correct diagnosis?

**Table 1.** _Relation between results of liver scan and correct diagnosis._

<div class="table-wrapper" markdown="block">

| Liver scan	|: Pathology :|||
|:---|:---:|:---:|:---:|
|					| **Abnormal (+)**	| **Normal (-)**	| **Total** |
| **Abnormal(+)**	| _231_				| 32				| 263 |
| **Normal(-)**		| 27				| _54_				| 81 |
| **Total**			| 258				| 86				| 344 |

</div>

The proportions of patients who are correctly "diagnosed" by the scan

* Disease signs and abnormal liver
	- 258 true positives
* No signs and healthy liver
	- 86 true negatives

The proportions of these two groups that were correctly diagnosed by the scan were $$231/258=0.90$$ and $$54/86=0.63$$, respectively. 

* Sensitivity 
	- Proportion of **true positives** that are **correctly identified** by the test.

* Specificity 
	- Proportion of **true negatives** that are **correctly identified** by the test.

Based on Altman and Bland's example sample, 
we expect 90% true positives (_patients with abnormal pathology to have abnormal (positive) liver scans_), 
while 63% true negatives (_those with normal pathology would have normal (negative) liver scans_).

## Confidence intervals
The sensitivity and specificity are proportions, so confidence intervals can be calculated.
This uses standard methods for proportions
{% cite gardner1989calculating %}.

## Quantifying the diagnostic ability
Sensitivity and specificity are one approach to quantifying the diagnostic ability of the test.
In this case, we already have the final results of **tests** and **diagnosis** of our sample set.
For an individual patient we only have the **test** result.
We want to quantify how well the test can predict true positives.

This is answered in the next statistical note; _predictive values_.
It defines _positive_ and _negative predictive values_ and requires the use of _sensitivity,_ _specificity,_ and _prevalence_.

## References 

{% bibliography --cited %}

**Footnote**
<b id="f1">1</b> This article is almost identical to the original version in acknowledgment to Altman and Bland. It is adapted here as part of a set of curated, consistent, and minimal examples of statistics required for human genomic analysis.
[↩](#a1)
