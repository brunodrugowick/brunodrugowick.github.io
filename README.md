The latest version of this site can be seen at [https://brunodrugowick.github.io](https://brunodrugowick.github.io).

# GitHub Pages

GitHub Pages can serve static content for free using your GitHub account. I use Jekyll to theme and blog on this website. Whenever you commit to your GitHub Pages repository, [Jekyll](https://jekyllrb.com/) runs to rebuild the pages in your site, from the content in your Markdown (or HTML) files.

## Quick Start

For free GitHub accounts, create a public repository called `<username>.github.io`. The `<username>` must be your GitHub username.

Create an `index.md` file with the following content:
```
# Hello World
```

Now your website is up and running at `https://<username>.github.io`.

## Blog Posts

### Create a file

Blog posts are files with the following name convention under `_posts` directory:
```
YEAR-MONTH-DAY-title.md
Example: 2019-04-24-HelloWorld.md
```

### Add a header

The following header can be added to every blog post, although you might want to do something different. It's up to you, really.
```
---
layout: default
title: Hello World
---

[HOME]({{ site.url }})
```

You then start writing your post using Markdown syntax.

## Developing locally

You don't want to edit everything on your web browser, do you? Especially after you start to know [everything Jekyll can do](https://jekyllrb.com/docs/).

To build the website locally follow the instructions [here](https://help.github.com/en/articles/setting-up-your-github-pages-site-locally-with-jekyll). You'll need Ruby. Build and run locally with `bundle exec jekyll serve` after configuring everything.