---
layout: post
title:  "Querying your Spring Data JPA Repository - Introduction"
date:   2020-01-06T23:14:36Z
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

<code>[java, spring, jpa, repository]</code>
<div class=card>
	  <div class=container>
	    <h4><b><br>You'll have a better experience reading in DEV</b></h4>
	    <p><a href="https://dev.to/brunodrugowick/querying-your-spring-data-jpa-repository-introduction-4ani" target="_blank">Click here to continue reading this post there >></a></p>
	    <p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/querying-your-spring-data-jpa-repository-introduction-4ani" target="_blank">read more</a>.</p>
	    <p>You can continue to read here too, it's up to you... =]</p>
	  </div>
	</div><br>
<p>In this series of posts I'll show you several methods to query your <code>Java</code> <code>JPA</code> <code>repositories</code> using <code>Spring Data JPA</code>. Throwing in some <code>Spring Boot</code> and <code>JPQL</code> and you have <em>too many words</em>!</p>

<h2>
  <a name="so-what-do-you-need-to-know" href="#so-what-do-you-need-to-know">
  </a>
  So... what do you need to know?
</h2>

<ul>
<li>Java and Spring: the <a href="https://docs.oracle.com/en/java/javase/13/">language</a> and the <a href="https://spring.io">framework</a>, respectively.</li>
<li>Java Persistence API (JPA): the specification for a ORM (Object-Relational Mapping) born from Hibernate, the first and most popular implementation of the JPA specification.

<ul>
<li>It's how you persist data to a relational database.</li>
</ul>


</li>
<li>Spring Data JPA: a <a href="https://spring.io/projects/spring-data-jpa">sub-project</a> of <a href="https://spring.io/projects/spring-data">Spring Data</a>, one of the many (many!) projects of Spring Framework.</li>
<li>Spring Data JPA Repository: a Java interface/class annotated with <code>@Repository</code> from <code>org.springframework.stereotype</code> package.</li>
</ul>

<p>Also noteworthy:</p>

<ul>
<li>Spring Boot: opinionated modules of the Spring Framework and third-party libraries. It means the libraries come with sensible defaults so you kick-start your development without much configuration of libraries.</li>
<li>Java Persistence Query Language (JPQL): a query language similar to SQL. I don't know much more than what you'll see here in this series of posts.</li>
</ul>

<p>If this brief explanation is not sufficient for you to comfortably continue reading, please, <em>let me know</em> and I'll do my best to update with more links and references (or maybe even write something). </p>

<p>Otherwise, you may continue on this awesome series of posts! =P</p>

<h2>
  <a name="content" href="#content">
  </a>
  Content
</h2>

<p>I'm going to cover 8 methods to query your data using Spring Data JPA Repositories. I'll develop <a href="https://github.com/brunodrugowick/jpa-queries-blog-post">an app for this series of posts</a> so you can follow along.</p>

<p>In the mean time, this post links to another GitHub repository.</p>

<h3>
  <a name="1-query-methods" href="#1-query-methods">
  </a>
  1. Query Methods
</h3>

<p>Awesome Spring Data JPA implementation!</p>


<div class="ltag__link">
  <a href="/brunodrugowick" class="ltag__link__link">
    <div class="ltag__link__pic">
      <img src="https://res.cloudinary.com/practicaldev/image/fetch/s--U-wFRb7a--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://res.cloudinary.com/practicaldev/image/fetch/s--LpCY0EbU--/c_fill%2Cf_auto%2Cfl_progressive%2Ch_150%2Cq_auto%2Cw_150/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/213112/5bb8eb2e-29a2-4307-be73-1ffdd76f8f9c.jpg" alt="brunodrugowick" loading="lazy">
    </div>
  </a>
  <a href="/brunodrugowick/spring-data-jpa-query-methods-l43" class="ltag__link__link">
    <div class="ltag__link__content">
      <h2>Spring Data JPA Query Methods</h2>
      <h3>Bruno Drugowick ・ Jan 15 '20 ・ 4 min read</h3>
      <div class="ltag__link__taglist">
        <span class="ltag__link__tag">#java</span>
        <span class="ltag__link__tag">#spring</span>
        <span class="ltag__link__tag">#jpa</span>
        <span class="ltag__link__tag">#query</span>
      </div>
    </div>
  </a>
</div>


<h3>
  <a name="2-jpql-within-the-source-code" href="#2-jpql-within-the-source-code">
  </a>
  2. JPQL within the source code
</h3>

<p>@Query annotation.</p>


<div class="ltag__link">
  <a href="/brunodrugowick" class="ltag__link__link">
    <div class="ltag__link__pic">
      <img src="https://res.cloudinary.com/practicaldev/image/fetch/s--U-wFRb7a--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://res.cloudinary.com/practicaldev/image/fetch/s--LpCY0EbU--/c_fill%2Cf_auto%2Cfl_progressive%2Ch_150%2Cq_auto%2Cw_150/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/213112/5bb8eb2e-29a2-4307-be73-1ffdd76f8f9c.jpg" alt="brunodrugowick" loading="lazy">
    </div>
  </a>
  <a href="/brunodrugowick/using-jpql-with-spring-data-jpa-48c0" class="ltag__link__link">
    <div class="ltag__link__content">
      <h2>Using JPQL with Spring Data JPA</h2>
      <h3>Bruno Drugowick ・ Jan 30 '20 ・ 2 min read</h3>
      <div class="ltag__link__taglist">
        <span class="ltag__link__tag">#java</span>
        <span class="ltag__link__tag">#spring</span>
        <span class="ltag__link__tag">#jpa</span>
        <span class="ltag__link__tag">#jpql</span>
      </div>
    </div>
  </a>
</div>


<h3>
  <a name="3-externalized-jpql-with-raw-ormxml-endraw-file" href="#3-externalized-jpql-with-raw-ormxml-endraw-file">
  </a>
  3. Externalized JPQL with <code>orm.xml</code> file
</h3>

<p>Well, there's this. =|</p>


<div class="ltag__link">
  <a href="/brunodrugowick" class="ltag__link__link">
    <div class="ltag__link__pic">
      <img src="https://res.cloudinary.com/practicaldev/image/fetch/s--U-wFRb7a--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://res.cloudinary.com/practicaldev/image/fetch/s--LpCY0EbU--/c_fill%2Cf_auto%2Cfl_progressive%2Ch_150%2Cq_auto%2Cw_150/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/213112/5bb8eb2e-29a2-4307-be73-1ffdd76f8f9c.jpg" alt="brunodrugowick" loading="lazy">
    </div>
  </a>
  <a href="/brunodrugowick/using-jpql-on-orm-xml-file-with-spring-data-jpa-39ej" class="ltag__link__link">
    <div class="ltag__link__content">
      <h2>Using JPQL on orm.xml file with Spring Data JPA</h2>
      <h3>Bruno Drugowick ・ Feb 11 '20 ・ 2 min read</h3>
      <div class="ltag__link__taglist">
        <span class="ltag__link__tag">#spring</span>
        <span class="ltag__link__tag">#jpa</span>
        <span class="ltag__link__tag">#repository</span>
        <span class="ltag__link__tag">#xml</span>
      </div>
    </div>
  </a>
</div>


<h3>
  <a name="4-custom-spring-data-jpa-repository-method" href="#4-custom-spring-data-jpa-repository-method">
  </a>
  4. Custom Spring Data JPA Repository method
</h3>

<p>Java code is added to the mix and dynamic stuff is now possible!</p>


<div class="ltag__link">
  <a href="/brunodrugowick" class="ltag__link__link">
    <div class="ltag__link__pic">
      <img src="https://res.cloudinary.com/practicaldev/image/fetch/s--U-wFRb7a--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://res.cloudinary.com/practicaldev/image/fetch/s--LpCY0EbU--/c_fill%2Cf_auto%2Cfl_progressive%2Ch_150%2Cq_auto%2Cw_150/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/213112/5bb8eb2e-29a2-4307-be73-1ffdd76f8f9c.jpg" alt="brunodrugowick" loading="lazy">
    </div>
  </a>
  <a href="/brunodrugowick/four-steps-to-extend-a-spring-data-jpa-repository-with-your-own-code-53b0" class="ltag__link__link">
    <div class="ltag__link__content">
      <h2>Three steps to extend a Spring Data JPA repository with your own code</h2>
      <h3>Bruno Drugowick ・ Feb 21 '20 ・ 5 min read</h3>
      <div class="ltag__link__taglist">
        <span class="ltag__link__tag">#spring</span>
        <span class="ltag__link__tag">#repository</span>
        <span class="ltag__link__tag">#java</span>
        <span class="ltag__link__tag">#jpa</span>
      </div>
    </div>
  </a>
</div>


<h3>
  <a name="5-use-of-criteria-api" href="#5-use-of-criteria-api">
  </a>
  5. Use of Criteria API
</h3>

<p>More dynamic.</p>

<ul>
<li>Article (to be written).</li>
<li>If you consider yourself self-taught, see: <a href="https://github.com/brunodrugowick/algafood-api/commit/e19a606fa2db4d7a9ecc297568922922dd5ff70f">this</a>.</li>
</ul>

<h3>
  <a name="6-use-of-specification-design-pattern" href="#6-use-of-specification-design-pattern">
  </a>
  6. Use of Specification design pattern
</h3>

<p>More and more dynamic!</p>

<ul>
<li>Article (to be written).</li>
<li>If you consider yourself self-taught, see: <a href="https://github.com/brunodrugowick/algafood-api/commit/9ffb6ecb2c9769dbf76760cf0a0b125ee80064ca">this</a>.</li>
</ul>

<h3>
  <a name="7-overriding-springs-default-implementation-for-jparepository" href="#7-overriding-springs-default-implementation-for-jparepository">
  </a>
  7. Overriding Spring's default implementation for JpaRepository
</h3>

<p>Now you'll feel like a JPA god!</p>

<ul>
<li>Article (to be written).</li>
<li>If you consider yourself self-taught, see: <a href="https://github.com/brunodrugowick/algafood-api/commit/dad7e2a187d1f3fba56d61793436b5c20d924a74">this</a>.</li>
</ul>

<h3>
  <a name="8-bonus-use-of-querydsl" href="#8-bonus-use-of-querydsl">
  </a>
  8. BONUS: use of <a href="http://www.querydsl.com/">Querydsl</a>
</h3>

<p>I don't even know what this is right now but I'll figure it out. Looks cool, though!</p>

<ul>
<li>Article (to be written).</li>
<li>If you consider yourself self-taught, see: <a href="https://github.com/brunodrugowick/algafood-api/commit/b771e424b2825e88a6bb7dabd117f7bae609df32">to be developed</a>.</li>
</ul>

<h2>
  <a name="thanks-to" href="#thanks-to">
  </a>
  Thanks to
</h2>

<p>Most of what you see here I learnt on a <a href="https://cafe.algaworks.com/lista-espera-spring-rest/">course from Algaworks (in Portuguese)</a> about REST APIs with Spring, where JPA is a huge section. I recommend the course if you speak Portuguese.</p>

<h2>
  <a name="not-included" href="#not-included">
  </a>
  Not Included
</h2>

<p>I won't cover any of this:</p>

<ul>
<li>Database configuration.</li>
<li>Spring Boot app creation.</li>
<li>Entity relationships.</li>
<li>Etc...</li>
</ul>

<p>Nevertheless, I'll provide a public GitHub repository with everything that I mention here and also would love to help if you drop a question on the Comments section.</p>...