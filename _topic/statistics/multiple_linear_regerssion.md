---
layout: topic
title: Multiple linear regression
created: 23 Apr 2023
tags: statistics
status: finished
subject: statistics
---
{{ page.title }}
================
* TOC
{:toc}

This page is based on "An Introduction to Statistical Learning". 

## Multiple Linear Regression

In practice, we often have more than one predictor. 
For example, in the Advertising data, we have data for the amount of money spent advertising on the radio and in newspapers, besides TV advertising. 
Instead of fitting a separate simple linear regression model for each predictor, a better approach is to extend the simple linear regression model to directly accommodate multiple predictors by giving each predictor a separate slope coefficient in a single model.

In general, if we have p distinct predictors, the multiple linear regression model takes the form:

$$
Y = \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \cdots + \beta_p X_p + \epsilon
$$

Where $$X_j$$ represents the jth predictor and $$\beta_j$$ quantifies the association between that variable and the response. 
We interpret $$\beta_j$$ as the average effect on Y of a one-unit increase in $$X_j$$, holding all other predictors fixed. 
In the advertising example:

$$
\text{sales} = \beta_0 + \beta_1 \times \text{TV} + \beta_2 \times \text{radio} + \beta_3 \times \text{newspaper} + \epsilon
$$


## Estimating the Regression Coefficients

In multiple linear regression, the regression coefficients are unknown and must be estimated. 
Given estimates $$\hat{\beta}_0$$, $$\hat{\beta}_1$$, ..., $$\hat{\beta}_p$$, we can make predictions using the formula:

$$
\hat{y} = \hat{\beta}_0 + \hat{\beta}_1 x_1 + \hat{\beta}_2 x_2 + \cdots + \hat{\beta}_p x_p
$$

The parameters are estimated using the same least squares approach as in simple linear regression. 
We choose $$\beta_0$$, $$\beta_1$$, ..., $$\beta_p$$ to minimize the sum of squared residuals:

$$
RSS = \sum_{i=1}^{n} (y_i - \hat{y}_i)^2 = \sum_{i=1}^{n} (y_i - \hat{\beta}_0 - \hat{\beta}_1 x_{i1} - \hat{\beta}_2 x_{i2} - \cdots - \hat{\beta}_p x_{ip})^2
$$

The values $$\hat{\beta}_0$$, $$\hat{\beta}_1$$, ..., $$\hat{\beta}_p$$ that minimize the sum of squared residuals are the multiple least squares regression coefficient estimates. 
These estimates have more complicated forms than those in simple linear regression and are most easily represented using matrix algebra.

In the Advertising data example, the multiple regression coefficient estimates for TV, radio, and newspaper advertising budgets are interpreted as follows: for a given amount of TV and newspaper advertising, spending an additional \$1,000 on radio advertising leads to an increase in sales by approximately 189 units. 
This illustrates that the simple and multiple regression coefficients can be quite different.


##  Some Important Questions

When performing multiple linear regression, we usually are interested in answering a few important questions:

1. 
Is at least one of the predictors $$X_1$$, $$X_2$$, ..., $$X_p$$ useful in predicting the response?
2. 
Do all the predictors help to explain Y, or is only a subset of the predictors useful?
3. 
How well does the model fit the data?
4. 
Given a set of predictor values, what response value should we predict, and how accurate is our prediction?

We will address each of these questions in the following sections.

## One: Is There a Relationship Between the Response and Predictors?

Recall that in the simple linear regression setting, in order to determine whether there is a relationship between the response and the predictor we can simply check whether $$\beta_1 = 0$$. 
In the multiple regression setting with $$p$$ predictors, we need to ask whether all of the regression coefficients are zero, i.e. 
whether $$\beta_1 = \beta_2 = \cdots = \beta_p = 0$$. 
As in the simple linear regression setting, we use a hypothesis test to answer this question. 
We test the null hypothesis,

$$H_0 : \beta_1 = \beta_2 = \cdots = \beta_p = 0$$

versus the alternative

$$H_a : \text{at least one } \beta_j \text{ is non-zero.}$$

This hypothesis test is performed by computing the F-statistic,

$$
F = \frac{(TSS - RSS)/p}{RSS/(n - p - 1)} 
$$

where, as with simple linear regression, $$TSS = \sum(y_i - \bar{y})^2$$ and $$RSS = \sum(y_i - \hat{y}_i)^2$$. 
If the linear model assumptions are correct, one can show that

$$
E\left\{\frac{RSS}{(n - p - 1)}\right\} = \sigma^2 \quad \text{and that, provided } H_0 \text{ is true, }
$$

$$
E\left\{\frac{(TSS - RSS)}{p}\right\} = \sigma^2.
$$

Hence, when there is no relationship between the response and predictors, one would expect the F-statistic to take on a value close to 1. 
On the other hand, if $$H_a$$ is true, then $$E\{(TSS - RSS)/p\} > \sigma^2$$, so we expect F to be greater than 1.

When $$H_0$$ is true and the errors $$\epsilon_i$$ have a normal distribution, the F-statistic follows an F-distribution. 
For any given value of $$n$$ and $$p$$, any statistical software package can be used to compute the p-value associated with the F-statistic using this distribution. 
Based on this p-value, we can determine whether or not to reject $$H_0$$.

Sometimes we want to test that a particular subset of $$q$$ of the coefficients are zero. 
This corresponds to a null hypothesis

$$
H_0 : \beta_{p - q + 1} = \beta_{p - q + 2} = \cdots = \beta_p = 0,
$$

where for convenience we have put the variables chosen for omission at the end of the list. 
In this case we fit a second model that uses all the variables except those last $$q$$. 
Suppose that the residual sum of squares for that model is $$RSS_0$$. 
Then the appropriate F-statistic is

$$
F = \frac{(RSS_0 - RSS)/q}{RSS/(n - p - 1)}. 
$$

The F-statistic adjusts for the number of predictors. 
Hence, if $$H_0$$ is true, there is only a 5% chance that the F-statistic will result in a p-value below 0.05, regardless of the number of predictors or the number of observations.

## Five: Model Fit

Once we have selected the variables to be included in the model, the next step is to assess how well the model fits the data. 
The most common way to do this is by examining the residual plot. 
The residual plot shows the difference between the predicted values of the response and the actual values of the response. 
If the model fits the data well, then the residuals should be randomly scattered around zero, with no discernible pattern. 
If there is a pattern in the residual plot, then it suggests that the model is not capturing some important aspect of the data.

Another way to assess model fit is by computing the R-squared value. 
Recall that the R-squared value measures the proportion of variability in the response that is explained by the model. 
A high R-squared value suggests that the model fits the data well, while a low R-squared value suggests that the model does not fit the data well.

In multiple regression, we use the adjusted R-squared value instead of the regular R-squared value. 
The adjusted R-squared value takes into account the number of variables in the model and adjusts the R-squared value downward if additional variables are added that do not contribute to the fit of the model. 
The adjusted R-squared value is given by:

$$\text{Adjusted R}^2 = 1 - \frac{n-1}{n-p}(1-R^2)$$

where $$n$$ is the sample size and $$p$$ is the number of predictors in the model.

It is important to note that a high R-squared or adjusted R-squared value does not necessarily mean that the model is a good fit for the data. 
It is possible to have a high R-squared value even if the model does not fit the data well. 
Therefore, it is important to also examine the residual plot to ensure that the model is capturing all of the important aspects of the data.

Finally, it is important to keep in mind that there are limitations to using linear regression to model complex relationships. 
Linear regression assumes that the relationship between the response and the predictors is linear, and that the errors are normally distributed with constant variance. 
If these assumptions are not met, then the model may not fit the data well and the results may not be reliable. 
In such cases, more advanced techniques such as nonlinear regression or generalized linear models may be necessary.

## Six: Model Fit

In multiple linear regression, we use the RSE (Residual Standard Error) and R2 statistics to assess the model fit. 
The R2 statistic measures the proportion of variance in the response that is explained by the model, and is given by:

$$ R^2 = Cor(Y, \hat{Y})^2 $$

where $$Y$$ is the response variable and $$\hat{Y}$$ is the predicted response variable. 
A high R2 value indicates that the model explains a large portion of the variance in the response variable.

The RSE statistic measures the standard deviation of the residuals, and is given by:

$$ RSE = \sqrt{\frac{RSS}{n-p-1}} $$

where $$RSS$$ is the residual sum of squares, $$n$$ is the sample size, and $$p$$ is the number of predictors in the model. 
A low RSE value indicates that the model has a small standard deviation of the residuals and is a better fit to the data.

It is important to note that a high R2 or low RSE value does not necessarily mean that the model is a good fit for the data. 
It is possible to have a high R2 or low RSE value even if the model does not fit the data well. 
Therefore, it is important to also examine the residual plot to ensure that the model is capturing all of the important aspects of the data.

In addition to numerical measures of model fit, graphical summaries can also be useful in identifying problems with the model that are not visible from numerical statistics. 
For example, a three-dimensional plot of the predictors versus the response variable can reveal non-linear patterns or interactions between predictors that cannot be modeled accurately using linear regression.

Overall, while linear regression can be a powerful tool for modeling relationships between variables, it is important to carefully assess model fit and to consider more advanced techniques if the assumptions of linear regression are not met.

## Four: Predictions
Once we have fit the multiple regression model, it is straightforward to apply the earlier eqn in order to predict the response $$Y$$ on the basis of a set of values for the predictors X1, X2, ..., Xp. 
However, there are three sorts of uncertainty associated with this prediction.
1. The coefficient estimates $$\hat{\beta_0}$$, $$\hat{\beta_1}$$,..., $$\hat{\beta_p}$$ are estimates for $$\beta_0$$, $$\beta_1$$,..., $$\beta_p$$. 
That is, the least squares plane
$$\hat{Y} = \hat{\beta_0} + \hat{\beta_1}X_1 + · · · + \hat{\beta_p}X_p$$
is only an estimate for the true population regression plane
$$f(X)=\beta_0 +\beta_1X_1 +···+\beta_pX_p.$$
The inaccuracy in the coefficient estimates is related to the reducible error from Chapter 2. 
We can compute a confidence interval in order to determine how close $$\hat{Y}$$ will be to $$f(X)$$.
2. Of course, in practice assuming a linear model for $$f(X)$$ is almost always an approximation of reality, so there is an additional source of potentially reducible error which we call model bias. 
So when we use a linear model, we are in fact estimating the best linear approximation to the true surface. 
However, here we will ignore this discrepancy, and operate as if the linear model were correct.

3. Even if we knew $$f(X)$$—that is, even if we knew the true values for $$\beta_0$$,$$\beta_1$$,...,$$\beta_p$$—the response value cannot be predicted perfectly because of the random error $$\varepsilon$$ in the model (3.21). 
This is called an irreducible error. 
How much will Y vary from $$\hat{Y}$$? We use prediction intervals to answer this question. 
Prediction intervals are always wider than confidence intervals, because they incorporate both the error in the estimate for $$f(X)$$ (the reducible error) and the uncertainty as to how much an individual point will differ from the population regression plane (the irreducible error).

We use a confidence interval to quantify the uncertainty surrounding the average sales over a large number of cities. 
For example, given that \$100,000 is spent on TV advertising and \$20,000 is spent on radio advertising in each city, the 95 % confidence interval is [10,985, 11,528]. 
We interpret this to mean that 95 % of intervals of this form will contain the true value of $$f(X)$$. 
On the other hand, a prediction interval can be used to quantify the uncertainty surrounding sales for a particular city. 
Given that \$100,000 is spent on TV advertising and \$20,000 is spent on radio advertising in that city the 95 % prediction interval is [7,930, 14,580]. 
We interpret this to mean that 95 % of intervals of this form will contain the true value of $$Y$$ for this city. 
Note that both intervals are centered at 11,256, but that the prediction interval is substantially wider than the confidence interval, reflecting the increased uncertainty about sales for a given city in comparison to the average sales over many locations.


