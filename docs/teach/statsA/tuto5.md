---
layout: default
title: "Topic B6 — Continuous Distributions"
parent: Maths and Statistics A
grand_parent: Teach
nav_order: 5
---

# Topic B6 — Continuous Distributions

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

## Probability density function $f(x)$

The area under the function $f(x)$ over all values of $x$ equals 1. That is, the integral equals 1.

No probability attached to a specific value.

## Cumulative distribution function (CDF) $F(x) = P(X<x)$

Probabilty that random variable $X$ is below $x$. S-shaped function of x.

Proba that random var is between a and b $P(a < X < b) = F(b) - F(a) = \int^b_a f(u)du$

## Uniform distribution $U(a,b)$

All the values have the same probability of happening. Computed as $ \frac{1}{b-a} $ (height of the fnct) as the proba of $ a \leq x \leq b  $, 0 for anything else.

## Compute expected value

The middle of the range, $ \frac{a+b}{2} $

Variance : $ \frac{(b-a)^2}{12} $ 

## Compute CDF

Uniform distrib of tips between 50 and 125.

Height? $ \frac{1}{b-a} $

Proba of having between max and 100? $ \frac{1}{b-a} (max - 100) $

## Normal distribution $X \sim N(\mu,\sigma)$

$f(x)= \frac{1}{\sqrt{2\pi \sigma^2}} exp \left\{ \frac{(x-\mu)^2}{2\sigma^2} \right\} $ don't need to know this by heart!

It is completely described by $\mu$ and $\sigma$

## Symmetry around the mean

There is 50% probability that $X \geq \mu$ and $X \leq \mu$

## Changes in $\mu$ vs changes in $\sigma$

Change in $\mu$: moves on the x-axis

Changes in $\sigma^2$: bigger $\sigma^2$ --> lower crest, thicker tails. 

## Standard normal distribution $Z \sim N(0,1)$

Normal with mean = 0, std dev = 1

## Standardization of normal random variables $ Z = \frac{X-\mu}{\sigma} $

If we got a normally distributed variable, we can standardize it using this formula $ Z = \frac{X-\mu}{\sigma} $. That is, apply this formula to all the observations $z$, also called z-scores. Std Dev becomes 1 (as seen above)

Inverse transformation, simple algebra. You want $X$ isolated on the left of the = sign.

Tables help you and give you $P(Z < z)$. Look for the first decimal down the first row, and second decimal across the columns

The probability for negative values: $P(Z < -z) = P(Z > z) = 1-P(Z<z)$

