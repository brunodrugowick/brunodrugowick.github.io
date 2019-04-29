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

The following header can be added to every blog post, although you might want to do something different. It's up to you, really.
```
---
layout: default
title: GitHub Pages - How To
---
```

You then start writing your post using Markdown syntax.

## Developing locally

You don't want to edit everything on your web browser, do you? Especially after you start to know [everything Jekyll can do](https://jekyllrb.com/docs/).

To build the website locally follow the instructions [here](https://help.github.com/en/articles/setting-up-your-github-pages-site-locally-with-jekyll). You'll need Ruby. Build and run locally with `bundle exec jekyll serve` after configuring everything.

## Jekyll Data Files

There's way more to learn about GitHub Pages and Jekyll, but I'd like to suggest just one more piece of documentation:

[Jekyll Data Files](https://jekyllrb.com/docs/datafiles/)

Jekyll Data Files are very useful to organize the information on your GitHub Page. It gives you the ability to edit sections of your page without touching the markup file (.md or .html), just like I taught you with the Posts, but for your own data structures. 

If you want to take a look, this websites uses, so far, Data Files for the "Useful Links" and "Active Projects" sections.

## Specific customizations for this project

### default.html

Although I'm using a template, I wanted to customized it so I follow the instructions [here](https://github.com/pages-themes/cayman).

I basically created a `assets/css/style.scss` file with the following content:
```
---
---

@import "{{ site.theme }}";
```

And them created a `_layouts/default.html` file with the content from the [same file on the theme project](https://github.com/pages-themes/cayman/blob/master/_layouts/default.html). After that I started to customize it.