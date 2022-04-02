---
layout: post
title:  "Spring Boot, Vue.js, Axios and Thymeleaf with Bootstrap in 4 commits"
date:   2020-02-04T05:12:42Z
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

<code>[beginners, vue, axios, spring]</code>
<div class=card>
	  <div class=container>
	    <h4><b><br>You'll have a better experience reading in DEV</b></h4>
	    <p><a href="https://dev.to/brunodrugowick/spring-boot-vue-js-axios-and-thymeleaf-with-bootstrap-in-4-commits-2b0l" target="_blank">Click here to continue reading this post there >></a></p>
	    <p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/spring-boot-vue-js-axios-and-thymeleaf-with-bootstrap-in-4-commits-2b0l" target="_blank">read more</a>.</p>
	    <p>You can continue to read here too, it's up to you... =]</p>
	  </div>
	</div><br>
<p>Take a deep breath, hold...</p>

<p>In 4 short and easy commits you'll get a Spring Boot app serving server-side rendered pages via Thymeleaf (with Bootstrap) and Vue.js scripts making use of Axios to make asynchronous requests to the server to update pages with data without reloading the whole page from the server again.</p>

<p>... release! Explaining the previous phrase may take longer than to implement it. So let's do it.</p>

<h1>
  <a name="commit-1-spring-initializr" href="#commit-1-spring-initializr">
  </a>
  Commit #1 - Spring Initializr
</h1>

<p>This one is easy. The first commit is the base Spring Boot application from Spring Initializr + a few extras. </p>

<p>You can generate your own version downloading <a href="https://start.spring.io/#!type=maven-project&amp;language=java&amp;platformVersion=2.2.4.RELEASE&amp;packaging=jar&amp;jvmVersion=1.8&amp;groupId=com.example&amp;artifactId=demo&amp;name=demo&amp;description=Demo%20project%20for%20Spring%20Boot&amp;packageName=com.example.demo&amp;dependencies=web,data-jpa,thymeleaf,h2,lombok,devtools">from this link</a> (already populated with some dependencies).</p>

<p>Add the following to the <code>pom.xml</code> file after loading the project in your preferred IDE:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight xml"><code><span class="nt">&lt;dependency&gt;</span>
    <span class="nt">&lt;groupId&gt;</span>org.webjars<span class="nt">&lt;/groupId&gt;</span>
    <span class="nt">&lt;artifactId&gt;</span>bootstrap<span class="nt">&lt;/artifactId&gt;</span>
    <span class="nt">&lt;version&gt;</span>4.4.1<span class="nt">&lt;/version&gt;</span>
<span class="nt">&lt;/dependency&gt;</span>
<span class="nt">&lt;dependency&gt;</span>
    <span class="nt">&lt;groupId&gt;</span>org.webjars<span class="nt">&lt;/groupId&gt;</span>
    <span class="nt">&lt;artifactId&gt;</span>webjars-locator<span class="nt">&lt;/artifactId&gt;</span>
    <span class="nt">&lt;version&gt;</span>0.38<span class="nt">&lt;/version&gt;</span>
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

<h1>
  <a name="commit-2-the-base-app" href="#commit-2-the-base-app">
  </a>
  Commit #2 - The base app
</h1>

<p>This commit may be long but it's not complicated at all. It adds Role and User entities:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@Entity</span><span class="o">(</span><span class="n">name</span> <span class="o">=</span> <span class="s">"role"</span><span class="o">)</span>
<span class="nd">@Data</span>
<span class="kd">public</span> <span class="kd">class</span> <span class="nc">Role</span> <span class="o">{</span>

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



<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@Entity</span><span class="o">(</span><span class="n">name</span> <span class="o">=</span> <span class="s">"user"</span><span class="o">)</span>
<span class="nd">@Data</span>
<span class="kd">public</span> <span class="kd">class</span> <span class="nc">User</span> <span class="o">{</span>

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


<p>And their corresponding Spring Data JPA repositories:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@Repository</span>
<span class="kd">public</span> <span class="kd">interface</span> <span class="nc">RoleRepository</span> <span class="kd">extends</span> <span class="nc">JpaRepository</span><span class="o">&lt;</span><span class="nc">Role</span><span class="o">,</span> <span class="nc">Long</span><span class="o">&gt;</span> <span class="o">{</span>
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



<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@Repository</span>
<span class="kd">public</span> <span class="kd">interface</span> <span class="nc">UserRepository</span> <span class="kd">extends</span> <span class="nc">JpaRepository</span><span class="o">&lt;</span><span class="nc">User</span><span class="o">,</span> <span class="nc">Long</span><span class="o">&gt;</span> <span class="o">{</span>
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


<p>Adds a controller to provide a server-side rendered page via Thymeleaf:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@Controller</span>
<span class="kd">public</span> <span class="kd">class</span> <span class="nc">MainController</span> <span class="o">{</span>

    <span class="nd">@RequestMapping</span><span class="o">(</span><span class="s">"/"</span><span class="o">)</span>
    <span class="kd">public</span> <span class="nc">String</span> <span class="nf">index</span><span class="o">()</span> <span class="o">{</span>
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


<p>And the <code>index.html</code> page itself on the <code>resources/templates</code> folder:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight html"><code><span class="cp">&lt;!DOCTYPE html&gt;</span>
<span class="nt">&lt;html</span> <span class="na">lang=</span><span class="s">"en"</span> <span class="na">xmlns:th=</span><span class="s">"http://www.thymeleaf.org"</span><span class="nt">&gt;</span>
<span class="nt">&lt;head&gt;</span>
    <span class="nt">&lt;link</span> <span class="na">href=</span><span class="s">'/webjars/bootstrap/css/bootstrap.min.css'</span> <span class="na">rel=</span><span class="s">'stylesheet'</span><span class="nt">&gt;</span>

    <span class="nt">&lt;meta</span> <span class="na">charset=</span><span class="s">"UTF-8"</span><span class="nt">&gt;</span>
    <span class="nt">&lt;title&gt;</span>Home<span class="nt">&lt;/title&gt;</span>
<span class="nt">&lt;/head&gt;</span>
<span class="nt">&lt;body&gt;</span>

<span class="nt">&lt;div</span> <span class="na">th:replace=</span><span class="s">"fragments/header :: header"</span><span class="nt">&gt;&lt;/div&gt;</span>

<span class="nt">&lt;script </span><span class="na">src=</span><span class="s">"/webjars/jquery/jquery.min.js"</span><span class="nt">&gt;&lt;/script&gt;</span>
<span class="nt">&lt;script </span><span class="na">src=</span><span class="s">"/webjars/bootstrap/js/bootstrap.min.js"</span><span class="nt">&gt;&lt;/script&gt;</span>
<span class="nt">&lt;/body&gt;</span>
<span class="nt">&lt;/html&gt;</span>
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


<p>Did you notice the <code>&lt;div th:replace...</code>? This is a neat feature of Thymeleaf to reuse code. Here it goes the reusable <code>header.html</code> on the <code>resources/templates/fragments</code> folder:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight html"><code><span class="cp">&lt;!DOCTYPE html&gt;</span>
<span class="nt">&lt;html</span> <span class="na">lang=</span><span class="s">"en"</span> <span class="na">xmlns:th=</span><span class="s">"http://www.thymeleaf.org"</span><span class="nt">&gt;</span>
<span class="nt">&lt;head&gt;</span>
    <span class="nt">&lt;link</span> <span class="na">href=</span><span class="s">'/webjars/bootstrap/css/bootstrap.min.css'</span> <span class="na">rel=</span><span class="s">'stylesheet'</span><span class="nt">&gt;</span>

    <span class="nt">&lt;meta</span> <span class="na">charset=</span><span class="s">"UTF-8"</span><span class="nt">&gt;</span>
    <span class="nt">&lt;title&gt;</span>Restaurants<span class="nt">&lt;/title&gt;</span>
<span class="nt">&lt;/head&gt;</span>
<span class="nt">&lt;body&gt;</span>

<span class="nt">&lt;nav</span> <span class="na">class=</span><span class="s">"navbar navbar-expand-lg navbar-dark bg-dark"</span> <span class="na">th:fragment=</span><span class="s">"header"</span><span class="nt">&gt;</span>
    <span class="nt">&lt;a</span> <span class="na">class=</span><span class="s">"navbar-brand"</span> <span class="na">href=</span><span class="s">"/"</span><span class="nt">&gt;</span>Home<span class="nt">&lt;/a&gt;</span>
    <span class="nt">&lt;button</span> <span class="na">aria-controls=</span><span class="s">"navbarSupportedContent"</span> <span class="na">aria-expanded=</span><span class="s">"false"</span> <span class="na">aria-label=</span><span class="s">"Toggle navigation"</span>
            <span class="na">class=</span><span class="s">"navbar-toggler"</span> <span class="na">data-target=</span><span class="s">"#navbarSupportedContent"</span> <span class="na">data-toggle=</span><span class="s">"collapse"</span> <span class="na">type=</span><span class="s">"button"</span><span class="nt">&gt;</span>
        <span class="nt">&lt;span</span> <span class="na">class=</span><span class="s">"navbar-toggler-icon"</span><span class="nt">&gt;&lt;/span&gt;</span>
    <span class="nt">&lt;/button&gt;</span>

    <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"collapse navbar-collapse"</span> <span class="na">id=</span><span class="s">"navbarSupportedContent"</span><span class="nt">&gt;</span>
        <span class="nt">&lt;ul</span> <span class="na">class=</span><span class="s">"navbar-nav mr-auto"</span><span class="nt">&gt;</span>
            <span class="nt">&lt;li</span> <span class="na">class=</span><span class="s">"nav-item dropdown"</span><span class="nt">&gt;</span>
                <span class="nt">&lt;a</span> <span class="na">aria-expanded=</span><span class="s">"false"</span> <span class="na">aria-haspopup=</span><span class="s">"true"</span> <span class="na">class=</span><span class="s">"nav-link dropdown-toggle"</span> <span class="na">data-toggle=</span><span class="s">"dropdown"</span>
                   <span class="na">href=</span><span class="s">"#"</span> <span class="na">id=</span><span class="s">"navbarDropdown"</span> <span class="na">role=</span><span class="s">"button"</span><span class="nt">&gt;</span>
                    Entities
                <span class="nt">&lt;/a&gt;</span>
                <span class="nt">&lt;div</span> <span class="na">aria-labelledby=</span><span class="s">"navbarDropdown"</span> <span class="na">class=</span><span class="s">"dropdown-menu"</span><span class="nt">&gt;</span>
                    <span class="nt">&lt;a</span> <span class="na">class=</span><span class="s">"dropdown-item"</span> <span class="na">href=</span><span class="s">"/users"</span><span class="nt">&gt;</span>Users<span class="nt">&lt;/a&gt;</span>
                    <span class="nt">&lt;a</span> <span class="na">class=</span><span class="s">"dropdown-item"</span> <span class="na">href=</span><span class="s">"/roles"</span><span class="nt">&gt;</span>Roles<span class="nt">&lt;/a&gt;</span>
                    <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"dropdown-divider"</span><span class="nt">&gt;&lt;/div&gt;</span>
                    <span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"dropdown-item-text p-4 text-muted"</span> <span class="na">style=</span><span class="s">"max-width: 200px;"</span><span class="nt">&gt;</span>
                        <span class="nt">&lt;p&gt;</span>
                            Administrative pages to list, edit, create and remove entities.
                        <span class="nt">&lt;/p&gt;</span>
                    <span class="nt">&lt;/div&gt;</span>
                <span class="nt">&lt;/div&gt;</span>
            <span class="nt">&lt;/li&gt;</span>
        <span class="nt">&lt;/ul&gt;</span>
        <span class="nt">&lt;form</span> <span class="na">class=</span><span class="s">"form-inline my-2 my-lg-0"</span><span class="nt">&gt;</span>
            <span class="nt">&lt;input</span> <span class="na">aria-label=</span><span class="s">"Search"</span> <span class="na">class=</span><span class="s">"form-control mr-sm-2"</span> <span class="na">placeholder=</span><span class="s">"Search"</span> <span class="na">type=</span><span class="s">"search"</span><span class="nt">&gt;</span>
            <span class="nt">&lt;button</span> <span class="na">class=</span><span class="s">"btn btn-outline-success my-2 my-sm-0"</span> <span class="na">type=</span><span class="s">"submit"</span><span class="nt">&gt;</span>Search<span class="nt">&lt;/button&gt;</span>
        <span class="nt">&lt;/form&gt;</span>
    <span class="nt">&lt;/div&gt;</span>
<span class="nt">&lt;/nav&gt;</span>

<span class="nt">&lt;script </span><span class="na">src=</span><span class="s">"/webjars/jquery/jquery.min.js"</span><span class="nt">&gt;&lt;/script&gt;</span>
<span class="nt">&lt;script </span><span class="na">src=</span><span class="s">"/webjars/bootstrap/js/bootstrap.min.js"</span><span class="nt">&gt;&lt;/script&gt;</span>
<span class="nt">&lt;/body&gt;</span>
<span class="nt">&lt;/html&gt;</span>
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
  <a name="commit-3-the-html-templates-for-the-entities" href="#commit-3-the-html-templates-for-the-entities">
  </a>
  Commit #3 - The HTML templates for the entities
</h1>

<p>Adds server-side-rendered templates and controllers. Templates provide basic html pages for Roles and Users.</p>

<p>This is the new <code>RoleController</code>:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@Controller</span>
<span class="kd">public</span> <span class="kd">class</span> <span class="nc">RoleController</span> <span class="o">{</span>

    <span class="nd">@GetMapping</span><span class="o">(</span><span class="s">"/roles"</span><span class="o">)</span>
    <span class="kd">public</span> <span class="nc">String</span> <span class="nf">rolesPage</span><span class="o">()</span> <span class="o">{</span>
        <span class="k">return</span> <span class="s">"roles"</span><span class="o">;</span>
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


<p>And the <code>UserController</code>:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@Controller</span>
<span class="kd">public</span> <span class="kd">class</span> <span class="nc">UserController</span> <span class="o">{</span>

    <span class="nd">@GetMapping</span><span class="o">(</span><span class="s">"/users"</span><span class="o">)</span>
    <span class="kd">public</span> <span class="nc">String</span> <span class="nf">users</span><span class="o">()</span> <span class="o">{</span>
        <span class="k">return</span> <span class="s">"users"</span><span class="o">;</span>
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


<p>The HTML for the <code>roles.html</code> page:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight html"><code><span class="cp">&lt;!DOCTYPE html&gt;</span>
<span class="nt">&lt;html</span> <span class="na">lang=</span><span class="s">"en"</span> <span class="na">xmlns:th=</span><span class="s">"http://www.thymeleaf.org"</span><span class="nt">&gt;</span>
<span class="nt">&lt;head&gt;</span>
    <span class="nt">&lt;link</span> <span class="na">href=</span><span class="s">'/webjars/bootstrap/css/bootstrap.min.css'</span> <span class="na">rel=</span><span class="s">'stylesheet'</span><span class="nt">&gt;</span>

    <span class="nt">&lt;meta</span> <span class="na">charset=</span><span class="s">"UTF-8"</span><span class="nt">&gt;</span>
    <span class="nt">&lt;title&gt;</span>Roles<span class="nt">&lt;/title&gt;</span>
<span class="nt">&lt;/head&gt;</span>
<span class="nt">&lt;body&gt;</span>

<span class="nt">&lt;div</span> <span class="na">th:replace=</span><span class="s">"fragments/header :: header"</span><span class="nt">&gt;&lt;/div&gt;</span>

<span class="nt">&lt;br&gt;&lt;br&gt;</span>

<span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"container"</span> <span class="na">id=</span><span class="s">"main"</span><span class="nt">&gt;</span>

    <span class="nt">&lt;table</span> <span class="na">class=</span><span class="s">"table table-striped table-bordered"</span><span class="nt">&gt;</span>
        <span class="nt">&lt;thead&gt;</span>
        <span class="nt">&lt;tr&gt;</span>
            <span class="nt">&lt;th&gt;</span>Role ID<span class="nt">&lt;/th&gt;</span>
            <span class="nt">&lt;th&gt;</span>Role Name<span class="nt">&lt;/th&gt;</span>
            <span class="nt">&lt;th&gt;</span>Actions<span class="nt">&lt;/th&gt;</span>
        <span class="nt">&lt;/tr&gt;</span>
        <span class="nt">&lt;/thead&gt;</span>
        <span class="nt">&lt;tbody&gt;</span>
        <span class="nt">&lt;tr&gt;</span>
            <span class="nt">&lt;td&gt;&lt;/td&gt;</span>
            <span class="nt">&lt;td&gt;&lt;/td&gt;</span>
            <span class="nt">&lt;td&gt;</span>
                <span class="nt">&lt;a&gt;</span>Edit<span class="nt">&lt;/a&gt;</span>
                <span class="nt">&lt;a&gt;</span>Delete<span class="nt">&lt;/a&gt;</span>
            <span class="nt">&lt;/td&gt;</span>
        <span class="nt">&lt;/tr&gt;</span>
        <span class="nt">&lt;/tbody&gt;</span>
    <span class="nt">&lt;/table&gt;</span>
<span class="nt">&lt;/div&gt;</span>

<span class="nt">&lt;script </span><span class="na">src=</span><span class="s">"/webjars/jquery/jquery.min.js"</span><span class="nt">&gt;&lt;/script&gt;</span>
<span class="nt">&lt;script </span><span class="na">src=</span><span class="s">"/webjars/bootstrap/js/bootstrap.min.js"</span><span class="nt">&gt;&lt;/script&gt;</span>
<span class="nt">&lt;/body&gt;</span>
<span class="nt">&lt;/html&gt;</span>
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


<p>And <code>users.html</code> page:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight html"><code><span class="cp">&lt;!DOCTYPE html&gt;</span>
<span class="nt">&lt;html</span> <span class="na">lang=</span><span class="s">"en"</span> <span class="na">xmlns:th=</span><span class="s">"http://www.thymeleaf.org"</span><span class="nt">&gt;</span>
<span class="nt">&lt;head&gt;</span>
    <span class="nt">&lt;link</span> <span class="na">href=</span><span class="s">'/webjars/bootstrap/css/bootstrap.min.css'</span> <span class="na">rel=</span><span class="s">'stylesheet'</span><span class="nt">&gt;</span>

    <span class="nt">&lt;meta</span> <span class="na">charset=</span><span class="s">"UTF-8"</span><span class="nt">&gt;</span>
    <span class="nt">&lt;title&gt;</span>Users<span class="nt">&lt;/title&gt;</span>
<span class="nt">&lt;/head&gt;</span>
<span class="nt">&lt;body&gt;</span>

<span class="nt">&lt;div</span> <span class="na">th:replace=</span><span class="s">"fragments/header :: header"</span><span class="nt">&gt;&lt;/div&gt;</span>

<span class="nt">&lt;br&gt;&lt;br&gt;</span>

<span class="nt">&lt;div</span> <span class="na">class=</span><span class="s">"container"</span> <span class="na">id=</span><span class="s">"main"</span><span class="nt">&gt;</span>

    <span class="nt">&lt;table</span> <span class="na">class=</span><span class="s">"table table-striped table-bordered"</span><span class="nt">&gt;</span>
        <span class="nt">&lt;thead&gt;</span>
        <span class="nt">&lt;tr&gt;</span>
            <span class="nt">&lt;th&gt;</span>First Name<span class="nt">&lt;/th&gt;</span>
            <span class="nt">&lt;th&gt;</span>Last Name<span class="nt">&lt;/th&gt;</span>
            <span class="nt">&lt;th&gt;</span>Role<span class="nt">&lt;/th&gt;</span>
            <span class="nt">&lt;th&gt;</span>Actions<span class="nt">&lt;/th&gt;</span>
        <span class="nt">&lt;/tr&gt;</span>
        <span class="nt">&lt;/thead&gt;</span>
        <span class="nt">&lt;tbody&gt;</span>
        <span class="nt">&lt;tr&gt;</span>
            <span class="nt">&lt;td&gt;&lt;/td&gt;</span>
            <span class="nt">&lt;td&gt;&lt;/td&gt;</span>
            <span class="nt">&lt;td&gt;&lt;/td&gt;</span>
            <span class="nt">&lt;td&gt;</span>
                <span class="nt">&lt;a&gt;</span>Edit<span class="nt">&lt;/a&gt;</span>
                <span class="nt">&lt;a&gt;</span>Delete<span class="nt">&lt;/a&gt;</span>
            <span class="nt">&lt;/td&gt;</span>
        <span class="nt">&lt;/tr&gt;</span>
        <span class="nt">&lt;/tbody&gt;</span>
    <span class="nt">&lt;/table&gt;</span>
<span class="nt">&lt;/div&gt;</span>

<span class="nt">&lt;script </span><span class="na">src=</span><span class="s">"/webjars/jquery/jquery.min.js"</span><span class="nt">&gt;&lt;/script&gt;</span>
<span class="nt">&lt;script </span><span class="na">src=</span><span class="s">"/webjars/bootstrap/js/bootstrap.min.js"</span><span class="nt">&gt;&lt;/script&gt;</span>
<span class="nt">&lt;/body&gt;</span>
<span class="nt">&lt;/html&gt;</span>
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
  <a name="commit-4-the-vue-magic" href="#commit-4-the-vue-magic">
  </a>
  Commit #4 - The Vue magic
</h1>

<p>Now we add Vue and Axios to the <code>pom.xml</code> file:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight xml"><code><span class="nt">&lt;dependency&gt;</span>
    <span class="nt">&lt;groupId&gt;</span>org.webjars<span class="nt">&lt;/groupId&gt;</span>
    <span class="nt">&lt;artifactId&gt;</span>vue<span class="nt">&lt;/artifactId&gt;</span>
    <span class="nt">&lt;version&gt;</span>2.6.11<span class="nt">&lt;/version&gt;</span>
<span class="nt">&lt;/dependency&gt;</span>
<span class="nt">&lt;dependency&gt;</span>
    <span class="nt">&lt;groupId&gt;</span>org.webjars.npm<span class="nt">&lt;/groupId&gt;</span>
    <span class="nt">&lt;artifactId&gt;</span>axios<span class="nt">&lt;/artifactId&gt;</span>
    <span class="nt">&lt;version&gt;</span>0.19.0<span class="nt">&lt;/version&gt;</span>
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


<p>Then a REST controller (this serializes the response to JSON by default) to return a list of Roles:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@RestController</span>
<span class="nd">@RequestMapping</span><span class="o">(</span><span class="s">"/api/v1"</span><span class="o">)</span>
<span class="kd">public</span> <span class="kd">class</span> <span class="nc">RolesController</span> <span class="o">{</span>

    <span class="kd">private</span> <span class="kd">final</span> <span class="nc">RoleRepository</span> <span class="n">roleRepository</span><span class="o">;</span>

    <span class="kd">public</span> <span class="nf">RolesController</span><span class="o">(</span><span class="nc">RoleRepository</span> <span class="n">roleRepository</span><span class="o">)</span> <span class="o">{</span>
        <span class="k">this</span><span class="o">.</span><span class="na">roleRepository</span> <span class="o">=</span> <span class="n">roleRepository</span><span class="o">;</span>
    <span class="o">}</span>

    <span class="nd">@GetMapping</span><span class="o">(</span><span class="s">"roles"</span><span class="o">)</span>
    <span class="kd">public</span> <span class="nc">List</span><span class="o">&lt;</span><span class="nc">Role</span><span class="o">&gt;</span> <span class="nf">list</span><span class="o">()</span> <span class="o">{</span>
        <span class="k">return</span> <span class="n">roleRepository</span><span class="o">.</span><span class="na">findAll</span><span class="o">();</span>
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


<p>And another one for Users:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight java"><code><span class="nd">@RestController</span>
<span class="nd">@RequestMapping</span><span class="o">(</span><span class="s">"/api/v1"</span><span class="o">)</span>
<span class="kd">public</span> <span class="kd">class</span> <span class="nc">UsersController</span> <span class="o">{</span>

    <span class="kd">private</span> <span class="kd">final</span> <span class="nc">UserRepository</span> <span class="n">userRepository</span><span class="o">;</span>

    <span class="kd">public</span> <span class="nf">UsersController</span><span class="o">(</span><span class="nc">UserRepository</span> <span class="n">userRepository</span><span class="o">)</span> <span class="o">{</span>
        <span class="k">this</span><span class="o">.</span><span class="na">userRepository</span> <span class="o">=</span> <span class="n">userRepository</span><span class="o">;</span>
    <span class="o">}</span>

    <span class="nd">@GetMapping</span><span class="o">(</span><span class="s">"/users"</span><span class="o">)</span>
    <span class="kd">public</span> <span class="nc">List</span><span class="o">&lt;</span><span class="nc">User</span><span class="o">&gt;</span> <span class="nf">list</span><span class="o">()</span> <span class="o">{</span>
        <span class="k">return</span> <span class="n">userRepository</span><span class="o">.</span><span class="na">findAll</span><span class="o">();</span>
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


<p>Finally, on the <code>roles.html</code> we edit the section where we want Vue.js to render the data and add a script:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight html"><code><span class="c">&lt;!-- unrelated code omitted for brevity --&gt;</span>
<span class="nt">&lt;tr</span> <span class="na">v-for=</span><span class="s">"role in roles"</span><span class="nt">&gt;</span>
    <span class="nt">&lt;td&gt;</span>{{ role.id }}<span class="nt">&lt;/td&gt;</span>
    <span class="nt">&lt;td&gt;</span>{{ role.name }}<span class="nt">&lt;/td&gt;</span>
<span class="c">&lt;!-- unrelated code omitted for brevity --&gt;</span>
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



<div class="highlight js-code-highlight">
<pre class="highlight javascript"><code><span class="c">&lt;!--</span> <span class="nx">Vue</span><span class="p">.</span><span class="nx">js</span> <span class="nx">imports</span> <span class="o">--&gt;</span>
<span class="o">&lt;</span><span class="nx">script</span> <span class="nx">src</span><span class="o">=</span><span class="dl">"</span><span class="s2">webjars/vue/vue.min.js</span><span class="dl">"</span><span class="o">&gt;&lt;</span><span class="sr">/script</span><span class="err">&gt;
</span><span class="o">&lt;</span><span class="nx">script</span> <span class="nx">src</span><span class="o">=</span><span class="dl">"</span><span class="s2">webjars/axios/dist/axios.min.js</span><span class="dl">"</span><span class="o">&gt;&lt;</span><span class="sr">/script</span><span class="err">&gt;
</span><span class="c">&lt;!--</span> <span class="nx">Actual</span> <span class="nx">Vue</span><span class="p">.</span><span class="nx">js</span> <span class="nx">script</span> <span class="o">--&gt;</span>
<span class="o">&lt;</span><span class="nx">script</span><span class="o">&gt;</span>
    <span class="kd">var</span> <span class="nx">app</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">Vue</span><span class="p">({</span>
        <span class="na">el</span><span class="p">:</span> <span class="dl">'</span><span class="s1">#main</span><span class="dl">'</span><span class="p">,</span>
        <span class="nx">data</span><span class="p">()</span> <span class="p">{</span>
            <span class="k">return</span> <span class="p">{</span>
                <span class="na">roles</span><span class="p">:</span> <span class="kc">null</span>
            <span class="p">}</span>
        <span class="p">},</span>
        <span class="nx">mounted</span><span class="p">(){</span>
            <span class="nx">axios</span>
                <span class="p">.</span><span class="kd">get</span><span class="p">(</span><span class="dl">"</span><span class="s2">/api/v1/roles</span><span class="dl">"</span><span class="p">)</span>
                <span class="p">.</span><span class="nx">then</span><span class="p">(</span><span class="nx">response</span> <span class="o">=&gt;</span> <span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="nx">roles</span> <span class="o">=</span> <span class="nx">response</span><span class="p">.</span><span class="nx">data</span><span class="p">))</span>
        <span class="p">},</span>
    <span class="p">})</span>
<span class="o">&lt;</span><span class="sr">/script</span><span class="err">&gt;
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


<p>The same modifications are made on the <code>users.html</code>:<br>
</p>
<div class="highlight js-code-highlight">
<pre class="highlight html"><code><span class="c">&lt;!-- unrelated code omitted for brevity --&gt;</span>
<span class="nt">&lt;tr</span> <span class="na">v-for=</span><span class="s">"user in users"</span><span class="nt">&gt;</span>
    <span class="nt">&lt;td&gt;</span>{{ user.firstName }}<span class="nt">&lt;/td&gt;</span>
    <span class="nt">&lt;td&gt;</span>{{ user.lastName }}<span class="nt">&lt;/td&gt;</span>
    <span class="nt">&lt;td&gt;</span>{{ user.role.name }}<span class="nt">&lt;/td&gt;</span>
<span class="c">&lt;!-- unrelated code omitted for brevity --&gt;</span>
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



<div class="highlight js-code-highlight">
<pre class="highlight javascript"><code><span class="c">&lt;!--</span> <span class="nx">Vue</span><span class="p">.</span><span class="nx">js</span> <span class="nx">imports</span> <span class="o">--&gt;</span>
<span class="o">&lt;</span><span class="nx">script</span> <span class="nx">src</span><span class="o">=</span><span class="dl">"</span><span class="s2">webjars/vue/vue.min.js</span><span class="dl">"</span><span class="o">&gt;&lt;</span><span class="sr">/script</span><span class="err">&gt;
</span><span class="o">&lt;</span><span class="nx">script</span> <span class="nx">src</span><span class="o">=</span><span class="dl">"</span><span class="s2">webjars/axios/dist/axios.min.js</span><span class="dl">"</span><span class="o">&gt;&lt;</span><span class="sr">/script</span><span class="err">&gt;
</span><span class="c">&lt;!--</span> <span class="nx">Actual</span> <span class="nx">Vue</span><span class="p">.</span><span class="nx">js</span> <span class="nx">script</span> <span class="o">--&gt;</span>
<span class="o">&lt;</span><span class="nx">script</span><span class="o">&gt;</span>
    <span class="kd">var</span> <span class="nx">app</span> <span class="o">=</span> <span class="k">new</span> <span class="nx">Vue</span><span class="p">({</span>
        <span class="na">el</span><span class="p">:</span> <span class="dl">'</span><span class="s1">#main</span><span class="dl">'</span><span class="p">,</span>
        <span class="nx">data</span><span class="p">()</span> <span class="p">{</span>
            <span class="k">return</span> <span class="p">{</span>
                <span class="na">users</span><span class="p">:</span> <span class="kc">null</span>
            <span class="p">}</span>
        <span class="p">},</span>
        <span class="nx">mounted</span><span class="p">(){</span>
            <span class="nx">axios</span>
                <span class="p">.</span><span class="kd">get</span><span class="p">(</span><span class="dl">"</span><span class="s2">/api/v1/users</span><span class="dl">"</span><span class="p">)</span>
                <span class="p">.</span><span class="nx">then</span><span class="p">(</span><span class="nx">response</span> <span class="o">=&gt;</span> <span class="p">(</span><span class="k">this</span><span class="p">.</span><span class="nx">users</span> <span class="o">=</span> <span class="nx">response</span><span class="p">.</span><span class="nx">data</span><span class="p">))</span>
        <span class="p">},</span>
    <span class="p">})</span>
<span class="o">&lt;</span><span class="sr">/script</span><span class="err">&gt;
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

<h1>
  <a name="beginners-tag" href="#beginners-tag">
  </a>
  Beginners tag
</h1>

<p>I'm using this tag for the second time. Since there are rules to use it, please let me know if there's something here you (or a beginner) don't understand or that I took for granted and you're (or a beginner may be :) confused about it.</p>


<hr>

<p>Image by <a href="https://pixabay.com/pt/users/jaykingsta14-4885997/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2358636">Jason King</a> por <a href="https://pixabay.com/pt/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2358636">Pixabay</a></p>...