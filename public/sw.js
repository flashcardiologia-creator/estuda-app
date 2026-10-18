// Service worker do FlashCardio: só recebe as notificações (push) e abre o app ao tocar nelas.
// Não guarda nada em cache.
self.addEventListener("install", () => self.skipWaiting());
self.addEventListener("activate", (event) => event.waitUntil(self.clients.claim()));

self.addEventListener("push", (event) => {
  let data = {};
  try {
    data = event.data ? event.data.json() : {};
  } catch {
    data = {};
  }
  event.waitUntil(
    self.registration.showNotification(data.title || "FlashCardio", {
      body: data.body || "",
      icon: "/icons/icon-192-v2.png",
      badge: "/icons/icon-192-v2.png",
      tag: data.tag || "missao-diaria",
      renotify: true,
      data: { url: data.url || "/" },
    })
  );
});

self.addEventListener("notificationclick", (event) => {
  event.notification.close();
  const url = (event.notification.data && event.notification.data.url) || "/";
  event.waitUntil(
    self.clients.matchAll({ type: "window", includeUncontrolled: true }).then((list) => {
      for (const client of list) {
        if ("focus" in client) {
          // Com o app já aberto, leva para a página do aviso (ex.: /?prolongar=1) além de trazê-lo para a frente.
          if (url !== "/" && "navigate" in client) {
            return client.focus().then(() => client.navigate(url)).catch(() => {});
          }
          return client.focus();
        }
      }
      return self.clients.openWindow(url);
    })
  );
});
