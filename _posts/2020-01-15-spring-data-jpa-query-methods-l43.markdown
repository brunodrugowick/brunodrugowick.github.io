---
layout: post
title:  "Spring Data JPA Query Methods"
date:   2020-01-15T07:19:06Z
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

<code>[java, spring, jpa, query]</code>
<div class=card>
	  <div class=container>
	    <h4><b><br>You'll have a better experience reading in DEV</b></h4>
	    <p><a href="https://dev.to/brunodrugowick/spring-data-jpa-query-methods-l43" target="_blank">Click here to continue reading this post there >></a></p>
	    <p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/spring-data-jpa-query-methods-l43" target="_blank">read more</a>.</p>
	    <p>You can continue to read here too, it's up to you... =]</p>
	  </div>
	</div><br>
<p>This is the post #3 of the series "Querying your Spring Data JPA Repository".</p>

<p>If you're following the series, by now you have an app with a list of Restaurants. The list is fetched using the method <code>findAll()</code> which you did not implement, because it was provided by Spring Data JPA when you created the <code>RestaurantRepository</code> class extending Spring's <code>JpaRepository</code> class.</p>

<p>Take a look at the previous post if you haven't already: </p>


<div class="ltag__link">
  <a href="/brunodrugowick" class="ltag__link__link">
    <div class="ltag__link__pic">
      <img src="https://res.cloudinary.com/practicaldev/image/fetch/s--U-wFRb7a--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://res.cloudinary.com/practicaldev/image/fetch/s--LpCY0EbU--/c_fill%2Cf_auto%2Cfl_progressive%2Ch_150%2Cq_auto%2Cw_150/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/213112/5bb8eb2e-29a2-4307-be73-1ffdd76f8f9c.jpg" alt="brunodrugowick" loading="lazy">
    </div>
  </a>
  <a href="/brunodrugowick/querying-your-spring-data-jpa-repository-basic-setup-1i8p" class="ltag__link__link">
    <div class="ltag__link__content">
      <h2>Querying your Spring Data JPA Repository - Basic Setup</h2>
      <h3>Bruno Drugowick ・ Jan 12 '20 ・ 4 min read</h3>
      <div class="ltag__link__taglist">
        <span class="ltag__link__tag">#java</span>
        <span class="ltag__link__tag">#spring</span>
        <span class="ltag__link__tag">#jpa</span>
        <span class="ltag__link__tag">#repository</span>
      </div>
    </div>
  </a>
</div>


<h1>
  <a name="the-task" href="#the-task">
  </a>
  The Task
</h1>

<p>Let's say that now you have to add a search bar on top of the list in order to filter it. The search must match any Restaurant name that contains the text the user types.</p>

<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--Iai_rOuP--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/d2rnejoxbpen63ip8qv6.jpg" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--Iai_rOuP--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/d2rnejoxbpen63ip8qv6.jpg" alt="Search Restaurants" loading="lazy" width="880" height="453"></a></p>

<p>As you can see, if the user types <code>Ma</code> three Restaurants are shown: <code>Mamma Mia</code>; <code>La Maison du Croissant</code>; and <code>Marcante Pizzaria</code>. They all contain <code>Ma</code> in their names.</p>

<h1>
  <a name="preparing-the-application" href="#preparing-the-application">
  </a>
  Preparing the application
</h1>

<p>Well, let's prepare our app to work with this new requirement.</p>

<h3>
  <a name="search-bar" href="#search-bar">
  </a>
  Search bar
</h3>

<p>Let's add a search bar with the following Thymeleaf code on the <code>index.html</code> file:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight html"><code><span class="nt">&lt;form</span> <span class="na">th:action=</span><span class="s">"@{/search}"</span><span class="nt">&gt;</span>
    Search by:
    <span class="nt">&lt;select</span> <span class="na">name=</span><span class="s">"field"</span><span class="nt">&gt;</span>
        <span class="nt">&lt;option</span> <span class="na">value=</span><span class="s">"name"</span><span class="nt">&gt;</span>Name<span class="nt">&lt;/option&gt;</span>
    <span class="nt">&lt;/select&gt;</span>
    <span class="nt">&lt;input</span> <span class="na">placeholder=</span><span class="s">"Your search query"</span> <span class="na">th:name=</span><span class="s">"query"</span> <span class="na">th:value=</span><span class="s">"${query}"</span> <span class="na">type=</span><span class="s">"text"</span><span class="nt">/&gt;</span>
    <span class="nt">&lt;input</span> <span class="na">type=</span><span class="s">"submit"</span> <span class="na">value=</span><span class="s">"Search"</span><span class="nt">/&gt;</span>
<span class="nt">&lt;/form&gt;</span>
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


<p>That's a simple form that hits on <code>/search</code> address with two request parameters:</p>

<ul>
<li>
<code>field</code> which contains the name of the field the user wants to search on (supporting only <code>name</code> for now).</li>
<li>
<code>query</code> containing whatever the user types into the search field.</li>
</ul>

<p>The URL after clicking Search with <code>Ma</code> on the search field would be <code>https://whatever-your-server-is/search?field=name&amp;query=Ma</code>.</p>
<h3>
  <a name="controller-method" href="#controller-method">
  </a>
  Controller method
</h3>

<p>We need a method on the <code>IndexPage.java</code> controller to handle the search for the user. This is the method that does the trick:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@RequestMapping</span><span class="o">(</span><span class="s">"/search"</span><span class="o">)</span>
<span class="kd">public</span> <span class="nc">String</span> <span class="nf">indexWithQuery</span><span class="o">(</span><span class="nd">@RequestParam</span><span class="o">(</span><span class="s">"query"</span><span class="o">)</span> <span class="nc">String</span> <span class="n">query</span><span class="o">,</span>
                             <span class="nd">@RequestParam</span><span class="o">(</span><span class="s">"field"</span><span class="o">)</span> <span class="nc">String</span> <span class="n">field</span><span class="o">,</span>
                             <span class="nc">Model</span> <span class="n">model</span><span class="o">)</span> <span class="o">{</span>
    <span class="k">if</span> <span class="o">(</span><span class="n">field</span><span class="o">.</span><span class="na">equals</span><span class="o">(</span><span class="s">"name"</span><span class="o">))</span> <span class="o">{</span>
        <span class="c1">// TODO add search by name here.</span>
    <span class="o">}</span>
    <span class="n">model</span><span class="o">.</span><span class="na">addAttribute</span><span class="o">(</span><span class="s">"field"</span><span class="o">,</span> <span class="n">field</span><span class="o">);</span>
    <span class="n">model</span><span class="o">.</span><span class="na">addAttribute</span><span class="o">(</span><span class="s">"query"</span><span class="o">,</span> <span class="n">query</span><span class="o">);</span>
    <span class="k">return</span> <span class="s">"index"</span><span class="o">;</span>
<span class="o">}</span>
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


<p>Let's understand what's important here:</p>

<ul>
<li>
<code>@RequestMapping("/search")</code> ties this method to the request that the form we added earlier will perform.</li>
<li>
<code>@RequestParam("query") String query</code> and <code>@RequestParam("field") String field</code> bind the request params (the variables after <code>?</code> on the URL) to Java variables we can use.</li>
</ul>

<p>The rest of the code:</p>

<ul>
<li>performs the search (not implemented yet);</li>
<li>returns the parameters the user selected/typed on the search form (seems reasonable to show this information on the filtered list of restaurants);</li>
<li>and redirects the user to the index page with the new information we just (not yet :) got. =P</li>
</ul>
<h1>
  <a name="finally-querying-the-repository" href="#finally-querying-the-repository">
  </a>
  Finally querying the Repository
</h1>

<p>Well, looks like we have to do the heavy work now, which is to find all the Restaurants containing a certain string on their names.</p>

<p>We do that with this <strong>huge</strong> and <strong>complicated</strong> code on the <code>RestaurantRepository.java</code> interface:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nc">List</span><span class="o">&lt;</span><span class="nc">Restaurant</span><span class="o">&gt;</span> <span class="nf">findAllByNameContaining</span><span class="o">(</span><span class="nc">String</span> <span class="n">query</span><span class="o">);</span>
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


<p>And now, by replacing that <code>TODO</code> we added earlier on the <code>IndexPage.java</code> controller with the following:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="n">model</span><span class="o">.</span><span class="na">addAttribute</span><span class="o">(</span><span class="s">"restaurants"</span><span class="o">,</span> <span class="n">restaurantRepository</span><span class="o">.</span><span class="na">findAllByNameContaining</span><span class="o">(</span><span class="n">query</span><span class="o">));</span>
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


<p>... your new search is working! <a href="https://jpa-queries-blog-post.herokuapp.com/search?field=name&amp;query=Ma">Want to try?</a> </p>
<h1>
  <a name="how-it-works" href="#how-it-works">
  </a>
  How it works
</h1>

<p>It's quite simple, actually: Spring Data parses the method name based on certain criteria and creates a query for you. Here's how it goes for this example (<code>findAllByNameContaining(String name)</code>):</p>

<ul>
<li>
<code>find</code> determines that entities should be returned. Could also be <code>read</code>, <code>query</code> and <code>get</code> to the same effect. If it was <code>count</code> would return the number of entities.</li>
<li>
<code>All</code> is ignored. Note that some keywords may be used here.</li>
<li>
<code>By</code> indicates to the parser the start of the actual criteria.</li>
<li>
<code>Name</code> tells Spring Data that there's a property called <code>name</code> on the underlying entity of this repository (<code>Restaurant</code>) that will be used as search criteria. In other words, there'll be a <code>where</code> clause in that property.</li>
<li>
<code>Containing</code> specifies the operator for the <code>where</code> clause. If not provided, <code>=</code> is implied.</li>
<li>
<code>(String name)</code> indicates the parameter that will be received in runtime to use as value on the <code>where</code> clause.</li>
</ul>

<p>I explained, but it's pretty self explanatory, don't you think? Well, with that in mind, let's think of some other valid methods following the same structure:</p>

<ul>
<li>
<code>findAllByCuisineNameContaining(String cuisine)</code> returns Restaurants which cuisine contains the provided value/string. Notice we are querying Restaurants but using fields from the Cuisine entity because Spring Data traverses nested properties!</li>
<li>
<code>findAllByDeliveryFeeIsLessThanEqual(BigDecimal deliveryFee)</code> returns Restaurants with delivery fee less than or equal the provided <code>deliveryFee</code> value. Notice the parameter type matches the entity's property type.</li>
</ul>

<p>Now you have more options on your search:</p>

<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--7VF9E91B--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/jo3rsfcfqjwhu5tsjzgj.png" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--7VF9E91B--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/jo3rsfcfqjwhu5tsjzgj.png" alt="More search options" loading="lazy" width="495" height="291"></a></p>

<p>Other valid methods:</p>

<ul>
<li>
<code>countByCuisineName(String cuisine)</code> to return the number of Restaurants with a given cuisine type.</li>
<li>
<code>findTopByCuisineNameOrderByDeliveryFeeAsc(String cuisine)</code> to return the restaurant with the cheapest delivery fee of a given cuisine.</li>
</ul>

<p>And their usage:<br>
<a href="https://res.cloudinary.com/practicaldev/image/fetch/s--2ae_B7o---/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/y1r0pjythk85qh1as1mn.png" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--2ae_B7o---/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/y1r0pjythk85qh1as1mn.png" alt="Cuisine queries" loading="lazy" width="272" height="166"></a></p>

<p>The repository with all the queries is not even a concrete class, there's no implementation on your code:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="kd">public</span> <span class="kd">interface</span> <span class="nc">RestaurantRepository</span> <span class="kd">extends</span> <span class="nc">JpaRepository</span><span class="o">&lt;</span><span class="nc">Restaurant</span><span class="o">,</span> <span class="nc">Long</span><span class="o">&gt;</span> <span class="o">{</span>

    <span class="nc">List</span><span class="o">&lt;</span><span class="nc">Restaurant</span><span class="o">&gt;</span> <span class="nf">findAllByNameContaining</span><span class="o">(</span><span class="nc">String</span> <span class="n">query</span><span class="o">);</span>

    <span class="nc">List</span><span class="o">&lt;</span><span class="nc">Restaurant</span><span class="o">&gt;</span> <span class="nf">findAllByCuisineNameContaining</span><span class="o">(</span><span class="nc">String</span> <span class="n">cuisine</span><span class="o">);</span>

    <span class="nc">List</span><span class="o">&lt;</span><span class="nc">Restaurant</span><span class="o">&gt;</span> <span class="nf">findAllByDeliveryFeeIsLessThanEqual</span><span class="o">(</span><span class="nc">BigDecimal</span> <span class="n">deliveryFee</span><span class="o">);</span>

    <span class="kt">long</span> <span class="nf">countByCuisineName</span><span class="o">(</span><span class="nc">String</span> <span class="n">cuisine</span><span class="o">);</span>

    <span class="nc">Restaurant</span> <span class="nf">findTopByCuisineNameOrderByDeliveryFeeAsc</span><span class="o">(</span><span class="nc">String</span> <span class="n">cuisine</span><span class="o">);</span>
<span class="o">}</span>
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


<p>You can find more information, including a list of supported keywords on the <a href="https://docs.spring.io/spring-data/jpa/docs/current/reference/html/#jpa.query-methods">official documentation</a>.</p>
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

<p>Adds the search bar: <a href="https://github.com/brunodrugowick/jpa-queries-blog-post/commit/d5a02bb903482e988e714e5c3b7ae64e81b49bb8">d5a02bb</a><br>
Adds search options and cuisine page:  <a href="https://github.com/brunodrugowick/jpa-queries-blog-post/commit/dd6793b957edb5426b1846750e0d4a460836b2ea">dd6793b</a> commit. </p>


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