---
layout: topic
title: Receiver operating characteristic plots
created: 2021-07-16
tags: statistics
status: finished
subject: statistics
---
{{ page.title }}
================

## Receiver operating characteristic plots
This article covers the fifth paper in the series of statistics notes {% cite altman1994diagnostic %}
([ lit-altman_bland.md ]( https://github.com/DylanLawless/notes/blob/main/202106291417-lit-altman_bland.md )):
is: 5. Altman DG, Bland JM. (1994) <a href="http://www.bmj.com/cgi/content/full/309/6948/188"> Diagnostic tests 3: receiver operating characteristic plots.</a> <b>309</b>, 188,
and concerns _quantitative diagnostic tests_.
Diagnosis based on yes or no answers are covered in another statistical note by Bland and Altman.
The same statistical methods for quantifying yes or no answers can be applied here when there is a cut off threshold for defining "_normal_" and "_abnormal_".
For simplicity, I will call someone who is diagnosed by a clinical test a "_case_" and someone who is not diagnosed by a test/healthy/normal, a "_control_".
These terms are incorrect, but much simpler to read each time than "people who are diagnosed by a test".

The receiver operating characteristic (ROC) plot can be used measure how test results compare between cases and controls.
Altman and Bland mention that this method was developed in the 1950s for evaluating radar signal detection.
As an aside for history buffs, from [wikipedia](https://en.wikipedia.org/wiki/Receiver_operating_characteristic):
> The ROC curve was first used during World War II for the analysis of radar signals before it was employed in signal detection theory.[56] Following the attack on Pearl Harbor in 1941, the United States army began new research to increase the prediction of correctly detected Japanese aircraft from their radar signals. For these purposes they measured the ability of a radar receiver operator to make these important distinctions, which was called the Receiver Operating Characteristic.[57]

<img src="{{ site.baseurl }}{% link images/receiver_operating_characteristic_plots.png %}" width="60%">

The example shown in Figure 1 uses graft versus host disease, with an index measurement whose definition is not important.
The yes indicate cases and no indicate controls in our terminology, respectively. 
The usefulness of the test for predicting graft versus host disease will clearly relate to the degree of non-overlap between the two distributions.
A ROC plot is obtained by calculating the
* sensitivity and 
* specificity 
of every observed data value and plotting, as in Figure 2,
* Y axis = sensitivity,
* X axis = 1 - specificity.

A test that perfectly defines cases and cotrols would have a curve that aligns withe Y axis and top.
A test that does not work would produce a straight line matching the centerline.
In practice, overlaps always occur such that the curve usually lies somewhere between, as shown in Figure 2.

The performance of the test (diagnostic accuracy) is reported as the _area under the ROC curve_.
The area is equal to the probability that a random case has a higher measurement than that of a control.
This probability is .5 for a test that does not work (e.g. coin-toss; straight line curve).
This discriminatory power assessment is important for a clinical test if it is to be sufficient to discriminate cases and controls. 

At this stage we have the global assessment of discriminatory power showing that a test can divide cases and control.
A cut off for clinical use also requires a local assessment. 
As per Altman and Bland; the simple approach of minimising "errors" (equivalent to maximising the sum of the sensitivity and specificity) is not necessarily best. 
We must consider any type of costs of 
* false negatives
* false positives
* and prevalence of disease in the test cohort. 

In their example:
* cancer in general population
	- most cases should be detected (high sensitivity) 
	- many false positives (low specificity), who could then be eliminated by a further test.

For comparing two or more measures, the ROC plot is useful. 
The curve wholly above another is clearly the better test. 
Altman and Bland cite a review for methods for comparing the areas under two curves for both paired and unpaired data. 

In my (reccomended) pocket-sized copy of 
_Oxford handbook of medical statistics_
{% cite peacock2011oxford %},
a clinical example uses a chosen cut-off of sensitivity $$>81\%$$ and specificity $$28\%$$. 
The area under ROC curve was .65, thus a moderately high predictive power. 
The accuracy (proportion of all correctly identified cases) was 
$$\frac{ 30 + 42 }{ 185 } = 39\%$$

<div class="table-wrapper" markdown="block">

$$\frac{\text{No. cases above cutoff} + \text{No. controls below cutoff }}{ \text{cohort total} }$$

</div>

## references 

{% bibliography --cited %}
