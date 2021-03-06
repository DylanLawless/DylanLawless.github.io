---
layout: topic
title: PCA
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
We will look at principal component analysis (PCA) and singular value decomposition (SVD).
Example: variable 1 and 2 (e.g. gene expression), and 6 observations (6 mice).
One measurement could be plotted on a single line; low values (left) to high values (right).
You might see a cluster of half the group on one side (low expression) and the rest of the group on the other side of the plot line (high expression).
Measuring two variables (ie. two genes), the sample approach would now make an x/y 2-D graph. You might see one half of the measurement group clustering with low values for both variables (low expression of gene 1 and gene 2).
If we measure 3 genes it would be, of course, a 3-D graph. Higher dimensions cannot be easily graphed.
PCA can make the multiple dimension measurements into 2-D graphs and identify what measurements are most valuable for clustering. PCA can also tell us how accurate the 2-D graph is.
 
We calculate the average value of variable 1 (gene 1) and the average value of variable 2. With the average, we can calculate the center of the data. Once this is done, we no longer need the original values, rather just the relative position on the 2-D graph.
If the center of the data were a crosshair on the 2-D plots, we will shift the plotted values so the that crosshair rests on the origin (0,0) of the graph. Once the data is centered on the origin we will then fit a line through the origin that best fits the data.

To quantify how well a line is fit to the data, PCA projects the data onto the line.
It can either measure the distance from the data to the line to find the line that minimises distance, or it can find the line that maximises the distance from projected points to the origin.
Both of these actions are equivalent. i.e. a point at 3,2 has a set distance from the origin (line a).
The line that we use to separate the whole dataset could be labelled line c.
Our original point at 3,2 would be joints to its projected position on line c by line b at a 90 degree angle.
As our separator line c rotates around the origin to find the best fit to the dataset, the line b will grow or shrink with the projected distance.
Line a does not change, (joining origin to 3,2).
Therefore b and c form a right angle and Pythagorean theorem shows how b and c are inversely related

$$ a^2 = b^2 + c^2 $$.

Thus, PCA can can either minimise the distance from the data to the line (via line b), or it can find the line that maximises the distance from projected points to the origin (via line c). C is the easiest to calculate (sum of squared distances of projected position to the origin, i.e. $$ sum of d_{1}^2 + d_{2}^2 + d_{3}^2 ... d_{n}^2 $$), "Sum of squared distances". The values are squared to cancel negative values.
The line is rotated and the same process is repeated to find the largest sum of squared distances, the Principal Component 1 (PC1).
The slope of PC1 is recorded, e.g. slope 0.5 - for every 2 units from origin along x we move up 1 unit, and data are spread more along axis-x then axis-y. PC1 is a linear combination of variables means that to get PC1 we would have 2 parts of x-axis variable and 1 part y-axis variable (i.e. gene 1 and gene 2).

If we were to use singular value decomposition (SVD), we could say that the line separator line distance for 1,0.5 would be:

$$ a^2 = b^2 + c^2 $$,

$$ a^2 = 2^2 + 1^2 $$,

$$ a = \sqrt{2^2 + 1^2} $$,

$$ a = 2.236 $$

Doing PCA with SVD, PC1 would be scaled so that the length of the line is = 1.
Each side of the Pythagorean triangle would be divided by 2.236;

(2.236/2.236)^2 =  (2/2.236)^2 + (1/2.236)^2

PC1 we would have 2/2.236 (0.894) parts of x-axis variable and 1/2.236 (0.447) part y-axis variable (i.e. gene 1 and gene 2).
The ratio is still the same
as 2 out, 1 up.
The 1 unit along vector (the slope normalised to 1, 0.894 gene 1 and 0.447 gene 2) is the "Singular Vector" or the "Eigenvector" for PC1.
The proportions of each gene/varaible are "Loading Scores).
Squared sum distances for PC1 = Eigenvalue for PC1.
"Square root of Eigenvalue for PC1" = "Singular Value for PC1"

PC2 is perpendicular to PC1. 90 degrees rotated e.g. 2 up, -1 out. Scaling to get a unit vector it would be
-0.447 gene 1 and 0.894 gene 2, the Eigenvector for PC2.


Variation for PC1 = Square sum of dist for PC1 divided by n-1 (e.g. 12)

Variation for PC2 = Square sum of dist for PC2 divided by n-1 (e.g. 3)

The total variation around both PCs is 12+3=15. PC1 accounts for 12/15 = 0.8, 80% of variation around the PCs; PC2 accounts for 20%.
A "scree plot" shows the percentage of variation that each PC accounts for.
For a third variable, center the data, find the best fit line through the origin. The best fit is PC1. But the recipe now has 3 components. Variable 3 (gene 3) might have the most important contribution (e.g. 0.5 part gene 1, 0.1 part gene 2, 0.8 part gene 3). Find PC2, the next best fit line through the origin, that is perpendicular to PC1. This time, gene 1 might be the most important part of PC2. Lastly, PC3 is the best fit line through the origin and perpendicular to PC1 and PC2.
The PCs can be either the numbers variables or the number of samples - whichever is smallest.

With all of the PCs calculated, the Eigenvalues (sum of squared distances) can be used to determine the proportion of variation that each PC accounts for. The scree plot of variation accounted for by each PC, you can decide how many PCs are useful, e.g. PC1 and PC2 may account for 95% of variation.
You may keep just PC1 and PC2, projecting the data onto these, so that PC1 and PC2 are horizontal and perpendicular. The final plot might just need one 2-D graph to account for the majority of data, although we can use several plots if needed to view more complexity from PC3, PC4 etc..
Lastly, some analysis like GWAS can incorporate multiple PCs as individual covariates (with Plink or GCTA this would be a table with one data column per PC, and one row per sample ID) to account for complexity.
In that case, our visualisation plots are more for sanity and understanding the diversity within the dataset.
