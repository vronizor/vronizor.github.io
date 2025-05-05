---
layout: post
title: R Language — A Comprehensive Guide for Beginners
author: Vincent Thorne
date: 2025-05-02
toc: true
---

After years of working with Stata for data analysis, I've found that R offers a powerful alternative with some distinct advantages. While there are many R tutorials available online, this guide represents my specific perspective and approach as someone who transitioned from Stata. I focus on the elements I found most useful and the challenges I encountered along the way.

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

## Basic Principles and Advantages vs Stata

R differs fundamentally from Stata in several important ways:

First, R allows you to work with multiple objects in memory simultaneously (data sets, functions, libraries, vectors), while Stata limits you to a single data set in memory. This flexibility enables more complex workflows and reduces the need for constant data loading/saving.

R is much closer to "real" programming languages like Python. Functions and packages are written in the same language as the one you use to code, making it intuitive to create your own tools. This seamless integration between user code and package development creates a lower barrier to expanding your capabilities.

The R community is massive, free, and open-source, offering thousands of specialized packages compared to Stata's more centralized ecosystem. When you encounter problems, you'll find extensive help online through forums, blogs, and documentation, all in a generally nice and supportive vibe (vs infamous Nick Cox...).

R's versatility allows you to do almost everything without leaving the environment. You can run other programs installed on your computer, connect to other languages (notably Python), write websites, books, or interactive dashboards. This extensibility means your skills transfer across various data science domains.

Finally, R offers a much nicer coding environment with features like code completion, syntax highlighting, proper indentation, and faster code writing. It also tends to work better with AI assistants!

## The Main Packages

### Principles

R was written a long time ago and comes with many commands out of the box, known as "base" commands. The packages that are always loaded include:

- `base`
- `stats`
- And some others

You can identify which package a command comes from by typing `?<command>` — the package name will show in curly brackets `<command> {package}`.

You could do 90% of your work with these base packages, but the R community has created additional packages to make your life easier. A pedantic but useful point: base commands are generally faster/more efficient, unless a package was specifically designed for speed. Sometimes packages prioritize convenience over speed, but other times they genuinely help you do things much more efficiently. I personally mix base commands with package commands all the time.

When looking for performance, search for "functions implemented in C" as a marker of speed.

To use additional packages, you need to:

1. Install them once: `install.packages("package")` (and again when you update R)
2. Load them every time you start a script: `library(package)`

As you load libraries, they "cover" the names of functions in your environment (this means if two packages have functions with the same name, the most recently loaded package's version will be used). You can always access the function of a package you have installed using `package::command()` to specify exactly which package's implementation you want.

### Input/Output (Mostly Input)

For working with various file formats, several packages excel:

**[`data.table`](https://rdatatable.gitlab.io/data.table/) functions:**

- `fread` for CSVs, JSON, and many other formats
- Sometimes `fread` doesn't work well with very large files or quirky encodings, in which case you'll need one of the packages below

**[tidyverse](https://www.tidyverse.org/):**

- [`readxl`](https://readxl.tidyverse.org) for Excel files
- [`readr`](https://readr.tidyverse.org/) for CSV files and other formats
  - More robust than `fread` in some cases, though sometimes slower

### Data Manipulation

Two main ecosystems dominate R's data manipulation landscape:

**tidyverse ([`dplyr`](https://dbplyr.tidyverse.org/), [`tidyr`](https://tidyr.tidyverse.org/)):**

- Generally considered the "easy" way, though sometimes not using the most efficient commands
- Heavy with lots of dependencies (i.e., other packages required to make it work well)
- Includes useful supplementary tools:
  - [`stringr`](https://stringr.tidyverse.org/) for string manipulation (learn [regex](https://regex101.com/)!)
  - [`lubridate`](https://lubridate.tidyverse.org) for dates and time manipulation
- Tip: don't load the whole tidyverse! Only load what you need

**`data.table`:**

- Designed for efficiency and speed
- Avoids making copies (memory-efficient), uses low-level C functions, can run on multiple threads
- Steeper learning curve, but worth the investment
- Somewhat similar to SQL syntax
- Can be used with `dplyr` style by running `data.table` in the background using [`dtplyr`](https://dtplyr.tidyverse.org/)

As you can tell, `data.table` is my go-to :-).

### Plotting

R offers different approaches to data visualization:

**Base functions:**

- Simple commands like `plot(vector1, vector2)` or `hist(vector)` for quick and easy plots

**[`ggplot2`](https://ggplot2.tidyverse.org/):**

- Part of the tidyverse ecosystem
- Takes time to learn but is incredibly powerful for complex visualizations
- I still Google (or ask LLMs) most of the things I want to do
- A helpful resource with examples: [ggplot2 essentials](http://www.sthda.com/english/wiki/ggplot2-essentials)
- Can also create maps, though I personally prefer `tmap` (a purely taste-based preference)

### Geo

For geographic data analysis and visualization:

**[`sf`](https://r-spatial.github.io/sf/) for vector data:**

- Handles buffers, intersections, spatial joins

**[`terra`](https://rspatial.github.io/terra/) for raster data:**

- Processes grid-based spatial data

Both may require some external packages installed on your computer (easily manageable with Homebrew).

**[`tmap`](https://r-tmap.github.io/tmap/) for mapping:**

- Currently transitioning to version 4.0, so commands might look strange
- I highly recommend the book [*Geocomputation with R*](https://geocompr.robinlovelace.net/) as both a learning resource and reference

### Other Useful Features

**`=` vs `<-`**

- You can use both `=` or `<-` to assign a value to a variable
- I usually use `=` because it's faster to type and more consistent with other programming languages

**Pipes:**

- You can pipe the result of a function into another function using `|>` (base pipe) or `%>%` (tidyverse pipe)
- This creates cleaner code for multiple data transformations in a row
- Makes code much more readable by reducing nested function calls

```r
# Without pipes (nested calls, hard to read)
head(filter(select(data, x, y), x > 10), 5)

# With pipes (much clearer)
data |> 
  select(x, y) |> 
  filter(x > 10) |> 
  head(5)
```

**Vectorization:**

- Many R functions accept vectors as input and efficiently apply operations to the entire vector
- When a function doesn't accept vectors, you can use the `*apply` family of functions
- This approach is typically faster than explicit loops

```r
# Vectorized operation (fast)
x <- 1:1000
y <- x^2 + 2*x + 1

# Using apply for custom function
nums <- 1:10
squared <- sapply(nums, function(x) x^2)
```

**Building your own functions:**

- Creating custom functions in R is straightforward
- You can examine how almost any function works by typing its name without the parentheses in the console

```r
# Define your own function
calculate_bmi <- function(weight_kg, height_m) {
  bmi <- weight_kg / (height_m^2)
  return(bmi)
}

# Use it
my_bmi <- calculate_bmi(70, 1.75)

# See function definition
head  # Type without parentheses to see how it works
```

**Object persistence:**

- To use a data set in different scripts, save objects with `saveRDS()` and load them with `readRDS()`
- This preserves all attributes of the object as they were when saved
- Please avoid saving CSVs for intermediate data whenever possible!

```r
# Save an R object
complex_dataframe <- data.frame(x = 1:10, y = letters[1:10])
saveRDS(complex_dataframe, "data/my_dataframe.rds")

# Later, in another script
complex_dataframe <- readRDS("data/my_dataframe.rds")
```

## Advanced Topics

### Parallel Computing

One disadvantage of R is that it's single-threaded by default, while Stata can be natively multithreaded (depending on the license). What does this mean?

- Your computer likely has 4-12 cores (processing units that perform calculations)
- Natively, R is single-threaded: operations happen one at a time (sequentially)
- As data sets grow larger, distributing operations across multiple cores can significantly reduce computation time

Solutions include:

- The `future` package ecosystem for "manual" parallel computing
- `data.table` installed from source to enable multi-threading for specific operations

### Large Data Sets

R, like most programming languages, primarily works with data "in-memory" (what your RAM can hold). This approach is fast but creates limitations with very large datasets (>10 million rows).

For memory-efficient processing:

- Use packages designed to minimize RAM usage (like `data.table`)
- For data too large to fit in memory, consider database-inspired approaches:
  - `duckdb` or `polars` can work with "on-disk" data without loading everything into RAM
  - These tools can even handle data split across multiple files

### Web Scraping

While not my specialty, R offers solid web scraping capabilities through:

- `rvest`, `xml2`, and `beautifulsoup` packages
- Python might be better for complex scraping projects

## Learn More

### Books

These resources have been invaluable in my R journey:

- [R for Data Science](https://r4ds.hadley.nz/) — The perfect starting point
- [Advanced R](https://adv-r.hadley.nz/) — Excellent for understanding how things work under the hood
- [Geocomputation with R](https://r.geocompx.org/) — Essential for spatial analysis

### Websites and Blogs

For staying current and solving problems:

- [data.table documentation](https://rdatatable.gitlab.io/data.table/)
- Most packages have websites with "vignettes" that demonstrate functionality
- Stack Overflow (an essential resource for troubleshooting)
- [R-bloggers](https://www.r-bloggers.com/)
- Twitter/X, Bluesky (follow R developers and data scientists)

### Pro Tips

Read the **help files** and **error messages** carefully! R documentation typically contains far more information than Stata's, including:

- Expected data types for function arguments
- Return value formats
- Detailed examples

Most errors can be solved by carefully reading the error message, which usually tells you exactly what went wrong. This approach has saved me countless hours of frustration.

---

I hope this guide helps your transition from Stata to R! The learning curve may feel steep at first, but the flexibility and power you'll gain are well worth the effort. If you have questions or suggestions, feel free to reach out.