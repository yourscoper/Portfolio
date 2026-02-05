export default function handler(req, res) {
  if (req.method !== 'GET') {
    return res.status(405).send('Method Not Allowed');
  }

  const html = `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Scoper's Obfuscator</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Coming+Soon&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/atom-one-dark.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/highlight.min.js"></script>
  <style>
    *{margin:0;padding:0;box-sizing:border-box;user-select:none;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none}
    html,body{height:100%;font-family:'Coming Soon',cursive;background:#0d0d0d;color:#f0f0f0;overflow-x:hidden}
    body{cursor:url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12"><circle cx="6" cy="6" r="6" fill="white"/></svg>') 6 6,auto}
    .container{min-height:100vh;padding:2rem 1rem 6rem;position:relative;display:flex;flex-direction:column;align-items:center}
    h1{font-size:clamp(3rem,11vw,7rem);color:#ffffff;text-shadow:0 0 30px #0066ff88,0 0 60px #0044cc66,0 0 90px #00226644;margin:1rem 0 .5rem;letter-spacing:-1px;text-align:center}
    .version{position:fixed;bottom:20px;left:20px;color:#aaa;font-size:1rem;opacity:0.85;z-index:10}
    .copyright{position:fixed;bottom:20px;left:50%;transform:translateX(-50%);color:#666;font-size:1rem;opacity:0.7;z-index:10}
    .editors{width:100%;max-width:1400px;display:grid;grid-template-columns:1fr 1fr;gap:1.5rem;margin:1rem 0 2rem}
    .editor-box{position:relative;display:flex;flex-direction:column;height:520px;border:1px solid #222;border-radius:8px;overflow:hidden;background:#111;box-shadow:0 10px 40px rgba(0,0,0,.7)}
    .editor-label{padding:.8rem 1.2rem;background:#1a1a1a;border-bottom:1px solid #222;font-size:1.3rem;color:#aaa}
    textarea{position:absolute;inset:0;z-index:10;background:transparent;color:transparent;resize:none;border:none;outline:none;padding:1.2rem;font-size:1.05rem;line-height:1.55;font-family:Consolas,monospace;caret-color:#0f8}
    .highlight-mirror{position:absolute;inset:0;z-index:5;padding:1.2rem;pointer-events:none;white-space:pre-wrap;word-wrap:break-word;font-size:1.05rem;line-height:1.55;background:#0f0f0f;overflow:hidden}
    pre{margin:0;height:100%}
    pre code.hljs{padding:1.2rem !important;height:100%;overflow:auto}
    .controls{display:flex;justify-content:center;gap:1.5rem;flex-wrap:wrap;margin:1.5rem 0 3rem}
    .btn{display:inline-flex;align-items:center;gap:.7rem;padding:.9rem 1.8rem;font-size:1.2rem;font-family:'Coming Soon',cursive;color:white;background:rgba(40,40,60,.6);border:1px solid rgba(180,180,255,.25);border-radius:10px;cursor:pointer;transition:all .22s ease}
    .btn:hover{transform:translateY(-3px);box-shadow:0 12px 30px rgba(120,100,255,.35);background:rgba(60,50,90,.7)}
    #trail-canvas,#sparkle-canvas{position:fixed;inset:0;pointer-events:none}
    #trail-canvas{z-index:4}
    #sparkle-canvas{z-index:2}
    @media (max-width:900px){.editors{grid-template-columns:1fr}.editor-box{height:380px}}
  </style>
</head>
<body>

<canvas id="sparkle-canvas"></canvas>
<canvas id="trail-canvas"></canvas>

<div class="container">
  <h1>Scoper's Obfuscator</h1>

  <div class="editors">
    <div class="editor-box">
      <div class="editor-label">Input Lua / LuaU</div>
      <div class="highlight-mirror" id="inputMirror"></div>
      <textarea id="input" placeholder="-- Paste your Lua/LuaU code here...\n-- Press Obfuscate when ready" autofocus></textarea>
    </div>

    <div class="editor-box">
      <div class="editor-label">Obfuscated Output</div>
      <pre><code id="output" class="language-lua"></code></pre>
    </div>
  </div>

  <div class="controls">
    <button class="btn" id="obfuscate">Obfuscate</button>
    <button class="btn" id="clear">Clear</button>
    <button class="btn" id="copy">Copy Output</button>
  </div>
</div>

<div class="version">v1.0.0</div>
<div class="copyright">© 2026 yourscoper. All rights reserved.</div>

<script>
hljs.configure({languages:['lua']});

// Block selection
document.onselectstart = () => false;
document.onkeydown = e => { if ((e.ctrlKey || e.metaKey) && e.key === 'a') e.preventDefault(); };

// Highlight mirror
const input = document.getElementById('input');
const mirror = document.getElementById('inputMirror');
const output = document.getElementById('output');

function updateMirror() {
  mirror.textContent = input.value || ' ';
  hljs.highlightElement(mirror);
}
input.addEventListener('input', updateMirror);
input.addEventListener('scroll', () => {
  mirror.scrollTop = input.scrollTop;
  mirror.scrollLeft = input.scrollLeft;
});

function highlightOutput(text) {
  output.textContent = text;
  hljs.highlightElement(output);
}

// Mouse trail & sparkles - EXACT from your main page
const trailCanvas = document.getElementById('trail-canvas');
const tctx = trailCanvas.getContext('2d');
trailCanvas.width = innerWidth;
trailCanvas.height = innerHeight;
window.addEventListener('resize', () => { trailCanvas.width = innerWidth; trailCanvas.height = innerHeight; });
const points = [];
document.addEventListener('mousemove', e => points.push({x: e.clientX, y: e.clientY, t: Date.now()}));
function drawTrail() {
  tctx.clearRect(0,0,trailCanvas.width,trailCanvas.height);
  const now = Date.now();
  for (let j = points.length - 1; j >= 0; j--) {
    if (now - points[j].t > 1000) { points.splice(j, 1); continue; }
    const age = (now - points[j].t) / 1000;
    if (j > 0) {
      tctx.beginPath();
      tctx.moveTo(points[j-1].x, points[j-1].y);
      tctx.lineTo(points[j].x, points[j].y);
      tctx.strokeStyle = 'rgba(255,255,255,' + (1 - age) + ')';
      tctx.lineWidth = 2;
      tctx.stroke();
    }
  }
  requestAnimationFrame(drawTrail);
}
drawTrail();

const sparkleCanvas = document.getElementById('sparkle-canvas');
const sctx = sparkleCanvas.getContext('2d');
sparkleCanvas.width = innerWidth;
sparkleCanvas.height = innerHeight;
window.addEventListener('resize', () => { sparkleCanvas.width = innerWidth; sparkleCanvas.height = innerHeight; });
const sparkles = [];
function createSparkle() {
  sparkles.push({ x: Math.random() * innerWidth, y: Math.random() * innerHeight * 0.6, r: Math.random() * 2.5 + 1, a: 1, t: Date.now() });
}
function drawSparkles() {
  sctx.clearRect(0,0,sparkleCanvas.width,sparkleCanvas.height);
  const now = Date.now();
  for (let j = sparkles.length - 1; j >= 0; j--) {
    const s = sparkles[j];
    const age = (now - s.t) / 1000;
    s.a = 1 - age / 1.5;
    if (s.a <= 0) { sparkles.splice(j,1); continue; }
    sctx.fillStyle = 'rgba(255,255,255,' + s.a + ')';
    sctx.beginPath();
    sctx.arc(s.x, s.y, s.r, 0, Math.PI*2);
    sctx.fill();
  }
  requestAnimationFrame(drawSparkles);
}
drawSparkles();
setInterval(createSparkle, 400);

// Buttons
document.getElementById('obfuscate').onclick = () => {
  const code = input.value.trim();
  if (!code) {
    highlightOutput("-- Nothing to obfuscate");
    return;
  }
  const escaped = code
    .replace(/\\\\/g, '\\\\\\\\')
    .replace(/'/g, "\\\\'")
    .replace(/\\n/g, '\\\\n')
    .replace(/\\r/g, '\\\\r');
  highlightOutput("loadstring('" + escaped + "')()");
};

document.getElementById('clear').onclick = () => {
  input.value = '';
  updateMirror();
  highlightOutput('');
  input.focus();
};

document.getElementById('copy').onclick = () => {
  const text = output.textContent.trim();
  if (!text) return;
  navigator.clipboard.writeText(text).then(() => {
    const btn = document.getElementById('copy');
    const old = btn.innerHTML;
    btn.innerHTML = 'Copied!';
    setTimeout(() => btn.innerHTML = old, 1800);
  });
};

// Init
updateMirror();
highlightOutput('');
</script>
</body>
</html>`;

  res.setHeader('Content-Type', 'text/html; charset=utf-8');
  res.status(200).send(html);
}
