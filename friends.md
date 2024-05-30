---
title: Friends
layout: default
---
{% for p in site.friends %}
  <h2><a href="{{ p.ext_url }}">{{ p.title }}</a></h2>
  <p>{{ p.content | markdownify }}</p>
  <p><a href="{{ p.ext_url }}">Visit &gt;&gt;</a></p>
{% endfor %}
