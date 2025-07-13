// ブログページの機能
const blogPosts = [];

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
