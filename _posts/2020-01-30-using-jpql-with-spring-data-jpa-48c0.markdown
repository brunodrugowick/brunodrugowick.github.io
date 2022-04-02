---
layout: post
title:  "Using JPQL with Spring Data JPA"
date:   2020-01-30T03:35:50Z
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

<code>[java, spring, jpa, jpql]</code>
<div class=card>
	  <div class=container>
	    <h4><b><br>You'll have a better experience reading in DEV</b></h4>
	    <p><a href="https://dev.to/brunodrugowick/using-jpql-with-spring-data-jpa-48c0" target="_blank">Click here to continue reading this post there >></a></p>
	    <p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/using-jpql-with-spring-data-jpa-48c0" target="_blank">read more</a>.</p>
	    <p>You can continue to read here too, it's up to you... =]</p>
	  </div>
	</div><br>
<p>This is the post #4 of the series "Querying your Spring Data JPA Repository".</p>

<p>Let's recap: by now you should have an app like <a href="https://jpa-queries-blog-post.herokuapp.com/">this</a>. The frontend (Thymeleaf + a very bad UI design) doesn't matter since our goal is to understand several ways to query your Spring Data JPA repository. Regardless, I <a href="https://github.com/brunodrugowick/jpa-queries-blog-post/commit/020142ef12d5f2413837df50d341c459e8f10154">added Bootstrap</a> to make make it easier on the eyes.</p>

<h1>
  <a name="adding-a-few-properties" href="#adding-a-few-properties">
  </a>
  Adding a few properties
</h1>

<p>Let's add <code>city</code>, <code>grabAndGo</code> and <code>active</code> properties to our <code>Restaurant</code> entity. You can see how on <a href="https://github.com/brunodrugowick/jpa-queries-blog-post/commit/ab7a2e4307a84a4208d5bb0b8755ab2c9c88821a">this commit</a>.</p>

<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--q0nX5ejw--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/il9urv4xz85gh1529iuy.png" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--q0nX5ejw--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/il9urv4xz85gh1529iuy.png" alt="Alt Text" loading="lazy" width="880" height="649"></a></p>

<h1>
  <a name="the-requirement" href="#the-requirement">
  </a>
  The requirement
</h1>

<p>Let's say now that you want to create a new custom search on our awesome search area:</p>

<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--Ezu-ZRdN--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/32hl2ruu78g21j7lto8m.png" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--Ezu-ZRdN--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/32hl2ruu78g21j7lto8m.png" alt="Alt Text" loading="lazy" width="880" height="216"></a></p>

<p>This searches for active restaurants with Grab'n'Go enabled in a city specified by the user. </p>

<h1>
  <a name="i-know-how-to-do-this-already" href="#i-know-how-to-do-this-already">
  </a>
  "I know how to do this already"
</h1>

<p>Yes, if you're following the series you already know how to do this with Query Methods. Here you go:</p>

<ul>
<li>Create a new method on the RestaurantRepository interface:
</li>
</ul>

<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nc">List</span><span class="o">&lt;</span><span class="nc">Restaurant</span><span class="o">&gt;</span> <span class="nf">findAllByActiveTrueAndGrabngoTrueAndCityContaining</span><span class="o">(</span><span class="nc">String</span> <span class="n">city</span><span class="o">);</span>
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


<p>That's going to work, but look at the size of the method name! C'mon! Imagine having to use this huge method name all over your code. That's not <a href="https://dzone.com/articles/naming-conventions-from-uncle-bobs-clean-code-phil">clean</a>!</p>
<h1>
  <a name="-raw-query-endraw-to-the-rescue" href="#-raw-query-endraw-to-the-rescue">
  </a>
  <code>@Query</code> to the rescue
</h1>

<p>That's the exact scenario to use a JPQL query. Let's refactor the code above:</p>

<ul>
<li>Rename the method to something more acceptable, like <code>activeGrabngoByCity</code>.</li>
<li>Add the annotation <code>@Query</code> above the method name.</li>
<li>Create your custom JPQL query.</li>
</ul>

<p>Here's the result:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@Query</span><span class="o">(</span><span class="s">"from Restaurant r where r.active = true and r.grabngo = true and r.city like %:city%"</span><span class="o">)</span>
<span class="nc">List</span><span class="o">&lt;</span><span class="nc">Restaurant</span><span class="o">&gt;</span> <span class="nf">activeGrabngoByCity</span><span class="o">(</span><span class="nc">String</span> <span class="n">city</span><span class="o">);</span>
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


<p>Notice that you don't have to follow the Query Methods' rules to name the method. You're telling Spring that you're providing the query for this method via the <code>@Query</code> annotation.</p>

<p>For now that's all that I'm going to cover. You can take a look at <a href="https://docs.jboss.org/hibernate/orm/current/userguide/html_single/Hibernate_User_Guide.html#hql">this documentation</a> from Hibernate to do your own cool stuff, JPQL is very powerful!</p>
<h1>
  <a name="the-example-app" href="#the-example-app">
  </a>
  The example app
</h1>

<p>The working app is <a href="https://jpa-queries-blog-post.herokuapp.com/">here</a> (wait for Heroku to load the app, it takes a few seconds on the free tier).</p>
<h1>
  <a name="commits-related-to-this-post" href="#commits-related-to-this-post">
  </a>
  Commits related to this post
</h1>

<p>Adds Bootstrap: <a href="https://github.com/brunodrugowick/jpa-queries-blog-post/commit/020142ef12d5f2413837df50d341c459e8f10154">020142</a>.<br>
Adds new properties to the Restaurant:  <a href="https://github.com/brunodrugowick/jpa-queries-blog-post/commit/ab7a2e4307a84a4208d5bb0b8755ab2c9c88821a">ab7a2e</a>.<br>
Refactors to JPQL: <a href="https://github.com/brunodrugowick/jpa-queries-blog-post/commit/8758bfb7544c9f2d7a7001467e9c317e59753509">8758bf</a>.</p>


<div class="ltag-github-readme-tag">
  <div class="readme-overview">
    <h2>
      <img src="https://res.cloudinary.com/practicaldev/image/fetch/s--566lAguM--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev.to/assets/github-logo-5a155e1f9a670af7944dd5e12375bc76ed542ea80224905ecaf878b9157cdefc.svg" alt="GitHub logo" loading="lazy">
      <a href="https://github.com/brunodrugowick">
        brunodrugowick
      </a> / <a style="font-weight: 600;" href="https://github.com/brunodrugowick/jpa-queries-blog-post">
        jpa-queries-blog-post
      </a>
    </h2>
    <h3>
      A demo project for a blog post about (Spring Data) JPA.
    </h3>
  </div>
</div>...