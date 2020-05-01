---
layout: default
title: "A list of topics"
permalink: "/topiclist/"
---

This document will list all of the topics, including itself.

<ul>
  {% for topic in site.topic %}
    <li>
      <a href="{{ topic.url }}">{{ topic.title }}</a>
      - {{ topic.headline }}
    </li>
  {% endfor %}
</ul>
