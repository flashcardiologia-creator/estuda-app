/** @type {import('next').NextConfig} */
const nextConfig = {
  /* config options here */
  // iPhone e alguns navegadores internos pedem /apple-touch-icon.png (e as variantes "-precomposed" e com tamanho, como
  // -120x120) na raiz do site, mesmo com o ícone declarado em /icons/. Sem isso essas buscas davam 404 (apareciam no Netlify).
  async rewrites() {
    return [{ source: "/:name(apple-touch-icon[^/]*)\\.png", destination: "/icons/apple-touch-icon-v2.png" }];
  },
};

export default nextConfig;
