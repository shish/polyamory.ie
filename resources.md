---
title: Resources
layout: default
---
{% for p in site.resources %}
  <h2>
    <a href="{{ p.ext_url }}">
      {{ p.title }} - {{ p.ext_url }}
    </a>
  </h2>
  <p>{{ p.content | markdownify }}</p>
{% endfor %}
