---
layout: post
title:  "Distributed Tracing with Spring Cloud Sleuth and Zipkin - AQAP Series"
date:   2020-07-26T14:11:39Z
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

<code>[spring, cloud, sleuth, zipkin]</code>
<div class=card>
	  <div class=container>
	    <h4><b><br>You'll have a better experience reading in DEV</b></h4>
	    <p><a href="https://dev.to/brunodrugowick/distributed-tracing-with-spring-cloud-sleuth-and-zipkin-3moo" target="_blank">Click here to continue reading this post there >></a></p>
	    <p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/distributed-tracing-with-spring-cloud-sleuth-and-zipkin-3moo" target="_blank">read more</a>.</p>
	    <p>You can continue to read here too, it's up to you... =]</p>
	  </div>
	</div><br>
<p>There's a lot going on related to cloud services, libraries, providers etc. In fact, everything cloud-related gets a lot of attention right now.</p>

<p>One thing I wanted to try was distribute tracing. Spring has a very interesting project under the <a href="https://spring.io/projects/spring-cloud">Spring Cloud umbrella</a>, called <a href="https://spring.io/projects/spring-cloud-sleuth">Spring Cloud Sleuth</a>, that auto-configures your app to work with distributed tracing tools.</p>

<p>Together with this project you have Spring Cloud Zipkin Client that takes your instrumented log information and sends it to a Zipkin server. The server provides a clean and easy to use interface to understand the relationships between your services.</p>

<h1>
  <a name="the-demo" href="#the-demo">
  </a>
  The Demo
</h1>

<h2>
  <a name="description" href="#description">
  </a>
  Description
</h2>

<p>To explore the projects I developed 3 "layers" of services that talk to each other. The first layer contain only one service (service-one) and requests data from the second layer, comprised of two services (service-two, service-three).</p>

<p>At this point we can talk about Spring Cloud Load Balancer. This project is used to configure client-side load-balancing on the service-one for the second layer of services. The picture below shows how the services relate to each other.</p>

<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--BICIKCpv--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/5xnwc1qg4woi79wpxrvg.png" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--BICIKCpv--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/5xnwc1qg4woi79wpxrvg.png" alt="Service dependency view" loading="lazy" width="880" height="229"></a></p>

<p>Any service of the second layer then calls the service from the third layer (service-four). The list of services the request went through is put together and returned to the client by service-one. </p>

<p>The two possible responses to a call to <code>service-one/info</code> are:<br>
</p>

<div class="highlight js-code-highlight">
<pre class="highlight json"><code><span class="err">//Using</span><span class="w"> </span><span class="err">service-two</span><span class="w"> </span><span class="err">on</span><span class="w"> </span><span class="err">the</span><span class="w"> </span><span class="err">second</span><span class="w"> </span><span class="err">layer</span><span class="w">

</span><span class="p">{</span><span class="w">
  </span><span class="nl">"info"</span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
    </span><span class="nl">"Service 4"</span><span class="p">:</span><span class="w"> </span><span class="s2">"Wow, request arrived this far!"</span><span class="p">,</span><span class="w">
    </span><span class="nl">"Service 2"</span><span class="p">:</span><span class="w"> </span><span class="s2">"ok"</span><span class="p">,</span><span class="w">
    </span><span class="nl">"Service 1"</span><span class="p">:</span><span class="w"> </span><span class="s2">"ok"</span><span class="w">
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



<div class="highlight js-code-highlight">
<pre class="highlight json"><code><span class="err">//Using</span><span class="w"> </span><span class="err">service-three</span><span class="w"> </span><span class="err">on</span><span class="w"> </span><span class="err">the</span><span class="w"> </span><span class="err">second</span><span class="w"> </span><span class="err">layer</span><span class="w">

</span><span class="p">{</span><span class="w">
  </span><span class="nl">"info"</span><span class="p">:</span><span class="w"> </span><span class="p">{</span><span class="w">
    </span><span class="nl">"Service 4"</span><span class="p">:</span><span class="w"> </span><span class="s2">"Wow, request arrived this far!"</span><span class="p">,</span><span class="w">
    </span><span class="nl">"Service 3"</span><span class="p">:</span><span class="w"> </span><span class="s2">"ok"</span><span class="p">,</span><span class="w">
    </span><span class="nl">"Service 1"</span><span class="p">:</span><span class="w"> </span><span class="s2">"ok"</span><span class="w">
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


<p>Service-one will unevenly load-balance between service-two and service-three because there's a <code>Thread.sleep(200)</code> on service-three.</p>

<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--QjEAIYiU--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/14at6y5qpnt446ildrtd.png" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--QjEAIYiU--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/14at6y5qpnt446ildrtd.png" alt="Uneven balancing" loading="lazy" width="781" height="356"></a></p>
<h2>
  <a name="running" href="#running">
  </a>
  Running
</h2>

<p>To make it easy to run your own tests and see the distributed tracing in action, I've prepared a repository with the four services described above and a <code>.jar</code> for the Zipkin server.</p>


<div class="ltag-github-readme-tag">
  <div class="readme-overview">
    <h2>
      <img src="https://res.cloudinary.com/practicaldev/image/fetch/s--566lAguM--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev.to/assets/github-logo-5a155e1f9a670af7944dd5e12375bc76ed542ea80224905ecaf878b9157cdefc.svg" alt="GitHub logo" loading="lazy">
      <a href="https://github.com/brunodrugowick">
        brunodrugowick
      </a> / <a style="font-weight: 600;" href="https://github.com/brunodrugowick/distributed-tracing-demo">
        distributed-tracing-demo
      </a>
    </h2>
    <h3>
      A demonstration of the usage of Spring Cloud Sleuth and Zipkin to trace requests across Spring Boot services.
    </h3>
  </div>
</div>



<p>Clone it and just run <code>/scripts/start-all.sh</code>. If you have Java 11 and Apache Bench (and a GNU/Linux operating system), everything runs and perform 10 thousand requests to fill your Zipkin server with some data.</p>

<h2>
  <a name="the-trace" href="#the-trace">
  </a>
  The trace
</h2>

<p>After waiting for a couple of minutes for the tests to run, the script instructs you to go to <code>http://localhost:9411</code>. Let's explore it a bit...</p>

<h3>
  <a name="zipkin-server" href="#zipkin-server">
  </a>
  Zipkin server
</h3>

<p>After searching for traces by clicking on the search icon, that's what the homepage looks like:</p>

<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--0Hw9Q2QD--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/mec8314g16bbpqabjckb.png" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--0Hw9Q2QD--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/mec8314g16bbpqabjckb.png" alt="Zipkin homepage" loading="lazy" width="880" height="433"></a></p>

<p>A very useful feature is the ability to filter traces based on the service name:</p>

<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--dWmjtUQM--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/koifoffbxrgv1bi1dvxl.png" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--dWmjtUQM--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/koifoffbxrgv1bi1dvxl.png" alt="Filter by service name" loading="lazy" width="687" height="328"></a></p>

<p>Inspecting a trace gives you this view, where you can easily see how long the request took in every service:</p>

<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--M7CZKWeh--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/62qy4wu44lmlrpxiqq4o.png" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--M7CZKWeh--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/62qy4wu44lmlrpxiqq4o.png" alt="Inspecting one trace" loading="lazy" width="880" height="220"></a></p>

<p>Finally, a very useful feature is understand your services dependencies using the Dependencies Page. Make sure you select a Start and End time and click the magnifier glass icon:</p>

<p><a href="https://res.cloudinary.com/practicaldev/image/fetch/s--M_rD4qHV--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/kfdv77n00bd4zcsaqsdb.png" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--M_rD4qHV--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://dev-to-uploads.s3.amazonaws.com/i/kfdv77n00bd4zcsaqsdb.png" alt="Dependencies page" loading="lazy" width="880" height="432"></a></p>

<h1>
  <a name="aqap-series" href="#aqap-series">
  </a>
  AQAP Series
</h1>

<p>As Quickly As Possible (AQAP) is a series of quick posts on something I find interesting. I encourage (and take part on) the discussions on the comments to further explore the technology, library or code quickly explained here.</p>


<hr>

<p>Image by <a href="https://pixabay.com/pt/users/jaykingsta14-4885997/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2358636">Jason King</a> por <a href="https://pixabay.com/pt/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=2358636">Pixabay</a></p>...