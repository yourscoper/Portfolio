// api/obfuscate.js
export default function handler(req, res) {
  res.setHeader('Content-Type', 'text/html; charset=utf-8');

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
    *{margin:0;padding:0;box-sizing:border-box;font-family:'Coming Soon',cursive;cursor:none !important}
    body{background:#0d0d0d;color:#fff;min-height:100vh;position:relative;overflow-x:hidden;cursor:url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' width='32' height='32' viewBox='0 0 32 32'><circle cx='16' cy='16' r='14' fill='none' stroke='%23ffffff' stroke-width='3' opacity='0.9'/><circle cx='16' cy='16' r='5' fill='%23ffffff'/></svg>") 16 16,auto}
    canvas{position:fixed;inset:0;pointer-events:none;z-index:1}
    header{text-align:center;padding:50px 20px 20px;position:relative;z-index:10}
    h1{font-size:4.2rem;color:#fff;text-shadow:0 0 30px rgba(255,255,255,0.7);margin-bottom:10px}
    .version{font-size:1.9rem;color:#fff;opacity:0.9}
    .container{max-width:1400px;margin:0 auto;padding:0 20px;display:grid;grid-template-columns:1fr 1fr;gap:30px;position:relative;z-index:5}
    .editor{display:flex;flex-direction:column;gap:12px}
    label{font-size:1.6rem;color:#ddd}
    textarea{width:100%;height:540px;background:#111;color:#e0e0e0;border:2px solid #333;border-radius:12px;padding:16px;font-size:1rem;font-family:Consolas,monospace;resize:vertical;outline:none}
    textarea:focus{border-color:#666;box-shadow:0 0 20px rgba(255,255,255,0.15)}
    pre#output{margin:0;padding:16px;background:#111;border:2px solid #333;border-radius:12px;min-height:540px;font-family:Consolas,monospace;font-size:1rem;white-space:pre-wrap;word-wrap:break-word;overflow-y:auto}
    .controls{grid-column:1/-1;display:flex;justify-content:center;gap:30px;flex-wrap:wrap;margin:40px 0}
    button{display:flex;align-items:center;gap:12px;background:#222;color:#fff;border:none;padding:14px 32px;font-size:1.3rem;border-radius:10px;cursor:pointer;transition:all 0.25s}
    button:hover{background:#333;transform:translateY(-2px);box-shadow:0 10px 25px rgba(255,255,255,0.15)}
    button svg{width:26px;height:26px;stroke:#fff;stroke-width:2}
    footer{text-align:center;padding:60px 20px;color:#777;font-size:1.2rem}
    footer span{color:#fff}
    @media (max-width:850px){.container{grid-template-columns:1fr}}
  </style>
</head>
<body>
<canvas id="spark"></canvas>

<header>
  <h1>Obfuscate Lua</h1>
  <div class="version">v1.0.8</div>
</header>

<div class="container">
  <div class="editor">
    <label>Input Lua Code</label>
    <textarea id="input" placeholder="-- paste your code here..."></textarea>
  </div>
  <div class="editor">
    <label>Obfuscated Output</label>
    <pre id="output">-- result appears here</pre>
  </div>
  <div class="controls">
    <button onclick="obf()">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 5a2 2 0 0 1 3.008-1.728l11.997 6.998a2 2 0 0 1 .003 3.458l-12 7A2 2 0 0 1 5 19z"/></svg>
      Obfuscate
    </button>
    <button onclick="clr()">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 21H8a2 2 0 0 1-1.42-.587l-3.994-3.999a2 2 0 0 1 0-2.828l10-10a2 2 0 0 1 2.829 0l5.999 6a2 2 0 0 1 0 2.828L12.834 21"/><path d="m5.082 11.09 8.828 8.828"/></svg>
      Clear
    </button>
    <button onclick="cpy()">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="14" height="14" x="8" y="8" rx="2" ry="2"/><path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2"/></svg>
      Copy
    </button>
  </div>
</div>

<footer>© <span id="y"></span> • All Rights Reserved</footer>

<script>
hljs.highlightAll();
document.getElementById("y").textContent=new Date().getFullYear();

const cv=document.getElementById("spark"),ct=cv.getContext("2d");
cv.width=innerWidth;cv.height=innerHeight;
addEventListener("resize",()=>{cv.width=innerWidth;cv.height=innerHeight});
let ps=[];
function np(){ps.push({x:Math.random()*innerWidth,y:Math.random()*innerHeight*1.3,r:Math.random()*3+1,vy:-(Math.random()*1.2+0.5),life:4000+Math.random()*7000})}
function dr(){ct.clearRect(0,0,cv.width,cv.height);let n=Date.now();ps=ps.filter(p=>n<p.life+n);ps.forEach(p=>{let a=(n-(n-p.life))/p.life;ct.globalAlpha=0.9*(1-a);ct.fillStyle="#fff";ct.beginPath();ct.arc(p.x,p.y,p.r,0,Math.PI*2);ct.fill();p.y+=p.vy});requestAnimationFrame(dr)}
for(let i=0;i<180;i++)np();setInterval(np,220);dr();

const inp=document.getElementById("input"),out=document.getElementById("output");
function clr(){inp.value="";out.textContent="";inp.focus()}
function cpy(){let t=out.textContent.trim();if(t)navigator.clipboard.writeText(t)}
function obf(){
  let code=inp.value.trim();
  if(!code){out.textContent="-- nothing to obfuscate";hljs.highlightElement(out);return}
  // === PUT YOUR REAL OBFUSCATION LOGIC HERE ===
  let esc=code.replace(/\\\\/g,"\\\\\\\\").replace(/"/g,'\\"').replace(/\\n/g,"\\\\n");
  out.textContent="-- Obfuscated v1.0.8\\nreturn (function() { local s = \\"" + esc + "\\"; return loadstring(s)() })()";
  hljs.highlightElement(out);
}
inp.addEventListener("input",()=>hljs.highlightElement(inp));
</script>
</body>
</html>`);
}
