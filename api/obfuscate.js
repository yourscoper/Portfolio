// api/obfuscate.js
export default function handler(req, res) {
  res.setHeader("Content-Type", "text/html; charset=utf-8");

  res.status(200).send(`<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Obfuscate Lua</title>
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Coming+Soon&display=swap">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/styles/atom-one-dark.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/highlight.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.9.0/languages/lua.min.js"></script>
  <style>
    *{margin:0;padding:0;box-sizing:border-box;font-family:'Coming Soon',cursive;cursor:none!important}
    body{background:#0d0d0d;color:#fff;min-height:100vh;position:relative;overflow-x:hidden;cursor:url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='32' height='32' viewBox='0 0 32 32'><circle cx='16' cy='16' r='14' fill='none' stroke='%23ffffff' stroke-width='3' opacity='0.9'/><circle cx='16' cy='16' r='5' fill='%23ffffff'/></svg>") 16 16,auto}
    canvas{position:fixed;inset:0;pointer-events:none;z-index:1}
    header{text-align:center;padding:60px 20px 30px;position:relative;z-index:10}
    h1{font-size:4.5rem;color:#fff;text-shadow:0 0 35px rgba(255,255,255,.6);margin-bottom:12px}
    .version{font-size:2.1rem;color:#fff;opacity:.92;letter-spacing:1px}
    .container{max-width:1440px;margin:0 auto;padding:0 30px;display:grid;grid-template-columns:1fr 1fr;gap:40px;position:relative;z-index:5}
    .editor{display:flex;flex-direction:column;gap:16px}
    label{font-size:1.8rem;color:#ddd}
    textarea{width:100%;height:580px;background:rgba(20,20,20,.8);color:#e0e0e0;border:2px solid #444;border-radius:14px;padding:20px;font-size:1.05rem;font-family:Consolas,monospace;resize:vertical;outline:none;backdrop-filter:blur(8px)}
    textarea:focus{border-color:#777;box-shadow:0 0 25px rgba(255,255,255,.18)}
    pre#output{margin:0;padding:20px;background:rgba(20,20,20,.8);border:2px solid #444;border-radius:14px;min-height:580px;font-family:Consolas,monospace;font-size:1.05rem;white-space:pre-wrap;word-wrap:break-word;overflow-y:auto;backdrop-filter:blur(8px)}
    .controls{grid-column:1/-1;display:flex;justify-content:center;gap:40px;flex-wrap:wrap;margin:50px 0}
    button{display:flex;align-items:center;gap:14px;background:rgba(255,255,255,.05);border:1px solid rgba(255,255,255,.15);color:#fff;padding:16px 36px;font-size:1.45rem;border-radius:12px;cursor:pointer;transition:all .28s;backdrop-filter:blur(12px);text-shadow:0 0 10px rgba(255,255,255,.5);box-shadow:0 0 20px rgba(0,0,0,.5)}
    button:hover{background:rgba(255,255,255,.12);transform:translateY(-3px);box-shadow:0 12px 35px rgba(255,255,255,.25)}
    button svg{width:28px;height:28px;stroke:#fff;stroke-width:2.2}
    footer{text-align:center;padding:80px 20px 60px;color:#888;font-size:1.35rem;position:relative;z-index:5}
    footer span{color:#fff}
    @media (max-width:900px){.container{grid-template-columns:1fr}h1{font-size:3.6rem}.version{font-size:1.7rem}}
  </style>
</head>
<body>
<canvas id="sparkles"></canvas>
<header>
  <h1>Obfuscate Lua</h1>
  <div class="version">v1.0.8</div>
</header>
<div class="container">
  <div class="editor">
    <label>Input Lua Code</label>
    <textarea id="input" placeholder="-- paste your lua / luau code here..."></textarea>
  </div>
  <div class="editor">
    <label>Obfuscated Output</label>
    <pre id="output">-- obfuscated code appears here</pre>
  </div>
  <div class="controls">
    <button onclick="obfuscate()">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 5a2 2 0 0 1 3.008-1.728l11.997 6.998a2 2 0 0 1 .003 3.458l-12 7A2 2 0 0 1 5 19z"></path></svg>
      Obfuscate
    </button>
    <button onclick="clearAll()">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 21H8a2 2 0 0 1-1.42-.587l-3.994-3.999a2 2 0 0 1 0-2.828l10-10a2 2 0 0 1 2.829 0l5.999 6a2 2 0 0 1 0 2.828L12.834 21"></path><path d="m5.082 11.09 8.828 8.828"></path></svg>
      Clear
    </button>
    <button onclick="copyOutput()">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="14" height="14" x="8" y="8" rx="2" ry="2"></rect><path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2"></path></svg>
      Copy Output
    </button>
  </div>
</div>
<footer>© <span id="yr"></span> • All Rights Reserved</footer>
<script>
hljs.highlightAll();document.getElementById("yr").textContent=new Date().getFullYear();
const c=document.getElementById("sparkles"),x=c.getContext("2d");c.width=innerWidth;c.height=innerHeight;window.addEventListener("resize",()=>{c.width=innerWidth;c.height=innerHeight});let p=[];function cp(){p.push({x:Math.random()*innerWidth,y:Math.random()*innerHeight*1.5,r:Math.random()*3+1.5,a:1,vy:-(Math.random()*1.5+.6),life:6000+Math.random()*10000})}function ds(){x.clearRect(0,0,c.width,c.height);const n=Date.now();p=p.filter(e=>n-(n-e.life)<e.life);p.forEach(e=>{const a=(n-(n-e.life))/e.life;x.globalAlpha=.92*(1-a);x.fillStyle="#ffffff";x.beginPath();x.arc(e.x,e.y,e.r*(1+Math.sin(n*.004+e.x)*.5),0,Math.PI*2);x.fill();e.y+=e.vy;e.x+=Math.sin(n*.001+e.y)*.8});requestAnimationFrame(ds)}for(let i=0;i<300;i++)cp();setInterval(cp,120);ds();
const i=document.getElementById("input"),o=document.getElementById("output");
function ca(){i.value="";o.textContent="";i.focus()}
function co(){const t=o.textContent.trim();if(!t)return;navigator.clipboard.writeText(t).then(()=>{const b=document.querySelector('button[onclick="co()"]');const ot=b.innerHTML;b.innerHTML="Copied!";setTimeout(()=>b.innerHTML=ot,1400)})}
function ob(){const code=i.value.trim();if(!code){o.textContent="-- nothing to obfuscate";hljs.highlightElement(o);return}
// === YOUR REAL OBFUSCATION CODE GOES HERE ===
const esc=code.replace(/\\\\/g,"\\\\\\\\").replace(/"/g,'\\"').replace(/\\n/g,"\\\\n");
o.textContent=\`-- Obfuscated v1.0.8
-- Original chars: \${code.length}

return (function() { local s = "\${esc}"; return loadstring(s)() })()\`;
hljs.highlightElement(o)}
i.addEventListener("input",()=>hljs.highlightElement(i));
</script>
</body>
</html>`);
}
