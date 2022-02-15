---
layout: post
title: Geospatial intersects with data.table, geos and sf
author: Vincent Thorne
#last-edit: 2022-02-09
---

Working with large spatial data sets in R, I was delighted to discover [Grant McDermott’s post](https://grantmcdermott.com/fast-geospatial-datatable-geos) on how to combine `data.table` and `geos` for blazing-fast spatial operations compared to the standard `sf` (keeping in mind that `geos` assumes planar geometries). The benchmark for the spatial operations he presents are very convincing, so decided to give it a go on the data set I’m currently working with, the infamous [NYC taxi trip records](https://www1.nyc.gov/site/tlc/about/tlc-trip-record-data.page).

In the example below, I am matching each trip pickup coordinates (points) with one of 263 taxi zones (polygons). In the end, I want to know how many taxi trips started in each zones. To find out to which taxi zone each pair of coordinates belongs, I use `st_intersect` from the `sf` package, and `geos_intersects_matrix` from `geos`. Surprisingly, the benchmark reveals that **when intersecting points and polygons** `sf` is about 40% faster compared to the `data.table`+`geos` team.

I am in no position to say what is happening behind the scenes here, but found it interesting to report and contrast with Grant’s findings: the advantages of using `data.table`+`geos` might depend on the type of spatial operation. There might also be a better way to implement the `data.table`+`geos` version in this case that I overlooked — if you have ideas, please let me know!



```R
library(sf)
library(geos)
library(data.table)
library(microbenchmark)

rm(list = ls())
gc()

url_trips = "https://s3.amazonaws.com/nyc-tlc/trip+data/yellow_tripdata_2015-01.csv"

download.file(url = url_trips, destfile = "trip_records.csv", mode = "wb") # takes some time and is pretty heavy!
trips.dt = fread("trip_records.csv", nrows = 100000) # enough rows to benchmark performance

# Keep only pickup (origin) coordinate columns
cols_drop = grep("pickup_l", names(trips.dt), value = T, invert = T)
trips.dt[, (cols_drop) := NULL]
trips.dt = trips.dt[!(pickup_longitude == 0 | pickup_latitude == 0)] # obviously invalid coordinates

# Generate geom
trips.dt[, `:=`(o_geom = geos_make_point(pickup_longitude, 
                                         pickup_latitude, 
                                         crs=4326))]

# Generate sf
trips.sf = st_as_sf(trips.dt)
trips.sf = st_transform(trips.sf, 4326)

# Get polygons to intersect
url_zones = "https://s3.amazonaws.com/nyc-tlc/misc/taxi_zones.zip"
download.file(url_zones, destfile = "zones_polygons.zip", mode = "wb")
unzip("zones_polygons.zip", exdir = file.path("zones"))

# sf version
zones.sf = st_read(file.path("zones", "taxi_zones.shp"))
zones.sf = st_transform(zones.sf, 4326)

# geom version
zones.dt = as.data.table(zones.sf)[, geom := as_geos_geometry(geometry, crs = 4326)]
zones.dt[, geometry := NULL]

# Functions to test
geos.dt = function(x) {
  geos_intersects_matrix(zones.dt[, geom], trips.dt[, o_geom])
}

sf = function(x) {
  st_intersects(zones.sf, trips.sf)
}

# Benchmark
microbenchmark(geos = geos.dt(),
               sf = sf(),
               times = 10)

# Unit: seconds
#  expr      min       lq     mean   median       uq      max neval
#  geos 3.406296 3.823752 4.388384 4.226851 4.992151 6.192083    10
#    sf 2.431363 2.493557 2.894264 2.870200 3.118318 3.941235    10
```

