# Bruno Drugowick

[BLOG](/index.md) | [PROJECTS](/projects.md) | [ABOUT ME](/aboutme.md)

{% for project in site.data.projects %}

## {{ project.name }}
            
{{ project.description }}
            
###### [GITHUB]({{ project.github }}) {% if project.link != null %} &nbsp; &nbsp; [APP]({{ project.link }}) {% endif %}

{% endfor %}

These are some things I've been working on. You can always take a look at my <a href="https://github.com/brunodrugowick?tab=repositories" target="_blank">GitHub Repositories</a> to see more.
