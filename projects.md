---
buildUrl: projects.html
---

# Active Projects

Those are the most relevant projects I'm working on. You can find more at my [GitHub](https://github.com/brunodrugowick).

| Project       | Description       | Links     |
| ------------- | ----------------- | ------------- | {% for project in site.data.projects %}
| {{ project.name }}  | {{ project.description }} | [GitHub]({{ project.github }}) <br> {% if project.link != null %} <a href="{{ project.link }}" target="_blank">App <img src="assets/img/external-link-altstyle=solid.svg" width="15px"/></a> {% endif %} | {% endfor %}