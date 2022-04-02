---
layout: post
title:  "The SHAME ON ME fix"
date:   2019-12-18T18:49:26Z
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

<code>[javascript, s3, sleep]</code>
<div class=card>
	  <div class=container>
	    <h4><b><br>You'll have a better experience reading in DEV</b></h4>
	    <p><a href="https://dev.to/brunodrugowick/the-shame-on-me-fix-2aij" target="_blank">Click here to continue reading this post there >></a></p>
	    <p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/the-shame-on-me-fix-2aij" target="_blank">read more</a>.</p>
	    <p>You can continue to read here too, it's up to you... =]</p>
	  </div>
	</div><br>
<p>I had a problem. On my 2-week journey into Javascript inspired by the Omnistack Week (a week where you implement a full application with NodeJS, React and React Native), I built <a href="https://omnistack-quick-start-frontend.herokuapp.com/">this application</a> but something was bothering me. I'll explain...</p>

<p>The function that uploads the post to the server, after doing so, redirects the user to the app's feed. Here's the code:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight javascript"><code><span class="nx">handleSubmit</span> <span class="o">=</span> <span class="k">async</span> <span class="nx">e</span> <span class="o">=&gt;</span> <span class="p">{</span>
    <span class="c1">// Prevents the browser from doing whatever after submiting a form</span>
    <span class="nx">e</span><span class="p">.</span><span class="nx">preventDefault</span><span class="p">();</span>
    <span class="c1">// This disables the submit button while the post is being created.</span>
    <span class="k">this</span><span class="p">.</span><span class="nx">setState</span><span class="p">({</span> <span class="na">loading</span><span class="p">:</span> <span class="kc">true</span> <span class="p">});</span>

    <span class="c1">// Creates the form to be submitted to the backend (from the app's state).</span>
    <span class="kd">const</span> <span class="nx">data</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">FormData</span><span class="p">();</span>
    <span class="nx">data</span><span class="p">.</span><span class="nx">append</span><span class="p">(</span><span class="dl">'</span><span class="s1">image</span><span class="dl">'</span><span class="p">,</span> <span class="k">this</span><span class="p">.</span><span class="nx">state</span><span class="p">.</span><span class="nx">image</span><span class="p">);</span>
    <span class="nx">data</span><span class="p">.</span><span class="nx">append</span><span class="p">(</span><span class="dl">'</span><span class="s1">author</span><span class="dl">'</span><span class="p">,</span> <span class="k">this</span><span class="p">.</span><span class="nx">state</span><span class="p">.</span><span class="nx">author</span><span class="p">);</span>
    <span class="nx">data</span><span class="p">.</span><span class="nx">append</span><span class="p">(</span><span class="dl">'</span><span class="s1">place</span><span class="dl">'</span><span class="p">,</span> <span class="k">this</span><span class="p">.</span><span class="nx">state</span><span class="p">.</span><span class="nx">place</span><span class="p">);</span>
    <span class="nx">data</span><span class="p">.</span><span class="nx">append</span><span class="p">(</span><span class="dl">'</span><span class="s1">description</span><span class="dl">'</span><span class="p">,</span> <span class="k">this</span><span class="p">.</span><span class="nx">state</span><span class="p">.</span><span class="nx">description</span><span class="p">);</span>
    <span class="nx">data</span><span class="p">.</span><span class="nx">append</span><span class="p">(</span><span class="dl">'</span><span class="s1">hashtags</span><span class="dl">'</span><span class="p">,</span> <span class="k">this</span><span class="p">.</span><span class="nx">state</span><span class="p">.</span><span class="nx">hashtags</span><span class="p">);</span>

    <span class="c1">// Posts to the backend.</span>
    <span class="k">await</span> <span class="nx">api</span><span class="p">.</span><span class="nx">post</span><span class="p">(</span><span class="dl">'</span><span class="s1">posts</span><span class="dl">'</span><span class="p">,</span> <span class="nx">data</span><span class="p">).</span><span class="nx">then</span><span class="p">(()</span> <span class="o">=&gt;</span> <span class="p">{</span>
        <span class="c1">// Not necessary because I redirect, but re-enables the button.</span>
        <span class="k">this</span><span class="p">.</span><span class="nx">setState</span><span class="p">({</span> <span class="na">loading</span><span class="p">:</span> <span class="kc">false</span> <span class="p">});</span>
    <span class="p">});</span>

    <span class="c1">// Redirects to the feed.</span>
    <span class="k">this</span><span class="p">.</span><span class="nx">props</span><span class="p">.</span><span class="nx">history</span><span class="p">.</span><span class="nx">push</span><span class="p">(</span><span class="dl">'</span><span class="s1">/</span><span class="dl">'</span><span class="p">);</span>
<span class="p">}</span>
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



<p>But, when redirected, the user would see this:</p>

<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--VJb61-k---/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/2ve9aay9hkp077j7l1yb.png" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--VJb61-k---/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/2ve9aay9hkp077j7l1yb.png" alt="the bug" loading="lazy" width="880" height="801"></a></p>

<p>On the first version of the app, in which the image was uploaded to the server, I didn't have this problem. But then I changed to upload the image to Amazon S3, which makes more sense than storing on the application's server (and solved the problem of hosting on the free tier of Heroku, that turns everything off after a while and back on when someone hits the server). </p>

<p>I guess that that problem had something to do with the time it takes Amazon S3 to provision everything... but I really don't know. So, I thought I could test the link before redirecting the user, while a loading layer or something like that would have the user waiting. I thought about a progress bar within the 'Share' button or a cool loading layer above everything...</p>

<p>BUT, here's what I did. A function:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight javascript"><code><span class="nx">sleep</span><span class="p">(</span><span class="nx">milliseconds</span><span class="p">)</span> <span class="p">{</span>
    <span class="kd">var</span> <span class="nx">start</span> <span class="o">=</span> <span class="k">new</span> <span class="nb">Date</span><span class="p">().</span><span class="nx">getTime</span><span class="p">();</span>
    <span class="k">for</span> <span class="p">(</span><span class="kd">var</span> <span class="nx">i</span> <span class="o">=</span> <span class="mi">0</span><span class="p">;</span> <span class="nx">i</span> <span class="o">&lt;</span> <span class="mi">1</span><span class="nx">e7</span><span class="p">;</span> <span class="nx">i</span><span class="o">++</span><span class="p">)</span> <span class="p">{</span>
        <span class="k">if</span> <span class="p">((</span><span class="k">new</span> <span class="nb">Date</span><span class="p">().</span><span class="nx">getTime</span><span class="p">()</span> <span class="o">-</span> <span class="nx">start</span><span class="p">)</span> <span class="o">&gt;</span> <span class="nx">milliseconds</span><span class="p">){</span>
            <span class="k">break</span><span class="p">;</span>
        <span class="p">}</span>
    <span class="p">}</span>
<span class="p">}</span>
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



<p>And right before redirecting the user, I added this (with the comment and everything):<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight javascript"><code><span class="cm">/**
* SHAME ON ME.
* 
* The first request to S3 after redirecting to the feed fails.
* This is my fix to it. The correct fix would be to test the URL and once it
* is working, redirect to the Feed.
* 
* For now, sit tight for about one second and hope for the best.
*/</span>
<span class="k">this</span><span class="p">.</span><span class="nx">sleep</span><span class="p">(</span><span class="mi">1000</span><span class="p">);</span>
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



<p>You can actually see the code on <a href="https://github.com/brunodrugowick/omnistack-quick-start-frontend/commit/c1e92b1834afb63299adb33265f9ef6164eb9b98">this commit</a> and, of course, contribute, since it's an open source project.</p>

<p>Shame on me, I know. <code>=|</code></p>...