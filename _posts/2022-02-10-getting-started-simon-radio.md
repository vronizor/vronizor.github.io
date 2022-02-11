---
layout: post
title: Getting started with Simon's Sunset Radio
author: Vincent Thorne
#last-edit: 2022-02-09
---

# Introduction

I love Simon Caldwell's [*Sunset* radio show](https://fbiradio.com/945fm/programs/sunset-simon-caldwell/) on FBI. It's jsut the kind of electronic music that can fuel my entire day. Large portion's of my time is spent on FBI's website, methodically clicking away to get the next show. Unfortunately for hardcore fans like myself, FBI doesn't provide a podcast of Simon's shows, and we're reduced to navigate the clumsy and laggy website.

That's until I decided to take matters in my own hands and build my own *Sunset with Simon Caldwell* “radio”. In this post, I'll start by trying to understand FBI's website structure. I will use R, my language of choice since a few years — both because that's what I'm most comfortable with, but also to check how it will perform in less data-centered tasks. Let's get started!

# Code

```R
library(xml2)
library(rvest)
library(stringr)
library(data.table)
options(timeout=10000) # increase download timeout threshold
```


First, let's get all links on the show's main landing page.

```R
mainpage = "https://fbiradio.com/945fm/programs/sunset-simon-caldwell/"
pg = read_html(mainpage)

links.all = html_attr(html_elements(pg, "a"), "href")
```

Check if we see any `.mp3` links.

```R
grep(".*\\.mp3", links.all, value = T)
# character(0)
```

No luck — that would have been too easy!

Inspecting the "play" button, we notice that clicking on it provokes an event. Looking at the network activity (in the browser's developer tools) when clicking the play button, we see that it `GET`s an mp3 file which we can copy the url.

```R
mp3_url = "https://d27rxetjl76nhc.cloudfront.net/ondemand/2022/02/07/202202071800_1_1_Sunset_-_Simon_Caldwell.mp3"
```

Let's try to decompose the URL in intelligible parts: notice the year after the `/ondemand/` part.

```R
year = gsub(".+/([0-9]{4})/.+", "\\1", mp3_url)
month = gsub(".+/[0-9]{4}/([0-9]{2})/.+", "\\1", mp3_url)
day = gsub(".+/[0-9]{4}/[0-9]{2}/([0-9]{2}).+", "\\1", mp3_url)
print(paste(year, month, day))
# [1] "2022 02 07"
```

Using some regex, `gsub` identifies the numbers that represent each date element. Notice the digits in parenthesis which form the group that may be extracted with the second argument `\\1`. Notice as well that we can tell regex how many digits we expect in curly brackets. After many years fighting it, I finally started to "get" and enjoy regex — do yourself a favor and get your hands dirty too! Once you start getting comfortable with it's inner workings, you'll find out it's pretty powerful. There are great online tools to get acquainted with the beast: I use [regexr.com](regexr.com) a lot to test regex code.

Back to our URL: notice how the date is repeated (all concatenated) after the day element we extracted. It seems to be followed by the show's start time, `18.00`. Let's extract that with more regex.

{% raw %}

```R
ymd = paste0(year, month, day)
hour = gsub(str_glue(".+/{ymd}([0-9]{{4}})_.+"), "\\1", mp3_url)
hour
# [1] "1800"
```
{% end raw %}

`str_glue` from `stringr` is great because it let's you refer to variables directly in the string using curly brackets. However, since our regex code also needs the curly brackets to know how many digits to expect, I had to double the curly brackets around the 4.

The rest of the mp3 name doesn't seem to have much to it and we may store it as is.

```R
ymdh = paste0(year, month, day, hour)
stub = gsub(str_glue(".+/{ymdh}(.+\\.mp3)$"), "\\1", mp3_url)
stub
# [1] "_1_1_Sunset_-_Simon_Caldwell.mp3"
```


Let's review the pieces we have so far:
```R
year
month
day
ymdh
stub
# [1] "2022"
# [1] "02"
# [1] "07"
# [1] "202202071800"
# [1] "_1_1_Sunset_-_Simon_Caldwell.mp3"
```

We should probably add the very first part of the URL as well.
```R
trunk = gsub(str_glue("^(.+/){year}/{month}/{day}/{ymdh}(.+\\.mp3)$"), "\\1", mp3_url)
print(str_glue("{trunk}{year}/{month}/{day}/{ymdh}{stub}"))
# https://d27rxetjl76nhc.cloudfront.net/ondemand/2022/02/07/202202071800_1_1_Sunset_-_Simon_Caldwell.mp3

```

Alright, now that we have the building blocks, let's try to got other shows at earlier dates. We start manually inputing different values for the dates and see if anything comes up.

```R
month = "01"
day = "31"

test_url = str_glue("{trunk}{year}/{month}/{day}/{year}{month}{day}{hour}{stub}")
test_url
# https://d27rxetjl76nhc.cloudfront.net/ondemand/2022/01/31/202201311800_1_1_Sunset_-_Simon_Caldwell.mp3

file_name = str_glue("{year}-{month}-{day}_simon-sunset.mp3")

# create "shows" directory if missing 
if(!dir.exists("shows")) {dir.create("shows")}
download.file(test_url, destfile = file.path(file_name), mode = "wb")
```

It worked! In next post, we'll see how far back in time we can go using some date-time packages for R.
