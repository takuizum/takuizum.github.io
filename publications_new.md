---
layout: page
title: 出版・論文
description: 研究成果として発表した論文、書籍、ソフトウェアパッケージなどをご紹介します。
permalink: /publications/
---

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
  {% if publication.abstract %}
  <p><strong>概要:</strong> {{ publication.abstract }}</p>
  {% endif %}
</div>
<hr>
{% endfor %}
{% endfor %}

## 論文の種類別

### 査読付きジャーナル論文
{% assign journal_papers = site.publications | where: 'type', 'journal' | sort: 'year' | reverse %}
{% for publication in journal_papers %}
- **{{ publication.title }}** ({{ publication.year }}) - {{ publication.venue }}
{% endfor %}

### 国際会議論文
{% assign conference_papers = site.publications | where: 'type', 'conference' | sort: 'year' | reverse %}
{% for publication in conference_papers %}
- **{{ publication.title }}** ({{ publication.year }}) - {{ publication.venue }}
{% endfor %}

### 書籍
{% assign books = site.publications | where: 'type', 'book' | sort: 'year' | reverse %}
{% for publication in books %}
- **{{ publication.title }}** ({{ publication.year }}) - {{ publication.venue }}
{% endfor %}
