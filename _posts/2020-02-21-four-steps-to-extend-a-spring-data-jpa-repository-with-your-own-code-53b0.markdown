---
layout: post
title:  "Three steps to extend a Spring Data JPA repository with your own code"
date:   2020-02-21T01:37:14Z
categories: 
---

> <div class=card><div class=container><h4><b><a href="https://dev.to/brunodrugowick/four-steps-to-extend-a-spring-data-jpa-repository-with-your-own-code-53b0">You'll have a better experience reading in DEV...</a></b></h4><i><p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/four-steps-to-extend-a-spring-data-jpa-repository-with-your-own-code-53b0">read more</a>.</p><p>You can continue to read here too, it's up to you...</p></i></div></div>
<p>This is the post #6 of the series "Querying your Spring Data JPA Repository".</p>

<h1>
 <a name="what-about-an-advanced-search" href="#what-about-an-advanced-search">
 </a>
 What about an advanced search?
</h1>

<p>What if you want to search by any field available on the Restaurant and combine then without having to select specific searches.</p>

<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--34wmF1Nc--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_66%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/aex4l3r7r7zbngzlgif8.gif" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--34wmF1Nc--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_66%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/aex4l3r7r7zbngzlgif8.gif" alt="Alt Text" loading="lazy" width="640" height="540" data-animated="true"></a></p>

<p>Well, it's not Google, but it's powerful enough for a lot of use cases.</p>

<h1>
 <a name="lets-prepare-the-app" href="#lets-prepare-the-app">
 </a>
 Let's prepare the app
</h1>

<p>Well, you know the drill. Let's build what's necessary for the app to work with this new advanced search option.</p>

<p>The search form looks like this:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight html"><code><span class="nt">&lt;form</span> <span class="na">th:action=</span><span class="s">"@{/advancedSearch/perform}"</span><span class="nt">&gt;</span>
 <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"card mb-auto"</span><span class="nt">&gt;</span>
 <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"card-header"</span><span class="nt">&gt;</span>
 <span class="nt">&lt;h4&gt;</span>Filter Restaurants<span class="nt">&lt;/h4&gt;</span>
 <span class="nt">&lt;/div&gt;</span>
 <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"card-body"</span><span class="nt">&gt;</span>
 <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"form-group row small"</span><span class="nt">&gt;</span>
 <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"col col-sm-4 float-left"</span><span class="nt">&gt;&lt;/div&gt;</span>
 <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"col col-sm-8 float-right"</span><span class="nt">&gt;</span>
 <span class="nt">&lt;a</span> <span class="na">class=</span><span class="s">"float-right"</span> <span class="na">href=</span><span class="s">"/"</span><span class="nt">&gt;</span>Simple search<span class="nt">&lt;/a&gt;</span>
 <span class="nt">&lt;/div&gt;</span>
 <span class="nt">&lt;/div&gt;</span>
 <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"form-group row"</span><span class="nt">&gt;</span>
 <span class="nt">&lt;label</span> <span class="na">class=</span><span class="s">"col col-sm-4"</span> <span class="na">for=</span><span class="s">"name"</span><span class="nt">&gt;</span>Name<span class="nt">&lt;/label&gt;</span>
 <span class="nt">&lt;input</span> <span class="na">class=</span><span class="s">"form-control col-sm-8"</span> <span class="na">id=</span><span class="s">"name"</span> <span class="na">placeholder=</span><span class="s">"&lt;empty&gt;"</span> <span class="na">th:name=</span><span class="s">"name"</span>
 <span class="na">th:value=</span><span class="s">"${search.name}"</span> <span class="na">type=</span><span class="s">"text"</span><span class="nt">/&gt;</span>
 <span class="nt">&lt;/div&gt;</span>
 <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"form-group row"</span><span class="nt">&gt;</span>
 <span class="nt">&lt;label</span> <span class="na">class=</span><span class="s">"col col-sm-4"</span> <span class="na">for=</span><span class="s">"address"</span><span class="nt">&gt;</span>Address<span class="nt">&lt;/label&gt;</span>
 <span class="nt">&lt;input</span> <span class="na">class=</span><span class="s">"form-control col-sm-8"</span> <span class="na">id=</span><span class="s">"address"</span> <span class="na">placeholder=</span><span class="s">"&lt;empty&gt;"</span> <span class="na">th:name=</span><span class="s">"address"</span>
 <span class="na">th:value=</span><span class="s">"${search.address}"</span> <span class="na">type=</span><span class="s">"text"</span><span class="nt">/&gt;</span>
 <span class="nt">&lt;/div&gt;</span>
 <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"form-group row"</span><span class="nt">&gt;</span>
 <span class="nt">&lt;label</span> <span class="na">class=</span><span class="s">"col col-sm-4"</span> <span class="na">for=</span><span class="s">"minDeliveryFee"</span><span class="nt">&gt;</span>Delivery Fee<span class="nt">&lt;/label&gt;</span>
 <span class="nt">&lt;label</span> <span class="na">class=</span><span class="s">"col col-sm-1"</span> <span class="na">for=</span><span class="s">"minDeliveryFee"</span><span class="nt">&gt;</span>Min<span class="nt">&lt;/label&gt;</span>
 <span class="nt">&lt;input</span> <span class="na">class=</span><span class="s">"form-control col-sm-3"</span> <span class="na">id=</span><span class="s">"minDeliveryFee"</span> <span class="na">placeholder=</span><span class="s">"&lt;min&gt;"</span> <span class="na">th:name=</span><span class="s">"minDeliveryFee"</span>
 <span class="na">th:value=</span><span class="s">"${search.minDeliveryFee}"</span> <span class="na">type=</span><span class="s">"text"</span><span class="nt">/&gt;</span>
 <span class="nt">&lt;label</span> <span class="na">class=</span><span class="s">"col col-sm-1"</span> <span class="na">for=</span><span class="s">"maxDeliveryFee"</span><span class="nt">&gt;</span>Max<span class="nt">&lt;/label&gt;</span>
 <span class="nt">&lt;input</span> <span class="na">class=</span><span class="s">"form-control col-sm-3"</span> <span class="na">id=</span><span class="s">"maxDeliveryFee"</span> <span class="na">placeholder=</span><span class="s">"&lt;max&gt;"</span> <span class="na">th:name=</span><span class="s">"maxDeliveryFee"</span>
 <span class="na">th:value=</span><span class="s">"${search.maxDeliveryFee}"</span> <span class="na">type=</span><span class="s">"text"</span><span class="nt">/&gt;</span>
 <span class="nt">&lt;/div&gt;</span>
 <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"form-group row"</span><span class="nt">&gt;</span>
 <span class="nt">&lt;label</span> <span class="na">class=</span><span class="s">"col col-sm-4"</span> <span class="na">for=</span><span class="s">"cuisine"</span><span class="nt">&gt;</span>Cuisine<span class="nt">&lt;/label&gt;</span>
 <span class="nt">&lt;input</span> <span class="na">class=</span><span class="s">"form-control col-sm-8"</span> <span class="na">id=</span><span class="s">"cuisine"</span> <span class="na">placeholder=</span><span class="s">"&lt;empty&gt;"</span> <span class="na">th:name=</span><span class="s">"cuisine"</span>
 <span class="na">th:value=</span><span class="s">"${search.cuisine}"</span> <span class="na">type=</span><span class="s">"text"</span><span class="nt">/&gt;</span>
 <span class="nt">&lt;/div&gt;</span>
 <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"form-group row"</span><span class="nt">&gt;</span>
 <span class="nt">&lt;label</span> <span class="na">class=</span><span class="s">"col col-sm-4"</span> <span class="na">for=</span><span class="s">"city"</span><span class="nt">&gt;</span>City<span class="nt">&lt;/label&gt;</span>
 <span class="nt">&lt;input</span> <span class="na">class=</span><span class="s">"form-control col-sm-8"</span> <span class="na">id=</span><span class="s">"city"</span> <span class="na">placeholder=</span><span class="s">"&lt;empty&gt;"</span> <span class="na">th:name=</span><span class="s">"city"</span>
 <span class="na">th:value=</span><span class="s">"${search.city}"</span> <span class="na">type=</span><span class="s">"text"</span><span class="nt">/&gt;</span>
 <span class="nt">&lt;/div&gt;</span>
 <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"form-group row"</span><span class="nt">&gt;</span>
 <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"col col-sm-4"</span><span class="nt">&gt;&lt;/div&gt;</span>
 <span class="nt">&lt;input</span> <span class="na">class=</span><span class="s">"btn btn-primary col col-sm-8"</span> <span class="na">type=</span><span class="s">"submit"</span> <span class="na">value=</span><span class="s">"Submit"</span><span class="nt">&gt;</span>
 <span class="nt">&lt;/div&gt;</span>
 <span class="nt">&lt;/div&gt;</span>
 <span class="nt">&lt;/div&gt;</span>
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


<p>We need new controller methods to handle the new page and the search operation:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@RequestMapping</span><span class="o">(</span><span class="s">"/advancedSearch"</span><span class="o">)</span>
<span class="kd">public</span> <span class="nc">String</span> <span class="nf">advancedSearch</span><span class="o">(</span><span class="nc">Model</span> <span class="n">model</span><span class="o">)</span> <span class="o">{</span>
 <span class="n">model</span><span class="o">.</span><span class="na">addAttribute</span><span class="o">(</span><span class="s">"restaurants"</span><span class="o">,</span> <span class="n">restaurantRepository</span><span class="o">.</span><span class="na">findAll</span><span class="o">());</span>
 <span class="n">model</span><span class="o">.</span><span class="na">addAttribute</span><span class="o">(</span><span class="s">"search"</span><span class="o">,</span> <span class="k">new</span> <span class="nc">AdvancedSearch</span><span class="o">());</span>
 <span class="k">return</span> <span class="s">"advancedSearch"</span><span class="o">;</span>
<span class="o">}</span>

<span class="nd">@RequestMapping</span><span class="o">(</span><span class="s">"/advancedSearch/perform"</span><span class="o">)</span>
<span class="kd">public</span> <span class="nc">String</span> <span class="nf">advancedSearchWithQuery</span><span class="o">(</span><span class="nd">@ModelAttribute</span> <span class="nc">AdvancedSearch</span> <span class="n">advancedSearch</span><span class="o">,</span> <span class="nc">Model</span> <span class="n">model</span><span class="o">)</span> <span class="o">{</span>
 <span class="n">model</span><span class="o">.</span><span class="na">addAttribute</span><span class="o">(</span><span class="s">"restaurants"</span><span class="o">,</span> <span class="n">restaurantRepository</span><span class="o">.</span><span class="na">advancedSearch</span><span class="o">(</span><span class="n">advancedSearch</span><span class="o">));</span>

 <span class="n">model</span><span class="o">.</span><span class="na">addAttribute</span><span class="o">(</span><span class="s">"search"</span><span class="o">,</span> <span class="n">advancedSearch</span><span class="o">);</span>
 <span class="k">return</span> <span class="s">"advancedSearch"</span><span class="o">;</span>
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


<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--aoGIl5HF--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_66%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/jvo51qw5q568q0wyf5hb.gif" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--aoGIl5HF--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_66%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/jvo51qw5q568q0wyf5hb.gif" alt="Alt Text" loading="lazy" width="640" height="502" data-animated="true"></a></p>

<p>Keep an eye on:</p>

<ul>
<li>The <code>@ModelAttribute</code> annotation: it maps the input to a new class called...</li>
<li>
<code>AdvancedSearch</code>. This is a simple bean with fields to hold data coming from the form. With the help of <a href="https://projectlombok.org/">Project Lombok</a> this class is <a href="https://github.com/brunodrugowick/jpa-queries-blog-post/blob/master/src/main/java/dev/drugowick/jpaqueriesblogpost/web/pages/dto/AdvancedSearch.java">quite simple</a>.

<ul>
<li>We use this class to pass data between the form and the app on both directions. This is how we can show the query inputs to the user even after the page is refreshed to show the search results (remember this is not your typical SPA, ok?).</li>
</ul>
</li>
</ul>
<h1>
 <a name="custom-repository-methods" href="#custom-repository-methods">
 </a>
 Custom Repository Methods
</h1>

<p>But you may also have noticed that we are calling a new method on the <code>restaurantRepository</code> called <code>advancedSearch</code> passing the homonym <code>advancedSearch</code> object via parameter. No, that's not a Spring Data JPA default method (would be nice, hã?), but the ability to create our own custom methods is the powerful stuff we're learning here!</p>

<p>Let's see how in 3 steps.</p>
<h2>
 <a name="step-1-create-a-new-interface-to-hold-the-method-declarations" href="#step-1-create-a-new-interface-to-hold-the-method-declarations">
 </a>
 Step 1: Create a new interface to hold the method declarations
</h2>


<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="kd">public</span> <span class="kd">interface</span> <span class="nc">CustomRestaurantRepository</span> <span class="o">{</span>
 <span class="nc">List</span><span class="o">&lt;</span><span class="nc">Restaurant</span><span class="o">&gt;</span> <span class="nf">advancedSearch</span><span class="o">(</span><span class="nc">AdvancedSearch</span> <span class="n">advancedSearch</span><span class="o">);</span>
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


<p>Notice the definition of the <code>advancedSearch</code> method. That's all we need right now.</p>
<h2>
 <a name="step-2-make-your-spring-data-jpa-repository-extend-your-new-interface" href="#step-2-make-your-spring-data-jpa-repository-extend-your-new-interface">
 </a>
 Step 2: Make your Spring Data JPA repository extend your new interface
</h2>


<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="kd">public</span> <span class="kd">interface</span> <span class="nc">RestaurantRepository</span> <span class="kd">extends</span> <span class="nc">JpaRepository</span><span class="o">&lt;</span><span class="nc">Restaurant</span><span class="o">,</span> <span class="nc">Long</span><span class="o">&gt;,</span> <span class="nc">CustomRestaurantRepository</span> <span class="o">{</span>
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


<p>Notice now that our repository extends both <code>JPARepository</code> (from Spring Data JPA project) and <code>CustomRestaurantRepository</code> (a class of our own to define repository methods). We can now call our new method, but what about its code?</p>
<h2>
 <a name="step-3-implement-the-custom-method" href="#step-3-implement-the-custom-method">
 </a>
 Step 3: Implement the custom method
</h2>

<p>Now it's just a matter of implementing the code we need. We will create a <code>CustomRestaurantRepositoryImpl</code> class that implements our newly created <code>CustomRestaurantRepository</code> interface.<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@Repository</span>
<span class="kd">public</span> <span class="kd">class</span> <span class="nc">CustomRestaurantRepositoryImpl</span> <span class="kd">implements</span> <span class="nc">CustomRestaurantRepository</span> <span class="o">{</span>

 <span class="nd">@PersistenceContext</span>
 <span class="kd">private</span> <span class="nc">EntityManager</span> <span class="n">entityManager</span><span class="o">;</span>

 <span class="nd">@Override</span>
 <span class="kd">public</span> <span class="nc">List</span><span class="o">&lt;</span><span class="nc">Restaurant</span><span class="o">&gt;</span> <span class="nf">advancedSearch</span><span class="o">(</span><span class="nc">AdvancedSearch</span> <span class="n">advancedSearch</span><span class="o">)</span> <span class="o">{</span>

 <span class="kt">var</span> <span class="n">jpql</span> <span class="o">=</span> <span class="k">new</span> <span class="nc">StringBuilder</span><span class="o">();</span>
 <span class="n">jpql</span><span class="o">.</span><span class="na">append</span><span class="o">(</span><span class="s">"from Restaurant where 1=1 "</span><span class="o">);</span>

 <span class="kt">var</span> <span class="n">parameters</span> <span class="o">=</span> <span class="k">new</span> <span class="nc">HashMap</span><span class="o">&lt;</span><span class="nc">String</span><span class="o">,</span> <span class="nc">Object</span><span class="o">&gt;();</span>

 <span class="k">if</span> <span class="o">(</span><span class="nc">StringUtils</span><span class="o">.</span><span class="na">hasLength</span><span class="o">(</span><span class="n">advancedSearch</span><span class="o">.</span><span class="na">getName</span><span class="o">()))</span> <span class="o">{</span>
 <span class="n">jpql</span><span class="o">.</span><span class="na">append</span><span class="o">(</span><span class="s">"and name like :name "</span><span class="o">);</span>
 <span class="n">parameters</span><span class="o">.</span><span class="na">put</span><span class="o">(</span><span class="s">"name"</span><span class="o">,</span> <span class="s">"%"</span> <span class="o">+</span> <span class="n">advancedSearch</span><span class="o">.</span><span class="na">getName</span><span class="o">()</span> <span class="o">+</span> <span class="s">"%"</span><span class="o">);</span>
 <span class="o">}</span>

 <span class="k">if</span> <span class="o">(</span><span class="nc">StringUtils</span><span class="o">.</span><span class="na">hasLength</span><span class="o">(</span><span class="n">advancedSearch</span><span class="o">.</span><span class="na">getAddress</span><span class="o">()))</span> <span class="o">{</span>
 <span class="n">jpql</span><span class="o">.</span><span class="na">append</span><span class="o">(</span><span class="s">"and address like :address "</span><span class="o">);</span>
 <span class="n">parameters</span><span class="o">.</span><span class="na">put</span><span class="o">(</span><span class="s">"address"</span><span class="o">,</span> <span class="s">"%"</span> <span class="o">+</span> <span class="n">advancedSearch</span><span class="o">.</span><span class="na">getAddress</span><span class="o">()</span> <span class="o">+</span> <span class="s">"%"</span><span class="o">);</span>
 <span class="o">}</span>

 <span class="k">if</span> <span class="o">(</span><span class="n">advancedSearch</span><span class="o">.</span><span class="na">getMinDeliveryFee</span><span class="o">()</span> <span class="o">!=</span> <span class="kc">null</span><span class="o">)</span> <span class="o">{</span>
 <span class="n">jpql</span><span class="o">.</span><span class="na">append</span><span class="o">(</span><span class="s">"and deliveryFee &gt;= :startFee "</span><span class="o">);</span>
 <span class="n">parameters</span><span class="o">.</span><span class="na">put</span><span class="o">(</span><span class="s">"startFee"</span><span class="o">,</span> <span class="n">advancedSearch</span><span class="o">.</span><span class="na">getMinDeliveryFee</span><span class="o">());</span>
 <span class="o">}</span>

 <span class="k">if</span> <span class="o">(</span><span class="n">advancedSearch</span><span class="o">.</span><span class="na">getMaxDeliveryFee</span><span class="o">()</span> <span class="o">!=</span> <span class="kc">null</span><span class="o">)</span> <span class="o">{</span>
 <span class="n">jpql</span><span class="o">.</span><span class="na">append</span><span class="o">(</span><span class="s">"and deliveryFee &lt;= :endingFee "</span><span class="o">);</span>
 <span class="n">parameters</span><span class="o">.</span><span class="na">put</span><span class="o">(</span><span class="s">"endingFee"</span><span class="o">,</span> <span class="n">advancedSearch</span><span class="o">.</span><span class="na">getMaxDeliveryFee</span><span class="o">());</span>
 <span class="o">}</span>

 <span class="k">if</span> <span class="o">(</span><span class="nc">StringUtils</span><span class="o">.</span><span class="na">hasLength</span><span class="o">(</span><span class="n">advancedSearch</span><span class="o">.</span><span class="na">getCuisine</span><span class="o">()))</span> <span class="o">{</span>
 <span class="n">jpql</span><span class="o">.</span><span class="na">append</span><span class="o">(</span><span class="s">"and cuisine.name like :cuisine "</span><span class="o">);</span>
 <span class="n">parameters</span><span class="o">.</span><span class="na">put</span><span class="o">(</span><span class="s">"cuisine"</span><span class="o">,</span> <span class="s">"%"</span> <span class="o">+</span> <span class="n">advancedSearch</span><span class="o">.</span><span class="na">getCuisine</span><span class="o">()</span> <span class="o">+</span> <span class="s">"%"</span><span class="o">);</span>
 <span class="o">}</span>

 <span class="k">if</span> <span class="o">(</span><span class="nc">StringUtils</span><span class="o">.</span><span class="na">hasLength</span><span class="o">(</span><span class="n">advancedSearch</span><span class="o">.</span><span class="na">getCity</span><span class="o">()))</span> <span class="o">{</span>
 <span class="n">jpql</span><span class="o">.</span><span class="na">append</span><span class="o">(</span><span class="s">"and city like :city "</span><span class="o">);</span>
 <span class="n">parameters</span><span class="o">.</span><span class="na">put</span><span class="o">(</span><span class="s">"city"</span><span class="o">,</span> <span class="s">"%"</span> <span class="o">+</span> <span class="n">advancedSearch</span><span class="o">.</span><span class="na">getCity</span><span class="o">()</span> <span class="o">+</span> <span class="s">"%"</span><span class="o">);</span>
 <span class="o">}</span>

 <span class="nc">TypedQuery</span><span class="o">&lt;</span><span class="nc">Restaurant</span><span class="o">&gt;</span> <span class="n">query</span> <span class="o">=</span> <span class="n">entityManager</span><span class="o">.</span><span class="na">createQuery</span><span class="o">(</span><span class="n">jpql</span><span class="o">.</span><span class="na">toString</span><span class="o">(),</span> <span class="nc">Restaurant</span><span class="o">.</span><span class="na">class</span><span class="o">);</span>

 <span class="n">parameters</span><span class="o">.</span><span class="na">forEach</span><span class="o">((</span><span class="n">key</span><span class="o">,</span> <span class="n">value</span><span class="o">)</span> <span class="o">-&gt;</span> <span class="n">query</span><span class="o">.</span><span class="na">setParameter</span><span class="o">(</span><span class="n">key</span><span class="o">,</span> <span class="n">value</span><span class="o">));</span>

 <span class="k">return</span> <span class="n">query</span><span class="o">.</span><span class="na">getResultList</span><span class="o">();</span>
 <span class="o">}</span>
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


<p>A lot to unpack here:</p>

<ul>
<li>First, we get ahold of an <code>EntityManager</code> injecting it via <code>@PersistenceContext</code>. With this we can perform operations via JPA.</li>
<li>Then we override the <code>advancedSearch</code> method to:

<ul>
<li>Check each and every property of the <code>AdvancedSearch</code> object adding it, if not null, to a custom JPQL query.</li>
<li>Match the appropriate parameters. First, on a temporary map and then actually mapping on the query.</li>
<li>Execute the query returning the results.</li>
</ul>
</li>
<li>Last, but not least, the suffix <code>Impl</code> is what actually tell Spring Data JPA that this is a custom implementation of the existing <code>RestaurantRepository</code>. Adding our interface and making the Spring Data JPA interface extend is only to make the code readable. You should do this!</li>
</ul>
<h1>
 <a name="additional-challenge" href="#additional-challenge">
 </a>
 Additional challenge
</h1>

<p>Notice that the example app has also an option to select the logical operator to use when performing the advanced search, <code>AND</code> or <code>OR</code>. You may want to try to implement it yourself, but if you don't want to, <a href="https://github.com/brunodrugowick/jpa-queries-blog-post/commit/a5d756ce3f968beeea536d0740005ae2e36c19a0">here's the implementation</a> for you.</p>

<p>That's the final result:</p>

<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--34wmF1Nc--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_66%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/aex4l3r7r7zbngzlgif8.gif" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--34wmF1Nc--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_66%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/aex4l3r7r7zbngzlgif8.gif" alt="Alt Text" loading="lazy" width="640" height="540" data-animated="true"></a></p>
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

<p>The preparation and core code is <a href="https://github.com/brunodrugowick/jpa-queries-blog-post/commit/b7fb9718824cfe9fa74113ed2ad772a32690a46f">here</a>.<br>
The logical operator addition is <a href="https://github.com/brunodrugowick/jpa-queries-blog-post/commit/a5d756ce3f968beeea536d0740005ae2e36c19a0">here</a>.<br>
And there's a UI improvement I did <a href="https://github.com/brunodrugowick/jpa-queries-blog-post/commit/06dbc0f30d2e108282176b3a2044bf7ef53e8357">here</a></p>


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