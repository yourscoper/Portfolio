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
body{
  background:#0d0d0d;color:#fff;min-height:100vh;overflow-x:hidden;
  cursor:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='32' height='32' viewBox='0 0 32 32'%3E%3Ccircle cx='16' cy='16' r='14' fill='none' stroke='%23fff' stroke-width='3'/%3E%3Ccircle cx='16' cy='16' r='5' fill='%23fff'/%3E%3C/svg%3E") 16 16, auto;
}
canvas{position:fixed;inset:0;pointer-events:none;z-index:1}
header{text-align:center;padding:50px 20px 20px;z-index:10;position:relative}
h1{font-size:4rem;text-shadow:0 0 30px rgba(255,255,255,.7)}
.version{font-size:1.8rem;opacity:.9}
.container{
  max-width:1400px;margin:0 auto;padding:0 20px;
  display:grid;grid-template-columns:1fr 1fr;gap:30px;
  position:relative;z-index:10
}
.editor{display:flex;flex-direction:column;gap:12px}
label{font-size:1.6rem;color:#ddd}
textarea{
  width:100%;height:520px;background:#111;color:#e0e0e0;
  border:2px solid #333;border-radius:12px;padding:16px;
  font-family:Consolas,monospace;font-size:1rem;resize:vertical
}
pre{
  min-height:520px;background:#111;border:2px solid #333;
  border-radius:12px;padding:16px;overflow:auto;
  font-family:Consolas,monospace;font-size:1rem
}
.controls{
  grid-column:1/-1;display:flex;justify-content:center;
  gap:30px;margin:40px 0
}
button{
  display:flex;align-items:center;gap:12px;
  background:#222;color:#fff;border:none;
  padding:14px 32px;font-size:1.3rem;
  border-radius:10px;cursor:pointer
}
button:hover{background:#333}
button svg{width:26px;height:26px;stroke:#fff}
footer{text-align:center;padding:60px 20px;color:#777;font-size:1.2rem}
footer span{color:#fff}
@media (max-width:850px){.container{grid-template-columns:1fr}}
</style>
</head>

<body>
<canvas id="sp"></canvas>

<header>
  <h1>Obfuscate Lua</h1>
  <div class="version">v1.0.8</div>
</header>

<div class="container">
  <div class="editor">
    <label>Input Lua Code</label>
    <textarea id="input" placeholder="-- paste code..."></textarea>
  </div>

  <div class="editor">
    <label>Obfuscated Output</label>
    <pre><code id="output" class="language-lua">-- result here</code></pre>
  </div>

  <div class="controls">
    <button onclick="obf()">▶ Obfuscate</button>
    <button onclick="clr()">✖ Clear</button>
    <button onclick="cpy()">⧉ Copy</button>
  </div>
</div>

<footer>© <span id="y"></span> • All Rights Reserved</footer>

<script>
hljs.highlightAll();
document.getElementById("y").textContent = new Date().getFullYear();

const canvas = document.getElementById("sp");
const ctx = canvas.getContext("2d");
canvas.width = innerWidth;
canvas.height = innerHeight;
addEventListener("resize",()=>{canvas.width=innerWidth;canvas.height=innerHeight});

const parts=[];
function spawn(){
  parts.push({x:Math.random()*canvas.width,y:canvas.height+20,r:Math.random()*2+1,vy:Math.random()+0.5,life:Date.now()+8000});
}
function draw(){
  ctx.clearRect(0,0,canvas.width,canvas.height);
  const now=Date.now();
  for(let i=parts.length-1;i>=0;i--){
    const p=parts[i];
    if(now>p.life){parts.splice(i,1);continue;}
    ctx.globalAlpha=.8;
    ctx.fillStyle="#fff";
    ctx.beginPath();ctx.arc(p.x,p.y,p.r,0,Math.PI*2);ctx.fill();
    p.y-=p.vy;
  }
  requestAnimationFrame(draw);
}
for(let i=0;i<150;i++)spawn();
setInterval(spawn,200);
draw();

const input=document.getElementById("input");
const output=document.getElementById("output");

function clr(){
  input.value="";
  output.textContent="";
  hljs.highlightElement(output);
}

function cpy(){
  if(output.textContent) navigator.clipboard.writeText(output.textContent);
}

function obf(){
  const code=input.value;
  if(!code.trim()){
    output.textContent="-- nothing";
    hljs.highlightElement(output);
    return;
  }

  // SAFE placeholder obfuscation (runtime only)
  const escaped = code
    .replace(/\\\\/g,"\\\\\\\\")
    .replace(/"/g,"\\\\\\"")
    .replace(/\\n/g,"\\\\n");

  output.textContent =
    "-- v1.0.8\\nreturn (function() local s=\\"" + escaped + "\\" return loadstring(s)() end)()";

  hljs.highlightElement(output);
}
</script>

</body>
</html>`);
}
