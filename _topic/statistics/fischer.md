---
layout: topic
title: Fischer's exact test
created: 
tags: statistics
status: finished
subject: statistics
---
{{ page.title }}
================

<br/>
https://www.statology.org/fishers-exact-test/
Statology page

Fisher's Exact Test is used to determine whether or not there is a significant association between two categorical variables. It is typically used as an alternative to the Chi-Square Test of Independence when one or more of the cell counts in a 2x2 table is less than 5.

Fisher's Exact Test uses the following null and alternative hypotheses:

* H0: (null hypothesis) The two variables are independent.
* H1: (alternative hypothesis) The two variables are not independent.

Suppose we have the following 2x2 table:

|            | Group 1 | Group 2 | Row Total |
|:-----------|:-------:|:-------:|:-------:|
| Category 1 | a | b | a+b |
| Category 2 | c | d | c+d |
| Column Total | a+c | b+d | a+b+c+d = n |

The one-tailed p value for Fisher's Exact Test is calculated as:

$$p = (a+b)!(c+d)!(a+c)!(b+d)! / (a!b!c!d!n!)$$

This produces the same p value as the CDF of the hypergeometric distribution with the following parameters:

* population size = n
* population "successes" = a+b
* sample size = a + c
* sample "successes" = a

The two-tailed p value for Fisher's Exact Test is less straightforward to calculate and can't be found by simply multiplying the one-tailed p value by two. To find the two-tailed p value, we recommend using the Fisher's Exact Test Calculator.

## Fisher's Exact Test: Example

Suppose we want to know whether or not gender is associated with political party preference. We take a simple random sample of 25 voters and survey them on their political party preference. The following table shows the results of the survey:

| Sex | Democrat | Republican | Total |
|:----|---------:|:----------:|:-----:|
| Male | 4 | 9 | 13 |
| Female | 8 | 4 | 12 |
| Total | 12 | 13 | 25 |

Step 1: Define the hypotheses.

We will perform Fisher's Exact Test using the following hypotheses:

* H0: Gender and political party preference are independent.
* H1: Gender and political party preference are not independent.

Step 2: Calculated the two-tailed p value.

We can use the Fisher's Exact Test Calculator with the following input:

| | Group1 | Group2 |
|---|:---:|:---:|
| Category 1 | 4 | 9 |
| Category 2 | 8 | 4 |

* One tailed p value: 0.081178
* Two-tailed p value is 0.115239

Fisher's Exact test example

The two-tailed p value is 0.115239. Since this value is less than 0.05, we fail to reject the null hypothesis. We do not have sufficient evidence to say that there is any statistically significant association between gender and political party preference.

## Additional Resources

The following tutorials explain how to perform a Fisher's Exact Test using different statistical programs:

How to Perform Fisher's Exact Test in R
https://www.statology.org/fishers-exact-test-in-r/

Fisher's Exact Test Calculator
https://www.statology.org/fishers-exact-test-calculator/

