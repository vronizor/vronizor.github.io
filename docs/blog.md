---
layout: default
title: Blog
---

<style>
ul.posts {
   list-style-type: none;
   margin-bottom: 2em;
}

ul.posts li {
   line-height: 1.75em;
}

ul.posts span {
   color: #aaa;
   font-family: Monaco, "Courier New", monospace;
   font-size: 80%;
}
</style>

# Blog entries

<ul class="posts">
   {% for post in site.posts %}
      <li><span>{{ post.date | date_to_string }}</span> &raquo; <a href="{{ post.url }}">{{ post.title }}</a></li>
   {% endfor %}
</ul>

