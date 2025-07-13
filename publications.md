---
layout: page
title: 出版・論文
description: 研究成果として発表した論文、書籍、ソフトウェアパッケージなどをご紹介します。
permalink: /publications/
---

<link rel="stylesheet" href="{{ '/assets/css/publications.css' | relative_url }}">

## 発表論文・著書

{% assign publications_by_year = site.publications | group_by: 'year' | sort: 'name' | reverse %}

{% for year_group in publications_by_year %}
### {{ year_group.name }}年

{% assign year_publications = year_group.items | sort: 'type' %}
{% for publication in year_publications %}
<div class="publication-item">
  <h4><a href="{{ publication.url | relative_url }}">{{ publication.title }}</a></h4>
  <p><strong>著者:</strong> {{ publication.authors }}</p>
  <p><strong>掲載先:</strong> {{ publication.venue }}{% if publication.volume %}, {{ publication.volume }}{% endif %}{% if publication.pages %}, pp. {{ publication.pages }}{% endif %}{% if publication.publisher %} ({{ publication.publisher }}){% endif %}</p>
  {% if publication.doi %}
  <p><strong>DOI:</strong> <a href="https://doi.org/{{ publication.doi }}" target="_blank">{{ publication.doi }}</a></p>
  {% endif %}
  {% if publication.abstract %}
  <p><strong>概要:</strong> {{ publication.abstract }}</p>
  {% endif %}
  
  <!-- APA 7th Style Citation -->
  <div class="apa-citation">
    <strong>APA引用:</strong> 
    {% if publication.type == 'journal' %}
      {{ publication.authors }} ({{ publication.year }}). {{ publication.title }}. <em>{{ publication.venue }}</em>{% if publication.volume %}, <em>{{ publication.volume }}</em>{% endif %}{% if publication.pages %}, {{ publication.pages }}{% endif %}. {% if publication.doi %}https://doi.org/{{ publication.doi }}{% endif %}
    {% elsif publication.type == 'conference' or publication.type == 'international_conference' %}
      {{ publication.authors }} ({{ publication.year }}). {{ publication.title }}. In <em>{{ publication.venue }}</em>{% if publication.pages %} (pp. {{ publication.pages }}){% endif %}. {% if publication.publisher %}{{ publication.publisher }}.{% endif %} {% if publication.doi %}https://doi.org/{{ publication.doi }}{% endif %}
    {% elsif publication.type == 'book' %}
      {{ publication.authors }} ({{ publication.year }}). <em>{{ publication.title }}</em>. {{ publication.venue }}. {% if publication.doi %}https://doi.org/{{ publication.doi }}{% endif %}
    {% endif %}
  </div>
</div>
<hr>
{% endfor %}
{% endfor %}

## 論文の種類別

### 査読付きジャーナル論文
{% assign journal_papers = site.publications | where: 'type', 'journal' | sort: 'year' | reverse %}
{% for publication in journal_papers %}
- **{{ publication.title }}** ({{ publication.year }}) - {{ publication.venue }}{% if publication.doi %} [DOI: {{ publication.doi }}](https://doi.org/{{ publication.doi }}){% endif %}
{% endfor %}

### 国内学会発表
{% assign domestic_conference_papers = site.publications | where: 'type', 'conference' | sort: 'year' | reverse %}
{% for publication in domestic_conference_papers %}
- **{{ publication.title }}** ({{ publication.year }}) - {{ publication.venue }}{% if publication.doi %} [DOI: {{ publication.doi }}](https://doi.org/{{ publication.doi }}){% endif %}
{% endfor %}

<!-- 国際学会発表（現在実績なし）
### 国際学会発表
{% assign international_conference_papers = site.publications | where: 'type', 'international_conference' | sort: 'year' | reverse %}
{% for publication in international_conference_papers %}
- **{{ publication.title }}** ({{ publication.year }}) - {{ publication.venue }}{% if publication.doi %} [DOI: {{ publication.doi }}](https://doi.org/{{ publication.doi }}){% endif %}
{% endfor %}
-->

### 書籍
{% assign books = site.publications | where: 'type', 'book' | sort: 'year' | reverse %}
{% for publication in books %}
- **{{ publication.title }}** ({{ publication.year }}) - {{ publication.venue }}{% if publication.doi %} [DOI: {{ publication.doi }}](https://doi.org/{{ publication.doi }}){% endif %}
{% endfor %}
