---
buildUrl: index.html
---

{% for post in site.posts %}
##### <a href="{{ post.url }}"><small>.</small></a> {{ post.date | date: "%A - %Y-%m-%d" }}
{{ post.excerpt }} 

<a href="{{ post.devToUrl }}" target="_blank">Continue reading at dev.to...</a>

---
{% endfor %}
