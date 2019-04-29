---
buildUrl: index.html
---

This is my landing page. Here you'll find my blog, projects I'm working on and more information about me (including a brief curriculum).

---
{% for post in site.posts %} {% if post.showOnHome %} 
## {{ post.title }}
##### {{ post.date | date: "%a, %b %d, %y" }}
{{ post.excerpt }} {% endif %} {% endfor %}
###### THAT'S THE MOST RECENT BLOG ENTRY. CONTINUE READING AT THE [BLOG](blog.html).

---

# That's me

![That's me!](assets/img/Drugo_2019.jpg)