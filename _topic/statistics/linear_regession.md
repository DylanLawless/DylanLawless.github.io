---
layout: topic
title: Linear regression
created: 
tags: statistics
status: finished
subject: statistics
---
{{ page.title }}
================
* TOC
{:toc}

<br/>
This page is being formulated currently by plagerising "An Introduction to Statistical Learning". If you find this page before a lot of changes are complete, then keep this in mind. Once major changes/completion occurs, this message will be updated to references instead. 

# Simple linear regression
{% raw %}
Predict a quantitative response $$Y$$ using a predictor variable $$X$$; regressing $$Y$$ onto $$X$$.
The _intercept_ and _splope_ are written as $$\beta_0$$ and $$\beta_1$$, respectively.
These are unknwon constants and together are knwon as the model _coefficients_ or _parameters_.
The simple linear regression is written as

$$
\label{eq1}\tag{1} 
Y \approx \beta_0 + \beta_1 X
$$

Values that are estimated are labelled with a "hat", e.g. 
$$\hat y$$ - a prediction of $$Y$$ based on $$X = x$$.
With some sample data, one can begin to predict $$Y$$ based on the predictor $$X$$ using the estimated model coefficients $$\hat \beta_0$$ and $$\hat \beta_1$$;

$$
\label{eq2}\tag{2} 
\hat y \approx \hat\beta_0 + \hat\beta_1 x
$$

In this case, the estimated response $$\hat y$$ equals the estimated intercept and slope ($$\hat \beta_0$$ and $$\hat \beta_1$$) according to a sample of the predictor values ($$x$$). 
{% endraw %}

# Drawing the line
{% raw %}
The estimated intercept and slope ($$\hat \beta_0$$ and $$\hat \beta_1$$) are unknown, therefore we need to get these values to predict $$Y$$ based on $$X$$.
A number ($$n$$) of obersevations are made where we measure $$X$$ and $$Y$$. Measurements could be recorded as: (measure 1, x = 5, y = 10), (measure 2, x = 10, y = 20), and so on up to $$n$$ obersavations; 

$$ 
\label{eq3}\tag{3} 
(5,10), (10,20),..., (x_n,y_n)  
$$ 

$$ 
(x_1,y_1), (x_2,y_2),..., (x_n,y_n)
$$
  
We want to combine each measurment on a plot so that the line drawn through the data fits well and produces coefficient estimates $$\hat \beta_0$$ and $$\hat \beta_1$$.
Each measurement ($$i$$) is represented with $$y_i \approx \hat \beta_0 + \hat \beta_1 x_i$$ for $$i = 1,2,...,n$$.
The ideal result will be a line that fits all points closely. 
The measure of _closeness_ has many topics of interest, but the most common method is to minimise the _least squares_.
  
$$e_i = y_i - \hat y_i$$ represents the $$i$$th _residual_ - the difference between our $$i$$th response according to our model versus the true $$i$$th observed response.
The _residual sum of squares_ (RSS) is written as
$$
\label{eq4}\tag{4} 
RSS = e^2 _1 + e^2 _2 +...+ e^2 _n
$$
 
$$
RSS = (y_1-\hat\beta0-\hat\beta_1x_1)^2+(y_2-\hat\beta_0-\hat\beta_1x_2)^2+...+(y_n-\hat\beta_0-\hat\beta_1x_n)^2.
$$

The least squares method uses $$ \hat\beta_0 and \hat\beta_1 $$ such that RSS is minimised. The minimisers are as follows

$$
\label{eq5}\tag{5} 
 \hat \beta_1  = 
\frac{ 
\sum_{i=1}^{n}	(	xi -\bar{x} )	(yi - \bar{y}	)	} 
{\sum_{i=1}^{n}	(	xi -\bar{x} )^2
}
$$

$$
\hat\beta_0 - \bar{y} - \hat\beta_1 \bar{x}
$$

where the sample means are
$$ \bar{y} \equiv \frac{1}{n}\sum_{i=1}^{n} y_i $$
and
$$ \bar{x} \equiv \frac{1}{n}\sum_{i=1}^{n} x_i $$
so the equation above (\ref{eq5}) defines the least squares coefficient estimates for simple linear regression.

{% endraw %}

# Accuracy of the Coefficient Estimates
{% raw %}
We will want to account for error $$\epsilon$$ to draw an accurate line. 
$$ \epsilon $$ would be the mean-zero random error for the relationship between $$ Y $$ and $$ X $$ for the unknown function $$ f $$.

$$
\label{eq6}\tag{6} 
Y = \beta_0 + \beta_1 X + \epsilon
$$

This equation represents the _population regression line_.
We assume that the error term will be independet of $$ X $$, and the model is a best approximation of the $$ X - Y $$ relationship.
Equation 5 shows the least squares regression coefficient estimates to model the _least squares line_.
In real data, the population regression line is not observed but from the sample observations we can calculate the least squares line.

We would like to know how closely these two lines could be from our sampled data. 
The mean of a random variable $$ Y $$ would be written as $$ \mu $$.
If we have $$ n $$ number of observations of $$ Y $$ ($$ y_1, y_2,...,y_n $$) then we can get the estimate of $$ \mu $$. 
So, the estimate $$ \hat \mu = \hat y $$, where the sample mean is $$ \hat y = \frac{1}{n} \sum_{i=1}^{n} y_i $$. 
Obviously the sample mean and true population mean may not be the very same, but they should be close. 
Similary, we want to know the true $$ \beta_0 $$ and $$ \beta_1 $$ in a linear regression so we will estimate the $$ \hat\beta_0 $$ and $$ \hat\beta_1 $$ as shown in eqn \ref{eq5}, the coefficient estimates that define the least squares line. 

Likewise, $$ \hat\mu $$ is used to estimate $$ \mu $$ in an unbiased way; each estimate might be over- or underestimated but there is no particular bias in one direction from the random samples. 
The least squares coefficient estimates for $$ \beta_0 $$ and $$ \beta_1 $$ will also be unbiased. 
Over a large number of observations the estimate should be very accurate but since we will have a limited number of samples the estimate accuracy estimate should be established. 
This is gerneally done using the _standard error_.
When considering the estimate mean $$ \hat\mu $$, the formula for SE($$\hat\mu $$) will be

$$
\label{eq7}\tag{7} 
Var( \hat\mu ) = SE( \hat\mu )^2 = \frac{\sigma^2}{n}
$$

$$ \sigma $$ (sigma) is the standard deviation for every $$ y_i $$ of $$ Y $$ (approximately; further reading on Gaussian error assumption and number of observations).
This SE will shirk with more frequent observations.
In the same direction we can measure the standard errors for $$ \hat\beta_0 $$ and $$ \hat\beta_1 $$

$$ 
\label{eq8}\tag{8} 
SE(\hat\beta_0)^2 = \sigma\left[  \frac{1}{n} 
+ 
\frac {\bar x^2}{ \sum_{i=1}^{n} (x_i - \bar x)^2 } \right]
$$


$$ 
SE(\hat\beta_1)^2 =  \frac{1}{n} 
+ 
\frac {\sigma^2}{ \sum_{i=1}^{n} (x_i - \bar x)^2 }
$$

and $$\sigma^2 = Var(\epsilon)$$. (To be strictly valid, the errors $$\epsilon_i$$ for each observation should be uncorrelated with common variance $$\sigma^2$$)
The estimate of $$ \sigma $$ is the _residual standard error_, and shown by $$
RSE = \sqrt{ \frac{RSS}{(n-2)} }
$$.

In turn, the SE can be used to calculate the _confidence interval_.
A range of values that will contain the true unknown value of the parameter with 95% probability is the 95% confidence interval. 
This interval for $$ \hat\beta_1 $$ is approximately 

$$ 
\label{eq9}\tag{9} 
\hat\beta_1 \pm 2 \cdot SE(\hat\beta_1) 
$$

a 95% chance that the true $$ \beta_1 $$ value is in this range.
The same fomula is true for $$ \beta_0 $$, swapping terms.

{% endraw %}

# SE in hypothesis tests for coefficients
{% raw %}
The SE can be used for a _hypothesis test_ on the corfficients, i.e. testing the _null hypothesis_ and _alternative hypothesis_,  
$$
\label{eq10}\tag{10} 
H_0 - there is not relationship between X and Y
$$  
$$ H_0 : \beta_1 = 0 $$
$$ H_0 - there is not relationship between X and Y $$
$$ H_a : \beta_1 = 0 $$,
respectively.

Therefore if $$ \beta_1 = 0 $$, according to
\ref(eqn 6)
this equation reduces to 
$$ Y = \beta+0 + \epsilon $$, and an association is not found between $$ X $$ and $$ Y $$.
For the null hypothesis to be true (no association) we must determine if the slope $$ \beta_1 $$, or rather our estimate $$ \hat\beta_1 $$ is non-zero.
If the SE$$ \hat\beta_1 $$ is small then we are confident that $$ \hat\beta_1 $$ is accurate, if for example $$ \beta_1 \neg 0 $$ indicating an 
$$ X - Y $$ relationship.
If our estimate SE (SE $$\hat\beta_1$$) is large, then we will need to see a much greater 
$$ X - Y $$ association before rejecting the null hypothesis (association is true).
A _t_-statistic is used to measure how many _standard deviations_ (SD) 
$$ \hat\beta_1 $$ is from 0.
T-statistic:
$$ 
\label{eq11}\tag{11} 
t = \frac{
\hat\beta_1 - 0}{
SE(\hat\beta_1)}
$$
No relationship will give _t_-distribution $$ n - 2 $$ degrees of freedom.
(bell curve shape, for values of n greater than $$ \approx $$ 30 it is similar to normal distribution).

The probability of observing any number equal to |_t_| or larger, assuming $$ 
\beta_1 = 0 $$, is the _p-value_.
A very low p-value indicates that it is unlikely that an assocation will be measured by chance, and therefore is like a true association between predictor and response, and we can _reject the null hypothesis_.

{% endraw %}

# Model accuracy
{% raw %}
After rejecting the null we want to check if the line fits well - does the model fit the data?
Ttwo related quantities can asses the fit of linear regression; _residual standard error_ (RSE) and $$
R^2$$
statistic. 
## Residual Standard Error

Because of the error term $$ 
\epsilon $$,
the LR cannot perfectly predict $$ Y $$ from $$ X $$.
RSE is an estimate of the SD of $$ 
\epsilon $$.


$$

\label{eq12}\tag{12} 
RSE = \sqrt{
\frac{1}{n-2} RSS
}
=
\sqrt{
\frac{1}{n-2}
\sum_{i=1}^n 
(y_i - \hat y_i)^2
}

$$ 

The RSS part is expanded on the right hand side of the equation since:
$$

RSS = 
\sum_{i=1}^n 
(y_i - \hat y_i)^2

$$.

The RSS is a measure of the _lack of fit_ of the model equation \ref{eq6} to
the dataset.
The value calculated in eqn \ref{eq12} will become smaller when the estimate and true value become closer; 
$$ \hat y_1 \approx y_1 $$ for 
$$ 
i = 1,2,...,n
$$, in which case the model will fit the data well.





## $$R^2$$ Statistic
We use this all the time; it will be worth getting into the discussion from 
Cosma Rohilla Shalizi in
[Advanced Data Analysis from an Elementary Point of View](
http://www.stat.cmu.edu/~cshalizi/ADAfaEPoV/)
_Chapter 2 The Truth about Linear Regression_
``2.2.1.1 R2: Distraction or Nuisance?''. 
The short summary following just covers the basic "normal" usage, rather getting into the statistica weeds. 





{% endraw %}


# Multiple linear regression
{% raw %}
In a linear regression we use a predictor variable X to predict a quantitative response Y.
If we want to use more than one variable ($$ X_1, X_2, ... $$) 
that might affect the response Y, then we will use a multiple linear regression. 

 





{% endraw %}














$$
\label{eq }\tag{ } 
$$


$$
\label{eq }\tag{ } 
$$

$$
\label{eq }\tag{ } 
$$

