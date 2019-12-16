---
layout: default
title: Hello, World
showOnHome: false
excerpt_separator: <!--more-->
comments: true
---

# Hello, World

I've been writing for several years now, on several platforms. But never in english and never focusing on programming.

That's the objective of this little tool, other than hosting my curriculum.

<!--more-->

# Comments

{% if page.comments %} 
<div id="disqus_thread"></div>
<script>

var disqus_config = function () {
this.page.url = 'https://drugowick.dev' + '{{ page.url }}';  // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = '{{ page.id }}'; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};

(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');
s.src = 'https://drugowick.disqus.com/embed.js';
s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
{% endif %}
