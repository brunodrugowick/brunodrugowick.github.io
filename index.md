##### [HOME]({{ site.url }}) | CURRICULUM
---

# Curriculum

Coming soon...

# Useful Links

{% for link in site.data.links %} 
- [{{ link.url }}]({{ link.url }}) {% endfor %}

# Active Projects

| Project       | Description       | Links     |
| ------------- | ----------------- | ------------- | {% for project in site.data.projects %}
| {{ project.name }}  | {{ project.description }} | [GitHub]({{ project.github }}) <br> {% if project.link != null %} <a href="{{ project.link }}" target="_blank">App <img src="assets/img/external-link-altstyle=solid.svg" width="15px"/></a> {% endif %} | {% endfor %}

# Blog posts

{% for post in site.posts %} 
- [{{ post.title }}]({{ post.url }}) {% endfor %}
