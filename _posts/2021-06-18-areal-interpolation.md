---
layout: post
title: Areal interpolation
author: Vincent Thorne
last-edit: 2022-01-31
---

Areal interpolation lets us “distribute” variables between spatial features overlapping but with different borders, which we call incongruent. Importantly, we assume that the variable is homogeneously distributed across a given spatial feature.

In R, the excellent [`areal`](https://slu-opengis.github.io/areal/index.html) package lets us do areal interpolation and control the parameters described below. The (also great) [`sf`](https://r-spatial.github.io/sf/index.html) package does have an `st_interpolate_aw` method, but it lacks some features `areal` implements.

The “distribution” of values across spatial units takes two parameters (i.e., takes place in two dimensions), described below.

## Extensive vs Intensive

**Extensive** distribution **spreads** the value of a variable across the overlapping features. This used for **count** variables (population, number of trees, etc).

**Intensive** distribution produces a **spatially weighted average** of the variable across the overlapping features. This is used for rates, averages and other **already transformed** variables (asthma rate, median income, etc)

## For extensive only: sum vs total

**Sum** assumes that 100% of the source data should be distributed to the target features. The total area of the source is thus $A_j=\sum A_{ij}$, the sum of all the overlapping (intersected) areas. 

In practice, that method is used when features do not perfectly overlap, but one still wishes to distribute the entirety of a feature’s value to the overlapping features (because of an imperfectly matching datasets, for example).

**Total** assumes that, if a source feature is not 100% overlapped by target features, then only the overlapped proportion should be distributed. For example, “if a source feature is only covered by 99.88% of the target features, only 99.88% of the source target’s data should be allocated to target features in the interpolation”. $A_j$ is thus the original area of the source feature, not the sum of the intersected areas as in sum. 

In practice, that method is used when one is certain the features overlap perfectly, or when only a proportion of the variable (relative to the overlapped area) needs to be allocated, because that’s what makes sense in that particular context. 

This is the “distribution dimension” where `areal`'s `aw_interpolate()` differs from `sf`'s `st_interpolate_aw()`: the former offers both “sum” and “total” options, while the latter only supports the “total” distribution. `areal` has the advantage of making the distinction explicit, but will yield the same results as `sf` if the “total” option is selected.

## More details

The [`areal`](https://slu-opengis.github.io/areal/index.html) homepage has detailed explanations and visual descriptions of the steps involved in areal interpolation. See also the reference on [`st_interpolate_aw()`](https://r-spatial.github.io/sf/reference/interpolate_aw.html) for more details on `sf`'s implementation.