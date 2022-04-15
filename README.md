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

A script gets articles from the DEV api.

## Jekyll Data Files

There's way more to learn about GitHub Pages and Jekyll, but I'd like to suggest just one more piece of documentation:

[Jekyll Data Files](https://jekyllrb.com/docs/datafiles/)

Jekyll Data Files are very useful to organize the information on your GitHub Page. It gives you the ability to edit sections of your page without touching the markup file (.md or .html), just like I taught you with the Posts, but for your own data structures. 

## Development

Because I always forget:

```
bundle install
```

```
bundle exec jekyll serve
```

