// ハンバーガーメニューの制御
document.addEventListener('DOMContentLoaded', function() {
    const hamburger = document.querySelector('.hamburger');
    const navMenu = document.querySelector('.nav-menu');
    
    hamburger.addEventListener('click', function() {
        hamburger.classList.toggle('active');
        navMenu.classList.toggle('active');
    });
    
    // メニューリンクをクリックしたときにメニューを閉じる
    document.querySelectorAll('.nav-link').forEach(n => n.addEventListener('click', () => {
        hamburger.classList.remove('active');
        navMenu.classList.remove('active');
    }));
});

// 更新情報の管理
const updates = [
    {
        date: "2025-07-10",
        title: "新しい統計解析パッケージをリリース",
        description: "R言語用の新しい統計解析パッケージを開発し、CRANに公開しました。心理測定学の分野で広く使用される分析手法を簡単に実行できます。"
    },
    {
        date: "2025-07-05",
        title: "国際学会での論文発表",
        description: "International Conference on Statistical Methodsにて、新しい項目反応理論モデルに関する研究成果を発表しました。"
    },
    {
        date: "2025-06-28",
        title: "データサイエンス研修プログラム開始",
        description: "企業向けのデータサイエンス研修プログラムを新たに開始しました。実践的なスキルの習得を重視したカリキュラムです。"
    },
    {
        date: "2025-06-20",
        title: "オープンソースプロジェクト公開",
        description: "機械学習モデルの解釈可能性を向上させるためのPythonライブラリをGitHubで公開しました。"
    },
    {
        date: "2025-06-15",
        title: "ブログ記事「ベイズ統計入門」公開",
        description: "ベイズ統計の基礎から応用まで、実例を交えて分かりやすく解説した記事を公開しました。"
    }
];

// 更新情報を表示する関数
function displayUpdates() {
    const updatesGrid = document.getElementById('updates-grid');
    const loadingElement = document.querySelector('.updates-loading');
    
    // 最新5件まで表示
    const recentUpdates = updates.slice(0, 5);
    
    // ローディング要素を非表示
    setTimeout(() => {
        loadingElement.style.display = 'none';
        
        recentUpdates.forEach(update => {
            const updateCard = document.createElement('div');
            updateCard.className = 'update-card';
            
            const formattedDate = new Date(update.date).toLocaleDateString('ja-JP', {
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });
            
            updateCard.innerHTML = `
                <div class="update-date">${formattedDate}</div>
                <h3 class="update-title">${update.title}</h3>
                <p class="update-description">${update.description}</p>
            `;
            
            updatesGrid.appendChild(updateCard);
        });
        
        // アニメーション効果
        const cards = document.querySelectorAll('.update-card');
        cards.forEach((card, index) => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(20px)';
            setTimeout(() => {
                card.style.transition = 'opacity 0.5s ease, transform 0.5s ease';
                card.style.opacity = '1';
                card.style.transform = 'translateY(0)';
            }, index * 100);
        });
    }, 500);
}

// コンタクトフォームの処理
function handleContactForm() {
    const form = document.querySelector('.contact-form');
    
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        
        // フォームデータの取得
        const formData = new FormData(form);
        const data = {
            name: formData.get('name'),
            email: formData.get('email'),
            subject: formData.get('subject'),
            message: formData.get('message')
        };
        
        // 簡単なバリデーション
        if (!data.name || !data.email || !data.subject || !data.message) {
            alert('すべての項目を入力してください。');
            return;
        }
        
        // メール形式のチェック
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!emailRegex.test(data.email)) {
            alert('正しいメールアドレスを入力してください。');
            return;
        }
        
        // 送信処理（実際の実装では適切なバックエンドAPIを使用）
        alert('お問い合わせありがとうございます。内容を確認次第、ご連絡いたします。');
        form.reset();
    });
}

// スムーススクロール
function initSmoothScroll() {
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });
}

// スクロール時のヘッダー効果
function initScrollEffects() {
    const header = document.querySelector('.header');
    let lastScrollTop = 0;
    
    window.addEventListener('scroll', function() {
        const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
        
        if (scrollTop > 100) {
            header.style.background = 'rgba(255, 255, 255, 0.95)';
            header.style.backdropFilter = 'blur(10px)';
        } else {
            header.style.background = '#fff';
            header.style.backdropFilter = 'none';
        }
        
        lastScrollTop = scrollTop;
    });
}

// 初期化
document.addEventListener('DOMContentLoaded', function() {
    displayUpdates();
    handleContactForm();
    initSmoothScroll();
    initScrollEffects();
});

// 新しい更新情報を追加する関数（管理用）
function addUpdate(date, title, description) {
    const newUpdate = {
        date: date,
        title: title,
        description: description
    };
    
    updates.unshift(newUpdate);
    
    // 表示を更新
    const updatesGrid = document.getElementById('updates-grid');
    updatesGrid.innerHTML = '';
    displayUpdates();
}

// エクスポート（他のファイルから使用する場合）
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        updates,
        addUpdate
    };
}
