// api/obfuscate.js
export default function handler(req, res) {
  res.setHeader("Content-Type", "text/html; charset=utf-8");

  res.status(200).send(`<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Test Obfuscate</title>
  <style>
    body { background:#111; color:#fff; font-family:sans-serif; padding:40px; text-align:center; }
    h1 { color:#0f0; }
  </style>
</head>
<body>
  <h1>Hello from Vercel — it works</h1>
  <p>If you see this → function is running correctly.</p>
</body>
</html>`);
}
