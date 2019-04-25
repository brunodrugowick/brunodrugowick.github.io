##### [HOME]({{ site.url }}) | CURRICULUM
---

# Curriculum

Coming soon...

# Useful Links

{% for link in site.data.links %} 
- {{ link.title }}: [{{ link.url }}]({{ link.url }}) {% endfor %}

# Active Projects

| Project       | Description       | More info     |
| ------------- | ----------------- | ------------- | {% for project in site.data.projects %}
| {{ project.name }}  | {{ project.description }} | [GitHub page]({{ project.link }}) | {% endfor %}

# Blog posts

{% for post in site.posts %} 
- [{{ post.title }}]({{ post.url }}) {% endfor %}
