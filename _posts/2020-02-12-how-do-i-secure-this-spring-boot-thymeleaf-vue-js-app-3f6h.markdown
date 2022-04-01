---
layout: post
title:  "How do I secure this Spring Boot + Thymeleaf + Vue.js app?"
date:   2020-02-12T23:33:52Z
categories: 
---

> <div class=card><div class=container><h4><b><a href="https://dev.to/brunodrugowick/how-do-i-secure-this-spring-boot-thymeleaf-vue-js-app-3f6h">You'll have a better experience reading in DEV...</a></b></h4><i><p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/how-do-i-secure-this-spring-boot-thymeleaf-vue-js-app-3f6h">read more</a>.</p><p>You can continue to read here too, it's up to you...</p></i></div></div>
<p>I have this app:</p>


<div class="ltag__link">
 <a href="/brunodrugowick" class="ltag__link__link">
 <div class="ltag__link__pic">
 <img src="https://res.cloudinary.com/practicaldev/image/fetch/s--U-wFRb7a--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://res.cloudinary.com/practicaldev/image/fetch/s--LpCY0EbU--/c_fill%2Cf_auto%2Cfl_progressive%2Ch_150%2Cq_auto%2Cw_150/https://dev-to-uploads.s3.amazonaws.com/uploads/user/profile_image/213112/5bb8eb2e-29a2-4307-be73-1ffdd76f8f9c.jpg" alt="brunodrugowick" loading="lazy">
 </div>
 </a>
 <a href="/brunodrugowick/complete-crud-with-spring-boot-vue-js-axios-fg1" class="ltag__link__link">
 <div class="ltag__link__content">
 <h2>Complete CRUD with Spring Boot, Vue.js, Axios</h2>
 <h3>Bruno Drugowick ・ Feb 9 '20 ・ 4 min read</h3>
 <div class="ltag__link__taglist">
 <span class="ltag__link__tag">#java</span>
 <span class="ltag__link__tag">#vue</span>
 <span class="ltag__link__tag">#axios</span>
 <span class="ltag__link__tag">#spring</span>
 </div>
 </div>
 </a>
</div>


<p>And I'm wondering how do I properly secure it? The app has:</p>

<ul>
<li>Server-rendered pages with Thymeleaf.</li>
<li>An API providing data for the pages.</li>
</ul>

<p>What's the proper way to secure and its underlying limitations considering this architecture?</p>

<p>Some questions that pop on my mind, to help you understand why I'm asking:</p>

<ul>
<li>Can I go with Spring Security defaults (adding csrf token on my forms that POST/PUT with Vue.js)?</li>
<li>How do I integrate this with my DELETE via API, for example?</li>
<li>Should I disable csrf?</li>
<li>Does this architecture makes sense? What are the caveats?</li>
</ul>

<p>...</p>


<hr>

<p>Cover image from <a href="https://www.flickr.com/photos/140988606@N08/28124222664">Christoph Scholz</a>.</p>...