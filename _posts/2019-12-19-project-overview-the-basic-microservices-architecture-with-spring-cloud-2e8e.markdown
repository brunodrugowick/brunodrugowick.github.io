---
layout: post
title:  "Project Overview: the Basic Microservices Architecture with Spring Cloud"
date:   2019-12-19T05:03:49Z
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

<code>[microservices, java, spring, cloud]</code>
<div class=card>
	  <div class=container>
	    <h4><b><br>You'll have a better experience reading in DEV</b></h4>
	    <p><a href="https://dev.to/brunodrugowick/project-overview-the-basic-microservices-architecture-with-spring-cloud-2e8e" target="_blank">Click here to continue reading this post there >></a></p>
	    <p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/project-overview-the-basic-microservices-architecture-with-spring-cloud-2e8e" target="_blank">read more</a>.</p>
	    <p>You can continue to read here too, it's up to you... =]</p>
	  </div>
	</div><br>
<p>This post presents the basic architecture of an online flower shop in a microservices architecture. I have no intention to provide detailed information on each component on this post.</p>

<p>I do provide a working example of a microservices application based on <a href="https://spring.io/projects/spring-cloud">Spring Cloud</a> project. I also provide a basic explanation of the components' responsibilities and how they achieve that, which I believe is a good way to understand the microservices architecture.</p>

<h2>
  <a name="components" href="#components">
  </a>
  Components
</h2>

<h3>
  <a name="store-front" href="#store-front">
  </a>
  Store Front
</h3>

<p><code>storefront</code> folder on the repository.</p>

<ul>
<li>The Store itself, like a website (although here it's just an API) where a user buys flowers and stuff.</li>
<li>Balances the requests to suppliers and carriers locally (client-side load-balancing) by fetching and caching Eureka server information (ribbon).</li>
<li>Uses Hystrix to control timeout on methods that use other microservices.</li>
<li>Uses Bulkhead (from Hystrix) to separate a group of threads for each operation managed by Hystrix.</li>
<li>Controls the integration with other microservices (using states).

<ul>
<li>RECEIVED: order created on the <code>storefront</code> microservice.</li>
<li>SUPPLIER_ORDER_CREATED: order incremented with information from the <code>supplier</code> microservice.</li>
<li>CARRIER_VOUCHER_CREATED: order incremented with information from the <code>carrier</code> microservice.</li>
</ul>


</li>
<li>Integrates with the authentication server.</li>
<li>Forwards authentication headers to other microservices with a RequestInterceptor bean.</li>
</ul>

<h3>
  <a name="supplier" href="#supplier">
  </a>
  Supplier
</h3>

<p><code>supplier</code> folder on the repository.</p>

<ul>
<li>Someone who provides products on different locations.</li>
<li>Provides Orders to the <code>storefront</code> component.</li>
<li>Integrates with the authentication server.</li>
</ul>

<h3>
  <a name="carrier" href="#carrier">
  </a>
  Carrier
</h3>

<p><code>carrier</code> folder on the repository.</p>

<ul>
<li>Someone who delivers stuff to clients from the suppliers.</li>
<li>Provides Vouchers to the <code>storefront</code> component.</li>
<li>Integrates with the authentication server.</li>
</ul>

<h3>
  <a name="authentication-server" href="#authentication-server">
  </a>
  Authentication Server
</h3>

<p><code>auth-service</code> folder on the repository.</p>

<ul>
<li>This is an OAuth server tying together Spring Security and Spring Cloud OAuth2.</li>
<li>Spring Security configures a user (hardcoded =).</li>
<li>Spring Cloud OAuth2 configures a client of the authorization server, the <code>storefront</code> (hardcoded =).</li>
</ul>

<h3>
  <a name="api-gateway" href="#api-gateway">
  </a>
  API Gateway
</h3>

<p><code>zuul-api-gateway</code> folder on the repository.</p>

<ul>
<li>Clients make requests for the API Gateway, which then redirects to the correct microservice for the request.</li>
<li>Implemented with Netflix Zuul.</li>
<li>Integrates (automatically) with Eureka to get microservices instances.</li>
<li>Does client-side load balancing with Ribbon automatically.</li>
</ul>

<h3>
  <a name="eureka-server" href="#eureka-server">
  </a>
  Eureka server
</h3>

<p><code>eureka-server</code> folder.</p>

<ul>
<li>Handles service registry and discovery.</li>
<li>Every component registers itself here.</li>
<li>Balancing is on the client, <del>via a RestTemplate bean configured to use Eureka server as a client</del> (this was replaced by the FeignClient. See older commits to understand how to configure a RestTemplate to work with Eureka Client).</li>
<li>Balancing is on the client through FeignClient, which is auto-configured on each application to balance requests when eureka client is being used.</li>
</ul>

<h3>
  <a name="config-server" href="#config-server">
  </a>
  Config Server
</h3>

<p><code>config-server</code> folder.</p>

<ul>
<li>Provides configuration to the microservices.  The <code>config-repo</code> folder is used to store the configuration files.</li>
</ul>

<h3>
  <a name="other-stuff" href="#other-stuff">
  </a>
  Other Stuff
</h3>

<ul>
<li>I've configured to log to papertrail (a log aggregator as a service) and used Spring Cloud Sleuth to add a traceId to every user request, being able to trace  the request across microservices.</li>
<li>The logback.xml on each "domain" microservice does the magic. This will stop working after a while, so provide your own configuration for logback...</li>
</ul>

<h2>
  <a name="handson" href="#handson">
  </a>
  Hands-on!
</h2>

<ol>
<li>Clone/fork <a href="https://github.com/brunodrugowick/microservices-flowershop">this GitHub repository</a>.</li>
<li>Import everything on <a href="https://spring.io/tools">STS</a>.</li>
<li>Provide the following configurations:

<ul>
<li>configure the config-server <code>application.yml</code> file with at least the <code>search-locations</code> property. You may change to the location of your own config repo on your local machine or use the commented configuration to use a github repository.</li>
<li>provide a MariaDB instance running with the following schemas already created: supplier; storefront; </li>
<li>Note: you can configure the database, connection info and schema name on the configuration files on the config-server.</li>
</ul>
</li>
<li>Run each of them separately using <code>./mvnw spring-boot:run</code> on each folder OR the Boot Dashboard on STS.</li>
</ol>

<h2>
  <a name="test-stuff" href="#test-stuff">
  </a>
  Test Stuff
</h2>

<p>There's a <a href="https://github.com/brunodrugowick/microservices-flowershop/blob/master/README/cartRequests.jmx">cartRequests.jmx</a> to be imported on <a href="https://jmeter.apache.org/">JMeter</a> and test Hystrix. Ask me if you want to know more about it.</p>

<p>There's also a <a href="https://github.com/brunodrugowick/microservices-flowershop/blob/master/README/insomnia_requests.json">insomnia_requests.json</a> file to be imported on <a href="https://insomnia.rest/download/">Insomnia</a> and test all endpoints.</p>

<h2>
  <a name="notes" href="#notes">
  </a>
  Notes
</h2>

<ul>
<li>commits to <code>master</code> tell the story of this project. You can follow <a href="https://github.com/brunodrugowick/microservices-flowershop/commits/master">here</a>.</li>
<li>this implementation is based on two courses from <a href="https://www.alura.com.br/">Alura</a>: <a href="https://www.alura.com.br/curso-online-microservices-spring-cloud-service-registry-config-server">this (in portuguese)</a> and <a href="https://www.alura.com.br/curso-online-microservices-spring-cloud-circuit-breaker-api-gateway">this (in portuguese)</a>.</li>
<li>This is a <a href="https://github.com/brunodrugowick/microservices-flowershop/issues">work in progress</a>.</li>
<li>The cover image for this post is taken from the spring.io homepage (<a href="https://spring.io/img/homepage/diagram-distributed-systems.svg">here</a>).</li>
</ul>...