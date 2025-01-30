const CACHE_NAME = "portfolio-cache-v1";
const OFFLINE_URL = "/projects/M_O_P_B/offline.html";

// キャッシュするリソース
const CACHE_ASSETS = [
    OFFLINE_URL,
    "/assets/index.html",  // オフライン時にアクセスするため、index.html もキャッシュ
    "/assets/css/style.css", // 必要ならCSSファイルもキャッシュ
    // 必要なその他のファイルを追加...
];

// Service Worker のインストール
self.addEventListener("install", event => {
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then(cache => cache.addAll(CACHE_ASSETS))
            .then(() => self.skipWaiting())
    );
});

// Service Worker の有効化
self.addEventListener("activate", event => {
    event.waitUntil(
        caches.keys().then(cacheNames => {
            return Promise.all(
                cacheNames.map(cache => {
                    if (cache !== CACHE_NAME) {
                        return caches.delete(cache);
                    }
                })
            );
        })
    );
    self.clients.claim();
});

// Fetch イベントの処理
self.addEventListener("fetch", event => {
    event.respondWith(
        fetch(event.request)
            .catch(() => caches.match(OFFLINE_URL)) // オフライン時に `offline.html` を表示
    );
});
