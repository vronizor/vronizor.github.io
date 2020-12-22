---
layout: default
title: "Topic C8 — Estimation"
parent: Maths and Statistics A
grand_parent: Teach
nav_order: 7
---

# Topic C8 — Estimation

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

## Point estimator

A function of the random sample used to make inferences about *a single value* of an unknown population parameter. 

Produces an estimate

## Properties of point estimators

- Unbiased: if its expected value = unknown pop parameter
- Efficient: if its SE is lower that other estimators
- Consistent: if it approaches the unknown population parameter as the sample size increases

## Interval estimator

A function of the random sample used to make inferences about the *range of plausible values* of an unknown population parameter. 

Produces a confidence interval

⟹ we use both point and interval estimators in modern statistics: point estimate ± margin error (interval estimator)

## Confidence interval for population mean, SD *known*

Interval estimate: range of values that, with a certain level of confidence, contains the population parameter of interest.

Point estimate ± margin error, where margin error accounts for the variability of the estimator and the desired confidence level of the interval.

We don't know $\mu$, but we know $\sigma$.

We have the sample mean, distributed as

$ \bar{X} \sim N \left( \mu, \frac{\sigma}{\sqrt{n}} \right) $

Confidence intervals (CI) given by $ \left[ \bar{x} \pm 1.96 \frac{\sigma}{\sqrt{n}} \right] $ for 95% confidence when $\bar{x}$ is the sample mean or the value we would like to test

More generally, CI given by $ \left[ \bar{x} \pm z_{\alpha/2} \frac{\sigma}{\sqrt{n}} \right] $ where $\alpha$ is the significance level and $z_{\alpha/2}$ the Z value in the standard normal distribution associated with the probability (i.e. area) $\alpha/2$.

### Interpretation

If numerous samples of size *n* are drawn from a given population, then 95% of the intervals formed by the formula $ \left[ \bar{x} \pm z_{\alpha/2} \frac{\sigma}{\sqrt{n}} \right] $ will contain $\mu$.

## T-distribution

## Confidence interval for population mean, SD *unknown*

Use sample SD $s$ 

Same standardizing formula (replacing $\sigma$ by $s$), but look up the $t_{n-1}$ distribution instead of $N(0,1)$, where $n-1$ is the degrees of freedom available: essentially the sample size –1.

Thus we get $ \left[ \bar{x} \pm t_{\alpha/2, df} \frac{\sigma}{\sqrt{n}} \right] $ where $df=n-1$.

## Confidence interval for the population proportion

Can be approximated by a normal when large sample, so we get $ \left[ \bar{p} \pm z_{\alpha/2} \sqrt \frac{\bar{p}(1-\bar{p})}{n} \right] $ .

## Sample size to estimate population mean and population proportion

Working in reverse

For means we have $CI = \bar{x} \pm z_{\alpha/2} \frac{\sigma}{\sqrt{n}} =  \bar{x} \pm E$, so $E = z_{\alpha/2} \frac{\sigma}{\sqrt{n}}$ and from there we rearrange to $n = \left( z_{\alpha/2} \frac{\sigma}{E} \right)^2$

For proportions $E = z_{\alpha/2} \sqrt \frac{\bar{p}(1-\bar{p})}{n}$  and $n = \left( \frac{z_{\alpha/2}}{E} \right)^2 \bar{p}(1-\bar{p})$

