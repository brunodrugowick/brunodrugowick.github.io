---
buildUrl: blog.html
---

{% for post in site.posts %}
# {{ post.title }} 
##### {{ post.date | date: "%a, %b %d, %y" }}
{{ post.excerpt }} 

[Continue reading...]({{ post.url }})
{% endfor %}