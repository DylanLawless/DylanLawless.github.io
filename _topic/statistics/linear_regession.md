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

This page is being formulated currently by plagerising "An Introduction to Statistical Learning". If you find this page before a lot of changes are complete, then keep this in mind. Once major changes/completion occurs, this message will be updated to references instead. 

# Simple linear regression
{% raw %}
Predict a quantitative response $$Y$$ using a predictor variable $$X$$; regressing $$Y$$ onto $$X$$.
The _intercept_ and _splope_ are written as $$\beta_0$$ and $$\beta_1$$, respectively.
These are unknwon constants and together are knwon as the model _coefficients_ or _parameters_.
The simple linear regression is written as
{% endraw %}

$$  
Y \approx \beta_0 + \beta_1 X
$$

{% raw %}
Values that are estimated are labelled with a "hat", e.g. 
$$\hat y$$ - a prediction of $$Y$$ based on $$X = x$$.
With some sample data, one can begin to predict $$Y$$ based on the predictor $$X$$ using the estimated model coefficients $$\hat \beta_0$$ and $$\hat \beta_1$$;
{% endraw %}

$$
\hat y \approx \hat\beta_0 + \hat\beta_1 x
$$

{% raw %}
In this case, the estimated response $$\hat y$$ equals the estimated intercept and slope ($$\hat \beta_0$$ and $$\hat \beta_1$$) according to a sample of the predictor values ($$x$$). 
{% endraw %}

# Drawing the line
{% raw %}
The estimated intercept and slope ($$\hat \beta_0$$ and $$\hat \beta_1$$) are unknown, therefore we need to get these values to predict $$Y$$ based on $$X$$.
A number ($$n$$) of obersevations are made where we measure $$X$$ and $$Y$$. Measurements could be recorded as: (measure 1, x = 5, y = 10), (measure 2, x = 10, y = 20), and so on up to $$n$$ obersavations; 
{% endraw %}

$$ 
(5,10), (10,20),..., (x_n,y_n)  
$$ 

$$ 
(x_1,y_1), (x_2,y_2),..., (x_n,y_n)
$$
  
{% raw %}
We want to combine each measurment on a plot so that the line drawn through the data fits well and produces coefficient estimates $$\hat \beta_0$$ and $$\hat \beta_1$$.
Each measurement ($$i$$) is represented with $$y_i \approx \hat \beta_0 + \hat \beta_1 x_i$$ for $$i = 1,2,...,n$$.
The ideal result will be a line that fits all points closely. 
The measure of _closeness_ has a many topics of interest, but the most common method is to minimise the _least squares_.
{% endraw %}
  
$$
RSS = e^2 _1 + e^2 _2 +...+ e^2 _n
$$
 
{% raw %}

{% endraw %}
$$
RSS = (y_1-\hat\beta0-\hat\beta_1x_1)^2+(y_2-\hat\beta_0-\hat\beta_1x_2)^2+...+(y_n-\hat\beta_0-\hat\beta_1x_n)^2.
$$

{% raw %}

{% endraw %}
$$
\hat \beta_1  = 
\frac{ 
\sum_{i=1}^{n}	(	xi -\bar{x} )	(yi - \bar{y}	)	} 
{\sum_{i=1}^{n}	(	xi -\bar{x} )^2
}
$$

{% raw %}

{% endraw %}
$$
\hat\beta_0 - \bar{y} - \hat\beta_1 \bar{x}
$$

