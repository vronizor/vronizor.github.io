---
layout: default
title: "Tutorial 2 — A3"
parent: Maths and Statistics A
grand_parent: Teaching
nav_order: 2
---

$$s_{xy} = \frac{1}{n-1} \sum^n_{i=1} (x_i-\bar{x}) (y_i-\bar{y})$$

# Tutorial 2 — A3

* TOC
{:toc}

## Mean vs Median vs Mode

- Mean
  - sum over all variables/nb obs.
  - /!\ affected by outliers

- Median
  - observations ranked, divided in two (middle value, or avg of center values)
  - OR 50% of obs above and below that value
  - safe from outliers

- Mode
  - most occuring value in data
  - qualitative vars
  - one mode: on value most occ. --> bimodal: two values in first position

## Arithmetic vs weighted mean

- "Normal mean"
- VS some values matter more than others (credits and grades)

## Percentiles and quantiles

- Cumulative frequencies
- 10th percentile = 4 --> 10% of observations have a value of 4 or less
- Quartiles are chunks of 25%: 1st Quart 25%, Second 50% (=???), Third 75%

## Inter quantile range (IQR)

- The range of values within the central 50% of observations

- $\mathit{IQR} = Q_3 - Q_1$

- OR the range of values between the 1st and 2nd quartile

## Outliers & boxplot

- Procedure

  - Calculate $\mathit{IQR} = Q_3 - Q_1$
  - Multiply $\mathit{IQR} \times 1.5$
  - Observation outlier if $x_i > Q_3 + 1.5 \times \mathit{IQR}$ (upper bound)
  - OR $x_i < Q_1 - 1.5 \times \mathit{IQR}$ (lower bound)

  ```
  Q1-1.5*IQR     Q1     Median   Q3      Q3+1.5*IQR
                  -----------------
  * |-------------|        |      |----------|    * *
                  -----------------
  ```

## Variance and standard deviation

* Range: Max-Min
* Mean Absolute deviation (MAD): avg absolute difference from the mean $\frac{1}{n-1} \sum^2_{i=1} (x_i - \bar{x})$
* **Variance**: average square distance from the mean $s^2 = \frac{1}{n-1} \sum^2_{i=1} (x_i - \bar{x})^2$
  * Square *punishes* more the observations far form the mean
* **Standard deviation**: $s = \sqrt{\mathit{s^2}} = \sqrt{\frac{1}{n-1} \sum^2_{i=1} (x_i - \bar{x})^2}$
* Coeff of variation: "standardizes" std dev: makes it comparable accross datasets $\mathit{CV}= \frac{s}{\bar{x}}$

## Z-scores, standardization

- How far an obs is far from the mean. Standardizing.
  - if it's on the mean, =0
  - smaller than mean --> <0
  - bigger than mean --> >0
- $\textit{z-score} = \frac{\mathit{Observation}-\mathit{Mean}}{\mathit{Std Deviation}}$

## Covariance vs correlation

- Covariance formula: $s_{xy} = \frac{1}{n-1} \sum^n_{i=1} (x_i-\bar{x}) (y_i-\bar{y})$
  - Looks familiar no? It's basically the variance, but for two different variables
  - How does a variable move relative to another?
- Correlation: $ r_{xy} = \frac{s_{xy}}{s_x s_y} $ that is $ \frac{\mathit{Cov}_{xy}}{\mathit{Var}_x \times \mathit{Var}_y} $
  - Yields a number between -1 and 1. What does it mean if the correlation = 1? Or -1?

## Chebyshev's theorem

- $ 1 - \frac{1}{\mathit{nbSD}^2} =$ percentage of observations within the range $ \mathit{mean} \pm (\mathit{nbSD} \times \mathit{SD}) $ for number of standard deviations bigger than 1
- Just need the mean and std deviation to get an idea of the spread of data
- Features
  - Regardless of the distribution of the dataset
  - Represents a lower bound, i.e. the minimum percentage within $k$ std dev (can be much larger): "No more than $x$ percent can be more than $k$ number of $SD$ away from the mean"

## The Empirical Rule

- Formula
  - $ \mathit{mean} \pm (1 \times SD) $ has approximately 68% of values
  - $ \mathit{mean} \pm (2 \times SD) $ has approximately 95% of values
  - $ \mathit{mean} \pm (3 \times SD) $ has approximately 100% of values
- Features
  - More precise
  - Only bell-shaped and symetric distributions 