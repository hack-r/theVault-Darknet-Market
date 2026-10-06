const html = `<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Be right back!</title>
<style>
  html, body { height: 100%; margin: 0; }
  body { display: flex; align-items: center; justify-content: center;
         font-family: system-ui, sans-serif; background: #111; color: #eee; }
  h1 { font-size: 3rem; }
</style>
</head>
<body>
<h1>Be right back!</h1>
</body>
</html>`;

export default {
  async fetch() {
    return new Response(html, {
      status: 503,
      headers: {
        "content-type": "text/html; charset=utf-8",
        "retry-after": "3600",
        "cache-control": "no-store",
      },
    });
  },
};
