---
layout: topic
title: Odds ratios, SE & CI
created: 4 July 2021
tags: statistics
status: finished
subject: statistics
---
{{ page.title }}
================

* TOC
{:toc}

## Introduction

Altman & Bland review the use of odds ratio (OR), standard error (SE), and confidence interval (CI) with some examples in 
{% cite bland2000odds %}; 
the 42nd paper on the list of statistical notes in their BMJ series,
([ lit-altman_bland.md ]( https://github.com/DylanLawless/notes/blob/main/202106291417-lit-altman_bland.md )):
42\. Bland JM, Altman DG. (2000) <a href="http://www.bmj.com/cgi/content/full/320/7247/1468">The odds ratio.</a> <b>320</b>, 1468.
<sup id="a1">[1](#f1)</sup>

In reproducing their examples I use $$X$$ and $$Y$$; 
* _X = Eczema_
* _Y = Hay fever_

As an example dataset, they cite the following table; Association between hay fever (Y) and eczema (X) in 11 year old children.

|  | Y Yes | Y No | Y Total |
|:---|---:|---:|---:|
| <b>X Yes</b> | 141 | 420 | 561 |
| <b>X No</b> | 928 | 13 525 | 14 453 |
| <b>X Total</b> | 1069 | 13 945 | 15 522 |

## Odds ratio

### Perspective 1
The _probability_ that a child with X will also have Y
is estimated by the proportion $$\dfrac{141}{561}$$ (25.1%)
and _odds_ is estimated by $$\dfrac{141}{420}$$. 

Similarly, for children without X the _probability_ of having Y is estimated by $$\dfrac{928}{14 453}$$ (6.4%) 
and the odds is $$\dfrac{928}{13 525}$$. 

They compare the groups in several ways: 
* By the difference between the proportions 
$$\dfrac{141}{561} - \dfrac{928}{14 453} = 0.187$$ (or 18.7 percentage points).
* The ratio of the proportions (also called the relative risk) 
$$\dfrac{ \left(\dfrac{141}{561}\right) }{ \left(\dfrac{928}{14 453}\right) } = 3.91 $$.
* The OR
$$\dfrac{ \left(\dfrac{141}{420}\right) }{ \left(\dfrac{928}{13 525}\right) } = 4.89$$.

### Perspective 2
Looking at the table the other way round, 
What is the _probability_ that a child with Y will also have X? 

The _proportion_ is $$\dfrac{141}{1069}$$ (13.2%) 
and the _odds_ is $$\dfrac{141}{928}$$. 

For a child without Y, the _proportion_ with X is 
$$\dfrac{420}{13 945}$$ (3.0%) 
and the _odds_ is $$\dfrac{420}{13 525}$$. 

Comparing the proportions this way, 
* The difference is 
$$\dfrac{141}{1069} - \dfrac{420}{13 945} = 0.102$$ (or 10.2 percentage points); 

* The ratio (relative risk) 
$$\dfrac{ \left(\dfrac{141}{1069}\right) }{ \left(\dfrac{420}{13 945}\right) } = 4.38$$; 
* The OR
$$\dfrac{ \left(\dfrac{141}{928}\right) }{ \left(\dfrac{420}{13 525}\right) } = 4.89$$. 

The OR is the same whichever way round we look at the table, 
but the difference and ratio of proportions are not.
This is because the two OR are 

$$\dfrac{ 141 / \textbf{420} }{ \textbf{928} / 13 525 }$$ and
$$\dfrac{ 141 / \textbf{928} }{ \textbf{420} / 13 525 }$$ 
which can both be rearranged to give
$$\dfrac{ 141 \times 13 525 }{ 928 \times 420 }$$.

Swapping orders for rows and columns produces the same OR.

Swapping orders for either only rows or only columns produces the the reciprocal of the OR, $$1/4.89 = 0.204$$.

Thus, OR can indicate the strength of the relationship.
OR cannot be negative but is not limited in the positive direction, producing a skew distribution. 
Reversing the order of categories for one variables simply results in a reversed sign of log OR: 

$$log(4.89) = 1.59$$, 

$$log(0.204) = - 1.59$$.

## Standard error
The standard error (SE) can be calculated for the log OR and hence a confidence interval (CI). 

The SE of log OR is simply estimated by the square root of the sum of the reciprocals of the four frequencies. 
For the example,

<div class="table-wrapper" markdown="block">

$$\text{SE(}log \text{OR)} =
\sqrt{
\frac{1}{141} + 
\frac{1}{420} + 
\frac{1}{928} + 
\frac{1}{13 525}}
=
0.103
$$

</div>

## Confidence interval

A 95% confidence interval (CI) for the log OR is obtained as 1.96 standard errors on either side of the estimate. 

For the example, 
the log OR is 
$$log_{e} (4.89) = 1.588$$ 
and the confidence interval is 
$$ 1.588 \pm 1.96 \times 0.103 $$, 
which gives $$1.386$$ to $$1.790$$. 

The antilog of these limits to give a 95% CI for the OR itself, 
as 
$$ exp(1.386) = 4.00 $$ to 
$$ exp(1.790) = 5.99 $$. 

The observed OR, 4.89, 
is not in the centre of the confidence interval because of the asymmetrical nature of the OR scale. 
For this reason, in graphs ORs are often plotted using a logarithmic scale. 
The OR is 1 when there is no relationship. 
We can test the null hypothesis that the OR is 1 by the usual 
$${\chi}^2$$ test for a two by two table.

Despite their usefulness, ORs can cause difficulties in interpretation. 
Altman & Bland review this debate and also discuss ORs in logistic regression and case-control studies in future Statistics Notes.

## References 

{% bibliography --cited %}

**Footnote**
<b id="f1">1</b> This article is almost identical to the original version in acknowledgment to Altman and Bland. It is adapted here as part of a set of curated, consistent, and minimal examples of statistics required for human genomic analysis.
[↩](#a1)
