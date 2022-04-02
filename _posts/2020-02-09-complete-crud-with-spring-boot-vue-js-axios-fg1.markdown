---
layout: post
title:  "Complete CRUD with Spring Boot, Vue.js, Axios"
date:   2020-02-09T02:35:04Z
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

<code>[java, vue, axios, spring]</code>
<div class=card>
	  <div class=container>
	    <h4><b><br>You'll have a better experience reading in DEV</b></h4>
	    <p><a href="https://dev.to/brunodrugowick/complete-crud-with-spring-boot-vue-js-axios-fg1" target="_blank">Click here to continue reading this post there >></a></p>
	    <p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/complete-crud-with-spring-boot-vue-js-axios-fg1" target="_blank">read more</a>.</p>
	    <p>You can continue to read here too, it's up to you... =]</p>
	  </div>
	</div><br>
<p>Following up on the last post of AQAP Series, here's the complete create-read-update-delete (CRUD) app relying on Spring (Boot), Vue.js and Axios.</p>

<p>See it in action:</p>

<p><iframe width="710" height="399" src="https://www.youtube.com/embed/72TV4XjlsCU" allowfullscreen loading="lazy">
</iframe>
 </p>

<p>I didn't mention Thymeleaf because there's no changes to the pages served by the back-end on this post.</p>

<p>I'll illustrate the code using the Role entity, but as always the complete code and the app running is available at the end.</p>

<p>Without further ado...</p>
<h1>
  <a name="adding-rest-operations" href="#adding-rest-operations">
  </a>
  Adding REST operations
</h1>

<p>We start adding two new operations on the <code>RoleController.java</code>:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@PostMapping</span><span class="o">(</span><span class="s">"roles"</span><span class="o">)</span>
<span class="kd">public</span> <span class="nc">Role</span> <span class="nf">save</span><span class="o">(</span><span class="nd">@RequestBody</span> <span class="nc">Role</span> <span class="n">role</span><span class="o">)</span> <span class="o">{</span>
    <span class="k">return</span> <span class="n">roleRepository</span><span class="o">.</span><span class="na">save</span><span class="o">(</span><span class="n">role</span><span class="o">);</span>
<span class="o">}</span>

<span class="nd">@DeleteMapping</span><span class="o">(</span><span class="s">"roles/{id}"</span><span class="o">)</span>
<span class="kd">public</span> <span class="kt">void</span> <span class="nf">get</span><span class="o">(</span><span class="nd">@PathVariable</span> <span class="nc">Long</span> <span class="n">id</span><span class="o">)</span> <span class="o">{</span>
    <span class="n">roleRepository</span><span class="o">.</span><span class="na">deleteById</span><span class="o">(</span><span class="n">id</span><span class="o">);</span>
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


<p>The <code>save</code> method takes care of both <code>create</code> and <code>update</code> operations. Spring is smart enough to update when there's an ID present and to create a new entity otherwise.</p>
<h1>
  <a name="the-role-form" href="#the-role-form">
  </a>
  The Role Form
</h1>

<p>This is our HTML form now:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight html"><code><span class="nt">&lt;form</span> <span class="na">v-on:submit.prevent=</span><span class="s">"postRole"</span><span class="nt">&gt;</span>
    <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"card mb-auto"</span><span class="nt">&gt;</span>
        <span class="nt">&lt;div</span> <span class="na">aria-controls=</span><span class="s">"roleForm"</span> <span class="na">aria-expanded=</span><span class="s">"false"</span> <span class="na">class=</span><span class="s">"card-header"</span> <span class="na">data-target=</span><span class="s">"#roleForm"</span>
             <span class="na">data-toggle=</span><span class="s">"collapse"</span> <span class="na">id=</span><span class="s">"formHeader"</span> <span class="na">style=</span><span class="s">"cursor: pointer"</span><span class="nt">&gt;</span>
            <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"float-left"</span><span class="nt">&gt;</span>New/Edit Role<span class="nt">&lt;/div&gt;</span>
            <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"float-right"</span><span class="nt">&gt;</span>+<span class="nt">&lt;/div&gt;</span>
        <span class="nt">&lt;/div&gt;</span>
        <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"card card-body collapse"</span> <span class="na">id=</span><span class="s">"roleForm"</span><span class="nt">&gt;</span>
            <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"form-group row"</span><span class="nt">&gt;</span>
                <span class="nt">&lt;label</span> <span class="na">for=</span><span class="s">"roleName"</span> <span class="na">class=</span><span class="s">"col-sm-4 col-form-label"</span><span class="nt">&gt;</span>Role Name<span class="nt">&lt;/label&gt;</span>
                <span class="nt">&lt;input</span> <span class="na">id=</span><span class="s">"roleId"</span> <span class="na">type=</span><span class="s">"hidden"</span> <span class="na">v-model=</span><span class="s">"role_id"</span><span class="nt">&gt;</span>
                <span class="nt">&lt;input</span> <span class="na">id=</span><span class="s">"roleName"</span> <span class="na">class=</span><span class="s">"form-control col-sm-8"</span> <span class="na">placeholder=</span><span class="s">"Role Name"</span> <span class="na">type=</span><span class="s">"text"</span>
                           <span class="na">v-model=</span><span class="s">"role_name"</span><span class="nt">/&gt;</span>
            <span class="nt">&lt;/div&gt;</span>
            <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"form-group row"</span><span class="nt">&gt;</span>
                <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"col col-sm-4"</span><span class="nt">&gt;&lt;/div&gt;</span>
                <span class="nt">&lt;input</span> <span class="na">class=</span><span class="s">"btn btn-primary col col-sm-8"</span> <span class="na">type=</span><span class="s">"submit"</span> <span class="na">value=</span><span class="s">"Save"</span><span class="nt">&gt;</span>
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


<p>Two things to notice here:</p>

<ul>
<li>
<code>v-on:submit.prevent="postRole"</code> is a Vue.js tag to specify the method to run when submitting the form and to prevent the default behaviour of page reloading on submit.</li>
<li>
<code>v-model</code> is another Vue.js tag. This binds an input with Vue.js data.</li>
</ul>
<h1>
  <a name="new-edit-and-delete-buttons" href="#new-edit-and-delete-buttons">
  </a>
  New Edit and Delete buttons
</h1>

<p>On the <code>Actions</code> column of our HTML table, just add two new buttons:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight html"><code><span class="nt">&lt;td&gt;</span>
    <span class="nt">&lt;button</span> <span class="na">class=</span><span class="s">"btn btn-primary"</span> <span class="na">v-on:click=</span><span class="s">"editRole(role)"</span><span class="nt">&gt;</span>Edit<span class="nt">&lt;/button&gt;</span>
    <span class="nt">&lt;button</span> <span class="na">class=</span><span class="s">"btn btn-danger"</span> <span class="na">v-on:click=</span><span class="s">"deleteRole(role)"</span><span class="nt">&gt;</span>Delete<span class="nt">&lt;/button&gt;</span>
<span class="nt">&lt;/td&gt;</span>
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


<p>Notice the same <code>v-on</code> tag, but now with an action of <code>click</code>. This binds the button click to a Vue.js method.</p>
<h1>
  <a name="the-vuejs-magic-again" href="#the-vuejs-magic-again">
  </a>
  The Vue.js Magic... again.
</h1>

<p>Our Vue.js script is now a little scary:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight javascript"><code><span class="o">&lt;</span><span class="nx">script</span><span class="o">&gt;</span>
    <span class="kd">var</span> <span class="nx">app</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">Vue</span><span class="p">({</span>
        <span class="na">el</span><span class="p">:</span> <span class="dl">'</span><span class="s1">#main</span><span class="dl">'</span><span class="p">,</span>
        <span class="nx">data</span><span class="p">()</span> <span class="p">{</span>
            <span class="k">return</span> <span class="p">{</span>
                <span class="na">roles</span><span class="p">:</span> <span class="kc">null</span><span class="p">,</span>
                <span class="na">role_id</span><span class="p">:</span> <span class="dl">''</span><span class="p">,</span>
                <span class="na">role_name</span><span class="p">:</span> <span class="dl">''</span><span class="p">,</span>
            <span class="p">}</span>
        <span class="p">},</span>
        <span class="nx">mounted</span><span class="p">(){</span>
            <span class="k">this</span><span class="p">.</span><span class="nx">getRoles</span><span class="p">();</span>
        <span class="p">},</span>
        <span class="na">methods</span><span class="p">:</span> <span class="p">{</span>
            <span class="na">getRoles</span><span class="p">:</span> <span class="kd">function</span> <span class="p">()</span> <span class="p">{</span>
                <span class="nx">axios</span>
                    <span class="p">.</span><span class="kd">get</span><span class="p">(</span><span class="dl">"</span><span class="s2">/api/v1/roles</span><span class="dl">"</span><span class="p">)</span>
                    <span class="p">.</span><span class="nx">then</span><span class="p">(</span><span class="nx">response</span> <span class="o">=&gt;</span> <span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="nx">roles</span> <span class="o">=</span> <span class="nx">response</span><span class="p">.</span><span class="nx">data</span><span class="p">))</span>
            <span class="p">},</span>
            <span class="na">postRole</span><span class="p">:</span> <span class="kd">function</span> <span class="p">(</span><span class="nx">event</span><span class="p">)</span> <span class="p">{</span>
                <span class="c1">// Creating</span>
                <span class="k">if</span> <span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="nx">role_id</span> <span class="o">==</span> <span class="dl">''</span> <span class="o">||</span> <span class="k">this</span><span class="p">.</span><span class="nx">role_id</span> <span class="o">==</span> <span class="kc">null</span><span class="p">)</span> <span class="p">{</span>
                    <span class="nx">axios</span>
                        <span class="p">.</span><span class="nx">post</span><span class="p">(</span><span class="dl">"</span><span class="s2">/api/v1/roles</span><span class="dl">"</span><span class="p">,</span> <span class="p">{</span>
                            <span class="dl">"</span><span class="s2">name</span><span class="dl">"</span><span class="p">:</span> <span class="k">this</span><span class="p">.</span><span class="nx">role_name</span><span class="p">,</span>
                        <span class="p">})</span>
                        <span class="p">.</span><span class="nx">then</span><span class="p">(</span><span class="nx">savedRole</span> <span class="o">=&gt;</span> <span class="p">{</span>
                            <span class="k">this</span><span class="p">.</span><span class="nx">roles</span><span class="p">.</span><span class="nx">push</span><span class="p">(</span><span class="nx">savedRole</span><span class="p">.</span><span class="nx">data</span><span class="p">);</span>
                            <span class="k">this</span><span class="p">.</span><span class="nx">role_name</span> <span class="o">=</span> <span class="dl">''</span><span class="p">;</span>
                            <span class="k">this</span><span class="p">.</span><span class="nx">role_id</span> <span class="o">=</span> <span class="dl">''</span><span class="p">;</span>
                        <span class="p">})</span>
                <span class="p">}</span> <span class="k">else</span> <span class="p">{</span> <span class="c1">// Updating</span>
                    <span class="nx">axios</span>
                        <span class="p">.</span><span class="nx">post</span><span class="p">(</span><span class="dl">"</span><span class="s2">/api/v1/roles</span><span class="dl">"</span><span class="p">,</span> <span class="p">{</span>
                            <span class="dl">"</span><span class="s2">id</span><span class="dl">"</span><span class="p">:</span> <span class="k">this</span><span class="p">.</span><span class="nx">role_id</span><span class="p">,</span>
                            <span class="dl">"</span><span class="s2">name</span><span class="dl">"</span><span class="p">:</span> <span class="k">this</span><span class="p">.</span><span class="nx">role_name</span><span class="p">,</span>
                        <span class="p">})</span>
                        <span class="p">.</span><span class="nx">then</span><span class="p">(</span><span class="nx">savedRole</span> <span class="o">=&gt;</span> <span class="p">{</span>
                            <span class="k">this</span><span class="p">.</span><span class="nx">getRoles</span><span class="p">();</span>
                            <span class="k">this</span><span class="p">.</span><span class="nx">role_name</span> <span class="o">=</span> <span class="dl">''</span><span class="p">;</span>
                            <span class="k">this</span><span class="p">.</span><span class="nx">role_id</span> <span class="o">=</span> <span class="dl">''</span><span class="p">;</span>
                        <span class="p">})</span>
                <span class="p">}</span>
            <span class="p">},</span>
            <span class="na">editRole</span><span class="p">:</span> <span class="kd">function</span> <span class="p">(</span><span class="nx">role</span><span class="p">)</span> <span class="p">{</span>
                <span class="k">this</span><span class="p">.</span><span class="nx">role_id</span> <span class="o">=</span> <span class="nx">role</span><span class="p">.</span><span class="nx">id</span><span class="p">;</span>
                <span class="k">this</span><span class="p">.</span><span class="nx">role_name</span> <span class="o">=</span> <span class="nx">role</span><span class="p">.</span><span class="nx">name</span><span class="p">;</span>
                <span class="nb">document</span><span class="p">.</span><span class="nx">getElementById</span><span class="p">(</span><span class="dl">'</span><span class="s1">roleForm</span><span class="dl">'</span><span class="p">).</span><span class="nx">setAttribute</span><span class="p">(</span><span class="dl">"</span><span class="s2">class</span><span class="dl">"</span><span class="p">,</span> <span class="nb">document</span><span class="p">.</span><span class="nx">getElementById</span><span class="p">(</span><span class="dl">'</span><span class="s1">roleForm</span><span class="dl">'</span><span class="p">).</span><span class="nx">getAttribute</span><span class="p">(</span><span class="dl">"</span><span class="s2">class</span><span class="dl">"</span><span class="p">)</span> <span class="o">+</span> <span class="dl">"</span><span class="s2"> show</span><span class="dl">"</span><span class="p">);</span>
            <span class="p">},</span>
            <span class="na">deleteRole</span><span class="p">:</span> <span class="k">async</span> <span class="kd">function</span> <span class="p">(</span><span class="nx">role</span><span class="p">)</span> <span class="p">{</span>
                <span class="k">await</span> <span class="nx">axios</span>
                    <span class="p">.</span><span class="k">delete</span><span class="p">(</span><span class="dl">"</span><span class="s2">/api/v1/roles/</span><span class="dl">"</span> <span class="o">+</span> <span class="nx">role</span><span class="p">.</span><span class="nx">id</span><span class="p">);</span>
                <span class="k">this</span><span class="p">.</span><span class="nx">getRoles</span><span class="p">();</span>
            <span class="p">}</span>
        <span class="p">},</span>
    <span class="p">})</span>
<span class="o">&lt;</span><span class="sr">/script</span><span class="err">&gt;
</span>
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


<p>But it's quite simple, actually. Let's explore what matters:</p>

<ul>
<li>
<code>el: '#main'</code> specifies that Vue.js is going to operate on this HTML element id. In our case this is <code>div</code> containing the form and table.</li>
<li>Inside <code>data()</code> we can specify variables that we are going to manipulate on the script and that the user may interact with. In our case notice that we have defined variables that represent the content of the form that the user interacts with.</li>
<li>
<code>mounted()</code> is called when Vue.js is ready (mounted on the element specified in <code>el</code> above). Here we call a method <code>getRoles()</code>. This method requests data to the API and sets it to a variable that is used to create the table of contents (using <code>v-for</code> explained on the last post).</li>
<li>
<code>methods</code> contains all the methods that interact with the API. Notice how they equate to the CRUD operations:

<ul>
<li>
<code>getRoles</code> is the <code>read</code> operation.</li>
<li>
<code>postRole</code> is the <code>create</code> operation.</li>
<li>
<code>editRole</code> is the <code>update</code> operation.</li>
<li>
<code>deleteRole</code> is the <code>delete</code> operation.</li>
</ul>
</li>
</ul>
<h1>
  <a name="the-app" href="#the-app">
  </a>
  The app
</h1>

<p>You can see the app running <a href="https://spring-thymeleaf-vue-crud.herokuapp.com/">here</a> (slightly modified since this is an ongoing analysis).</p>

<p>The repository and the aforementioned commits, also slightly modified, <a href="https://github.com/brunodrugowick/spring-thymeleaf-vue-crud-example/commits/master">here</a>.</p>


<div class="ltag-github-readme-tag">
  <div class="readme-overview">
    <h2>
      <img src="https://res.cloudinary.com/practicaldev/image/fetch/s--566lAguM--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev.to/assets/github-logo-5a155e1f9a670af7944dd5e12375bc76ed542ea80224905ecaf878b9157cdefc.svg" alt="GitHub logo" loading="lazy">
      <a href="https://github.com/brunodrugowick">
        brunodrugowick
      </a> / <a style="font-weight: 600;" href="https://github.com/brunodrugowick/spring-thymeleaf-vue-crud-example">
        spring-thymeleaf-vue-crud-example
      </a>
    </h2>
    <h3>
      Complete CRUD example project with Spring Boot, Thymeleaf, Vue.js and Axios.
    </h3>
  </div>
</div>



<h1>
  <a name="aqap-series" href="#aqap-series">
  </a>
  AQAP Series
</h1>

<p>As Quickly As Possible (AQAP) is a series of quick posts on something I find interesting. I encourage (and take part on) the discussions on the comments to further explore the technology, library or code quickly explained here.</p>


<hr>

<p>Image by <a href="https://pixabay.com/pt/users/jaykingsta14-4885997/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2358636">Jason King</a> por <a href="https://pixabay.com/pt/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2358636">Pixabay</a></p>...