---
layout: post
title:  "The most basic security for Spring Boot with Thymeleaf"
date:   2020-03-25T02:54:09Z
categories: 
---

> <div class=card><div class=container><h4><b><a href="https://dev.to/brunodrugowick/the-most-basic-security-for-spring-boot-with-thymeleaf-339h">You'll have a better experience reading in DEV...</a></b></h4><i><p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/the-most-basic-security-for-spring-boot-with-thymeleaf-339h">read more</a>.</p><p>You can continue to read here too, it's up to you...</p></i></div></div>
<p>I like to develop small proof of concept applications. Although just validating, some security stuff may be necessary sometimes. Most often than not I also want to have 2 or more users...</p>

<p>So if you're using Spring and Thymeleaf, for the most basic and quick setup for a Spring MVC web app, just do:</p>

<h2>
 <a name="add-the-raw-pomxml-endraw-dependency" href="#add-the-raw-pomxml-endraw-dependency">
 </a>
 Add the <code>pom.xml</code> dependency
</h2>

<p>Just add this to the file:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight xml"><code><span class="nt">&lt;dependency&gt;</span>
 <span class="nt">&lt;groupId&gt;</span>org.springframework.boot<span class="nt">&lt;/groupId&gt;</span>
 <span class="nt">&lt;artifactId&gt;</span>spring-boot-starter-security<span class="nt">&lt;/artifactId&gt;</span>
<span class="nt">&lt;/dependency&gt;</span>
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
 <a name="create-the-most-basic-security-config-ever" href="#create-the-most-basic-security-config-ever">
 </a>
 Create the most basic security config ever
</h2>



<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@EnableWebSecurity</span>
<span class="nd">@Configuration</span>
<span class="kd">public</span> <span class="kd">class</span> <span class="nc">WebSecurityConfig</span> <span class="kd">extends</span> <span class="nc">WebSecurityConfigurerAdapter</span> <span class="o">{</span>

 <span class="nd">@Override</span>
 <span class="kd">protected</span> <span class="kt">void</span> <span class="nf">configure</span><span class="o">(</span><span class="nc">AuthenticationManagerBuilder</span> <span class="n">auth</span><span class="o">)</span> <span class="kd">throws</span> <span class="nc">Exception</span> <span class="o">{</span>
 <span class="n">auth</span>
 <span class="o">.</span><span class="na">inMemoryAuthentication</span><span class="o">()</span>
 <span class="o">.</span><span class="na">withUser</span><span class="o">(</span><span class="s">"username"</span><span class="o">).</span><span class="na">password</span><span class="o">(</span><span class="s">"{noop}password"</span><span class="o">).</span><span class="na">roles</span><span class="o">(</span><span class="s">"USER"</span><span class="o">).</span><span class="na">and</span><span class="o">()</span>
 <span class="o">.</span><span class="na">withUser</span><span class="o">(</span><span class="s">"username2"</span><span class="o">).</span><span class="na">password</span><span class="o">(</span><span class="s">"{noop}password"</span><span class="o">).</span><span class="na">roles</span><span class="o">(</span><span class="s">"USER"</span><span class="o">);</span>
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



<h2>
 <a name="additional-stuff" href="#additional-stuff">
 </a>
 Additional stuff
</h2>

<p>Well, you're mostly done, but there're a few things that I believe are important to consider.</p>

<h3>
 <a name="csrf-protection" href="#csrf-protection">
 </a>
 CSRF protection
</h3>

<p>The first thing is that with the current config you won't be able to make a HTTP POST request because Spring is automatically protecting your app from CSRF attacks. You must add the <code>csrf</code> token already provided by Spring when POSTing. </p>

<p>You do that by adding the following inside your <code>&lt;form&gt;</code> and <code>&lt;/form&gt;</code> tags:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight xml"><code><span class="nt">&lt;input</span> <span class="na">type=</span><span class="s">"hidden"</span> <span class="na">th:name=</span><span class="s">"${_csrf.parameterName}"</span> <span class="na">th:value=</span><span class="s">"${_csrf.token}"</span><span class="nt">/&gt;</span>
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
 <a name="logout-link" href="#logout-link">
 </a>
 Logout link
</h3>

<p>The current configuration provides you a login page that may be enough for demonstrations. But having more than one user makes you want to logout and show some behavior with the other users.</p>

<p>For this, just add the following form somewhere in your app:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight html"><code><span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"text-light"</span><span class="nt">&gt;</span>
 <span class="nt">&lt;form</span> <span class="na">action=</span><span class="s">"/logout"</span>
 <span class="na">method=</span><span class="s">"post"</span><span class="nt">&gt;</span>
 <span class="nt">&lt;input</span> <span class="na">class=</span><span class="s">"btn btn-link"</span> 
 <span class="na">type=</span><span class="s">"submit"</span>
 <span class="na">value=</span><span class="s">"Log out"</span> <span class="nt">/&gt;</span>
 <span class="nt">&lt;input</span> <span class="na">type=</span><span class="s">"hidden"</span>
 <span class="na">th:name=</span><span class="s">"${_csrf.parameterName}"</span>
 <span class="na">th:value=</span><span class="s">"${_csrf.token}"</span><span class="nt">/&gt;</span>
 <span class="nt">&lt;/form&gt;</span>
<span class="nt">&lt;/div&gt;</span>
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
 <a name="getting-the-logged-user" href="#getting-the-logged-user">
 </a>
 Getting the logged user
</h3>

<p>Finally, if you want to know which user is logged, inject a <code>Principal</code> instance on your controller methods. Here's an example:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@GetMapping</span>
<span class="kd">public</span> <span class="nc">String</span> <span class="nf">homePage</span><span class="o">(</span><span class="nc">Principal</span> <span class="n">principal</span><span class="o">,</span> <span class="nc">Model</span> <span class="n">model</span><span class="o">)</span> <span class="o">{</span>
 <span class="nc">String</span> <span class="n">username</span> <span class="o">=</span> <span class="n">principal</span><span class="o">.</span><span class="na">getName</span><span class="o">();</span>
 <span class="n">model</span><span class="o">.</span><span class="na">addAttribute</span><span class="o">(</span><span class="s">"username"</span><span class="o">,</span> <span class="n">username</span><span class="o">);</span>
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



<p>Now you can show the logged user right on your homepage.</p>

<h1>
 <a name="aqap-series" href="#aqap-series">
 </a>
 AQAP Series
</h1>

<p>As Quickly As Possible (AQAP) is a series of quick posts on something I find interesting. I encourage (and take part on) the discussions on the comments to further explore the technology, library or code quickly explained here.</p>


<hr>

<p>Image by <a href="https://pixabay.com/pt/users/jaykingsta14-4885997/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2358636">Jason King</a> por <a href="https://pixabay.com/pt/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2358636">Pixabay</a></p>...