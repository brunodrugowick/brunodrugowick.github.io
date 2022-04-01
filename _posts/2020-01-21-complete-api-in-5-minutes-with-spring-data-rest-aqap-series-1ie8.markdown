---
layout: post
title:  "Complete API in 5 minutes with Spring Data REST - AQAP Series"
date:   2020-01-21T03:29:29Z
categories: 
---

> <div class=card><div class=container><h4><b><a href="https://dev.to/brunodrugowick/complete-api-in-5-minutes-with-spring-data-rest-aqap-series-1ie8">You'll have a better experience reading in DEV...</a></b></h4><i><p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/complete-api-in-5-minutes-with-spring-data-rest-aqap-series-1ie8">read more</a>.</p><p>You can continue to read here too, it's up to you...</p></i></div></div>
<p>The following instructions will give you a complete REST API for two related resources in 5 minutes. You will write less than 50 lines of code.</p>

<h1>
 <a name="bootstrap-the-project-with-spring-initializr" href="#bootstrap-the-project-with-spring-initializr">
 </a>
 Bootstrap the Project with Spring Initializr
</h1>

<p>Spring Initializr let's you quickly bootstrap your Spring applications by selecting dependencies. I've already prepared a configuration with the following dependencies:</p>

<ul>
<li>
<code>Spring Data JPA</code> to persist data to a database.</li>
<li>
<code>H2 Database</code> to auto-configure an embedded relational database.</li>
<li>
<code>Rest Repositories</code> to expose Spring Data repositories over REST.</li>
<li>
<code>Lombok</code> to reduce boilerplate code and create in compile-time all the Java getters, setters, constructors etc.</li>
</ul>

<p>Click <a href="https://start.spring.io/#!type=maven-project&amp;language=java&amp;platformVersion=2.2.4.RELEASE&amp;packaging=jar&amp;jvmVersion=1.8&amp;groupId=com.example&amp;artifactId=demo&amp;name=demo&amp;description=Demo%20project%20for%20Spring%20Boot%20with%20Spring%20Rest%20Repositories&amp;packageName=com.example.demo&amp;dependencies=data-jpa,lombok,data-rest,h2">here</a> to be redirected to Spring Initializr wesite with the previous configuration loaded.</p>

<p>Download, unzip and load the project on your favorite IDE.</p>

<h1>
 <a name="specify-the-resources" href="#specify-the-resources">
 </a>
 Specify the resources
</h1>

<p>There'll be a resource called <code>User</code>:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@Entity</span> <span class="nd">@Data</span>
<span class="kd">class</span> <span class="nc">User</span> <span class="o">{</span>

 <span class="nd">@Id</span>
 <span class="nd">@GeneratedValue</span><span class="o">(</span><span class="n">strategy</span> <span class="o">=</span> <span class="nc">GenerationType</span><span class="o">.</span><span class="na">IDENTITY</span><span class="o">)</span>
 <span class="kd">private</span> <span class="kt">long</span> <span class="n">id</span><span class="o">;</span>

 <span class="kd">private</span> <span class="nc">String</span> <span class="n">firstName</span><span class="o">;</span>
 <span class="kd">private</span> <span class="nc">String</span> <span class="n">lastName</span><span class="o">;</span>

 <span class="nd">@ManyToOne</span>
 <span class="nd">@JoinColumn</span><span class="o">(</span><span class="n">name</span> <span class="o">=</span> <span class="s">"role_id"</span><span class="o">)</span>
 <span class="kd">private</span> <span class="nc">Role</span> <span class="n">role</span><span class="o">;</span>
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


<p>And another one called <code>Role</code>:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@Entity</span> <span class="nd">@Data</span>
<span class="kd">class</span> <span class="nc">Role</span> <span class="o">{</span>

 <span class="nd">@Id</span>
 <span class="nd">@GeneratedValue</span><span class="o">(</span><span class="n">strategy</span> <span class="o">=</span> <span class="nc">GenerationType</span><span class="o">.</span><span class="na">IDENTITY</span><span class="o">)</span>
 <span class="kd">private</span> <span class="kt">long</span> <span class="n">id</span><span class="o">;</span>

 <span class="kd">private</span> <span class="nc">String</span> <span class="n">name</span><span class="o">;</span>
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


<p>Notice the following:</p>

<ul>
<li>
<code>@Entity</code> specifies this as a JPA entity to be persisted to a database (in our case, H2).</li>
<li>
<code>@Data</code> is a Lombok annotation that creates code in compile-time for getters, setters, constructors, toString and hash methods.</li>
<li>
<code>@Id</code> and <code>@GeneratedValue</code> are JPA annotations that designate the <code>id</code> field as an ID for the entities and that the database IDs will be auto-generated (in this case by the database).</li>
<li>
<code>@ManyToOne</code> and <code>@JoinColumn</code> relate User and Role entities.</li>
</ul>
<h1>
 <a name="create-and-expose-repositories" href="#create-and-expose-repositories">
 </a>
 Create and expose repositories
</h1>

<p>The Repository pattern abstracts the access to read and write data from/to a database. In this little experiment, the entities are to be persisted and the repositories implement the operations to do so. </p>

<p>With Spring Data, though, you won't need any implementation, since it'll be provided to us in runtime. Let's see how:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@RepositoryRestResource</span><span class="o">(</span><span class="n">collectionResourceRel</span> <span class="o">=</span> <span class="s">"users"</span><span class="o">,</span> <span class="n">itemResourceRel</span> <span class="o">=</span> <span class="s">"user"</span><span class="o">,</span> <span class="n">path</span> <span class="o">=</span> <span class="s">"users"</span><span class="o">)</span>
<span class="kd">interface</span> <span class="nc">PersonRepository</span> <span class="kd">extends</span> <span class="nc">JpaRepository</span><span class="o">&lt;</span><span class="nc">User</span><span class="o">,</span> <span class="nc">Long</span><span class="o">&gt;</span> <span class="o">{}</span>

<span class="nd">@RepositoryRestResource</span><span class="o">(</span><span class="n">collectionResourceRel</span> <span class="o">=</span> <span class="s">"roles"</span><span class="o">,</span> <span class="n">itemResourceRel</span> <span class="o">=</span> <span class="s">"role"</span><span class="o">,</span> <span class="n">path</span> <span class="o">=</span> <span class="s">"roles"</span><span class="o">)</span>
<span class="kd">interface</span> <span class="nc">RoleRepository</span> <span class="kd">extends</span> <span class="nc">JpaRepository</span><span class="o">&lt;</span><span class="nc">Role</span><span class="o">,</span> <span class="nc">Long</span><span class="o">&gt;</span> <span class="o">{}</span>
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


<p>Let's break things down:</p>

<ul>
<li>
<code>@RepositoryRestResource</code> is what exposes the entities as REST endpoints.

<ul>
<li>
<code>itemResourceRel</code> specifies how to call one instance of an entity.</li>
<li>
<code>collectionResourceRel</code> specifies how to call two or more instances of an entity.</li>
<li>
<code>path</code> specifies the path (url) to access the resource.</li>
</ul>
</li>
<li>
<code>extends JpaRepository&lt;...</code> is what provides all the methods to write each entity to the database. The list below was taken with the code completion feature (<code>CTRL + Space</code> on IntelliJ IDEA) on an instance of a repository:</li>
</ul>

<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--3cVMdt15--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/teyse3i42kh4wq0683u0.png" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--3cVMdt15--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/teyse3i42kh4wq0683u0.png" alt="Alt Text" loading="lazy" width="447" height="660"></a></p>
<h2>
 <a name="bootstrap-some-data" href="#bootstrap-some-data">
 </a>
 Bootstrap some data
</h2>

<p>For demonstration purposes, let's create a <code>import.sql</code> file on the <code>resources</code> folder to populate the database with data upon app initialization.<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight sql"><code><span class="k">insert</span> <span class="k">into</span> <span class="k">role</span> <span class="p">(</span><span class="n">name</span><span class="p">)</span> <span class="k">values</span> <span class="p">(</span><span class="s1">'USER'</span><span class="p">),</span> <span class="p">(</span><span class="s1">'ADMIN'</span><span class="p">),</span> <span class="p">(</span><span class="s1">'ROOT'</span><span class="p">);</span>
<span class="k">insert</span> <span class="k">into</span> <span class="k">user</span> <span class="p">(</span><span class="n">first_name</span><span class="p">,</span> <span class="n">last_name</span><span class="p">,</span> <span class="n">role_id</span><span class="p">)</span> <span class="k">values</span> <span class="p">(</span><span class="s1">'Johnny'</span><span class="p">,</span> <span class="s1">'Bravo'</span><span class="p">,</span> <span class="mi">1</span><span class="p">),</span> <span class="p">(</span><span class="s1">'Johnny'</span><span class="p">,</span> <span class="s1">'Manso'</span><span class="p">,</span> <span class="mi">2</span><span class="p">),</span> <span class="p">(</span><span class="s1">'Sidra'</span><span class="p">,</span> <span class="s1">'Cereser'</span><span class="p">,</span> <span class="mi">1</span><span class="p">),</span> <span class="p">(</span><span class="s1">'Chuck'</span><span class="p">,</span> <span class="s1">'Norris'</span><span class="p">,</span> <span class="mi">3</span><span class="p">);</span>
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

<h1>
 <a name="test-some-operations" href="#test-some-operations">
 </a>
 Test some operations
</h1>

<p>Assuming you're running the application on your machine, the following snippets help you "see" the API working.</p>
<h4>
 <a name="get-list-of-resources" href="#get-list-of-resources">
 </a>
 GET list of resources
</h4>

<p>On the terminal, type:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight shell"><code>curl <span class="nt">-i</span> <span class="nt">-X</span> GET http://localhost:8080/users
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


<p>You get:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight json"><code><span class="err">HTTP/</span><span class="mf">1.1</span><span class="w"> </span><span class="mi">200</span><span class="w"> 
</span><span class="err">Vary:</span><span class="w"> </span><span class="err">Origin</span><span class="w">
</span><span class="err">Vary:</span><span class="w"> </span><span class="err">Access-Control-Request-Method</span><span class="w">
</span><span class="err">Vary:</span><span class="w"> </span><span class="err">Access-Control-Request-Headers</span><span class="w">
</span><span class="err">Content-Type:</span><span class="w"> </span><span class="err">application/hal+json</span><span class="w">
</span><span class="err">Transfer-Encoding:</span><span class="w"> </span><span class="err">chunked</span><span class="w">
</span><span class="err">Date:</span><span class="w"> </span><span class="err">Tue,</span><span class="w"> </span><span class="mi">21</span><span class="w"> </span><span class="err">Jan</span><span class="w"> </span><span class="mi">2020</span><span class="w"> </span><span class="mi">03</span><span class="err">:</span><span class="mi">02</span><span class="err">:</span><span class="mi">40</span><span class="w"> </span><span class="err">GMT</span><span class="w">

</span><span class="p">{</span><span class="w">
 </span><span class="nl">"_embedded"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"users"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">[</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"firstName"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"Johnny"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"lastName"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"Bravo"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"_links"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"self"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/1"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"user"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/1"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"role"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/1/role"</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">},</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"firstName"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"Johnny"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"lastName"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"Manso"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"_links"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"self"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/2"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"user"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/2"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"role"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/2/role"</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">},</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"firstName"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"Sidra"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"lastName"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"Cereser"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"_links"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"self"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/3"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"user"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/3"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"role"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/3/role"</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">},</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"firstName"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"Chuck"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"lastName"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"Norris"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"_links"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"self"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/4"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"user"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/4"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"role"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/4/role"</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">}</span><span class="w"> </span><span class="p">]</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"_links"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"self"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users{?page,size,sort}"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"templated"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="kc">true</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"profile"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/profile/users"</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"page"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"size"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="mi">20</span><span class="p">,</span><span class="w">
 </span><span class="nl">"totalElements"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="mi">4</span><span class="p">,</span><span class="w">
 </span><span class="nl">"totalPages"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="mi">1</span><span class="p">,</span><span class="w">
 </span><span class="nl">"number"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="mi">0</span><span class="w">
 </span><span class="p">}</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>
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


<p>On the terminal, type:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight shell"><code>curl <span class="nt">-i</span> <span class="nt">-X</span> GET http://localhost:8080/roles
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


<p>You get:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight json"><code><span class="err">HTTP/</span><span class="mf">1.1</span><span class="w"> </span><span class="mi">200</span><span class="w"> 
</span><span class="err">Vary:</span><span class="w"> </span><span class="err">Origin</span><span class="w">
</span><span class="err">Vary:</span><span class="w"> </span><span class="err">Access-Control-Request-Method</span><span class="w">
</span><span class="err">Vary:</span><span class="w"> </span><span class="err">Access-Control-Request-Headers</span><span class="w">
</span><span class="err">Content-Type:</span><span class="w"> </span><span class="err">application/hal+json</span><span class="w">
</span><span class="err">Transfer-Encoding:</span><span class="w"> </span><span class="err">chunked</span><span class="w">
</span><span class="err">Date:</span><span class="w"> </span><span class="err">Tue,</span><span class="w"> </span><span class="mi">21</span><span class="w"> </span><span class="err">Jan</span><span class="w"> </span><span class="mi">2020</span><span class="w"> </span><span class="mi">03</span><span class="err">:</span><span class="mi">10</span><span class="err">:</span><span class="mi">29</span><span class="w"> </span><span class="err">GMT</span><span class="w">

</span><span class="p">{</span><span class="w">
 </span><span class="nl">"_embedded"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"roles"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">[</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"name"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"USER"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"_links"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"self"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/roles/1"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"role"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/roles/1"</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">},</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"name"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"ADMIN"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"_links"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"self"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/roles/2"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"role"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/roles/2"</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">},</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"name"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"ROOT"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"_links"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"self"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/roles/3"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"role"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/roles/3"</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">}</span><span class="w"> </span><span class="p">]</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"_links"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"self"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/roles{?page,size,sort}"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"templated"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="kc">true</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"profile"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/profile/roles"</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"page"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"size"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="mi">20</span><span class="p">,</span><span class="w">
 </span><span class="nl">"totalElements"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="mi">3</span><span class="p">,</span><span class="w">
 </span><span class="nl">"totalPages"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="mi">1</span><span class="p">,</span><span class="w">
 </span><span class="nl">"number"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="mi">0</span><span class="w">
 </span><span class="p">}</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>
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
 <a name="get-one-resource" href="#get-one-resource">
 </a>
 GET one resource
</h4>

<p>On the terminal, type:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight shell"><code>curl <span class="nt">-i</span> <span class="nt">-X</span> GET http://localhost:8080/users/1
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


<p>You get:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight json"><code><span class="err">HTTP/</span><span class="mf">1.1</span><span class="w"> </span><span class="mi">200</span><span class="w"> 
</span><span class="err">Vary:</span><span class="w"> </span><span class="err">Origin</span><span class="w">
</span><span class="err">Vary:</span><span class="w"> </span><span class="err">Access-Control-Request-Method</span><span class="w">
</span><span class="err">Vary:</span><span class="w"> </span><span class="err">Access-Control-Request-Headers</span><span class="w">
</span><span class="err">Content-Type:</span><span class="w"> </span><span class="err">application/hal+json</span><span class="w">
</span><span class="err">Transfer-Encoding:</span><span class="w"> </span><span class="err">chunked</span><span class="w">
</span><span class="err">Date:</span><span class="w"> </span><span class="err">Tue,</span><span class="w"> </span><span class="mi">21</span><span class="w"> </span><span class="err">Jan</span><span class="w"> </span><span class="mi">2020</span><span class="w"> </span><span class="mi">03</span><span class="err">:</span><span class="mi">05</span><span class="err">:</span><span class="mi">21</span><span class="w"> </span><span class="err">GMT</span><span class="w">

</span><span class="p">{</span><span class="w">
 </span><span class="nl">"firstName"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"Johnny"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"lastName"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"Bravo"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"_links"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"self"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/1"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"user"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/1"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"role"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/1/role"</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">}</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>
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


<p>On the terminal, type:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight shell"><code>curl <span class="nt">-i</span> <span class="nt">-X</span> GET http://localhost:8080/roles/1
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


<p>You get:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight json"><code><span class="err">HTTP/</span><span class="mf">1.1</span><span class="w"> </span><span class="mi">200</span><span class="w"> 
</span><span class="err">Vary:</span><span class="w"> </span><span class="err">Origin</span><span class="w">
</span><span class="err">Vary:</span><span class="w"> </span><span class="err">Access-Control-Request-Method</span><span class="w">
</span><span class="err">Vary:</span><span class="w"> </span><span class="err">Access-Control-Request-Headers</span><span class="w">
</span><span class="err">Content-Type:</span><span class="w"> </span><span class="err">application/hal+json</span><span class="w">
</span><span class="err">Transfer-Encoding:</span><span class="w"> </span><span class="err">chunked</span><span class="w">
</span><span class="err">Date:</span><span class="w"> </span><span class="err">Tue,</span><span class="w"> </span><span class="mi">21</span><span class="w"> </span><span class="err">Jan</span><span class="w"> </span><span class="mi">2020</span><span class="w"> </span><span class="mi">03</span><span class="err">:</span><span class="mi">11</span><span class="err">:</span><span class="mi">12</span><span class="w"> </span><span class="err">GMT</span><span class="w">

</span><span class="p">{</span><span class="w">
 </span><span class="nl">"name"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"USER"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"_links"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"self"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/roles/1"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"role"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/roles/1"</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">}</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>
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
 <a name="post-a-new-resource" href="#post-a-new-resource">
 </a>
 POST a new resource
</h4>

<p>On the terminal, type:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight shell"><code>curl <span class="nt">-i</span> <span class="nt">-X</span> POST <span class="nt">-H</span> <span class="s2">"Content-Type:application/json"</span> <span class="nt">-d</span> <span class="s1">'{"firstName": "Jhon", "lastName": "Benga", "role": "http://localhost:8080/roles/1"}'</span> http://localhost:8080/users
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


<p>You get:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight json"><code><span class="err">HTTP/</span><span class="mf">1.1</span><span class="w"> </span><span class="mi">201</span><span class="w"> 
</span><span class="err">Vary:</span><span class="w"> </span><span class="err">Origin</span><span class="w">
</span><span class="err">Vary:</span><span class="w"> </span><span class="err">Access-Control-Request-Method</span><span class="w">
</span><span class="err">Vary:</span><span class="w"> </span><span class="err">Access-Control-Request-Headers</span><span class="w">
</span><span class="err">Location:</span><span class="w"> </span><span class="err">http://localhost:</span><span class="mi">8080</span><span class="err">/users/</span><span class="mi">5</span><span class="w">
</span><span class="err">Content-Type:</span><span class="w"> </span><span class="err">application/hal+json</span><span class="w">
</span><span class="err">Transfer-Encoding:</span><span class="w"> </span><span class="err">chunked</span><span class="w">
</span><span class="err">Date:</span><span class="w"> </span><span class="err">Tue,</span><span class="w"> </span><span class="mi">21</span><span class="w"> </span><span class="err">Jan</span><span class="w"> </span><span class="mi">2020</span><span class="w"> </span><span class="mi">03</span><span class="err">:</span><span class="mi">09</span><span class="err">:</span><span class="mi">01</span><span class="w"> </span><span class="err">GMT</span><span class="w">

</span><span class="p">{</span><span class="w">
 </span><span class="nl">"firstName"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"Jhon"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"lastName"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"Benga"</span><span class="p">,</span><span class="w">
 </span><span class="nl">"_links"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"self"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/5"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"user"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/5"</span><span class="w">
 </span><span class="p">},</span><span class="w">
 </span><span class="nl">"role"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
 </span><span class="nl">"href"</span><span class="w"> </span><span class="p">:</span><span class="w"> </span><span class="s2">"http://localhost:8080/users/5/role"</span><span class="w">
 </span><span class="p">}</span><span class="w">
 </span><span class="p">}</span><span class="w">
</span><span class="p">}</span><span class="w">
</span></code></pre>
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


<p>Ahá, did you notice the <code>role</code> property? Yeah, you just send the <code>href</code> property of the role you want to attribute to the user.</p>

<p>Note: this is the reason I didn't include a HAL browser on this article. I don't know how (for now) to properly configure/customize the HAL browser to post embedded entities.</p>
<h1>
 <a name="final-thoughts" href="#final-thoughts">
 </a>
 Final thoughts
</h1>

<p>That was quick, wasn't it? The repository for the application is this:</p>


<div class="ltag-github-readme-tag">
 <div class="readme-overview">
 <h2>
 <img src="https://res.cloudinary.com/practicaldev/image/fetch/s--566lAguM--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev.to/assets/github-logo-5a155e1f9a670af7944dd5e12375bc76ed542ea80224905ecaf878b9157cdefc.svg" alt="GitHub logo" loading="lazy">
 <a href="https://github.com/brunodrugowick">
 brunodrugowick
 </a> / <a style="font-weight: 600;" href="https://github.com/brunodrugowick/spring-data-rest-example">
 spring-data-rest-example
 </a>
 </h2>
 <h3>
 
 </h3>
 </div>
 <div class="ltag-github-body">
 
<div id="readme" class="md" data-path="README.md"><article class="markdown-body entry-content container-lg" itemprop="text"><p dir="auto">Example application to serve as a boilerplate and learning purposes for Spring Data REST.</p>
</article></div>

 </div>
 <div class="gh-btn-container"><a class="gh-btn" href="https://github.com/brunodrugowick/spring-data-rest-example">View on GitHub</a></div>
</div>



<p>Here's all the code we wrote for the application:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@SpringBootApplication</span>
<span class="kd">public</span> <span class="kd">class</span> <span class="nc">SpringDataRestExampleApplication</span> <span class="o">{</span>
 <span class="kd">public</span> <span class="kd">static</span> <span class="kt">void</span> <span class="nf">main</span><span class="o">(</span><span class="nc">String</span><span class="o">[]</span> <span class="n">args</span><span class="o">)</span> <span class="o">{</span>
 <span class="nc">SpringApplication</span><span class="o">.</span><span class="na">run</span><span class="o">(</span><span class="nc">SpringDataRestExampleApplication</span><span class="o">.</span><span class="na">class</span><span class="o">,</span> <span class="n">args</span><span class="o">);</span>
 <span class="o">}</span>
<span class="o">}</span>

<span class="nd">@Entity</span> <span class="nd">@Data</span>
<span class="kd">class</span> <span class="nc">User</span> <span class="o">{</span>

 <span class="nd">@Id</span>
 <span class="nd">@GeneratedValue</span><span class="o">(</span><span class="n">strategy</span> <span class="o">=</span> <span class="nc">GenerationType</span><span class="o">.</span><span class="na">IDENTITY</span><span class="o">)</span>
 <span class="kd">private</span> <span class="kt">long</span> <span class="n">id</span><span class="o">;</span>

 <span class="kd">private</span> <span class="nc">String</span> <span class="n">firstName</span><span class="o">;</span>
 <span class="kd">private</span> <span class="nc">String</span> <span class="n">lastName</span><span class="o">;</span>

 <span class="nd">@ManyToOne</span>
 <span class="nd">@JoinColumn</span><span class="o">(</span><span class="n">name</span> <span class="o">=</span> <span class="s">"role_id"</span><span class="o">)</span>
 <span class="kd">private</span> <span class="nc">Role</span> <span class="n">role</span><span class="o">;</span>
<span class="o">}</span>

<span class="nd">@Entity</span> <span class="nd">@Data</span>
<span class="kd">class</span> <span class="nc">Role</span> <span class="o">{</span>

 <span class="nd">@Id</span>
 <span class="nd">@GeneratedValue</span><span class="o">(</span><span class="n">strategy</span> <span class="o">=</span> <span class="nc">GenerationType</span><span class="o">.</span><span class="na">IDENTITY</span><span class="o">)</span>
 <span class="kd">private</span> <span class="kt">long</span> <span class="n">id</span><span class="o">;</span>

 <span class="kd">private</span> <span class="nc">String</span> <span class="n">name</span><span class="o">;</span>
<span class="o">}</span>

<span class="nd">@RepositoryRestResource</span><span class="o">(</span><span class="n">collectionResourceRel</span> <span class="o">=</span> <span class="s">"users"</span><span class="o">,</span> <span class="n">itemResourceRel</span> <span class="o">=</span> <span class="s">"user"</span><span class="o">,</span> <span class="n">path</span> <span class="o">=</span> <span class="s">"users"</span><span class="o">)</span>
<span class="kd">interface</span> <span class="nc">PersonRepository</span> <span class="kd">extends</span> <span class="nc">JpaRepository</span><span class="o">&lt;</span><span class="nc">User</span><span class="o">,</span> <span class="nc">Long</span><span class="o">&gt;</span> <span class="o">{}</span>

<span class="nd">@RepositoryRestResource</span><span class="o">(</span><span class="n">collectionResourceRel</span> <span class="o">=</span> <span class="s">"roles"</span><span class="o">,</span> <span class="n">itemResourceRel</span> <span class="o">=</span> <span class="s">"role"</span><span class="o">,</span> <span class="n">path</span> <span class="o">=</span> <span class="s">"roles"</span><span class="o">)</span>
<span class="kd">interface</span> <span class="nc">RoleRepository</span> <span class="kd">extends</span> <span class="nc">JpaRepository</span><span class="o">&lt;</span><span class="nc">Role</span><span class="o">,</span> <span class="nc">Long</span><span class="o">&gt;</span> <span class="o">{}</span>
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



<h1>
 <a name="aqap-series" href="#aqap-series">
 </a>
 AQAP Series
</h1>

<p>As Quickly As Possible (AQAP) is a series of quick posts on something I find interesting. I encourage (and take part on) the discussions on the comments to further explore the technology, library or code quickly explained here.</p>

<h1>
 <a name="beginners-tag" href="#beginners-tag">
 </a>
 Beginners tag
</h1>

<p>I'm using this tag for the first time. Since there are rules to use it, please let me know if there's something here you (or a beginner) don't understand or that I took for granted and you're (or a beginner may be :) confused about it.</p>


<hr>

<p>Image by <a href="https://pixabay.com/pt/users/jaykingsta14-4885997/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2358636">Jason King</a> por <a href="https://pixabay.com/pt/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2358636">Pixabay</a></p>...