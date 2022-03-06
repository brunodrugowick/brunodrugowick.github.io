---
buildUrl: projects.html
---

<head>
    <link rel="stylesheet" type="text/css" href="stylesheets/main.css">
</head>

<div>
    {% for project in site.data.projects %}
    <div class="card">
        <svg width="100%" height="20">
            <rect width="100%" height="100%" style="fill: rgb(190, 220, 220); stroke-width: 0; border-radius: 5px 5px 0 0" />
        </svg>
        <div class="container">
            <h2>{{ project.name }}</h2>
            <p>{{ project.description }}</p>
            <h5><a href="{{ project.github }}" target="_blank">GitHub</a>        
                {% if project.link != null %} &nbsp; &nbsp; <a href="{{ project.link }}" target="_blank">App <img src="assets/img/external-link-altstyle=solid.svg" width="12px"/> </a> {% endif %}
            </h5>
        </div>
    </div>
    <br>
    {% endfor %}
</div>


These are some things I've been working on. You can always take a look at my <a href="https://github.com/brunodrugowick?tab=repositories" target="_blank">GitHub Repositories</a> to see more.
