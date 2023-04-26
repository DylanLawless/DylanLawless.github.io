# Cluster Analysis

Based on the thread by @selcukorkmaz
<https://twitter.com/selcukorkmaz/status/1650501705920921602>

Cluster analysis is a technique used to group data points based on their similarity. Here are some popular methods & R packages.

## Identifying the Optimal Number of Clusters

![Cluster analysis methods](https://pbs.twimg.com/media/FufCjM2XgAUfOdb.jpg "Cluster analysis methods")

To determine the optimal number of clusters, various methods can be used. The following methods are popular:

## Elbow Method

The Elbow Method involves plotting the explained variation (inertia) as a function of the number of clusters. The "elbow point" on the curve represents the optimal number of clusters.

R package: 'factoextra'

[cran.r-project.org/web/packages/f...](https://cran.r-project.org/web/packages/factoextra/index.html)


```{r}
library(factoextra)
fviz_nbclust(data, kmeans, method = "wss")
```

## Silhouette Score

This method evaluates the quality of clustering by calculating the average silhouette score of each data point. Higher silhouette scores indicate better cluster assignments. Optimal clusters have the highest average silhouette score.

R package: 'cluster'

[cran.r-project.org/web/packages/c...](https://cran.r-project.org/web/packages/cluster/index.html)


```R
library(cluster)
silhouette_avg <- function(k) {
  km.res <- kmeans(data, centers = k, nstart = 25)
  ss <- silhouette(km.res$cluster, dist(data))
  mean(ss[, 3])
}
k.values <- 2:10
silhouette_scores <- sapply(k.values, silhouette_avg)
plot(k.values, silhouette_scores,
     xlab = "Number of clusters",
     ylab = "Average silhouette width")

```

## Gap Statistic

The Gap Statistic method compares the total within-cluster sum of squares (WSS) with that of a null reference distribution. The optimal number of clusters is found when the gap is the largest.

R package: 'cluster' and 'factoextra'

```R
library(cluster)
library(factoextra)
gap_stat <- function(k) {
  km.res <- kmeans(data, centers = k, nstart = 25)
  wss <- sum(km.res$withinss)
  return(log(wss) + log(nrow(data)) * k)
}
k.values <- 2:10
gap_scores <- sapply(k.values, gap_stat)
plot(gap_scores ~ k.values, type = "b",
     xlab = "Number of clusters",
     ylab = "Gap statistic")
```

## Calinski-Harabasz (CH) Index

The CH Index compares the between-cluster sum of squares (BSS) to the within-cluster sum of squares (WSS) for different numbers of clusters. The optimal number of clusters has the highest CH Index value.

R package: 'cluster'

```R
library(cluster)
ch_scores <- function(k) {
  km.res <- kmeans(data, centers = k, nstart = 25)
  bss <- sum(colSums(dist(km.res$centers))^2)
  wss <- sum(km.res$withinss)
  return((bss / (k - 1)) / (wss / (nrow(data) - k)))
}
k.values <- 2:10
ch_scores <- sapply(k.values, ch_scores)
plot(k.values, ch_scores,
     xlab = "Number of clusters",
     ylab = "Calinski-Harabasz index")

```

## Consensus Clustering

This method combines multiple clustering runs with varying numbers of clusters to identify the most stable partitioning of the data. The optimal number of clusters is chosen based on the stability of the partitions.

R package: 'ConsensusClusterPlus'

[https://bioconductor.org/packages/release/bioc/html/Co...](https://bioconductor.org/packages/release/bioc/html/ConsensusClusterPlus.html)

```R
library(ConsensusClusterPlus)
consensus_cluster <- function(k) {
  cc.res <- consensusClusterPlus(data, k = k, reps = 50, pItem = 0.8, pFeature = 1,
                                 clusterAlg = "hc", distance = "euclidean", method = "average")
  return(cc.res$ConsensusCluster$clusters)
}
k.values <- 2:10
cc_scores <- sapply(k.values, consensus_cluster)
fviz_nbclust(data, consensus_cluster, method = "silhouette", consensus = TRUE)
```

## BIC and AIC

Bayesian Information Criterion (BIC) and Akaike Information Criterion (AIC) are both model selection criteria that help identify the optimal number of clusters by balancing the model complexity and goodness-of-fit.

R package: 'mclust'

[cran.r-project.org/web/packages/m...](https://cran.r-project.org/web/packages/mclust/index.html)

```R
library(mclust)
bic <- function(k) {
  mclust_model <- Mclust(data, G = k)
  return(BIC(mclust_model))
}
aic <- function(k) {
  mclust_model <- Mclust(data, G = k)
  return(AIC(mclust_model))
}
k.values <- 2:10
bic_scores <- sapply(k.values, bic)
aic_scores <- sapply(k.values, aic)
plot(k.values, bic_scores, type = "b",
     xlab = "Number of clusters",
     ylab = "BIC")
plot(k.values, aic_scores, type = "b",
     xlab = "Number of clusters",
     ylab = "AIC")
```

## TreeCut

If you are using hierarchical clustering methods, you can use the 'dynamicTreeCut' R package to find the optimal number of clusters by cutting the dendrogram at the most suitable height.

R package: 'dynamicTreeCut'

[cran.r-project.org/web/packages/d...](https://cran.r-project.org/web/packages/dynamicTreeCut/index.html)
```R
library(dynamicTreeCut)
hc <- hclust(dist(data))
modules <- cutreeDynamic(hc, method = "hybrid", minClusterSize = 10)
fviz_dend(hc, k = 10, cex = 0.5,
          k_colors = c("#008080", "#FF5733", "#00FFFF", "#800080", "#FFC300", "#FF8C00", "#7CFC00", "#FF69B4", "#000080", "#F08080"))

```

## K-medoids clustering

K-medoids clustering is similar to K-means clustering, but instead of computing the mean of the points in each cluster, it selects a representative point (medoid) as the center of the cluster. The 'clara' function in the 'cluster' package and the 'pam' function in the 'cluster' package can be used to perform K-medoids clustering.

## DBSCAN clustering

DBSCAN (Density-Based Spatial Clustering of Applications with Noise) is a density-based clustering method that groups together points that are closely packed together and separates out points that are isolated or far away from any cluster. The 'dbscan' function in the 'dbscan' package can be used to perform DBSCAN clustering.

## Gaussian mixture modeling

Gaussian mixture modeling is a probabilistic clustering method that models each cluster as a Gaussian distribution. The 'Mclust' function in the 'mclust' package can be used to perform Gaussian mixture modeling.

## Spectral clustering

Spectral clustering is a graph-based clustering method that projects the data onto a low-dimensional space and performs clustering in that space. The 'spectralClustering' function in the 'kernlab' package can be used to perform spectral clustering.

## Fuzzy clustering

Fuzzy clustering assigns each data point a membership score for each cluster, indicating the degree to which the point belongs to each cluster. The 'fanny' function in the 'cluster' package and the 'cmeans' function in the 'e1071' package can be used to perform fuzzy clustering.
