---
layout: post
title: Running this website
author: Vincent Thorne
---

How to create and maintain [my personal website](http://vronizor.github.io) built with [Jekyll](https://jekyllrb.com/) and hosted on [GitHub Pages](https://pages.github.com/).

## Create the website

A thorough guide is available in the [GitHub docs](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/creating-a-github-pages-site-with-jekyll). Since I first built the website things have changed quite a bit, and I also mostly forgot how I did it (surely my developer friend was key to this step).

## Running locally and maintaining

The website is made out of ruby Gems. The way to keep Gems' dependencies correct and compatible with one another is to use Bundler. Thus, most of the operations should be done through Bundler.

1. `cd /Users/vinceth/Documents/GitHub/vronizor.github.io`
2. `bundle exec jekyll serve` to serve the website locally
    1. if it doesn't work, you might have to update the Gems: run `bundle update` and `bundle install`. Try to serve locally again.
    2. if it doesn't work, start from scratch:
        1. Run `gem env` and make sure the correct Ruby version is in your `~/.zshrc`. Restart the terminal.
        2. Delete the Gemfiles
        3. Initialize a new Gemfile `bundle init`
        4. Add GitHub pages: `bundle add github-pages` and `bundle install` everything
        5. Add whatever it complains about when trying `bundle exec jekyll serve`
            1. 2021-06-18: I had to `bundle add webrick`, `bundle add rake` and write the following to the Gemfile:

                ```ruby
                *# If you have any plugins, put them here!
                group :jekyll_plugins do
                    gem "jekyll-feed"
                    gem "jekyll-remote-theme"
                  end*
                ```

    3. Make your changes and then push them all to GitHub.
    4. Web-search whatever problems you have left until your head explodes and you beg your developer friend to please help you.

It's important to update the bundle regularly or GitHub and its Dependabot will complain about security issues. These complaints are annoying and you want to avoid them at all costs, even if that means pulling your hair over Jekyll and Gems every now and then.

## Alternatives to Jekyll

[Hugo](https://gohugo.io/) is another very popular (and possibly more user-friendly?) static website generator. For now I'm sticking to Jekyll because I like the theme I am using, [Just the Docs](https://github.com/pmarsceill/just-the-docs), which gives more of a "traditional" website structure than many other themes I've seen.