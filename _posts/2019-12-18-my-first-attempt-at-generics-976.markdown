---
layout: post
title:  "My first attempt at Generics..."
date:   2019-12-18T18:55:41Z
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

<code>[java, generics, reflection, spring]</code>
<div class=card>
	  <div class=container>
	    <h4><b><br>You'll have a better experience reading in DEV</b></h4>
	    <p><a href="https://dev.to/brunodrugowick/my-first-attempt-at-generics-976" target="_blank">Click here to continue reading this post there >></a></p>
	    <p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/my-first-attempt-at-generics-976" target="_blank">read more</a>.</p>
	    <p>You can continue to read here too, it's up to you... =]</p>
	  </div>
	</div><br>
<p>... it turns out I didn't need it!</p>

<p>It's been a while that I wanted to try something with Generics. The opportunity just hit me when an implementation with Reflection was shown to me. Those are two topics I want to make myself more comfortable with, so... ideal opportunity!</p>

<h2>
  <a name="the-opportunity" href="#the-opportunity">
  </a>
  The Opportunity
</h2>

<p>I was implementing a PATCH HTTP request on a controller for an entity called Restaurant as part of a REST API course I'm taking. The implementation that the instructor came up with was something like this (using Reflection):<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@PatchMapping</span><span class="o">(</span><span class="s">"/{id}"</span><span class="o">)</span>
<span class="kd">public</span> <span class="nc">ResponseEntity</span><span class="o">&lt;?&gt;</span> <span class="n">partialUpdate</span><span class="o">(</span><span class="nd">@PathVariable</span> <span class="nc">Long</span> <span class="n">id</span><span class="o">,</span> <span class="nd">@RequestBody</span> <span class="nc">Map</span><span class="o">&lt;</span><span class="nc">String</span><span class="o">,</span> <span class="nc">Object</span><span class="o">&gt;</span> <span class="n">restaurantMap</span><span class="o">)</span> <span class="o">{</span>
    <span class="nc">Restaurant</span> <span class="n">restaurantToUpdate</span> <span class="o">=</span> <span class="n">restaurantCrudService</span><span class="o">.</span><span class="na">read</span><span class="o">(</span><span class="n">id</span><span class="o">);</span>

    <span class="k">if</span> <span class="o">(</span><span class="n">restaurantToUpdate</span> <span class="o">==</span> <span class="kc">null</span><span class="o">)</span> <span class="o">{</span>
        <span class="k">return</span> <span class="nc">ResponseEntity</span><span class="o">.</span><span class="na">notFound</span><span class="o">().</span><span class="na">build</span><span class="o">();</span>
    <span class="o">}</span>

    <span class="n">merge</span><span class="o">(</span><span class="n">restaurantMap</span><span class="o">,</span> <span class="n">restaurantToUpdate</span><span class="o">);</span>

    <span class="k">return</span> <span class="nf">update</span><span class="o">(</span><span class="n">id</span><span class="o">,</span> <span class="n">restaurantToUpdate</span><span class="o">);</span>
<span class="o">}</span>

<span class="kd">public</span> <span class="nf">merge</span><span class="o">(</span><span class="nc">Map</span><span class="o">&lt;</span><span class="nc">String</span><span class="o">,</span> <span class="nc">Object</span><span class="o">&gt;</span> <span class="n">objectMap</span><span class="o">,</span> <span class="nc">Restaurant</span> <span class="n">restaurantToUpdate</span><span class="o">)</span> <span class="o">{</span>
    <span class="nc">ObjectMapper</span> <span class="n">objectMapper</span> <span class="o">=</span> <span class="k">new</span> <span class="nc">OjectMapper</span><span class="o">()</span>
    <span class="nc">Restaurant</span> <span class="n">newObject</span> <span class="o">=</span> <span class="n">objectMapper</span><span class="o">.</span><span class="na">convertValue</span><span class="o">(</span><span class="n">objectMap</span><span class="o">,</span> <span class="nc">Restaurant</span><span class="o">.</span><span class="na">class</span><span class="o">);</span>

    <span class="n">objectMap</span><span class="o">.</span><span class="na">forEach</span><span class="o">((</span><span class="n">fieldProp</span><span class="o">,</span> <span class="n">valueProp</span><span class="o">)</span> <span class="o">-&gt;</span> <span class="o">{</span>
        <span class="nc">Field</span> <span class="n">field</span> <span class="o">=</span> <span class="nc">ReflectionUtils</span><span class="o">.</span><span class="na">findField</span><span class="o">(</span><span class="nc">Restaurant</span><span class="o">.</span><span class="na">class</span><span class="o">,</span> <span class="n">fieldProp</span><span class="o">);</span>
        <span class="n">field</span><span class="o">.</span><span class="na">setAccessible</span><span class="o">(</span><span class="kc">true</span><span class="o">);</span>

        <span class="nc">Object</span> <span class="n">newValue</span> <span class="o">=</span> <span class="nc">ReflectionUtils</span><span class="o">.</span><span class="na">getField</span><span class="o">(</span><span class="n">field</span><span class="o">,</span> <span class="n">newObject</span><span class="o">);</span>

        <span class="nc">ReflectionUtils</span><span class="o">.</span><span class="na">setField</span><span class="o">(</span><span class="n">field</span><span class="o">,</span> <span class="n">objectToUpdate</span><span class="o">,</span> <span class="n">newValue</span><span class="o">);</span>
    <span class="o">});</span>
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



<p>And I'd have to reimplement this method on all my controllers (for other entities). So, I tried to create a solution with Generics.</p>

<h2>
  <a name="the-solution" href="#the-solution">
  </a>
  The Solution
</h2>

<h3>
  <a name="the-generic-class" href="#the-generic-class">
  </a>
  The Generic Class
</h3>

<p>This is the class that represents the code above but with Generics in mind:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="kd">public</span> <span class="kd">class</span> <span class="nc">ObjectMerger</span><span class="o">&lt;</span><span class="no">T</span><span class="o">&gt;</span> <span class="o">{</span>

    <span class="kd">private</span> <span class="nc">ObjectMapper</span> <span class="n">objectMapper</span><span class="o">;</span>
    <span class="kd">private</span> <span class="nc">Class</span><span class="o">&lt;</span><span class="no">T</span><span class="o">&gt;</span> <span class="n">type</span><span class="o">;</span>

    <span class="kd">private</span> <span class="nf">ObjectMerger</span><span class="o">(</span><span class="nc">Class</span><span class="o">&lt;</span><span class="no">T</span><span class="o">&gt;</span> <span class="n">type</span><span class="o">)</span> <span class="o">{</span>
        <span class="k">this</span><span class="o">.</span><span class="na">objectMapper</span> <span class="o">=</span> <span class="k">new</span> <span class="nc">ObjectMapper</span><span class="o">();</span>
        <span class="k">this</span><span class="o">.</span><span class="na">type</span> <span class="o">=</span> <span class="n">type</span><span class="o">;</span>
    <span class="o">}</span>

    <span class="kd">public</span> <span class="kd">static</span> <span class="nc">ObjectMerger</span> <span class="nf">of</span><span class="o">(</span><span class="nc">Class</span> <span class="n">type</span><span class="o">)</span> <span class="o">{</span>
        <span class="k">return</span> <span class="k">new</span> <span class="nf">ObjectMerger</span><span class="o">(</span><span class="n">type</span><span class="o">);</span>
    <span class="o">}</span>

    <span class="kd">public</span> <span class="kt">void</span> <span class="nf">mergeRequestBodyToGenericObject</span><span class="o">(</span><span class="nc">Map</span><span class="o">&lt;</span><span class="nc">String</span><span class="o">,</span> <span class="nc">Object</span><span class="o">&gt;</span> <span class="n">objectMap</span><span class="o">,</span> <span class="no">T</span> <span class="n">objectToUpdate</span><span class="o">)</span> <span class="o">{</span>
        <span class="no">T</span> <span class="n">newObject</span> <span class="o">=</span> <span class="n">objectMapper</span><span class="o">.</span><span class="na">convertValue</span><span class="o">(</span><span class="n">objectMap</span><span class="o">,</span> <span class="n">type</span><span class="o">);</span>

        <span class="n">objectMap</span><span class="o">.</span><span class="na">forEach</span><span class="o">((</span><span class="n">fieldProp</span><span class="o">,</span> <span class="n">valueProp</span><span class="o">)</span> <span class="o">-&gt;</span> <span class="o">{</span>
            <span class="nc">Field</span> <span class="n">field</span> <span class="o">=</span> <span class="nc">ReflectionUtils</span><span class="o">.</span><span class="na">findField</span><span class="o">(</span><span class="n">type</span><span class="o">,</span> <span class="n">fieldProp</span><span class="o">);</span>
            <span class="n">field</span><span class="o">.</span><span class="na">setAccessible</span><span class="o">(</span><span class="kc">true</span><span class="o">);</span>

            <span class="nc">Object</span> <span class="n">newValue</span> <span class="o">=</span> <span class="nc">ReflectionUtils</span><span class="o">.</span><span class="na">getField</span><span class="o">(</span><span class="n">field</span><span class="o">,</span> <span class="n">newObject</span><span class="o">);</span>

            <span class="nc">ReflectionUtils</span><span class="o">.</span><span class="na">setField</span><span class="o">(</span><span class="n">field</span><span class="o">,</span> <span class="n">objectToUpdate</span><span class="o">,</span> <span class="n">newValue</span><span class="o">);</span>
        <span class="o">});</span>
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



<p>You can see that I can instantiate this with any other class type (hence "generic") using <code>of</code> method and the class will provide a method to map a <code>Map&lt;String, Object&gt;</code> to the object type provided. This is Generics solution to implement partial updates to an object via a PATCH HTTP request.</p>

<h3>
  <a name="the-new-implementation-for-the-patch-http-method" href="#the-new-implementation-for-the-patch-http-method">
  </a>
  The new implementation for the PATCH HTTP method
</h3>

<p>This is the new implementation for the PATCH HTTP method of any Controller from now on (here, the Restaurant example):<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@PatchMapping</span><span class="o">(</span><span class="s">"/{id}"</span><span class="o">)</span>
<span class="kd">public</span> <span class="nc">ResponseEntity</span><span class="o">&lt;?&gt;</span> <span class="n">partialUpdate</span><span class="o">(</span><span class="nd">@PathVariable</span> <span class="nc">Long</span> <span class="n">id</span><span class="o">,</span> <span class="nd">@RequestBody</span> <span class="nc">Map</span><span class="o">&lt;</span><span class="nc">String</span><span class="o">,</span> <span class="nc">Object</span><span class="o">&gt;</span> <span class="n">restaurantMap</span><span class="o">)</span> <span class="o">{</span>
    <span class="nc">Restaurant</span> <span class="n">restaurantToUpdate</span> <span class="o">=</span> <span class="n">restaurantCrudService</span><span class="o">.</span><span class="na">read</span><span class="o">(</span><span class="n">id</span><span class="o">);</span>

    <span class="k">if</span> <span class="o">(</span><span class="n">restaurantToUpdate</span> <span class="o">==</span> <span class="kc">null</span><span class="o">)</span> <span class="o">{</span>
        <span class="k">return</span> <span class="nc">ResponseEntity</span><span class="o">.</span><span class="na">notFound</span><span class="o">().</span><span class="na">build</span><span class="o">();</span>
    <span class="o">}</span>

    <span class="nc">ObjectMerger</span>
        <span class="o">.</span><span class="na">of</span><span class="o">(</span><span class="nc">Restaurant</span><span class="o">.</span><span class="na">class</span><span class="o">)</span>
        <span class="o">.</span><span class="na">mergeRequestBodyToGenericObject</span><span class="o">(</span><span class="n">restaurantMap</span><span class="o">,</span> <span class="n">restaurantToUpdate</span><span class="o">);</span>

    <span class="k">return</span> <span class="nf">update</span><span class="o">(</span><span class="n">id</span><span class="o">,</span> <span class="n">restaurantToUpdate</span><span class="o">);</span>
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



<h2>
  <a name="wait-i-was-wrong" href="#wait-i-was-wrong">
  </a>
  Wait... I was wrong!
</h2>

<h3>
  <a name="what-i-wanted-to-do-was-simply-dry" href="#what-i-wanted-to-do-was-simply-dry">
  </a>
  What I wanted to do was simply DRY.
</h3>

<p><code>Don't Repeat Yourself</code>, i.e. a solution where I would not repeat myself for the PATCH HTTP requests (in this case). I thought Generics was the solution because... reasons! Well, I don't know exactly at this point. All I remember now is that I also had in mind that I didn't want to instantiate ojects with <code>new</code>.</p>

<p>So, here it goes for historial purposes, the Generics implementation: <a href="https://github.com/brunodrugowick/algafood-api/commit/0d5b7bc25bc1a7c69d523c19c4a1abef10f862ce">the one where I was thinking with my ass</a>.</p>

<h3>
  <a name="and-i-didnt-even-need-configuration" href="#and-i-didnt-even-need-configuration">
  </a>
  And I didn't even need configuration.
</h3>



<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="kd">public</span> <span class="kd">static</span> <span class="nc">ObjectMerger</span> <span class="nf">of</span><span class="o">(</span><span class="nc">Class</span> <span class="n">type</span><span class="o">)</span> <span class="o">{</span>
    <span class="k">return</span> <span class="k">new</span> <span class="nf">ObjectMerger</span><span class="o">(</span><span class="n">type</span><span class="o">);</span>
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



<p>So I created a <code>of</code> method to return a new ObjectMerger: <a href="https://github.com/brunodrugowick/algafood-api/commit/940020631adab29a8c92707252e54c7df02af813">the one where someone helped me to make a bit of sense</a>.</p>

<h3>
  <a name="and-to-avoid-instantiation-i-could-cache-on-a-map" href="#and-to-avoid-instantiation-i-could-cache-on-a-map">
  </a>
  And to avoid instantiation I could cache on a map.
</h3>



<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="kd">public</span> <span class="kd">static</span> <span class="nc">ObjectMerger</span> <span class="nf">of</span><span class="o">(</span><span class="nc">Class</span> <span class="n">type</span><span class="o">)</span> <span class="o">{</span>

    <span class="k">if</span> <span class="o">(!</span><span class="n">cacheEnabled</span><span class="o">)</span> <span class="o">{</span>
        <span class="c1">// Cache is not enabled. A new instance is always created.</span>
        <span class="k">return</span> <span class="k">new</span> <span class="nf">ObjectMerger</span><span class="o">(</span><span class="n">type</span><span class="o">);</span>
    <span class="o">}</span>

    <span class="k">if</span> <span class="o">(!</span><span class="n">objectMergerCache</span><span class="o">.</span><span class="na">containsKey</span><span class="o">(</span><span class="n">type</span><span class="o">))</span> <span class="o">{</span>
        <span class="nc">ObjectMerger</span> <span class="n">objectMerger</span> <span class="o">=</span> <span class="k">new</span> <span class="nc">ObjectMerger</span><span class="o">(</span><span class="n">type</span><span class="o">);</span>
        <span class="n">objectMergerCache</span><span class="o">.</span><span class="na">put</span><span class="o">(</span><span class="n">type</span><span class="o">,</span> <span class="n">objectMerger</span><span class="o">);</span>
        <span class="c1">// Cache enabled. Instance created (first request).</span>
        <span class="k">return</span> <span class="n">objectMerger</span><span class="o">;</span>
    <span class="o">}</span>

    <span class="c1">// Cache enabled. Returning existing instance.</span>
    <span class="k">return</span> <span class="n">objectMergerCache</span><span class="o">.</span><span class="na">get</span><span class="o">(</span><span class="n">type</span><span class="o">);</span>
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



<p>This ideia led to this implementation: <a href="https://github.com/brunodrugowick/algafood-api/commit/991c2ebe7e4ae4330b53291d9825c64ad3180aee">the one where I was almost there</a>.</p>

<h3>
  <a name="well-what-am-i-caching-anyway" href="#well-what-am-i-caching-anyway">
  </a>
  Well, what am I caching anyway?
</h3>



<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="kd">public</span> <span class="kd">class</span> <span class="nc">ObjectMerger</span> <span class="o">{</span>

    <span class="kd">public</span> <span class="kd">static</span> <span class="kt">void</span> <span class="nf">mergeRequestBodyToGenericObject</span><span class="o">(</span><span class="nc">Map</span><span class="o">&lt;</span><span class="nc">String</span><span class="o">,</span> <span class="nc">Object</span><span class="o">&gt;</span> <span class="n">objectMap</span><span class="o">,</span> <span class="nc">Object</span> <span class="n">objectToUpdate</span><span class="o">,</span> <span class="nc">Class</span> <span class="n">type</span><span class="o">)</span> <span class="o">{</span>
        <span class="nc">ObjectMapper</span> <span class="n">objectMapper</span> <span class="o">=</span> <span class="k">new</span> <span class="nc">ObjectMapper</span><span class="o">();</span>
        <span class="nc">Object</span> <span class="n">newObject</span> <span class="o">=</span> <span class="n">objectMapper</span><span class="o">.</span><span class="na">convertValue</span><span class="o">(</span><span class="n">objectMap</span><span class="o">,</span> <span class="n">type</span><span class="o">);</span>

        <span class="n">objectMap</span><span class="o">.</span><span class="na">forEach</span><span class="o">((</span><span class="n">fieldProp</span><span class="o">,</span> <span class="n">valueProp</span><span class="o">)</span> <span class="o">-&gt;</span> <span class="o">{</span>
            <span class="nc">Field</span> <span class="n">field</span> <span class="o">=</span> <span class="nc">ReflectionUtils</span><span class="o">.</span><span class="na">findField</span><span class="o">(</span><span class="n">type</span><span class="o">,</span> <span class="n">fieldProp</span><span class="o">);</span>
            <span class="n">field</span><span class="o">.</span><span class="na">setAccessible</span><span class="o">(</span><span class="kc">true</span><span class="o">);</span>

            <span class="nc">Object</span> <span class="n">newValue</span> <span class="o">=</span> <span class="nc">ReflectionUtils</span><span class="o">.</span><span class="na">getField</span><span class="o">(</span><span class="n">field</span><span class="o">,</span> <span class="n">newObject</span><span class="o">);</span>

            <span class="nc">ReflectionUtils</span><span class="o">.</span><span class="na">setField</span><span class="o">(</span><span class="n">field</span><span class="o">,</span> <span class="n">objectToUpdate</span><span class="o">,</span> <span class="n">newValue</span><span class="o">);</span>
        <span class="o">});</span>
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



<p>I didn't need any properties on the class, it could be a helper class, no state, just function. So I made a dead simple static method: <a href="https://github.com/brunodrugowick/algafood-api/commit/8c166780e172daa2e7fed84972c9012372334651">the one where I felt like an idiot</a>.</p>

<h2>
  <a name="and-thats-it" href="#and-thats-it">
  </a>
  And that's it
</h2>

<p>It's working, I learnt a lot and I'm very pleased with myself. Hahahahaha.</p>

<p>You can see the history of this post <a href="https://github.com/brunodrugowick/brunodrugowick.github.io/commits/master/_posts/2019-12-11-first-attempt-generics-reflection.md">here</a>.<br>
You can test the API <a href="https://algafoodapi.herokuapp.com/">here</a>.</p>


<hr>

<p>Image by <a href="https://commons.wikimedia.org/wiki/File:Confused_man.jpg">U3100481</a></p>...