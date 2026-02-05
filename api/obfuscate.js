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
    *{margin:0;padding:0;box-sizing:border-box;user-select:none;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none}
    html,body{height:100%;font-family:'Coming Soon',cursive;background:#0d0d0d;color:#f0f0f0;overflow-x:hidden}
    body{cursor:url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12"><circle cx="6" cy="6" r="6" fill="white"/></svg>') 6 6,auto}
    .container{min-height:100vh;padding:2rem 1rem 5rem;position:relative;display:flex;flex-direction:column;align-items:center}
    h1{font-size:clamp(3rem,11vw,7rem);color:#0066ff;text-shadow:0 0 30px #0066ff88,0 0 60px #0044cc66;margin:1rem 0 .5rem;letter-spacing:-1px;text-align:center}
    .version{position:fixed;bottom:20px;left:20px;color:#aaa;font-size:1rem;opacity:0.85;z-index:10;text-shadow:0 0 8px #000}
    .editors{width:100%;max-width:1400px;display:grid;grid-template-columns:1fr 1fr;gap:1.5rem;margin:1rem 0 2rem}
    .editor-box{position:relative;display:flex;flex-direction:column;height:520px;border:1px solid #222;border-radius:8px;overflow:hidden;background:#111;box-shadow:0 10px 40px rgba(0,0,0,.7)}
    .editor-label{padding:.8rem 1.2rem;background:#1a1a1a;border-bottom:1px solid #222;font-size:1.3rem;color:#aaa}
    textarea{position:absolute;inset:0;z-index:10;background:transparent;color:#fff;resize:none;border:none;outline:none;padding:1.2rem;font-size:1.05rem;line-height:1.55;font-family:Consolas,monospace;caret-color:#0f8}
    .highlight-mirror{position:absolute;inset:0;z-index:5;padding:1.2rem;pointer-events:none;white-space:pre-wrap;word-wrap:break-word;font-size:1.05rem;line-height:1.55;background:#0f0f0f;overflow:hidden}
    pre{margin:0;height:100%}
    pre code.hljs{padding:1.2rem !important;height:100%;overflow:auto}
    .controls{display:flex;justify-content:center;gap:1.5rem;flex-wrap:wrap;margin:1.5rem 0 3rem}
    .btn{display:inline-flex;align-items:center;gap:.7rem;padding:.9rem 1.8rem;font-size:1.2rem;font-family:'Coming Soon',cursive;color:white;background:rgba(40,40,60,.6);border:1px solid rgba(180,180,255,.25);border-radius:10px;cursor:pointer;transition:all .22s ease}
    .btn:hover{transform:translateY(-3px);box-shadow:0 12px 30px rgba(120,100,255,.35);background:rgba(60,50,90,.7)}
    footer{margin-top:auto;padding:2rem 0 1rem;color:#666;font-size:1.1rem;opacity:.7;text-align:center}
    #trail-canvas,#sparkle-canvas{position:fixed;inset:0;pointer-events:none;z-index:-1}
    @media (max-width:900px){.editors{grid-template-columns:1fr}.editor-box{height:380px}h1{font-size:clamp(2.8rem,9vw,5rem)}}
  </style>
</head>
<body>

<canvas id="trail-canvas"></canvas>
<canvas id="sparkle-canvas"></canvas>

<div class="container">
  <h1>Scoper's Obfuscator</h1>

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

<div class="version">v1.0.0</div>

<script>
hljs.configure({languages:['lua']});
hljs.highlightAll();

// Block all selection
document.addEventListener('selectstart', e=>e.preventDefault());
document.addEventListener('keydown', e=>{if((e.ctrlKey||e.metaKey)&&e.key.toLowerCase()==='a')e.preventDefault()});

// Input mirror highlighting
const input = document.getElementById('input');
const mirror = document.getElementById('inputMirror');
const output = document.getElementById('output');

function updateMirror(){
  mirror.textContent = input.value;
  hljs.highlightElement(mirror);
}
input.addEventListener('input', updateMirror);
input.addEventListener('scroll', ()=>{mirror.scrollTop=input.scrollTop; mirror.scrollLeft=input.scrollLeft;});

// Output highlight
function highlightOutput(txt){
  output.textContent = txt;
  hljs.highlightElement(output);
}

// Mouse trail (copied logic)
const trail = document.getElementById('trail-canvas');
const tctx = trail.getContext('2d');
trail.width = innerWidth; trail.height = innerHeight;
window.addEventListener('resize', ()=>{trail.width=innerWidth;trail.height=innerHeight});
const points = [];
document.addEventListener('mousemove', e=>points.push({x:e.clientX,y:e.clientY,t:Date.now()}));
function drawTrail(){
  tctx.clearRect(0,0,trail.width,trail.height);
  const now = Date.now();
  for(let i=points.length-1;i>=0;i--){
    if(now-points[i].t>1000){points.splice(i,1);continue}
    const age=(now-points[i].t)/1000;
    if(i>0){
      tctx.beginPath();
      tctx.moveTo(points[i-1].x,points[i-1].y);
      tctx.lineTo(points[i].x,points[i].y);
      tctx.strokeStyle=\`rgba(255,255,255,\${1-age})\`;
      tctx.lineWidth=2;
      tctx.stroke();
    }
  }
  requestAnimationFrame(drawTrail);
}
drawTrail();

// Sparkles (2× density → create every 200ms)
const sparkle = document.getElementById('sparkle-canvas');
const sctx = sparkle.getContext('2d');
sparkle.width = innerWidth; sparkle.height = innerHeight;
window.addEventListener('resize', ()=>{sparkle.width=innerWidth;sparkle.height=innerHeight});
const sparkles = [];
function createSparkle(){
  sparkles.push({x:Math.random()*innerWidth, y:Math.random()*innerHeight*0.6, r:Math.random()*2.5+1, a:1, t:Date.now()});
}
function drawSparkles(){
  sctx.clearRect(0,0,sparkle.width,sparkle.height);
  const now = Date.now();
  for(let i=sparkles.length-1;i>=0;i--){
    const s=sparkles[i];
    const age=(now-s.t)/1000;
    s.a=1-age/1.5;
    if(s.a<=0){sparkles.splice(i,1);continue}
    sctx.fillStyle=\`rgba(255,255,255,\${s.a})\`;
    sctx.beginPath();
    sctx.arc(s.x,s.y,s.r,0,Math.PI*2);
    sctx.fill();
  }
  requestAnimationFrame(drawSparkles);
}
drawSparkles();
setInterval(createSparkle, 200); // 2× faster creation → roughly 2× more sparkles

// Buttons logic
document.getElementById('obfuscate').onclick=()=>{
  const code=input.value.trim();
  if(!code)return highlightOutput("-- Nothing to obfuscate");
  const escaped=code.replace(/\\\\/g,'\\\\\\\\').replace(/'/g,"\\\\'").replace(/\\n/g,'\\\\n').replace(/\\r/g,'\\\\r');
  highlightOutput(\`loadstring('\${escaped}')()\`);
};

document.getElementById('clear').onclick=()=>{
  input.value='';
  updateMirror();
  highlightOutput('');
  input.focus();
};

document.getElementById('copy').onclick=()=>{
  if(!output.textContent.trim())return;
  navigator.clipboard.writeText(output.textContent).then(()=>{
    const b=document.getElementById('copy');
    const o=b.innerHTML;
    b.innerHTML='<svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M20 6 9 17l-5-5"/></svg> Copied!';
    setTimeout(()=>b.innerHTML=o,1800);
  }).catch(()=>{});
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
