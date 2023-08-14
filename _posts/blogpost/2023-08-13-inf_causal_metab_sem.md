---
layout: post
title: Summary - inference of causal metabolite networks
created: 13 Aug 2023
tags: genomics
status: finished
---

{{ page.title }}
================

<p class="meta">13 Aug 2023</p>

A summary of: 
Chen, S., Lin, Z., Shen, X., Li, L., & Pan, W. (2023). Inference of causal metabolite networks in the presence of invalid instrumental variables with GWAS summary data. Genetic Epidemiology, 1–15,
<https://doi.org/10.1002/gepi.22535>,
{% cite chen2023inference %}.

## Abstract
Structural equation models (SEMs) for inferring causal networks in metabolites and other complex traits. The method:
1. Performs causal analysis to discover relationships among multiple traits.
2. Accounts for potential invalid IVs.
3. Allows for data analysis using only GWAS summary statistics.
4. Considers bidirectional relationships between traits.

The approach uses a stepwise selection to identify invalid IVs, and demonstrates its superior performance using both real and simulated GWAS data.

## METHODS

### 2.1 One-sample data

For one-sample GWAS individual-level data:
- For each of $$n$$ individuals:
  - We have $$p$$ SNPs as IVs and $$M$$ traits.
  - Traits are denoted by an $$n x M$$ matrix $$Y = [y_1, y_2, ... , y_M]$$.
    - Where $$y_i = (y_1i, y_2i, ..., y_ni)^T$$ is the vector of $$n$$ observations for trait $$i = 1, 2, ..., M$$.
  - IVs are denoted as $$Z = [z_1, ... , z_p]$$.
    - Where $$z_j = (z_1j, ..., z_nj)^T$$ is the vector of the $$n$$ observations for IV $$j = 1, 2, ..., p$$.

### 2.2 SEM with individual-level data
- SEM is used as a tool for multivariate causal inference in this framework.
- The analysis is based on one-sample GWAS individual-level data.
- The system considers linear equations for the 'n' individuals in the sample.
- Notations follow Wang et al. 2016.
- The model has random errors denoted by a 'n x M' matrix.
- The matrix 'E' consists of vectors for the 'n' random errors for each trait from 1 to M.
- The assumption is made that the expected value of error 'e_i' is 0.
- For each trait, the error follows a normal distribution with mean 0 and variance 'σ_i^2'.
- The matrix 'M x M' denotes the coefficients for the traits, represented by 'Γ'.
- The coefficients for each trait 'i' range from 1 to M.
- The linear model for the 'i-th' trait is represented by an equation where traits are connected linearly and the sum is 0.

### 2.3 SEM with some invalid IVs
- Discusses the scenario when some IVs may be invalid.
- Violation of one or more of the three valid IV Assumptions (A1)–(A3).
- Proposes a method to account for invalid IVs in SEM.
- For trait i, the first $${p}_{0i}$$ IVs are considered invalid IVs.
- Represents the matrix of invalid IVs with $${Z}_{ {\mathscr{A}}_{i}}=[{z}_{1},{\rm{\ldots }},{z}_{p_{0i}}]$$.
- $${z}_{j}={({z}_{1j},{\rm{\ldots }},{z}_{nj})}^{T}$$ is the vector for the n observations of IV $$j=1,2,{\rm{\ldots }},{p}_{0i}$$.
- $$M$$ vectors are present for the coefficients of invalid IVs: $${B}_{1},{\rm{\ldots }},{B}_{M}$$.
- $${B}_{i}={({\beta }_{1i},{\beta }_{2i},{\rm{\ldots }},{\beta }_{p_{0i}i})}^{T}$$ represents the direct or (horizontal) pleiotropic effects of the invalid IVs on trait $$i=1,2,{\rm{\ldots }},M$$.
- The linear SEM for trait i is represented as: $${y}_{1}{\gamma }_{1i}+\cdots +{y}_{i}{\gamma }_{ii}+\cdots +{y}_{M}{\gamma }_{Mi}+{z}_{1}{\beta }_{1i}+\cdots +{z}_{p_{0}i}{\beta }_{p_{0i}i}+{e}_{i}=0,$$.
- $$\gamma$$'s and $$\beta$$'s are unknown parameters in the model.

## Code
### onesample mvstepIV

The original source code is here:
<https://github.com/chen-siyi7/one-sample-stepwise-IV-selection/blob/main/one-sample%20stepwise%20IV%20code.R>

The function `onesample_mvstepIV` conducts one-sample stepwise IV.

**Input Parameters:**
- `p`: Total number of predictors.
- `R`: Correlation matrix.
- `betaZX`: Regression coefficients for predictors.
- `betaZY`: Regression coefficients for outcomes.
- `se_betaZY`: Standard error of `betaZY`.
- `n`: Sample size.
- `gamma_hat`: Gamma hat values (prior information).

**Main Computations:**
1. Initialize `ZTZ` using `R` as:
   $$ ZTZ = R $$
2. Compute `ZTY` as the element-wise product of `ZTZ` diagonal and `betaZY`: $$ ZTY = \text{diag}(ZTZ) \times \beta{ZY} $$
3. Calculate the median of `YTY` for each predictor `SNP` as: $$ YTY[SNP] = (n-1) \times ZTZ[SNP,SNP] \times (se_\beta{ZY}^2)[SNP] + ZTY[SNP] \times \beta{ZY}[SNP] $$, excluding NA values.
4. Compute Bayesian Information Criterion (`BIC`) for each predictor. For each predictor `i`:
    - a. Create a matrix `test11` with diagonal element `i` set to 1.
    - b. Create matrix `W1` by combining `test11` and `gamma_hat`.
    - c. Solve for `W1` using: $$ \text{solve.W1} = W1^T \times ZTZ \times W1 $$
    - d. Compute beta estimates `beta1` as: $$ \beta1 = (solve.W1^{-1} \times W1^T \times ZTY) $$
    - e. Calculate `BIC` as: $$ testbic[i] = n \times \log(YTY - \beta1^T \times W1^T \times ZTY) + \log(n) \times \sum_{i} \text{diag}(test11) $$
5. Determine the optimal instrument variables (`IVs`) based on `BIC`:
    - a. For each iteration `j`, select the predictor `i` with the smallest `BIC`.
    - b. Repeat the process by adding one predictor at a time.
    - c. Stop if the current and previous `IV` are the same.
6. Compute the final beta estimates using the invalid IVs:
    - a. Extract the invalid IVs from `whichIV` and set their diagonal elements in `test11` to 1.
    - b. Compute beta estimates `beta1` as: $$ \beta1 = (solve.W1^{-1} \times W1^T \times ZTY) $$
    - c. Calculate variance of beta `Varbeta` as: $$ \text{Var\beta} = \text{diag}(solve.W1 \times n) \times \sigma_u2 $$ where $$\sigma_u2 = YTY - \beta1^T \times W1^T \times ZTY$$.

**Output:**
- `invalidIV`: Indices of invalid IVs.
- `beta_est`: Estimated beta values.
- `beta_se`: Standard error of beta estimates.
- `K`: Number of invalid IVs.

### onesample mvstepIV ind
The original source code is here:
<https://github.com/chen-siyi7/one-sample-stepwise-IV-selection/blob/main/onesample_mvstepIV_ind%20code.R>

The function `onesample_mvstepIV_ind` performs one-sample stepwise IV for independent SNPs.

**Input Parameters:**
- `Y`: Response variable.
- `Z`: Predictor matrix.
- `n`: Sample size.
- `gamma_hat`: Gamma hat values (prior information).

**Main Computations:**
1. Initialize `testbic` for Bayesian Information Criterion.
2. For each predictor `i`:
    - a. Initialize a zero vector `l` with length `dim(Z)[2]` and set the `i`th element to 1.
    - b. Modify matrix `Z22` such that for each row `j`, `Z22[j,]` is `Z[j,]*l`.
    - c. Perform a linear regression (`lm_stage2`) of `Y` on `Z22` and `Z*gamma_hat`.
    - d. Calculate `BIC` for this predictor using: $$ testbic[i] = n \times \log\left(\frac{\sum(lm\_stage2\text{residuals}^2)}{n}\right) + \log(n) \times \sum(l) $$
3. Determine the optimal instrument variables (`IVs`) based on `BIC`:
    - a. For each iteration `j`, select the predictor `i` with the smallest `BIC`.
    - b. Modify matrix `Z22` for the selected predictors and add one predictor at a time.
    - c. Repeat the linear regression and calculate `BIC` as in step 2.
    - d. Stop if the current and previous `IV` are the same.
4. Extract the invalid IVs, `which.invalid`, from `whichIV` and sort them to obtain `K`.
5. Compute the final beta estimates using the invalid IVs:
    - a. Extract columns `K` from `Z` to form `Z22`.
    - b. Perform linear regression (`lm_stage2`) of `Y` on `Z22` and `Z*gamma_hat`.
    - c. Calculate beta estimates `betaest` as: $$ \beta{est} = \text{summary}(lm\_stage2)\text{coef[,1]} $$
    - d. Calculate variance of residuals `sigma_u2` as: $$ \sigma_u2 = \frac{\sum(lm\_stage2\text{residuals}^2)}{n} $$
    - e. Calculate variance of beta `Varbeta` using: $$ \text{Varbeta} = \text{diag}(ginv(X^TX)) \times \sigma_u2 $$ where $$ X = \text{cbind}(Z22, Dhat) $$ and $$ Dhat = Z*gamma\_hat $$.
    - f. Compute the standard error `betase` as: $$ \beta{se} = \sqrt{\text{Varbeta}} $$

**Output:**
- `beta_est`: Estimated beta values.
- `beta_se`: Standard error of beta estimates.
- `invalid IVs`: Indices of invalid IVs.
- `no. of invalid IV`: Number of invalid IVs.

## References

{% bibliography --cited %}
