//==========
// ServiceWorker
console.log("Hello ServiceWorker!!");

const CACHE_VERSION = "cache_0.0.1";
const CACHE_FILES = [
    "/index.html",
    "/offline.html", // オフライン用ページ
    "/assets/css/style.css",
    "/assets/js/main.js",
    "/assets/images/logo.png"
];

// Installイベントで必要なファイルをキャッシュ
self.addEventListener("install", (e) => {
    console.log("Service Worker Installing...");
    e.waitUntil(
        caches.open(CACHE_VERSION).then((cache) => {
            console.log("Caching files...");
            return cache.addAll(CACHE_FILES);
        })
    );
});

// Activateイベントで古いキャッシュを削除
self.addEventListener("activate", (e) => {
    console.log("Service Worker Activated...");
    const cacheWhitelist = [CACHE_VERSION];
    e.waitUntil(
        caches.keys().then((keyList) => {
            return Promise.all(
                keyList.map((key) => {
                    if (cacheWhitelist.indexOf(key) === -1) {
                        return caches.delete(key);
                    }
                })
            );
        })
    );
});

// Fetchイベントでキャッシュを利用
self.addEventListener("fetch", (e) => {
    e.respondWith(
        caches.match(e.request).then((res) => {
            if (res) return res;  // キャッシュがあればそれを返す
            return fetch(e.request).catch(() => {
                // ネットワークがない場合、オフラインページを表示
                return caches.match("/offline.html");
            });
        })
    );
});
