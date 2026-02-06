export default function handler(req, res) {
  if (req.method !== 'GET') {
    return res.status(405).send('Method Not Allowed');
  }

  const html = `<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Scoper's Obfuscator</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Coming+Soon&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/atom-one-dark.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/highlight.min.js"></script>
  <style>
    * { margin:0; padding:0; box-sizing:border-box; }
    html, body {
      height:100%;
      font-family:'Coming Soon',cursive;
      background:#0d0d0d;
      color:#f0f0f0;
      overflow-x:hidden;
    }
    body {
      cursor:url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12"><circle cx="6" cy="6" r="6" fill="white"/></svg>') 6 6,auto;
    }
    .container {
      min-height:100vh;
      padding:2rem 1rem 6rem;
      display:flex;
      flex-direction:column;
      align-items:center;
    }
    h1 {
      font-size:clamp(3rem,11vw,7rem);
      color:#ffffff;
      text-shadow:0 0 30px #0066ff88,0 0 60px #0044cc66;
      margin:1rem 0 .5rem;
      text-align:center;
    }
    .version, .copyright, .editor-label, .btn {
      font-family:'Coming Soon',cursive;
    }
    .version {
      position:fixed;
      bottom:20px;
      left:20px;
      color:#aaa;
      font-size:1rem;
      opacity:0.85;
      z-index:10;
    }
    .copyright {
      position:fixed;
      bottom:20px;
      left:50%;
      transform:translateX(-50%);
      color:#666;
      font-size:1rem;
      opacity:0.7;
      z-index:10;
    }
    .editors {
      width:100%;
      max-width:1400px;
      display:grid;
      grid-template-columns:1fr 1fr;
      gap:1.5rem;
      margin:1rem 0 2rem;
      position:relative;
      z-index:10;
    }
    .editor-box {
      height:520px;
      background:#111;
      border:1px solid #333;
      border-radius:8px;
      overflow:hidden;
      box-shadow:0 10px 40px rgba(0,0,0,.8);
    }
    .editor-label {
      padding:.8rem 1.2rem;
      background:#1a1a1a;
      border-bottom:1px solid #333;
      font-size:1.3rem;
      color:#aaa;
    }
    .editor-area {
      position:relative;
      height:calc(100% - 48px);
    }
    textarea, #output-container {
      position:absolute;
      inset:0;
      background:#111;
      color:#e0e0e0;
      padding:1.2rem;
      font-family:Consolas,monospace;
      font-size:1.05rem;
      line-height:1.55;
      border:none;
      outline:none;
      resize:none;
      white-space:pre;
      tab-size:2;
    }
    #input {
      z-index:3;
      caret-color:#fff;
    }
    #output-container {
      z-index:3;
      overflow:auto;
      cursor:default;
    }
    .highlight-mirror {
      position:absolute;
      inset:0;
      z-index:2;
      padding:1.2rem;
      pointer-events:none;
      white-space:pre;
      font-family:Consolas,monospace;
      font-size:1.05rem;
      line-height:1.55;
      background:#111;
      color:#e0e0e0;
      overflow:hidden;
    }
    .controls {
      margin-top:1.5rem;
      display:flex;
      gap:1.2rem;
      flex-wrap:wrap;
      justify-content:center;
    }
    .btn {
      display:inline-flex;
      align-items:center;
      gap:.6rem;
      padding:.9rem 1.8rem;
      font-size:1.2rem;
      background:rgba(40,40,60,.6);
      color:#fff;
      border:1px solid rgba(180,180,255,.25);
      border-radius:10px;
      cursor:pointer;
      transition:.25s ease;
    }
    .btn:hover {
      transform:translateY(-3px);
      box-shadow:0 12px 30px rgba(120,100,255,.35);
    }
    #trail-canvas, #sparkle-canvas {
      position:fixed;
      inset:0;
      pointer-events:none;
    }
    #trail-canvas { z-index:1; }
    #sparkle-canvas { z-index:0; }
    @media(max-width:900px){
      .editors{grid-template-columns:1fr}
      .editor-box{height:380px}
    }
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
      <div class="editor-area">
        <div class="highlight-mirror" id="inputMirror"></div>
        <textarea id="input" spellcheck="false" placeholder="-- Paste your Lua/LuaU code here...\n-- Press Obfuscate when ready" autofocus></textarea>
      </div>
    </div>

    <div class="editor-box">
      <div class="editor-label">Obfuscated Output</div>
      <div class="editor-area">
        <pre id="output-container"><code id="output" class="language-lua"></code></pre>
      </div>
    </div>
  </div>

  <div class="controls">
    <button class="btn" id="obfuscate">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg>
      Obfuscate
    </button>
    <button class="btn" id="clear">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><path d="M8 6h13M6 12h13M10 18h10M3 6l2 2-2 2M3 12l2 2-2 2M3 18l2 2-2 2"/></svg>
      Clear
    </button>
    <button class="btn" id="copy">
      <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg>
      Copy Output
    </button>
  </div>
</div>

<div class="version">v1.0.1</div>
<div class="copyright">© 2026 yourscoper. All rights reserved.</div>

<script>
hljs.configure({languages:['lua']});

// Selection control: only inside code areas
document.addEventListener('selectstart', e => {
  if (!e.target.closest('textarea') && !e.target.closest('#output-container')) {
    e.preventDefault();
  }
});
document.addEventListener('keydown', e => {
  if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'a') {
    const isInEditor = e.target.closest('textarea') || e.target.closest('#output-container');
    if (!isInEditor) e.preventDefault();
  }
});

// Tab → insert 2 spaces
document.getElementById('input').addEventListener('keydown', e => {
  if (e.key === 'Tab') {
    e.preventDefault();
    const start = e.target.selectionStart;
    const end = e.target.selectionEnd;
    e.target.value = e.target.value.substring(0, start) + '  ' + e.target.value.substring(end);
    e.target.selectionStart = e.target.selectionEnd = start + 2;
  }
});

// Mirror highlight
const input = document.getElementById('input');
const mirror = document.getElementById('inputMirror');
const output = document.getElementById('output');

function updateMirror() {
  mirror.innerHTML = hljs.highlight(input.value || ' ', {language: 'lua'}).value;
}
input.addEventListener('input', updateMirror);
input.addEventListener('scroll', () => {
  mirror.parentElement.scrollTop = input.scrollTop;
  mirror.parentElement.scrollLeft = input.scrollLeft;
});

function highlightOutput(text) {
  output.innerHTML = hljs.highlight(text, {language: 'lua'}).value;
}

// Mouse trail (exact from your main page)
const trailCanvas = document.getElementById('trail-canvas');
const tctx = trailCanvas.getContext('2d');
trailCanvas.width = innerWidth; trailCanvas.height = innerHeight;
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
      tctx.strokeStyle = \`rgba(255,255,255,\${1-age})\`;
      tctx.lineWidth = 2;
      tctx.stroke();
    }
  }
  requestAnimationFrame(drawTrail);
}
drawTrail();

// Sparkles — 3× density
const sparkleCanvas = document.getElementById('sparkle-canvas');
const sctx = sparkleCanvas.getContext('2d');
sparkleCanvas.width = innerWidth; sparkleCanvas.height = innerHeight;
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
    sctx.fillStyle = \`rgba(255,255,255,\${s.a})\`;
    sctx.beginPath();
    sctx.arc(s.x, s.y, s.r, 0, Math.PI*2);
    sctx.fill();
  }
  requestAnimationFrame(drawSparkles);
}
drawSparkles();
setInterval(() => { createSparkle(); createSparkle(); createSparkle(); }, 300); // faster + triple spawn

// Buttons
document.getElementById('obfuscate').onclick = () => {
  const c = input.value.trim();
  if (!c) return highlightOutput('-- Nothing to obfuscate');
  const e = c.replace(/\\\\/g,'\\\\\\\\').replace(/'/g,"\\\\'").replace(/\\n/g,'\\\\n').replace(/\\r/g,'\\\\r');
  highlightOutput("loadstring('" + e + "')()");
};

document.getElementById('clear').onclick = () => {
  input.value = '';
  updateMirror();
  highlightOutput('');
};

document.getElementById('copy').onclick = () => {
  navigator.clipboard.writeText(output.textContent);
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
