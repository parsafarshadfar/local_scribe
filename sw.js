const CACHE_NAME = 'local_scribe';

self.addEventListener('install', () => self.skipWaiting());

self.addEventListener('activate', (e) => {
    e.waitUntil(
        caches.keys().then(names =>
            Promise.all(names.map(c => { if (c !== CACHE_NAME) return caches.delete(c); }))
        )
    );
    self.clients.claim();
});

self.addEventListener('fetch', (e) => {
    // Only apply cache strategy to same-origin requests
    // Let CDN requests (Tailwind, Google Fonts, etc.) pass through normally
    if (!e.request.url.startsWith(self.location.origin)) return;

    // For navigation requests, try network first, fallback to cache
    if (e.request.mode === 'navigate') {
        e.respondWith(
            fetch(e.request)
                .then(response => {
                    const clone = response.clone();
                    caches.open(CACHE_NAME).then(cache => cache.put(e.request, clone));
                    return response;
                })
                .catch(() => caches.match(e.request))
        );
        return;
    }

    // For other same-origin requests (JSON, etc.), try cache first, then network
    e.respondWith(
        caches.match(e.request).then(cached => {
            if (cached) return cached;
            return fetch(e.request).then(response => {
                const clone = response.clone();
                caches.open(CACHE_NAME).then(cache => cache.put(e.request, clone));
                return response;
            });
        })
    );
});
