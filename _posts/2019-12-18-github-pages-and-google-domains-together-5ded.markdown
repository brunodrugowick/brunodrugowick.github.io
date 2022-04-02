---
layout: post
title:  "GitHub Pages and Google Domains together"
date:   2019-12-18T18:41:17Z
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

<code>[github, googledomains]</code>
<div class=card>
	  <div class=container>
	    <h4><b><br>You'll have a better experience reading in DEV</b></h4>
	    <p><a href="https://dev.to/brunodrugowick/github-pages-and-google-domains-together-5ded" target="_blank">Click here to continue reading this post there >></a></p>
	    <p>However, if you want to know more about the project to mirror my posts from DEV here (and why), go ahead and <a href="https://dev.to/brunodrugowick/github-pages-and-google-domains-together-5ded" target="_blank">read more</a>.</p>
	    <p>You can continue to read here too, it's up to you... =]</p>
	  </div>
	</div><br>
<p>Oh, that annoyed me more than it should. Yes, it's quite easy to make your custom domain point to your GitHub Pages project, but from the confusing GitHub documentation (too much freaking information) to the annoying first-page Google results, took me a while for everything to work properly.</p>

<p>Now I have my GitHub Pages project working fine over HTTPS with my custom domain on <a href="https://drugowick.dev">https://drugowick.dev</a> or <a href="https://www.drugowick.dev">https://www.drugowick.dev</a>.</p>

<p>So... assuming: </p>

<ul>
<li>you already have a custom domain (mine is drugowick.dev)</li>
<li>you already have a GitHub Pages project (<a href="https://dev.to/brunodrugowick/how-to-use-github-pages-j7d">if you don't...</a>
</li>
</ul>

<p>... here are the 3 simple steps to use your GitHub Pages project with your domain:</p>

<ol>
<li><p>On your GitHub Pages repository settings (<code>https://github.com/&lt;your-username&gt;/&lt;your-username&gt;.github.io/settings</code>) in the <code>Custom domain</code> field, put your custom domain including the <strong>www</strong> in the beginning, like so:<br>
<a href="https://res.cloudinary.com/practicaldev/image/fetch/s--oF2OD5sC--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/56ehzbe4f01ng8h8oifi.png" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--oF2OD5sC--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/56ehzbe4f01ng8h8oifi.png" alt="GitHub Settings Custom Domain" loading="lazy" width="678" height="231"></a></p></li>
<li><p>Check the box <code>Enforce HTTPS</code> (you may have to wait a little for this option to be available).</p></li>
<li><p>Add the following <code>Custom resource records</code> to your Google Domains DNS configuration:<br>
<a href="https://res.cloudinary.com/practicaldev/image/fetch/s--pklMqupj--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/y1e9ul2djv5mm4i3rd0u.png" class="article-body-image-wrapper"><img src="https://res.cloudinary.com/practicaldev/image/fetch/s--pklMqupj--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://thepracticaldev.s3.amazonaws.com/i/y1e9ul2djv5mm4i3rd0u.png" alt="Google Domains DNS Config" loading="lazy" width="880" height="658"></a></p></li>
</ol>

<ul>
<li>A set of <code>A</code> records pointing to GitHub's IPs. <a href="https://help.github.com/en/articles/setting-up-an-apex-domain#configuring-a-records-with-your-dns-provider">Here</a> you can find the updated IP addresses that should be used.</li>
<li>A <code>CNAME</code> record pointing to <code>&lt;your-username&gt;.github.io</code> and with <code>www</code> on the Name field.</li>
</ul>

<p>Wait a little bit again for everything to work. It will work! </p>

<p>Well... it works for me! =)</p>

<p>Thanks to:</p>

<ul>
<li><a href="https://woliveiras.com.br/posts/jamstack-dom%C3%ADnio-personalizado-com-google-domains-e-github-pages/">https://woliveiras.com.br/posts/jamstack-dom%C3%ADnio-personalizado-com-google-domains-e-github-pages/</a></li>
<li><a href="https://medium.com/@monarchwadia/github-pages-setting-up-www-subdomain-with-ssl-https-aca9eca371d6">https://medium.com/@monarchwadia/github-pages-setting-up-www-subdomain-with-ssl-https-aca9eca371d6</a></li>
</ul>


<hr>

<p>Image from <a href="https://pixabay.com/pt/users/ann_designs-6288193/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=4471660">ann_designs</a> por <a href="https://pixabay.com/pt/?utm_source=link-attribution&amp;utm_medium=referral&amp;utm_campaign=image&amp;utm_content=4471660">Pixabay</a></p>...