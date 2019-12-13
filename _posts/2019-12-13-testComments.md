---
layout: default
title: Test comments
showOnHome: false
excerpt_separator: <!--more-->
comments: true
---

# Can you comment?

I'm adding ~~Commento~~ Disqus (for now I don't want to pay and don't care about privacy) in order for all the people who visit this blog to comment. Oh, my god, so many people!

Please comment below and help me test! Someone, please!

<!--more-->

Yeah, this is just a page break, below are the comments... aren't they?

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
