const REPO_URL = "https://github.com/hack-r/theVault-Darknet-Market";
const POSOCAP_URL = "https://posocap.com";

const TITLE = "theVault – Be right back! Securing new hosting";
const DESCRIPTION =
  "theVault, the open-source darknet vendor store prototype, is temporarily offline while we secure new hosting. Source code and screenshots are on GitHub.";

function landingPage(origin) {
  const canonical = `${origin}/`;
  const ogImage = `${origin}/images/screenshot0.png`;
  const jsonLd = {
    "@context": "https://schema.org",
    "@type": "WebPage",
    name: TITLE,
    description: DESCRIPTION,
    url: canonical,
    primaryImageOfPage: ogImage,
    isPartOf: {
      "@type": "SoftwareSourceCode",
      name: "theVault",
      codeRepository: REPO_URL,
      programmingLanguage: "PHP",
    },
  };

  return `<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>${TITLE}</title>
<meta name="description" content="${DESCRIPTION}">
<meta name="robots" content="index, follow, max-image-preview:large">
<link rel="canonical" href="${canonical}">
<link rel="icon" href="/images/favicon.ico" sizes="any">
<link rel="apple-touch-icon" href="/images/thevault.png">
<meta property="og:type" content="website">
<meta property="og:site_name" content="theVault">
<meta property="og:title" content="${TITLE}">
<meta property="og:description" content="${DESCRIPTION}">
<meta property="og:url" content="${canonical}">
<meta property="og:image" content="${ogImage}">
<meta property="og:image:alt" content="theVault marketplace screenshot">
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:title" content="${TITLE}">
<meta name="twitter:description" content="${DESCRIPTION}">
<meta name="twitter:image" content="${ogImage}">
<script type="application/ld+json">${JSON.stringify(jsonLd)}</script>
<style>
  :root { color-scheme: dark; }
  * { box-sizing: border-box; }
  body { margin: 0; font-family: system-ui, sans-serif; background: #0d1b3a; color: #eee; line-height: 1.6; }
  a { color: #f5c46b; }
  header, main, footer { max-width: 960px; margin: 0 auto; padding: 1.5rem 16px; }
  header { text-align: center; }
  header img { border-radius: 24px; }
  h1 { font-size: clamp(2rem, 6vw, 3rem); margin: .5rem 0; }
  h2 { margin-top: 2rem; }
  figure { margin: 1.5rem 0; }
  figure img { max-width: 100%; height: auto; border-radius: 8px; border: 1px solid #2c3f6b; }
  figcaption { font-size: .9rem; color: #b8c2d9; margin-top: .4rem; }
  footer { text-align: center; border-top: 1px solid #2c3f6b; color: #b8c2d9; }
</style>
</head>
<body>
<header>
  <img src="/images/thevault.png" width="180" height="180" alt="theVault logo: a bank vault door with a golden DNA helix">
  <h1>Be right back!</h1>
  <p>theVault is temporarily offline while we secure new hosting.</p>
</header>
<main>
  <section>
    <h2>What is theVault?</h2>
    <p>theVault is an open-source prototype darknet vendor store, inspired by
    <img src="/images/goldhat.png" width="20" height="20" alt="Goldhat logo" style="vertical-align:middle">
    Goldhat Free Market and the speculative medical thriller <em>Baby X</em>.
    Browse the full source code, install guides and notes on
    <a href="${REPO_URL}">GitHub</a>.</p>
  </section>
  <section>
    <h2>A look inside</h2>
    <figure>
      <img src="/images/screenshot0.png" width="1091" height="674" loading="lazy" alt="theVault demo storefront showing the Celebrity DNA category">
      <figcaption>The Celebrity DNA category in the demo storefront.</figcaption>
    </figure>
    <figure>
      <img src="/images/screenshot.png" width="1191" height="620" loading="lazy" alt="theVault demo storefront showing the Artists category">
      <figcaption>The Artists category in the demo storefront.</figcaption>
    </figure>
  </section>
  <section>
    <h2>Status</h2>
    <p>We are securing new hosting and will be back online soon. In the meantime, the
    <a href="${REPO_URL}">theVault repository on GitHub</a> remains available.</p>
  </section>
</main>
<footer>
  <p>Brought to you by <a href="${POSOCAP_URL}">PosoCap</a>.</p>
</footer>
</body>
</html>`;
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    if (url.pathname.startsWith("/images/")) {
      const res = await env.ASSETS.fetch(request);
      const out = new Response(res.body, res);
      out.headers.set("cache-control", "public, max-age=86400");
      return out;
    }

    if (url.pathname === "/robots.txt") {
      return new Response(`User-agent: *\nAllow: /\n`, {
        headers: { "content-type": "text/plain; charset=utf-8" },
      });
    }

    // 503 + Retry-After tells search engines the outage is temporary,
    // so existing rankings are preserved.
    return new Response(landingPage(url.origin), {
      status: 503,
      headers: {
        "content-type": "text/html; charset=utf-8",
        "retry-after": "3600",
        "cache-control": "no-store",
      },
    });
  },
};
