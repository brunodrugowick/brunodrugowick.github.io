---
layout: post
title:  "Using JPQL on orm.xml file with Spring Data JPA"
date:   2020-02-11T01:06:39Z
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

<code>[spring, jpa, repository, xml]</code>
<div class=card>
	  <div class=container>
	    <h4><b><br>You'll have a better experience reading in DEV</b></h4>
	    <p><a href="https://dev.to/brunodrugowick/using-jpql-on-orm-xml-file-with-spring-data-jpa-39ej" target="_blank">Click here to continue reading this post there >></a></p>
	    <p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/using-jpql-on-orm-xml-file-with-spring-data-jpa-39ej" target="_blank">read more</a>.</p>
	    <p>You can continue to read here too, it's up to you... =]</p>
	  </div>
	</div><br>
<p>This is the post #5 of the series "Querying your Spring Data JPA Repository".</p>

<p>And this is a quick one.</p>

<h1>
  <a name="remember-our-jpql" href="#remember-our-jpql">
  </a>
  Remember our JPQL?
</h1>

<p>Yeah, what if for some reason you want to externalize the query to a XML file. Why, you ask? Well, I'm not sure. More on that at the end of this post.</p>

<h1>
  <a name="just-put-it-on-a-ormxml-file" href="#just-put-it-on-a-ormxml-file">
  </a>
  Just put it on a orm.xml file!
</h1>

<p>The file must be at <code>resources/META-INF/orm.xml</code>:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight xml"><code><span class="cp">&lt;?xml version="1.0" encoding="UTF-8"?&gt;</span>
<span class="nt">&lt;entity-mappings</span>
        <span class="na">xmlns:xsi=</span><span class="s">"http://www.w3.org/2001/XMLSchema-instance"</span>
        <span class="na">xmlns=</span><span class="s">"http://xmlns.jcp.org/xml/ns/persistence/orm"</span>
        <span class="na">version=</span><span class="s">"2.2"</span><span class="nt">&gt;</span>

    <span class="nt">&lt;named-query</span> <span class="na">name=</span><span class="s">"Restaurant.activeGrabngoByCity"</span><span class="nt">&gt;</span>
        <span class="nt">&lt;query&gt;</span>from Restaurant r where r.active = true and r.grabngo = true and r.city like concat('%', :city, '%')<span class="nt">&lt;/query&gt;</span>
    <span class="nt">&lt;/named-query&gt;</span>

    <span class="c">&lt;!-- You can have more...
    &lt;named-query name="Restaurant.otherMethodName"&gt;
        &lt;query&gt;from Restaurant where whatever ... &lt;/query&gt;
    &lt;/named-query&gt;
    --&gt;</span>

<span class="nt">&lt;/entity-mappings&gt;</span>

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


<p>As always, let's highlight some things:</p>

<ul>
<li>The <code>entity-mappings</code> tag must be exactly what you see here. Just copy and paste this part.</li>
<li>The attribute <code>name</code> on the tag <code>named-query</code> specifies the method the query will relate to. Whenever the method is called this JPA query is executed.</li>
<li>The query had to go over a small change, did you notice? We added a <code>concat</code> to form the last portion of the <code>where</code>clause. Without it an <code>unexpected token: %</code> error would be thrown.</li>
</ul>

<p>You'd also have to change other things, like replace <code>&lt;</code> with <code>&amp;lt;</code> and <code>&gt;</code> with <code>&amp;gt;</code>, which is the way to use those characters in XML.</p>
<h1>
  <a name="the-benefit" href="#the-benefit">
  </a>
  The benefit
</h1>

<p>I can think of one benefit which is the ability to change the query without recompiling the application. This is questionable, though, but... well... it's possible.</p>

<p>To be honest here, there's way more you can do on this file related to persistence and JPA. In fact, you could configure everything JPA-related on this file and ditch annotations. Everybody, though, is moving out from XML-based configuration to Annotations-based configuration.</p>

<p>Yet, this is still something to learn, I believe. I just like how complicated things get over time, and this is one manifestation of this complexity.</p>
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

<p>There's only <a href="https://github.com/brunodrugowick/jpa-queries-blog-post/commit/8548e75043ede44252d2c9514c6c12e7993b32a6">this</a> (and I promptly reverted afterwards).</p>


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