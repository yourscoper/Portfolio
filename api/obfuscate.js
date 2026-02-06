export default async function handler(req, res) {
  // Handle GET: serve the UI (executor-style, one wide input box, buttons bottom-right)
  if (req.method === 'GET') {
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
    html, body { height:100%; font-family:'Coming Soon',cursive; background:#0d0d0d; color:#f0f0f0; overflow-x:hidden; }
    body { cursor:url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12"><circle cx="6" cy="6" r="6" fill="white"/></svg>') 6 6,auto; }
    .container { min-height:100vh; padding:2rem 1rem 6rem; display:flex; flex-direction:column; align-items:center; }
    h1 { font-size:clamp(3rem,11vw,7rem); color:#ffffff; text-shadow:0 0 30px #0066ff88,0 0 60px #0044cc66; margin:1rem 0 .5rem; text-align:center; }
    .version, .copyright, .editor-label, .btn { font-family:'Coming Soon',cursive; }
    .version { position:fixed; bottom:20px; left:20px; color:#fff; font-size:1rem; opacity:0.85; z-index:10; }
    .copyright { position:fixed; bottom:20px; left:50%; transform:translateX(-50%); color:#fff; font-size:1rem; opacity:0.7; z-index:10; }
    .editor-box { width:100%; max-width:1600px; height:50vh; background:#111; border:1px solid #333; border-radius:8px; overflow:hidden; box-shadow:0 10px 40px rgba(0,0,0,.8); display:flex; flex-direction:column; position:relative; }
    .editor-label { padding:.8rem 1.2rem; background:#1a1a1a; border-bottom:1px solid #333; font-size:1.3rem; color:#aaa; }
    .editor-area { position:relative; flex:1; display:flex; overflow:hidden; }
    .line-numbers { width:40px; background:#0a0a0a; color:#555; text-align:right; padding:1.2rem 0.5rem 1.2rem 0; font-family:Consolas,monospace; font-size:1.05rem; line-height:1.55; user-select:none; pointer-events:none; border-right:1px solid #222; overflow:hidden; white-space:pre; }
    .code-wrapper { flex:1; position:relative; overflow:auto; }
    textarea { position:absolute; inset:0; background:transparent; color:transparent; padding:1.2rem; padding-left:45px; font-family:Consolas,monospace; font-size:1.05rem; line-height:1.55; border:none; outline:none; resize:none; white-space:pre; tab-size:2; caret-color:#fff; caret-shape:bar; z-index:3; }
    .highlight-mirror { position:absolute; inset:0; z-index:2; padding:1.2rem; padding-left:45px; pointer-events:none; white-space:pre; font-family:Consolas,monospace; font-size:1.05rem; line-height:1.55; background:#111; color:#e0e0e0; overflow:hidden; letter-spacing:0; word-spacing:0; }
    .executor-controls { position:absolute; bottom:12px; right:12px; display:flex; gap:0.8rem; z-index:10; }
    .btn { display:flex; align-items:center; gap:0.5rem; padding:0.6rem 1.2rem; font-size:1rem; background:rgba(40,40,60,.7); color:#fff; border:1px solid rgba(180,180,255,.3); border-radius:8px; cursor:pointer; transition:.2s ease; }
    .btn:hover { background:rgba(255,255,255,0.25); color:#000; transform:scale(1.05); }
    #trail-canvas, #sparkle-canvas { position:fixed; inset:0; pointer-events:none; }
    #trail-canvas { z-index:1; }
    #sparkle-canvas { z-index:0; }
    @media(max-width:900px){ .editor-box { height:60vh; } }
  </style>
</head>
<body>

<canvas id="sparkle-canvas"></canvas>
<canvas id="trail-canvas"></canvas>

<div class="container">
  <h1>Scoper's Obfuscator</h1>

  <div class="editor-box">
    <div class="editor-label">Script Input</div>
    <div class="editor-area">
      <div class="line-numbers" id="inputLines"></div>
      <div class="code-wrapper">
        <div class="highlight-mirror" id="inputMirror"></div>
        <textarea id="input" spellcheck="false" placeholder='print("Hello, World!")' autofocus></textarea>
      </div>
    </div>

    <div class="executor-controls">
      <button class="btn" id="download">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>
        Download
      </button>
      <button class="btn" id="clear">
        <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M8 6h13M6 12h13M10 18h10M3 6l2 2-2 2M3 12l2 2-2 2M3 18l2 2-2 2"/></svg>
        Clear
      </button>
    </div>
  </div>
</div>

<div class="version">v1.0.2</div>
<div class="copyright">© 2026 yourscoper. All rights reserved.</div>

<script>
hljs.configure({languages:['lua']});

// Block selection outside code area
document.addEventListener('selectstart', e => {
  if (!e.target.closest('.code-wrapper')) e.preventDefault();
});

// Ctrl+A only inside editor
document.addEventListener('keydown', e => {
  if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'a') {
    if (!e.target.closest('.code-wrapper')) e.preventDefault();
  }
});

// Tab → 2 spaces
document.getElementById('input').addEventListener('keydown', e => {
  if (e.key === 'Tab') {
    e.preventDefault();
    const start = e.target.selectionStart;
    const end = e.target.selectionEnd;
    e.target.value = e.target.value.substring(0, start) + '  ' + e.target.value.substring(end);
    e.target.selectionStart = e.target.selectionEnd = start + 2;
  }
});

// Line numbers + mirror
const input = document.getElementById('input');
const mirror = document.getElementById('inputMirror');
const inputLines = document.getElementById('inputLines');

function updateLineNumbers() {
  const lines = (input.value || '').split('\\n');
  const count = lines.length;
  let numbers = '';
  for (let i = 1; i <= count; i++) {
    numbers += i + '\\n';
  }
  inputLines.textContent = numbers;
}

function updateMirror() {
  mirror.innerHTML = hljs.highlight(input.value || ' ', {language: 'lua'}).value;
  updateLineNumbers();
}
input.addEventListener('input', updateMirror);
input.addEventListener('scroll', () => {
  mirror.parentElement.scrollTop = input.scrollTop;
  mirror.parentElement.scrollLeft = input.scrollLeft;
  inputLines.scrollTop = input.scrollTop;
});

// Download obfuscated code
document.getElementById('download').onclick = async () => {
  const code = input.value.trim();
  if (!code) return alert('No code to obfuscate/download');

  try {
    const res = await fetch('/api/obfuscate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ script: code })
    });

    if (!res.ok) {
      const err = await res.text();
      alert('Obfuscation failed: ' + err);
      return;
    }

    const obfuscated = await res.text();
    const blob = new Blob([obfuscated], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'obf_' + Math.random().toString(36).substring(2, 10) + '.lua';
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);

    alert('Downloaded obfuscated .lua file!');
  } catch (err) {
    alert('Error: ' + err.message);
  }
};

// Clear
document.getElementById('clear').onclick = () => {
  input.value = '';
  updateMirror();
};

// Mouse trail & sparkles — galaxy / blinking stars in space (full page coverage, 5x fewer but twinkling)
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

const sparkleCanvas = document.getElementById('sparkle-canvas');
const sctx = sparkleCanvas.getContext('2d');
sparkleCanvas.width = innerWidth; sparkleCanvas.height = innerHeight;
window.addEventListener('resize', () => { sparkleCanvas.width = innerWidth; sparkleCanvas.height = innerHeight; });
const stars = []; // renamed to "stars" for galaxy feel

function createStar() {
  stars.push({
    x: Math.random() * innerWidth,
    y: Math.random() * innerHeight, // ← full page (0 to 1.0)
    r: Math.random() * 1.8 + 0.4,   // small stars
    baseA: Math.random() * 0.6 + 0.3, // base brightness
    phase: Math.random() * Math.PI * 2, // random blink offset
    t: Date.now()
  });
}

function drawStars() {
  sctx.clearRect(0, 0, sparkleCanvas.width, sparkleCanvas.height);
  const now = Date.now();
  for (let j = stars.length - 1; j >= 0; j--) {
    const s = stars[j];
    // Slow pulsing (blink like stars) — sine wave for natural twinkle
    const t = (now - s.t) / 1000;
    s.a = s.baseA + Math.sin(t * 1.5 + s.phase) * 0.4; // slow blink between ~0.1 and ~1.0
    s.a = Math.max(0.1, Math.min(1, s.a)); // never fully off

    sctx.fillStyle = `rgba(240,240,255,${s.a})`; // slight blue-white for space stars
    sctx.beginPath();
    sctx.arc(s.x, s.y, s.r, 0, Math.PI * 2);
    sctx.fill();
  }
  requestAnimationFrame(drawStars);
}
drawStars();

// Initial stars + slow respawn (very few, calm galaxy)
for (let i = 0; i < 120; i++) createStar(); // ~120 stars total on screen
setInterval(() => {
  if (stars.length < 120) createStar(); // slowly replace faded ones
}, 3000); // very slow respawn

// Init
updateMirror();
updateLineNumbers(input, inputLines);
</script>
</body>
</html>`;

    res.setHeader('Content-Type', 'text/html; charset=utf-8');
    return res.status(200).send(html);
  }

  // Handle POST: proxy to MoonVeil → return raw text only
  if (req.method !== 'POST') {
    return res.status(405).send('Method Not Allowed');
  }

  let body = '';
  req.on('data', chunk => body += chunk);
  req.on('end', async () => {
    try {
      const { script } = JSON.parse(body || '{}');

      if (!script || typeof script !== 'string' || script.trim() === '') {
        return res.status(400).send('No script provided');
      }

      const apiKey = process.env.MOONVEIL_API_KEY;

      if (!apiKey) {
        return res.status(500).send('Server misconfigured - missing API key');
      }

      const response = await fetch('https://moonveil.cc/api/obfuscate', {
        method: 'POST',
        headers: {
          'Authorization': `Bearer ${apiKey}`,
          'Content-Type': 'application/json',
          'Accept': 'text/plain'
        },
        body: JSON.stringify({
          script,
          options: {
            cffDecomposeExpr: true,
            cffEnable: true,
            cffHoistLocals: true,
            embedRuntime: true,
            mangleConstLift: 0,
            mangleEnable: true,
            mangleGlobals: true,
            mangleNamedIndex: true,
            mangleNumbers: true,
            mangleSelfCalls: true,
            mangleStrings: true,
            prettify: true,
            vmDebug: false,
            vmSafeEnv: true,
            vmWrapScript: true
          }
        })
      });

      if (!response.ok) {
        const errorText = await response.text();
        return res.status(response.status).send(errorText || 'MoonVeil API failed');
      }

      const obfuscated = await response.text();
      res.setHeader('Content-Type', 'text/plain; charset=utf-8');
      res.status(200).send(obfuscated);
    } catch (err) {
      console.error('Proxy error:', err);
      res.status(500).send('Internal server error');
    }
  });
}
