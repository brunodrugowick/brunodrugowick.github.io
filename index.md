---
buildUrl: index.html
---

{% for post in site.posts %}
##### {{ post.date | date: "%A - %Y-%m-%d" }}
{{ post.excerpt }} 

[Continue reading...]({{ post.url }})

---
{% endfor %}
