---
layout: default
title: How to Use GitHub Pages
showOnHome: false
excerpt_separator: <!--more-->
comments: true
devToUrl: https://dev.to/brunodrugowick/how-to-use-github-pages-j7d
---

# How to Use GitHub Pages

GitHub Pages can serve static content for free using your GitHub account. I use [Jekyll](https://jekyllrb.com/) to theme and blog on drugo.dev (and the irony is that I'm moving to dev.to now - more on that later). Whenever you commit to your GitHub Pages repository, Jekyll runs to rebuild the pages in your site, from the content in your Markdown (or HTML) files.

<!--more-->

<a href="https://dev.to/brunodrugowick/how-to-use-github-pages-j7d" target="_blank">Continue reading at dev.to...</a>

## Quick Start

For free GitHub accounts, create a public repository called `<username>.github.io`. The `<username>` must be your GitHub username.

Create an `index.md` file with the following content:
```
# Hello World
```

Now your website is up and running at `https://<username>.github.io`.

## Theming

You can theme GitHub pages simply by going to your repository Settings page and selecting a theme using the Theme Chooser on the GitHub Pages section. What this does is create a file on the root of your project... so, if you create the file yourself, you're done. Follow the steps:

1. Create a file named `_config.yml` on the root of your GitHub Pages repository.
2. Add the following to the file:
    ```
    theme: jekyll-theme-cayman
    ```
3. Commit the file and push it to GitHub.

You're themed! If you want to use other themes, you can either go to your repository Settings page or [learn more here](https://help.github.com/en/articles/adding-a-jekyll-theme-to-your-github-pages-site).

## Blog Posts

### Create a file

Blog posts are files with the following name convention under `_posts` directory:
```
YEAR-MONTH-DAY-title.md
Example: 2019-04-24-HelloWorld.md
```

### Add a header

The following header must be added to every blog post, although you might want to customize title and other things. It's up to you, really. The HOME link for example is totally a personal choice.
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

## Finally...

There's way more to learn about GitHub Pages and Jekyll, but I'd like to suggest just one more piece of documentation:

[Jekyll Data Files](https://jekyllrb.com/docs/datafiles/)

Jekyll Data Files are very useful to organize the information on your GitHub Page. It gives you the ability to edit sections of your page without touching the markup file (.md or .html), just like I taught you with the Posts, but for your own data structures. 

If you want to take a look, this websites uses, so far, Data Files for the "Useful Links" and "Active Projects" sections.
