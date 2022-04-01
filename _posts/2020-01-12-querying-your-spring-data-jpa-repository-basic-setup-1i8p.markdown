---
layout: post
title:  "Querying your Spring Data JPA Repository - Basic Setup"
date:   2020-01-12T21:53:36Z
categories: 
---

> <div class=card><div class=container><h4><b><a href="https://dev.to/brunodrugowick/querying-your-spring-data-jpa-repository-basic-setup-1i8p">You'll have a better experience reading in DEV...</a></b></h4><i><p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/querying-your-spring-data-jpa-repository-basic-setup-1i8p">read more</a>.</p><p>You can continue to read here too, it's up to you...</p></i></div></div>
<p>Well, nothing is simple nowadays. I'm a fan of complexity, so here's not the place you'll find quick answers. Nevertheless, I do seek to organize things in a way that's easy to refer to later, after reading and understand these blog posts.</p>

<p>With that in mind, in this second post of the series <a href="https://dev.to/brunodrugowick/querying-your-spring-data-jpa-repository-introduction-4ani">Querying your Spring Data JPA Repository</a> I'll create a basic setup where everything that lacks are repository queries. The following sections explain the app architecture.</p>

<p>If you don't want to invest time creating the basic setup, here's the <a href="https://github.com/brunodrugowick/jpa-queries-blog-post/releases/tag/v.1.0.1">code/app</a>.</p>

<h2>
 <a name="main-considerations" href="#main-considerations">
 </a>
 Main considerations
</h2>

<p>I'll use the current version of Spring Boot <a href="https://spring.io/blog/2019/12/06/spring-boot-2-2-2-is-now-available">2.2.2</a> with the starters:</p>

<ul>
<li>
<code>spring-boot-starter-web</code>: adds Spring MVC with Tomcat as the application server.</li>
<li>
<code>spring-boot-starter-data-jpa</code>: adds Spring Data JPA, providing persistence of objects.</li>
<li>
<code>spring-boot-starter-thymeleaf</code>: adds Thymeleaf, the most popular templating engine to build pages dynamically on the server for the client (browser) to download. "Oh, you're not using Angular or React, you fool" you may say. Yeah, deal with with. Thymeleaf is actually a great solution if you don't want a "decoupled" frontend with Angular or other frontend framework.</li>
<li>
<code>h2</code>: provides H2 in-memory database. Adding this dependency is enough to start coding without any database configured. I'll make everything compatible with MySQL so later one can only add the MySQL driver and configure the connection on <code>application.properties</code>.</li>
</ul>

<p>So my <code>pom.xml</code> starts with the following basic dependencies:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight xml"><code><span class="nt">&lt;dependency&gt;</span>
 <span class="nt">&lt;groupId&gt;</span>org.springframework.boot<span class="nt">&lt;/groupId&gt;</span>
 <span class="nt">&lt;artifactId&gt;</span>spring-boot-starter-web<span class="nt">&lt;/artifactId&gt;</span>
<span class="nt">&lt;/dependency&gt;</span>
<span class="nt">&lt;dependency&gt;</span>
 <span class="nt">&lt;groupId&gt;</span>org.springframework.boot<span class="nt">&lt;/groupId&gt;</span>
 <span class="nt">&lt;artifactId&gt;</span>spring-boot-starter-data-jpa<span class="nt">&lt;/artifactId&gt;</span>
<span class="nt">&lt;/dependency&gt;</span>
<span class="nt">&lt;dependency&gt;</span>
 <span class="nt">&lt;groupId&gt;</span>org.springframework.boot<span class="nt">&lt;/groupId&gt;</span>
 <span class="nt">&lt;artifactId&gt;</span>spring-boot-starter-thymeleaf<span class="nt">&lt;/artifactId&gt;</span>
<span class="nt">&lt;/dependency&gt;</span>
<span class="nt">&lt;dependency&gt;</span>
 <span class="nt">&lt;groupId&gt;</span>com.h2database<span class="nt">&lt;/groupId&gt;</span>
 <span class="nt">&lt;artifactId&gt;</span>h2<span class="nt">&lt;/artifactId&gt;</span>
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



<p>And the following complementary dependencies to help in the development process:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight xml"><code><span class="nt">&lt;dependency&gt;</span>
 <span class="nt">&lt;groupId&gt;</span>org.springframework.boot<span class="nt">&lt;/groupId&gt;</span>
 <span class="nt">&lt;artifactId&gt;</span>spring-boot-devtools<span class="nt">&lt;/artifactId&gt;</span>
 <span class="nt">&lt;scope&gt;</span>runtime<span class="nt">&lt;/scope&gt;</span>
 <span class="nt">&lt;optional&gt;</span>true<span class="nt">&lt;/optional&gt;</span>
<span class="nt">&lt;/dependency&gt;</span>
<span class="nt">&lt;dependency&gt;</span>
 <span class="nt">&lt;groupId&gt;</span>org.projectlombok<span class="nt">&lt;/groupId&gt;</span>
 <span class="nt">&lt;artifactId&gt;</span>lombok<span class="nt">&lt;/artifactId&gt;</span>
 <span class="nt">&lt;optional&gt;</span>true<span class="nt">&lt;/optional&gt;</span>
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
 <a name="app-layers-packages" href="#app-layers-packages">
 </a>
 App Layers (packages)
</h2>

<ul>
<li>Web <code>web.*</code>: controllers for pages or endpoints go here.</li>
<li>Business <code>domain.*</code>: models (for now), e.g. Restaurant and Cuisine definitions.</li>
<li>Infrastructure <code>infrastructure.*</code>: repositories go here.</li>
</ul>

<h2>
 <a name="the-code" href="#the-code">
 </a>
 The code
</h2>

<p>I encourage you to build your own project following the scarce instructions I'm providing. The reason is that only through hands on experience you really learn. Of course I provide the complete code if you don't want the trouble.</p>

<h3>
 <a name="web-layer" href="#web-layer">
 </a>
 Web layer
</h3>

<p><a name="findAll"></a>The web layer is composed of one index controller:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@Controller</span>
<span class="kd">public</span> <span class="kd">class</span> <span class="nc">IndexPage</span> <span class="o">{</span>

 <span class="kd">private</span> <span class="kd">final</span> <span class="nc">RestaurantRepository</span> <span class="n">restaurantRepository</span><span class="o">;</span>

 <span class="kd">public</span> <span class="nf">IndexPage</span><span class="o">(</span><span class="nc">RestaurantRepository</span> <span class="n">restaurantRepository</span><span class="o">)</span> <span class="o">{</span>
 <span class="k">this</span><span class="o">.</span><span class="na">restaurantRepository</span> <span class="o">=</span> <span class="n">restaurantRepository</span><span class="o">;</span>
 <span class="o">}</span>

 <span class="nd">@RequestMapping</span>
 <span class="kd">public</span> <span class="nc">String</span> <span class="nf">index</span><span class="o">(</span><span class="nc">Model</span> <span class="n">model</span><span class="o">)</span> <span class="o">{</span>
 <span class="n">model</span><span class="o">.</span><span class="na">addAttribute</span><span class="o">(</span><span class="s">"restaurants"</span><span class="o">,</span> <span class="n">restaurantRepository</span><span class="o">.</span><span class="na">findAll</span><span class="o">());</span>
 <span class="k">return</span> <span class="s">"index"</span><span class="o">;</span>
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



<p>Notice the <code>restaurantRepository.findAll()</code> that I'll explain in a bit.</p>

<h3>
 <a name="business-layer" href="#business-layer">
 </a>
 Business layer
</h3>

<p>In the business layer I included the domain, i.e., the objects that'll be persisted.</p>

<p>Restaurant:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@Data</span>
<span class="nd">@EqualsAndHashCode</span><span class="o">(</span><span class="n">onlyExplicitlyIncluded</span> <span class="o">=</span> <span class="kc">true</span><span class="o">)</span>
<span class="nd">@Entity</span>
<span class="nd">@Table</span><span class="o">(</span><span class="n">uniqueConstraints</span> <span class="o">=</span> <span class="nd">@UniqueConstraint</span><span class="o">(</span><span class="n">columnNames</span> <span class="o">=</span> <span class="s">"name"</span><span class="o">))</span>
<span class="kd">public</span> <span class="kd">class</span> <span class="nc">Restaurant</span> <span class="o">{</span>

 <span class="nd">@EqualsAndHashCode</span><span class="o">.</span><span class="na">Include</span>
 <span class="nd">@Id</span>
 <span class="nd">@GeneratedValue</span><span class="o">(</span><span class="n">strategy</span> <span class="o">=</span> <span class="nc">GenerationType</span><span class="o">.</span><span class="na">IDENTITY</span><span class="o">)</span>
 <span class="kd">private</span> <span class="nc">Long</span> <span class="n">id</span><span class="o">;</span>

 <span class="kd">private</span> <span class="nc">String</span> <span class="n">name</span><span class="o">;</span>

 <span class="kd">private</span> <span class="nc">BigDecimal</span> <span class="n">deliveryFee</span><span class="o">;</span>

 <span class="nd">@ManyToOne</span>
 <span class="nd">@JoinColumn</span><span class="o">(</span><span class="n">name</span> <span class="o">=</span> <span class="s">"cuisine_id"</span><span class="o">,</span> <span class="n">nullable</span> <span class="o">=</span> <span class="kc">false</span><span class="o">)</span>
 <span class="kd">private</span> <span class="nc">Cuisine</span> <span class="n">cuisine</span><span class="o">;</span>

 <span class="kd">private</span> <span class="nc">String</span> <span class="n">address</span><span class="o">;</span>

 <span class="nd">@CreationTimestamp</span>
 <span class="nd">@Column</span><span class="o">(</span><span class="n">columnDefinition</span> <span class="o">=</span> <span class="s">"datetime"</span><span class="o">,</span> <span class="n">updatable</span> <span class="o">=</span> <span class="kc">false</span><span class="o">)</span>
 <span class="kd">private</span> <span class="nc">LocalDateTime</span> <span class="n">createdDate</span><span class="o">;</span>

 <span class="nd">@UpdateTimestamp</span>
 <span class="nd">@Column</span><span class="o">(</span><span class="n">columnDefinition</span> <span class="o">=</span> <span class="s">"datetime"</span><span class="o">)</span>
 <span class="kd">private</span> <span class="nc">LocalDateTime</span> <span class="n">updatedDate</span><span class="o">;</span>

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



<p>And Cuisine:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@Data</span>
<span class="nd">@EqualsAndHashCode</span><span class="o">(</span><span class="n">onlyExplicitlyIncluded</span> <span class="o">=</span> <span class="kc">true</span><span class="o">)</span>
<span class="nd">@Entity</span>
<span class="nd">@Table</span><span class="o">(</span><span class="n">uniqueConstraints</span> <span class="o">=</span> <span class="nd">@UniqueConstraint</span><span class="o">(</span><span class="n">columnNames</span> <span class="o">=</span> <span class="s">"name"</span><span class="o">))</span>
<span class="kd">public</span> <span class="kd">class</span> <span class="nc">Cuisine</span> <span class="o">{</span>

 <span class="nd">@EqualsAndHashCode</span><span class="o">.</span><span class="na">Include</span>
 <span class="nd">@Id</span>
 <span class="nd">@GeneratedValue</span><span class="o">(</span><span class="n">strategy</span> <span class="o">=</span> <span class="nc">GenerationType</span><span class="o">.</span><span class="na">IDENTITY</span><span class="o">)</span>
 <span class="kd">private</span> <span class="nc">Long</span> <span class="n">id</span><span class="o">;</span>

 <span class="nd">@OneToMany</span><span class="o">(</span><span class="n">mappedBy</span> <span class="o">=</span> <span class="s">"cuisine"</span><span class="o">)</span>
 <span class="nc">List</span><span class="o">&lt;</span><span class="nc">Restaurant</span><span class="o">&gt;</span> <span class="n">restaurants</span><span class="o">;</span>

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



<p>Notice they have a relationship between then. That's it for the Business layer. Notice also that no Service is provided: for brevity I'll query the Repositories from the Controllers.</p>

<h3>
 <a name="infrastructure-layer" href="#infrastructure-layer">
 </a>
 Infrastructure layer
</h3>

<p>An interface that extends an interface from Spring Data JPA project. This provides the <code>findAll()</code> method that <a href="#findAll">you saw earlier</a>.<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="kd">public</span> <span class="kd">interface</span> <span class="nc">RestaurantRepository</span> <span class="kd">extends</span> <span class="nc">JpaRepository</span><span class="o">&lt;</span><span class="nc">Restaurant</span><span class="o">,</span> <span class="nc">Long</span><span class="o">&gt;</span> <span class="o">{</span>
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
 <a name="initial-data" href="#initial-data">
 </a>
 Initial Data
</h2>

<p>To provide initial data, there's a file <code>import.sql</code> into <code>resources</code> folder. This is JPA stuff and runs when starting the application.<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight sql"><code><span class="k">insert</span> <span class="k">into</span> <span class="n">cuisine</span> <span class="p">(</span><span class="n">name</span><span class="p">)</span> <span class="k">values</span> <span class="p">(</span><span class="s1">'Italian'</span><span class="p">);</span>
<span class="k">insert</span> <span class="k">into</span> <span class="n">cuisine</span> <span class="p">(</span><span class="n">name</span><span class="p">)</span> <span class="k">values</span> <span class="p">(</span><span class="s1">'Brazilian'</span><span class="p">);</span>
<span class="k">insert</span> <span class="k">into</span> <span class="n">cuisine</span> <span class="p">(</span><span class="n">name</span><span class="p">)</span> <span class="k">values</span> <span class="p">(</span><span class="s1">'American'</span><span class="p">);</span>
<span class="k">insert</span> <span class="k">into</span> <span class="n">cuisine</span> <span class="p">(</span><span class="n">name</span><span class="p">)</span> <span class="k">values</span> <span class="p">(</span><span class="s1">'French'</span><span class="p">);</span>

<span class="k">insert</span> <span class="k">into</span> <span class="n">restaurant</span> <span class="p">(</span><span class="n">name</span><span class="p">,</span> <span class="n">address</span><span class="p">,</span> <span class="n">delivery_fee</span><span class="p">,</span> <span class="n">cuisine_id</span><span class="p">,</span> <span class="n">created_date</span><span class="p">,</span> <span class="n">updated_date</span><span class="p">)</span> <span class="k">values</span> <span class="p">(</span><span class="s1">'Mamma Mia'</span><span class="p">,</span> <span class="s1">'Mamma Street, 14'</span><span class="p">,</span> <span class="mi">10</span><span class="p">.</span><span class="mi">0</span><span class="p">,</span> <span class="mi">1</span><span class="p">,</span> <span class="k">current_timestamp</span><span class="p">,</span> <span class="k">current_timestamp</span><span class="p">);</span>
<span class="k">insert</span> <span class="k">into</span> <span class="n">restaurant</span> <span class="p">(</span><span class="n">name</span><span class="p">,</span> <span class="n">address</span><span class="p">,</span> <span class="n">delivery_fee</span><span class="p">,</span> <span class="n">cuisine_id</span><span class="p">,</span> <span class="n">created_date</span><span class="p">,</span> <span class="n">updated_date</span><span class="p">)</span> <span class="k">values</span> <span class="p">(</span><span class="s1">'Churrascaria'</span><span class="p">,</span> <span class="s1">'Disorder Avenue, 5000'</span><span class="p">,</span> <span class="mi">8</span><span class="p">.</span><span class="mi">0</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="k">current_timestamp</span><span class="p">,</span> <span class="k">current_timestamp</span><span class="p">);</span>
<span class="k">insert</span> <span class="k">into</span> <span class="n">restaurant</span> <span class="p">(</span><span class="n">name</span><span class="p">,</span> <span class="n">address</span><span class="p">,</span> <span class="n">delivery_fee</span><span class="p">,</span> <span class="n">cuisine_id</span><span class="p">,</span> <span class="n">created_date</span><span class="p">,</span> <span class="n">updated_date</span><span class="p">)</span> <span class="k">values</span> <span class="p">(</span><span class="s1">'Burguer Place'</span><span class="p">,</span> <span class="s1">'Clueless Alley, 10'</span><span class="p">,</span> <span class="mi">5</span><span class="p">.</span><span class="mi">0</span><span class="p">,</span> <span class="mi">3</span><span class="p">,</span> <span class="k">current_timestamp</span><span class="p">,</span> <span class="k">current_timestamp</span><span class="p">);</span>
<span class="k">insert</span> <span class="k">into</span> <span class="n">restaurant</span> <span class="p">(</span><span class="n">name</span><span class="p">,</span> <span class="n">address</span><span class="p">,</span> <span class="n">delivery_fee</span><span class="p">,</span> <span class="n">cuisine_id</span><span class="p">,</span> <span class="n">created_date</span><span class="p">,</span> <span class="n">updated_date</span><span class="p">)</span> <span class="k">values</span> <span class="p">(</span><span class="s1">'La Maison du Croissant '</span><span class="p">,</span> <span class="s1">'Rue Paris, 7'</span><span class="p">,</span> <span class="mi">15</span><span class="p">.</span><span class="mi">0</span><span class="p">,</span> <span class="mi">4</span><span class="p">,</span> <span class="k">current_timestamp</span><span class="p">,</span> <span class="k">current_timestamp</span><span class="p">);</span>

<span class="k">insert</span> <span class="k">into</span> <span class="n">restaurant</span> <span class="p">(</span><span class="n">name</span><span class="p">,</span> <span class="n">address</span><span class="p">,</span> <span class="n">delivery_fee</span><span class="p">,</span> <span class="n">cuisine_id</span><span class="p">,</span> <span class="n">created_date</span><span class="p">,</span> <span class="n">updated_date</span><span class="p">)</span> <span class="k">values</span> <span class="p">(</span><span class="s1">'Pasta Buona'</span><span class="p">,</span> <span class="s1">'Pasta Street, 4'</span><span class="p">,</span> <span class="mi">2</span><span class="p">.</span><span class="mi">0</span><span class="p">,</span> <span class="mi">1</span><span class="p">,</span> <span class="k">current_timestamp</span><span class="p">,</span> <span class="k">current_timestamp</span><span class="p">);</span>
<span class="k">insert</span> <span class="k">into</span> <span class="n">restaurant</span> <span class="p">(</span><span class="n">name</span><span class="p">,</span> <span class="n">address</span><span class="p">,</span> <span class="n">delivery_fee</span><span class="p">,</span> <span class="n">cuisine_id</span><span class="p">,</span> <span class="n">created_date</span><span class="p">,</span> <span class="n">updated_date</span><span class="p">)</span> <span class="k">values</span> <span class="p">(</span><span class="s1">'Marcante Pizzaria'</span><span class="p">,</span> <span class="s1">'Bricks Street, 21'</span><span class="p">,</span> <span class="mi">9</span><span class="p">.</span><span class="mi">0</span><span class="p">,</span> <span class="mi">2</span><span class="p">,</span> <span class="k">current_timestamp</span><span class="p">,</span> <span class="k">current_timestamp</span><span class="p">);</span>
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



<p>More to come... this series isn't over.</p>...