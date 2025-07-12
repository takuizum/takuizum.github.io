---
layout: page
title: 出版・論文
hero: true
description: 研究成果として発表した論文、書籍、ソフトウェアパッケージなどをご紹介します。
permalink: /publications/
scripts: [publications]
---

<section class="publications-content">
  <div class="container">
    <div class="publications-nav">
      <button class="filter-btn active" data-filter="all">すべて</button>
      <button class="filter-btn" data-filter="journal">査読付き論文</button>
      <button class="filter-btn" data-filter="conference">学会発表</button>
      <button class="filter-btn" data-filter="book">書籍</button>
      <button class="filter-btn" data-filter="software">ソフトウェア</button>
    </div>

    <div class="publications-grid" id="publications-grid">
      {% for publication in site.publications %}
      <div class="publication-card" data-category="{{ publication.type }}">
        <div class="publication-header">
          <span class="publication-type {{ publication.type }}">{{ publication.type_label | default: publication.type }}</span>
          <span class="publication-year">{{ publication.year }}</span>
        </div>
        <h3 class="publication-title">
          <a href="{{ publication.url | relative_url }}">{{ publication.title }}</a>
        </h3>
        
        {% if publication.authors %}
        <div class="publication-authors">
          {% for author in publication.authors %}
            {% if author == "takuizum" %}<strong>{{ author }}</strong>{% else %}{{ author }}{% endif %}
            {% unless forloop.last %}, {% endunless %}
          {% endfor %}
        </div>
        {% endif %}
        
        {% if publication.journal %}
        <div class="publication-journal">{{ publication.journal }}</div>
        {% endif %}
        
        {% if publication.abstract %}
        <p class="publication-abstract">{{ publication.abstract }}</p>
        {% endif %}

        {% if publication.links %}
        <div class="publication-links">
          {% for link in publication.links %}
            <a href="{{ link.url }}" class="pub-link" target="_blank">
              <i class="{{ link.icon }}"></i> {{ link.label }}
            </a>
          {% endfor %}
        </div>
        {% endif %}
      </div>
      {% endfor %}
    </div>

    <div class="stats-section">
      <h2 class="section-title">研究実績統計</h2>
      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-number">15+</div>
          <div class="stat-label">査読付き論文</div>
        </div>
        <div class="stat-card">
          <div class="stat-number">25+</div>
          <div class="stat-label">学会発表</div>
        </div>
        <div class="stat-card">
          <div class="stat-number">3</div>
          <div class="stat-label">出版書籍</div>
        </div>
        <div class="stat-card">
          <div class="stat-number">8</div>
          <div class="stat-label">ソフトウェア</div>
        </div>
        <div class="stat-card">
          <div class="stat-number">500+</div>
          <div class="stat-label">引用数</div>
        </div>
        <div class="stat-card">
          <div class="stat-number">5</div>
          <div class="stat-label">研究助成</div>
        </div>
      </div>
    </div>
  </div>
</section>
