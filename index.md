---
buildUrl: index.html
---

<head>
    <link rel="stylesheet" type="text/css" href="stylesheets/main.css">
</head>

<div>
    {% for devPost in site.data.devPosts %} 
    <div class="card">
        <a href="{{ devPost.url }}" target="_blank">
            <img src="{{ devPost.cover_image }}" style="width: 100%">
        </a>
        <a href="{{ devPost.url }}" target="_blank">
            <div class="container">
                <h3>{{ devPost.title }}</h3>
                <h6>{{ devPost.readable_publish_date }}</h6>
                <p>{{ devPost.description }}</p>
            </div>
        </a>
    </div>
    <br>
    {% endfor %}
</div>
