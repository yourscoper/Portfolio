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
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/atom-one-dark.min.css" integrity="sha512-Jk4AqjWsdSzSWCSuQTfYRIF84Rq/eV0G2+tu07byYwHcbTGfdmLrHjUSwvzp5HvbiqK4ibmNwdcG49Y5RGYPTNU==" crossorigin="anonymous" referrerpolicy="no-referrer" />
  <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js" integrity="sha512-D9gUyxqja7hBtkWpPWGt9wfbfaMGVt9gnyCvYa+jojwwPHLCkSKVkE8f1aKL2VOpdLBSxMAQ2u26xqAXA7/6TSA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
  <style>
    *{margin:0;padding:0;box-sizing:border-box}
    html,body{height:100%;font-family:'Coming Soon',cursive;background:#0d0d0d;color:#f0f0f0;overflow-x:hidden;overflow-y:auto}
    body{cursor:url("data:image/svg+xml,%3Csvg width='32' height='32' viewBox='0 0 32 32' xmlns='http://www.w3.org/2000/svg'%3E%3Ccircle cx='16' cy='16' r='10' fill='none' stroke='%23ffffff' stroke-width='2' opacity='0.9'/%3E%3Ccircle cx='16' cy='16' r='3' fill='%23ffffff'/%3E%3C/svg%3E") 16 16,crosshair}
    .container{min-height:100vh;padding:2rem 1rem 4rem;position:relative;display:flex;flex-direction:column;align-items:center}
    h1{font-size:clamp(3.5rem,12vw,8rem);color:#fff;text-shadow:0 0 40px rgba(255,255,255,.45),0 0 80px rgba(180,180,255,.25);margin-bottom:.2rem;letter-spacing:-2px;text-align:center}
    .version{font-size:1.6rem;color:#ddd;opacity:.9;margin-bottom:2.5rem;text-shadow:0 0 20px rgba(255,255,255,.3);align-self:flex-start}
    .editors{width:100%;max-width:1400px;display:grid;grid-template-columns:1fr 1fr;gap:1.5rem;margin-bottom:2rem;position:relative}
    .editor-box{display:flex;flex-direction:column;height:520px;border:1px solid #222;border-radius:8px;overflow:hidden;background:#111;box-shadow:0 10px 40px rgba(0,0,0,.7);position:relative}
    .editor-label{padding:.8rem 1.2rem;background:#1a1a1a;border-bottom:1px solid #222;font-size:1.3rem;color:#aaa}
    textarea{position:absolute;inset:0;z-index:2;background:transparent;color:transparent;resize:none;border:none;outline:none;padding:1.2rem;font-size:1.05rem;line-height:1.55;font-family:Consolas,monospace;caret-color:#fff}
    .highlight-mirror{position:absolute;inset:0;z-index:1;overflow:auto;padding:1.2rem;pointer-events:none;white-space:pre-wrap;word-wrap:break-word;font-size:1.05rem;line-height:1.55;background:#0f0f0f;color:#e0e0e0}
    pre{margin:0;height:100%}
    pre code.hljs{padding:1.2rem !important;height:100%;overflow:auto}
    .controls{display:flex;justify-content:center;gap:1.5rem;flex-wrap:wrap;margin:1.5rem 0 3rem}
    .btn{display:inline-flex;align-items:center;gap:.7rem;padding:.9rem 1.8rem;font-size:1.2rem;font-family:'Coming Soon',cursive;color:white;background:rgba(40,40,60,.6);border:1px solid rgba(180,180,255,.25);border-radius:10px;cursor:pointer;transition:all .22s ease;backdrop-filter:blur(4px);text-shadow:0 1px 4px rgba(0,0,0,.6)}
    .btn:hover{transform:translateY(-3px);box-shadow:0 12px 30px rgba(120,100,255,.35),0 0 40px rgba(180,160,255,.25);border-color:rgba(200,190,255,.6);background:rgba(60,50,90,.7)}
    footer{margin-top:auto;padding:2rem 0 1rem;color:#888;font-size:1.1rem;opacity:.7}
    #trailCanvas,#particles{position:fixed;inset:0;pointer-events:none;z-index:-1}
    @media (max-width:900px){.editors{grid-template-columns:1fr}.editor-box{height:380px}h1{font-size:clamp(3rem,10vw,5.5rem)}}
  </style>
</head>
<body>

<canvas id="trailCanvas"></canvas>
<canvas id="particles"></canvas>

<div class="container">
  <h1>Scoper's Obfuscator</h1>
  <div class="version">v1.0.0</div>

  <div class="editors">
    <div class="editor-box">
      <div class="editor-label">Input Lua / LuaU</div>
      <div class="highlight-mirror" id="inputMirror"></div>
      <textarea id="input" placeholder="-- Paste your Lua/LuaU code here...\n-- Press Obfuscate when ready" autofocus spellcheck="false"></textarea>
    </div>

    <div class="editor-box">
      <div class="editor-label">Obfuscated Output</div>
      <pre><code id="output" class="language-lua"></code></pre>
    </div>
  </div>

  <div class="controls">
    <button class="btn" id="obfuscate"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><polygon points="5 3 19 12 5 21 5 3"/></svg>Obfuscate</button>
    <button class="btn" id="clear"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M8 6h13M6 12h13M10 18h10M3 6l2 2-2 2M3 12l2 2-2 2M3 18l2 2-2 2"/></svg>Clear</button>
    <button class="btn" id="copy"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"/><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"/></svg>Copy Output</button>
  </div>

  <footer>© 2026 yourscoper. All rights reserved.</footer>
</div>

<script>
hljs.configure({languages:['lua']});
hljs.highlightAll();

// Disable text selection globally
document.addEventListener('selectstart', e => e.preventDefault());
document.addEventListener('keydown', e => {
  if ((e.ctrlKey || e.metaKey) && e.key.toLowerCase() === 'a') {
    e.preventDefault();
  }
});

// Input mirror for fake highlighting
const input = document.getElementById('input');
const inputMirror = document.getElementById('inputMirror');
const output = document.getElementById('output');

function updateMirror() {
  let code = input.value || '';
  inputMirror.textContent = code;
  hljs.highlightElement(inputMirror);
}
input.addEventListener('input', updateMirror);
input.addEventListener('scroll', () => { inputMirror.scrollTop = input.scrollTop; inputMirror.scrollLeft = input.scrollLeft; });

// Highlight output
function highlightOutput(text) {
  output.textContent = text;
  hljs.highlightElement(output);
}

// Mouse trail (fading lines)
const trailCanvas = document.getElementById('trailCanvas');
const tctx = trailCanvas.getContext('2d');
let trailPoints = [];
function resizeCanvases() {
  trailCanvas.width = window.innerWidth;
  trailCanvas.height = window.innerHeight;
  particlesCanvas.width = window.innerWidth;
  particlesCanvas.height = window.innerHeight;
}
window.addEventListener('resize', resizeCanvases);
resizeCanvases();

document.addEventListener('mousemove', e => {
  trailPoints.push({x: e.clientX, y: e.clientY, t: Date.now()});
});
function drawTrail() {
  tctx.clearRect(0,0,trailCanvas.width,trailCanvas.height);
  const now = Date.now();
  for (let i = trailPoints.length - 1; i >= 0; i--) {
    if (now - trailPoints[i].t > 800) { trailPoints.splice(i,1); continue; }
    const age = (now - trailPoints[i].t) / 800;
    if (i > 0) {
      tctx.beginPath();
      tctx.moveTo(trailPoints[i-1].x, trailPoints[i-1].y);
      tctx.lineTo(trailPoints[i].x, trailPoints[i].y);
      tctx.strokeStyle = \`rgba(255,255,255,\${1-age})\`;
      tctx.lineWidth = 2.5;
      tctx.stroke();
    }
  }
  requestAnimationFrame(drawTrail);
}
drawTrail();

// Sparkles (2x amount)
const particlesCanvas = document.getElementById('particles');
const pctx = particlesCanvas.getContext('2d');
let particles = [];
class Particle {
  constructor() { this.reset(); }
  reset() {
    this.x = Math.random() * particlesCanvas.width;
    this.y = particlesCanvas.height + 30;
    this.size = Math.random() * 2.8 + 0.8;
    this.speed = Math.random() * 0.7 + 0.2;
    this.opacity = Math.random() * 0.5 + 0.35;
    this.delay = Math.random() * 3000;
    this.glow = Math.random() > 0.5 ? 1 : 0.5;
  }
  update(time) {
    if (time < this.delay) return;
    this.y -= this.speed;
    if (this.y < -20) this.reset();
  }
  draw() {
    pctx.globalAlpha = this.opacity;
    pctx.shadowBlur = 15 * this.glow;
    pctx.shadowColor = '#ffffff';
    pctx.fillStyle = '#ffffff';
    pctx.beginPath();
    pctx.arc(this.x, this.y, this.size, 0, Math.PI * 2);
    pctx.fill();
  }
}
for (let i = 0; i < 360; i++) particles.push(new Particle());
function animateParticles(time = 0) {
  pctx.clearRect(0,0,particlesCanvas.width,particlesCanvas.height);
  particles.forEach(p => { p.update(time); p.draw(); });
  requestAnimationFrame(animateParticles);
}
animateParticles();

// Buttons
document.getElementById('obfuscate').onclick = () => {
  const code = input.value.trim();
  if (!code) return highlightOutput("-- Nothing to obfuscate");
  const escaped = code
    .replace(/\\/g, '\\\\')
    .replace(/'/g, "\\'")
    .replace(/\n/g, '\\n')
    .replace(/\r/g, '\\r');
  const wrapped = \`loadstring('\${escaped}')()\`;
  highlightOutput(wrapped);
};

document.getElementById('clear').onclick = () => {
  input.value = '';
  updateMirror();
  highlightOutput('');
  input.focus();
};

document.getElementById('copy').onclick = () => {
  if (!output.textContent.trim()) return;
  navigator.clipboard.writeText(output.textContent).then(() => {
    const btn = document.getElementById('copy');
    const orig = btn.innerHTML;
    btn.innerHTML = '<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M20 6 9 17l-5-5"/></svg> Copied!';
    setTimeout(() => btn.innerHTML = orig, 1800);
  }).catch(() => {});
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
