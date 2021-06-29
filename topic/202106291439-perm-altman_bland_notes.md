## Correlation, regression and repeated data
The first paper on the list
@bland1994correlation
[ lit-altman_bland.md ]( 202106291417-lit-altman_bland.md ) is:
* 1. Bland JM, Altman DG. (1994) <a href="http://www.bmj.com/cgi/content/full/308/6933/896"> Correlation, regression and repeated data.</a> <b>308</b>, 896.

It concerns the analysis of paired data where there is more than one observation per subject.
They point out that it could be highly misleading to analyse such data by combining repeated observations from several subjects and then calculating the correlation coefficient as if the data were a simple sample.

Many researchers would assume that it is acceptable to gather repeated measurements for individuals and  put all the data together.

They use simulated data showing five pairs of measurements of two uncorrelated variables X and Y for subjects 1, 2, 3, 4, and 5.
Using each subject's mean values, they show correlation coefficient r=-0.67, df=3, P=0.22.
However, when they put all 25 observations together they get r=-0.47, df=23, P=0.02.
When the calculation is performed as if they have 25 subjects, the number of degrees of freedom for the significance test is increased incorrectly and a spurious significant difference is produce.
Thus demonstrating that one should not mix observations from different subjects indiscriminately, whether using correlation or the closely related regression analysis.

## Correlation within subjects, part 1
The methods to use in these circumstances are later discussed in another note for the BMJ series
@bland1995statistics,
number 11 on the list [ lit-altman_bland.md ]( 202106291417-lit-altman_bland.md ):
* 11. Bland JM, Altman DG. (1995) <a href="http://www.bmj.com/cgi/content/full/310/6977/446">Calculating correlation coefficients with repeated observations: Part 1, correlation within subjects.</a> <b>310</b>, 446.

_Notes: I am replacing their terms for my notes:_
* _X = Paco2_
* _Y = pHi_

In this note they show an example table using 8 subjects with _4-8 observations_ for X and Y:

| Subject | Y | X |
|:--------|:---:|:---:|
| 1 | 6.68 | 3.97 |  
| 1 | 6.53 | 4.12 | 
| ... | ... | ... |

* If subject's average Y is related to the subject's average X
	- We can use the correlation between the subject means, which they shall describe in a subsequent note.
* If an increase in Y within the individual was associated with an increase in X 
	- We want to remove the differences between subjects and look only at changes within.

To look at variation within the subject we can use multiple regression.

* Make one variable, X or Y, the outcome variable and the other variable and the subject the predictor variables. 
* Subject is treated as a categorical factor using dummy variables and so has seven degrees of freedom. 

* Using an analysis of variance table for the regression (table II) shows how the variability in Y can be partitioned into components due to different sources.
	- Also known as analysis of covariance 
	- Equivalent to fitting parallel lines through each subject's data. 

| Source of variation | Degrees of freedom | Sum of squares | Mean square | Variance ratio (F) | Probability |
|:--------------------|-------------------:|---------------:|------------:|-------------------:|------------:|
| Subjects | 7 | 2.9661 | 0.4237 | 48.3 | $<$0.0001 |
| PaCO2 | 1 | 0.1153 | 0.1153 | 13.1 | 0.0008 |
| Residual | 38 | 0.3337 | 0.0088 |  | |
| Total | 46 | 3.3139 | 0.0720 |  | |

* The residual sum of squares in table II represents the variation about regression lines. 
* This removes the variation due to subjects (and any other nuisance variables which might be present) and express the variation in Y due to X as a proportion of what's left: 
	- (Sum of squares for X)/(Sum of squares for X + residual sum of squares).
* The magnitude of the correlation coefficient within subjects is the square root of this proportion. 
	- For table II this is: $\sqrt{ \frac{0.1153}{0.1153+0.3337} } = 0.51 $
	- The sign of the correlation coefficient is given by the sign of the regression coefficient for X.
* Regression slope is -0.108
* So the correlation coefficient within subjects is -0.51. 
* The P value is found either from:
	- F test in the associated analysis of variance table, 
	- t test for the regression slope. 
	- It doesn't matter which variable we regress on which; 
	- we get the same correlation coefficient and P value either way.

Incorrectly calculating the correlation coefficient 
by ignoring the fact that we have 47 observations on only 8 subjects, would produce -0.07, P=0.7. 

## Correlation within subjects, part 2
The second part shows how to find the correlation between the subject means 
@bland1995calculating,
number 12 on the list [ lit-altman_bland.md ]( 202106291417-lit-altman_bland.md ):
* 12. Bland JM, Altman DG. (1995) <a href="http://www.bmj.com/cgi/content/full/310/6980/633">Calculating correlation coefficients with repeated observations: Part 2, correlation between subjects.</a> <b>310</b>, 633.

In this note they show the example table using the same 8 subjects with _one mean observation_ for X and Y:

|Subject | Y | X | Number |
|:------:|:---:|:----:|:------:|
| 1 | 6.49 | 4.04 | 4 |
| 2 | 7.05 | 5.37 | 4 |
| 3 | 7.36 | 4.83 | 9 |
| 4 | 7.33 | 5.31 | 5 |
| 5 | 7.31 | 4.40 | 8 |
| 6 | 7.32 | 4.92 | 6 |
| 7 | 6.91 | 6.60 | 3 |
| 8 | 7.12 | 4.78 | 8 |

* If subject's average Y is related to the subject's average X
	- We can use the correlation between the subject means.

They calculate the usual correlation coefficient for the mean Y and mean X; r=0.09, P=0.8.
Does not take into account the different numbers of measurements on each subject. 

* Does this matter?:
	- Depends on how different the numbers of observations are 
	- whether the measurements within subjects vary much compared with the means between subjects

We can calculate a weighted correlation coefficient using the number of observations as weights. 
Many computer programs will calculate this, but it is not difficult to do by hand.

* They denote the mean Y and X for subject i by $\bar{x}_i$ and $\bar{y}_i$, 
* the number of observations for subject i by $m_i$, 
* and the number of subjects by $n$. 
* The weighted mean of the $\bar{x}_i$ is 
$\frac{ \sum{ m_i \bar{x}_i } }{ \sum{ m_i } }$
<!-- (summation)mixi/(summation)mi. --> 

In the usual case, where there is one observation per subject, the $m_i$ 
are all one and this formula gives the usual mean 
$\frac{ \sum{\bar{x}_i} }{n} $.
<!-- (summation)xi/n. -->

An easy way to calculate the weighted correlation coefficient is to replace each individual observation by its subject mean. 
Thus the table would yield 47 pairs of observations, 
the first four of which would each be pH=6.49 and Paco2=4.04, and so on. 

If we use the usual formula for the correlation coefficient on the expanded data we will get the weighted correlation coefficient. 
However, we must be careful when it comes to the P value. 
We have only 8 observations (n in general), not 47. 
We should ignore any P value printed by our computer program, and use a statistical table instead.

The formula for a weighted correlation coefficient is:

$$
\frac{
\sum{m_i \bar{x}_i \bar{y}_i} 
- 
- \sum{m_i \bar{x}_i} \sum{m_i \bar{y}_i} 
- \mathbin{/}
- \sum{m_i}
- }{
- \sqrt{
-  ( 
-  \sum{m_i \bar{y}_i^2} 
-  -
-  (\sum{m_i \bar{y}_i})^2 
-  \mathbin{/}
-  \sum{m_i}
-  )
-  ( 
-  \sum{m_i \bar{y}_i^2} 
-  -
-  (\sum{m_i \bar{y}_i})^2 
-  \mathbin{/}
-  \sum{m_i}
-  )}
-  }
-  $$
-  }}

where all summations are from $i=1$ to $n$. 
When all the $m_i$ are equal they cancel out, 
giving the usual formula for a correlation coefficient.

For the data in the table the weighted correlation coefficient is r=0.08, P=0.9. 
There is no evidence that subjects with a high Y also have a high X. 
However, as they have already shown in part 1, 
within the subject a rise in Y was associated with a fall in X.
