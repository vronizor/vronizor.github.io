---
layout: post
title: Managing memory in R
author: Vincent Thorne
last-edit: 2021-06-21
---

A computer's memory is where a computer stores the working data it wants to make operations on. RAM is the most common form of memory in general purpose computers. Memory should not be confused storage, which is usually located on a hard drive (slower, higher capacity) or flash storage (faster, lower capacity). In R, loaded datasets and created objects are held in memory, ready for computation. Since your memory is ([more or less](https://osxdaily.com/2010/10/08/mac-virtual-memory-swap/)) limited by your RAM capacity, it's important to manage it in order to avoid `Error: vector memory exhausted (limit reached?)` errors, which are as frustrating as unambiguous.

# Using the right packages

When working with large datasets with millions of observations, you can quickly run out of memory. The first step is to make sur you are working with `[data.table](https://rdatatable.gitlab.io/)`s instead of `data.frame`s. `data.table`s process *[much faster](https://h2oai.github.io/db-benchmark/)* than most other in-memory data management packages.

# Remove and garbage collect

Second, be sure to remove unused objects: use the `rm(<object>)` or `rm(list = c('<object1>', '<object2>', ...))` if you have multiple objects. After removing, be sure to garbage collect using `gc()`: this erases all unlink objects from your RAM. [This video](https://www.youtube.com/watch?v=2JasKMJonaQ) is a nice and short introduction to garbage collection for non-programmers. A typical use of `rm(...)` and `gc()` is shown below.

```r
### Some loading and transformations ###
# Load SF in memory from storage
grid_panel.sf = readRDS('2_data/2_constructed/the_grid_3.0.Rds')
# Transform to data.table for faster manipulation
grid_panel.dt = as.data.table(grid_panel.sf)
# Keep only some variables, keep only one row per ID
grid_work.dt = grid_panel.dt[unique(id), .(id, cell_index, geometry)]
# Change the name of variables
setnames(grid_work.dt, 'id', 'cell_id')
# Transform back to SF
grid_work.sf = st_as_sf(grid_work.dt)

### Clean-up ###
rm(list = c('grid_panel.sf', 'grid_panel.dt', 'grid_work.dt'))
gc()
```

# Slice it up

Finally, you may slice up your data and perform the computation in a loop, and re-assemble the pieces in a final step. If you work with multi-years datasets for example, you might have to perform some operations year-by-year, and bind all the years back together once the computations are completed.

# Can't slice it? Automate script writing

Beware, however, that some operations are better executed outside a loop: if the method you use takes advantage of parallelized computation, a loop will restrict that ability. Therefore, packages like `data.table` ([when properly installed on Mac](https://github.com/Rdatatable/data.table/wiki/Installation#openmp-enabled-compiler-for-mac)) and `[r5r](https://ipeagit.github.io/)` are at their full potential outside of loops. 

What if you have a series of operations using these packages that would fit perfectly in a loop? My last trick for these cases is to write a script containing all the functions with all the operations you wish to perform sequentially. Then, using a loop, you can create almost instantly a number of different script that load your functions and perform the operations. Copy/paste the running of this script and you get the full power of parallelize methods in a loop-y fashion. Below is an example that illustrates that last "trick".

```r
#~~~~~~~~~~~~~~~~~~~~~~~~~~~#
####       INTRO         ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~#

# Matrix of stations, for each year

# Each route is independently computed for each year,
# since we have yearly street network maps.

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
####       PACKAGES         ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

library(tidyverse)
library(sf)
library(data.table)
library(tmap)
options(java.parameters = '-Xmx8G')
library(r5r)
library(tictoc)

### Clean all variables and garbage collect
rm(list = ls())
gc()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
####       FUNCTIONS         ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

#~~~~~~~~~~~~~~~~~~~~~~~~~~#
####       CODE         ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~#

####~~~~~~~~~~~~~~~~~ Write the content of each script ~~~~~~~~~~~~~~~~~####

# Running each script individually enables us to use the full power of the Java
# machine, computing routes in parallel across multiple cores.
# Inside a loop, only a single core would be used.

routing.path = file.path('1_scripts', '1_data-prep', '1_routing')

if(!dir.exists(routing.path)){
  dir.create(routing.path)
}

#### Content of individual scripts ####

for (y in 2013:2019){
  
  script.path = file.path(routing.path, str_glue('routing_{y}.R'))
  
  if (!file.exists(script.path)) {
    file.create(script.path)
  }
  
  script = file(script.path)
  content = c('rm(list = ls())',
              'gc()',
              "source(file.path('1_scripts', '1_data-prep', '1_routing', 'routing-fncts.R'))", # routing-fncts.R contains all the commands necessary to perform the computations.
              str_glue("r5r_full.process({y})"),
              str_glue("routing.path = '{routing.path}'")) # Load the routing path to be able to load the next routing script in master.
  writeLines(content, script)
  close(script)
  
}

####~~~~~~~~~~~~~~~~~ Run each script individually ~~~~~~~~~~~~~~~~~####

source(file.path(routing.path, 'routing_2013.R'))
source(file.path(routing.path, 'routing_2014.R'))
source(file.path(routing.path, 'routing_2015.R'))
source(file.path(routing.path, 'routing_2016.R'))
source(file.path(routing.path, 'routing_2017.R'))
source(file.path(routing.path, 'routing_2018.R'))
source(file.path(routing.path, 'routing_2019.R'))

# Clean up
rJava::.jgc(R.gc = TRUE)
gc()
```