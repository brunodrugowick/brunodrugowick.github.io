---
layout: post
title:  "Automatically update your GitHub Pages website with posts from dev.to"
date:   2022-03-26T21:29:55Z
---

<style type="text/css" media="screen">
  .card {
    box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
    transition: 0.3s;
    width: 100%;
  }
  .card:hover {
    box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
  }
  .container {
    padding: 2px 16px;
  }
</style>

<code>[github, githubactions, jekyll, static]</code>
<div class=card>
	  <div class=container>
	    <h4><b><br>You'll have a better experience reading in DEV</b></h4>
	    <p><a href="https://dev.to/brunodrugowick/update-your-github-pages-website-with-posts-from-devto-ein" target="_blank">Click here to continue reading this post there >></a></p>
	    <p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/update-your-github-pages-website-with-posts-from-devto-ein" target="_blank">read more</a>.</p>
	    <p>You can continue to read here too, it's up to you... =]</p>
	  </div>
	</div><br>
<h2>
  <a name="important-note" href="#important-note">
  </a>
  Important note
</h2>

<p>It's all free. The idea here is to get a working solution without spending a penny.</p>

<h2>
  <a name="introduction" href="#introduction">
  </a>
  Introduction
</h2>

<p>I've already talked about GitHub Pages a long while ago when I first created my personal website.</p>

<p>Then, for convenience, I switched to another tool, which was free at the time, and never touched my website again. I won't name it because from around 2 years ago to now, when I decided to write a few things again, the tool is just a mess and it's not working. I'd have to pay to make it work the way I want, which is basically:</p>

<ul>
<li>A freaking simple static website with the list of my posts in dev.to.</li>
</ul>

<p>The reasons: I don't make any money from my website, is just a place to put some things I like to talk about; also, I forget things easily and will need to refer to these things in the future for sure.</p>

<h2>
  <a name="cut-to-the-chase" href="#cut-to-the-chase">
  </a>
  Cut to the chase
</h2>

<h3>
  <a name="1-build-your-personal-website" href="#1-build-your-personal-website">
  </a>
  1. Build your personal website
</h3>

<p>I won't spend time here, <a href="https://pages.github.com/">GitHub has lots of info about this</a>... and <a href="https://dev.to/brunodrugowick/github-pages-and-google-domains-together-5ded">I have a post on how to combine it with Google Domains</a> (that recently got out of Beta, by the way).</p>

<h3>
  <a name="2-create-a-script-to-get-the-posts" href="#2-create-a-script-to-get-the-posts">
  </a>
  2. Create a script to get the posts
</h3>

<p>Dev.to as a <a href="https://developers.forem.com/api">very nice API</a> and, most importantly, GET requests are free! So we can create a very simple script to get your posts and then - and here's the trick, save to a file that your GitHub Pages website understands as data! Here's the script:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight plaintext"><code>#!/bin/bash

#### Thing to notice 1 ####
POSTS_FILE=./_data/devPosts.json

# Clear the posts file
echo -n "" &gt;$POSTS_FILE

#### Thing to notice 2 ####
POSTS_JSON=$(curl https://dev.to/api/articles?username=brunodrugowick&amp;?per_page=1000)

#### Thing to notice 3 ####
echo "$POSTS_JSON" | jq &gt;&gt;$POSTS_FILE
date &gt;last_updated_date
</code></pre>
<div class="highlight__panel js-actions-panel">
<div class="highlight__panel-action js-fullscreen-code-action">
    <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewbox="0 0 24 24" class="highlight-action crayons-icon highlight-action--fullscreen-on"><title>Enter fullscreen mode</title>
    <path d="M16 3h6v6h-2V5h-4V3zM2 3h6v2H4v4H2V3zm18 16v-4h2v6h-6v-2h4zM4 19h4v2H2v-6h2v4z"></path>
</svg>

    <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewbox="0 0 24 24" class="highlight-action crayons-icon highlight-action--fullscreen-off"><title>Exit fullscreen mode</title>
    <path d="M18 7h4v2h-6V3h2v4zM8 9H2V7h4V3h2v6zm10 8v4h-2v-6h6v2h-4zM8 15v6H6v-4H2v-2h6z"></path>
</svg>

</div>
</div>
</div>



<h4>
  <a name="thing-to-notice-1" href="#thing-to-notice-1">
  </a>
  Thing to notice 1
</h4>

<p>Notice how this variable points to a file under the <code>_data</code> directory. This is <a href="https://jekyllrb.com/docs/datafiles/">a special directory for GitHub Actions, that's powered by Jekyll</a>.</p>

<p>Files in this directory can be used as data when building your static website. You'll see in a few how this is used.</p>

<h4>
  <a name="thing-to-notice-2" href="#thing-to-notice-2">
  </a>
  Thing to notice 2
</h4>

<p>This part of the script is the request to the dev.to API. Notice the parameters:</p>

<ul>
<li>
<code>username=brunodrugowick</code> is getting the posts for my user. You should change that to your username.</li>
<li>
<code>per_page=1000</code> is the number of posts to retrieve. I believe I won't ever get to that number, but in case I do I'll work on a loop to handle the pagination. =)</li>
</ul>

<h4>
  <a name="thing-to-notice-3" href="#thing-to-notice-3">
  </a>
  Thing to notice 3
</h4>

<p>This part of the script writes the result of the request above to the data file that we referenced earlier. The pipe (<code>|</code>) to <code>jq</code> is to format nicely, probably not required.</p>

<h3>
  <a name="3-list-the-posts-in-your-website" href="#3-list-the-posts-in-your-website">
  </a>
  3. List the posts in your website
</h3>

<p>At this point, this script can already be used in your local environment to fill in a data file that you can use in your GitHub Pages website. Let's do this then. </p>

<p>Put this code in your <code>index.md</code> page (you can use <code>.html</code> too or put this code anywhere else that you want in your website):<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight plaintext"><code>{% for devPost in site.data.devPosts %}
## {{ devPost.title }}

{{ devPost.readable_publish_date }}

{{ devPost.description }} [continue to read]({{ devPost.url }})

{% endfor %}
</code></pre>
<div class="highlight__panel js-actions-panel">
<div class="highlight__panel-action js-fullscreen-code-action">
    <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewbox="0 0 24 24" class="highlight-action crayons-icon highlight-action--fullscreen-on"><title>Enter fullscreen mode</title>
    <path d="M16 3h6v6h-2V5h-4V3zM2 3h6v2H4v4H2V3zm18 16v-4h2v6h-6v-2h4zM4 19h4v2H2v-6h2v4z"></path>
</svg>

    <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewbox="0 0 24 24" class="highlight-action crayons-icon highlight-action--fullscreen-off"><title>Exit fullscreen mode</title>
    <path d="M18 7h4v2h-6V3h2v4zM8 9H2V7h4V3h2v6zm10 8v4h-2v-6h6v2h-4zM8 15v6H6v-4H2v-2h6z"></path>
</svg>

</div>
</div>
</div>



<p>This is a simple <code>for</code> loop that goes through all of the posts that you saved to a <code>devPosts</code> file using the script that we created earlier.</p>

<p>The directive <code>site.data.devPosts</code> is what refers to that file. Everything that we access for a post in particular, like <code>devPost.description</code> or <code>devPost.url</code> is refering to the fields returned from the dev.to API.</p>

<h3>
  <a name="4-automate-the-task-of-updating-your-website" href="#4-automate-the-task-of-updating-your-website">
  </a>
  4. Automate the task of updating your website
</h3>

<p>What we have so far is good enough, right? Every time you write something to dev.to you could go to your personal website repository, run the script and push a commit to let GitHub build and publish your website for you. </p>

<p>But we can go one step further and automate the whole thing with GitHub Actions! We'll create a workflow called Update Articles in your repository. Create a file <code>.github/workflows/update-articles.yml</code> in your repository with the following content:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight plaintext"><code>name: Update Articles

#### Thing to notice 1 ####
on:
  schedule:
    - cron:  '30 23 * * *'
  workflow_dispatch:

jobs:
  run-script:
    runs-on: ubuntu-latest

    steps:
      - uses: actions/checkout@v2

      - name: Run script to get articles from dev.to
        #### Thing to notice 2 ####
        run: |
          ./scripts/post_files_from_GET_json.sh

      - name: Commit to the repo
        run: |
          git config --global user.name 'Bruno Drugowick'
          git config --global user.email 'brunodrugowick@users.noreply.github.com'
          git add .
          git commit -am "Update articles list"
          git push

</code></pre>
<div class="highlight__panel js-actions-panel">
<div class="highlight__panel-action js-fullscreen-code-action">
    <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewbox="0 0 24 24" class="highlight-action crayons-icon highlight-action--fullscreen-on"><title>Enter fullscreen mode</title>
    <path d="M16 3h6v6h-2V5h-4V3zM2 3h6v2H4v4H2V3zm18 16v-4h2v6h-6v-2h4zM4 19h4v2H2v-6h2v4z"></path>
</svg>

    <svg xmlns="http://www.w3.org/2000/svg" width="20px" height="20px" viewbox="0 0 24 24" class="highlight-action crayons-icon highlight-action--fullscreen-off"><title>Exit fullscreen mode</title>
    <path d="M18 7h4v2h-6V3h2v4zM8 9H2V7h4V3h2v6zm10 8v4h-2v-6h6v2h-4zM8 15v6H6v-4H2v-2h6z"></path>
</svg>

</div>
</div>
</div>



<h4>
  <a name="thing-to-notice-1" href="#thing-to-notice-1">
  </a>
  Thing to notice 1
</h4>

<p>This section ensures your workflow runs both on a <code>schedule</code> (every day at 11:30 PM) or whenever you want via <code>workflow_dispatch</code>. Here's what this will look like in your repository later:</p>

<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--ehVJrxGe--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/uploads/articles/of1vlv0zfi4d4ybghh52.png" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--ehVJrxGe--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/uploads/articles/of1vlv0zfi4d4ybghh52.png" alt="Running GitHub Action with workflow_dispatch option" loading="lazy" width="880" height="576"></a></p>

<h4>
  <a name="thing-to-notice-2" href="#thing-to-notice-2">
  </a>
  Thing to notice 2
</h4>

<p>This section is just instructing GitHub Actions to run your workflow on the local copy of the repository that was checked out one step above. </p>

<p>The rest of the script is a commit to the repository with the change. This simplified version makes sure we commit anything, even if none, but we could verify if there was a change before deciding to push a commit to the repository, for example.</p>

<h2>
  <a name="conclusion" href="#conclusion">
  </a>
  Conclusion
</h2>

<p>There you have it, now whatever you write on dev.to is also mirrored on your personal website.</p>

<p>Please let me know in the comments if you know another solution for this "problem".</p>...