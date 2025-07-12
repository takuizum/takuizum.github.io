// ブログページの機能
const blogPosts = [
    {
        id: 1,
        title: "ベイズ統計学入門：MCMCから実践まで",
        excerpt: "ベイズ統計学の基礎概念から、MCMCサンプリング、実際のデータ分析まで包括的に解説します。Stanを使った実装例も含めて、初学者にも分かりやすく説明します。",
        category: "statistics",
        tags: ["ベイズ統計", "MCMC", "Stan"],
        date: "2025-07-10",
        readTime: "15分",
        author: "takuizum",
        popular: true
    },
    {
        id: 2,
        title: "Rによる項目反応理論の実装",
        excerpt: "項目反応理論（IRT）の理論的背景から、Rを使った実際の分析手法まで詳しく解説。ltmパッケージとmirtパッケージの使い分けも説明します。",
        category: "tutorial",
        tags: ["R", "IRT", "項目反応理論"],
        date: "2025-07-05",
        readTime: "20分",
        author: "takuizum",
        popular: true
    },
    {
        id: 3,
        title: "機械学習と心理測定学の融合",
        excerpt: "機械学習手法を心理測定学に応用する最新の研究動向について解説。深層学習を用いた項目反応理論モデルの可能性を探ります。",
        category: "research",
        tags: ["機械学習", "深層学習", "心理測定学"],
        date: "2025-06-28",
        readTime: "12分",
        author: "takuizum",
        popular: false
    },
    {
        id: 4,
        title: "Pythonでのベイズニューラルネットワーク実装",
        excerpt: "PyTorchを使ってベイズニューラルネットワークを実装する方法を詳しく解説。不確実性の定量化と予測精度の向上について実例を交えて説明します。",
        category: "programming",
        tags: ["Python", "PyTorch", "ベイズ", "ニューラルネットワーク"],
        date: "2025-06-20",
        readTime: "25分",
        author: "takuizum",
        popular: true
    },
    {
        id: 5,
        title: "統計的仮説検定の正しい理解",
        excerpt: "p値の意味、多重比較問題、効果量の重要性など、統計的仮説検定にまつわる誤解を解き、正しい理解を促進します。",
        category: "statistics",
        tags: ["仮説検定", "p値", "効果量"],
        date: "2025-06-15",
        readTime: "18分",
        author: "takuizum",
        popular: false
    },
    {
        id: 6,
        title: "tidyverseを使ったデータ前処理の完全ガイド",
        excerpt: "Rのtidyverseパッケージ群を使ったデータ前処理の基本から応用テクニックまで、実例を豊富に含めて解説します。",
        category: "tutorial",
        tags: ["R", "tidyverse", "データ前処理"],
        date: "2025-06-10",
        readTime: "22分",
        author: "takuizum",
        popular: true
    },
    {
        id: 7,
        title: "時系列分析入門：ARIMAモデルから状態空間モデルまで",
        excerpt: "時系列データの基本的な分析手法から、ARIMAモデル、状態空間モデルまで、理論と実装の両面から解説します。",
        category: "statistics",
        tags: ["時系列分析", "ARIMA", "状態空間モデル"],
        date: "2025-05-25",
        readTime: "30分",
        author: "takuizum",
        popular: false
    },
    {
        id: 8,
        title: "GitHubを使った研究プロジェクト管理",
        excerpt: "研究プロジェクトでのバージョン管理、コラボレーション、成果物の公開まで、GitHubを効果的に活用する方法を紹介します。",
        category: "programming",
        tags: ["Git", "GitHub", "プロジェクト管理"],
        date: "2025-05-20",
        readTime: "16分",
        author: "takuizum",
        popular: true
    }
];

let filteredPosts = [...blogPosts];
let currentPage = 1;
const postsPerPage = 5;

document.addEventListener('DOMContentLoaded', function() {
    initBlogFilters();
    displayPosts();
    displayPopularPosts();
    initCategoryLinks();
});

function initBlogFilters() {
    const searchInput = document.getElementById('search-input');
    const categoryFilter = document.getElementById('category-filter');
    
    searchInput.addEventListener('input', function() {
        filterPosts();
    });
    
    categoryFilter.addEventListener('change', function() {
        filterPosts();
    });
}

function filterPosts() {
    const searchTerm = document.getElementById('search-input').value.toLowerCase();
    const selectedCategory = document.getElementById('category-filter').value;
    
    filteredPosts = blogPosts.filter(post => {
        const matchesSearch = post.title.toLowerCase().includes(searchTerm) ||
                            post.excerpt.toLowerCase().includes(searchTerm) ||
                            post.tags.some(tag => tag.toLowerCase().includes(searchTerm));
        
        const matchesCategory = selectedCategory === 'all' || post.category === selectedCategory;
        
        return matchesSearch && matchesCategory;
    });
    
    currentPage = 1;
    displayPosts();
    displayPagination();
}

function displayPosts() {
    const blogPostsContainer = document.getElementById('blog-posts');
    const startIndex = (currentPage - 1) * postsPerPage;
    const endIndex = startIndex + postsPerPage;
    const postsToShow = filteredPosts.slice(startIndex, endIndex);
    
    blogPostsContainer.innerHTML = '';
    
    if (postsToShow.length === 0) {
        blogPostsContainer.innerHTML = `
            <div style="text-align: center; padding: 3rem; color: #666;">
                <i class="fas fa-search" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.5;"></i>
                <p>該当する記事が見つかりませんでした。</p>
            </div>
        `;
        return;
    }
    
    postsToShow.forEach((post, index) => {
        const postElement = createPostElement(post);
        postElement.style.opacity = '0';
        postElement.style.transform = 'translateY(20px)';
        blogPostsContainer.appendChild(postElement);
        
        // アニメーション効果
        setTimeout(() => {
            postElement.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
            postElement.style.opacity = '1';
            postElement.style.transform = 'translateY(0)';
        }, index * 100);
    });
    
    displayPagination();
}

function createPostElement(post) {
    const postDiv = document.createElement('div');
    postDiv.className = 'blog-post';
    
    const formattedDate = new Date(post.date).toLocaleDateString('ja-JP', {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
    });
    
    const categoryNames = {
        'statistics': '統計学',
        'programming': 'プログラミング',
        'research': '研究',
        'tutorial': 'チュートリアル'
    };
    
    postDiv.innerHTML = `
        <div class="blog-post-header">
            <div class="blog-post-meta">
                <span><i class="fas fa-calendar"></i> ${formattedDate}</span>
                <span><i class="fas fa-clock"></i> ${post.readTime}</span>
                <span><i class="fas fa-folder"></i> ${categoryNames[post.category]}</span>
                <span><i class="fas fa-user"></i> ${post.author}</span>
            </div>
        </div>
        <h2 class="blog-post-title">
            <a href="blog-post-${post.id}.html">${post.title}</a>
        </h2>
        <p class="blog-post-excerpt">${post.excerpt}</p>
        <div class="blog-post-tags">
            ${post.tags.map(tag => `<span class="tag">${tag}</span>`).join('')}
        </div>
        <a href="blog-post-${post.id}.html" class="read-more">続きを読む <i class="fas fa-arrow-right"></i></a>
    `;
    
    return postDiv;
}

function displayPopularPosts() {
    const popularPostsContainer = document.getElementById('popular-posts');
    const popularPosts = blogPosts.filter(post => post.popular).slice(0, 5);
    
    popularPostsContainer.innerHTML = '';
    
    popularPosts.forEach(post => {
        const formattedDate = new Date(post.date).toLocaleDateString('ja-JP', {
            month: 'short',
            day: 'numeric'
        });
        
        const popularPostDiv = document.createElement('div');
        popularPostDiv.className = 'popular-post';
        popularPostDiv.innerHTML = `
            <div class="popular-post-title">
                <a href="blog-post-${post.id}.html">${post.title}</a>
            </div>
            <div class="popular-post-date">${formattedDate}</div>
        `;
        
        popularPostsContainer.appendChild(popularPostDiv);
    });
}

function displayPagination() {
    const paginationContainer = document.getElementById('pagination');
    const totalPages = Math.ceil(filteredPosts.length / postsPerPage);
    
    if (totalPages <= 1) {
        paginationContainer.innerHTML = '';
        return;
    }
    
    let paginationHTML = '';
    
    // 前のページボタン
    if (currentPage > 1) {
        paginationHTML += `<a href="#" class="page-btn" data-page="${currentPage - 1}">
            <i class="fas fa-chevron-left"></i>
        </a>`;
    }
    
    // ページ番号
    for (let i = 1; i <= totalPages; i++) {
        if (i === currentPage) {
            paginationHTML += `<span class="page-btn active">${i}</span>`;
        } else {
            paginationHTML += `<a href="#" class="page-btn" data-page="${i}">${i}</a>`;
        }
    }
    
    // 次のページボタン
    if (currentPage < totalPages) {
        paginationHTML += `<a href="#" class="page-btn" data-page="${currentPage + 1}">
            <i class="fas fa-chevron-right"></i>
        </a>`;
    }
    
    paginationContainer.innerHTML = paginationHTML;
    
    // ページネーションのイベントリスナー
    paginationContainer.querySelectorAll('.page-btn[data-page]').forEach(btn => {
        btn.addEventListener('click', function(e) {
            e.preventDefault();
            currentPage = parseInt(this.getAttribute('data-page'));
            displayPosts();
            window.scrollTo({ top: 0, behavior: 'smooth' });
        });
    });
}

function initCategoryLinks() {
    const categoryItems = document.querySelectorAll('.category-item');
    
    categoryItems.forEach(item => {
        item.addEventListener('click', function(e) {
            e.preventDefault();
            const category = this.getAttribute('data-category');
            document.getElementById('category-filter').value = category;
            filterPosts();
        });
    });
}

// 購読フォームの処理
document.addEventListener('DOMContentLoaded', function() {
    const subscribeForm = document.querySelector('.subscribe-form');
    
    if (subscribeForm) {
        subscribeForm.addEventListener('submit', function(e) {
            e.preventDefault();
            const email = this.querySelector('input[type="email"]').value;
            
            if (email) {
                alert('ありがとうございます！最新記事の通知をお送りします。');
                this.reset();
            }
        });
    }
});

// タグクリック時のフィルター
document.addEventListener('click', function(e) {
    if (e.target.classList.contains('tag')) {
        const tagText = e.target.textContent;
        document.getElementById('search-input').value = tagText;
        filterPosts();
    }
});
