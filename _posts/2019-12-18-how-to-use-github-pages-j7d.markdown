---
layout: post
title:  "How to Use GitHub Pages"
date:   2019-12-18T15:18:38Z
categories: 
---

> <div class=card><div class=container><h4><b><a href="https://dev.to/brunodrugowick/how-to-use-github-pages-j7d">You'll have a better experience reading in DEV...</a></b></h4><i><p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/how-to-use-github-pages-j7d">read more</a>.</p><p>You can continue to read here too, it's up to you...</p></i></div></div>
<h1>
 <a name="how-to-use-github-pages" href="#how-to-use-github-pages">
 </a>
 How to Use GitHub Pages
</h1>

<p>GitHub Pages can serve static content for free using your GitHub account. I use Jekyll to theme and blog on <a href="https://drugowick.dev">drugo.dev</a> (and the irony is that I'm moving to <a href="https://dev.to">dev.to</a> now - more on that later). Whenever you commit to your GitHub Pages repository, <a href="https://jekyllrb.com/">Jekyll</a> runs to rebuild the pages in your site, from the content in your Markdown (or HTML) files.</p>

<h2>
 <a name="quick-start" href="#quick-start">
 </a>
 Quick Start
</h2>

<p>For free GitHub accounts, create a public repository called <code>&lt;username&gt;.github.io</code>. The <code>&lt;username&gt;</code> must be your GitHub username.</p>

<p>Create an <code>index.md</code> file with the following content:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight plaintext"><code># Hello World
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



<p>Now your website is up and running at <code>https://&lt;username&gt;.github.io</code>.</p>

<h2>
 <a name="theming" href="#theming">
 </a>
 Theming
</h2>

<p>You can theme GitHub pages simply by going to your repository Settings page and selecting a theme using the Theme Chooser on the GitHub Pages section. What this does is create a file on the root of your project... so, if you create the file yourself, you're done. Follow the steps:</p>

<ol>
<li>Create a file named <code>_config.yml</code> on the root of your GitHub Pages repository.</li>
<li>
<p>Add the following to the file:<br>
</p>
<pre class="highlight plaintext"><code>theme: jekyll-theme-cayman
</code></pre>

</li>
<li><p>Commit the file and push it to GitHub.</p></li>
</ol>

<p>You're themed! If you want to use other themes, you can either go to your repository Settings page or <a href="https://help.github.com/en/articles/adding-a-jekyll-theme-to-your-github-pages-site">learn more here</a>.</p>

<h2>
 <a name="blog-posts" href="#blog-posts">
 </a>
 Blog Posts
</h2>

<h3>
 <a name="create-a-file" href="#create-a-file">
 </a>
 Create a file
</h3>

<p>Blog posts are files with the following name convention under <code>_posts</code> directory:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight plaintext"><code>YEAR-MONTH-DAY-title.md
Example: 2019-04-24-HelloWorld.md
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



<h3>
 <a name="add-a-header" href="#add-a-header">
 </a>
 Add a header
</h3>

<p>The following header must be added to every blog post, although you might want to customize title and other things. It's up to you, really. The HOME link for example is totally a personal choice.<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight plaintext"><code>---
layout: default
title: "Hello World"
---

[HOME]({{ site.url }})
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



<p>You then start writing your post using Markdown syntax.</p>

<h2>
 <a name="developing-locally" href="#developing-locally">
 </a>
 Developing locally
</h2>

<p>You don't want to edit everything on your web browser, do you? Especially after you start to know <a href="https://jekyllrb.com/docs/">everything Jekyll can do</a>.</p>

<p>To build the website locally follow the instructions <a href="https://help.github.com/en/articles/setting-up-your-github-pages-site-locally-with-jekyll">here</a>. You'll need Ruby. Build and run locally with <code>bundle exec jekyll serve</code> after configuring everything.</p>

<h2>
 <a name="finally" href="#finally">
 </a>
 Finally...
</h2>

<p>There's way more to learn about GitHub Pages and Jekyll, but I'd like to suggest just one more piece of documentation:</p>

<p><a href="https://jekyllrb.com/docs/datafiles/">Jekyll Data Files</a></p>

<p>Jekyll Data Files are very useful to organize the information on your GitHub Page. It gives you the ability to edit sections of your page without touching the markup file (.md or .html), just like I taught you with the Posts, but for your own data structures. </p>

<p>If you want to take a look, this websites uses, so far, Data Files for the "Useful Links" and "Active Projects" sections.</p>...