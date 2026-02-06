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
*{margin:0;padding:0;box-sizing:border-box}
html,body{
  height:100%;
  font-family:'Coming Soon',cursive;
  background:#0d0d0d;
  color:#f0f0f0;
}
body{
  cursor:url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12"><circle cx="6" cy="6" r="6" fill="white"/></svg>') 6 6,auto;
}
.container{
  min-height:100vh;
  padding:2rem 1rem 6rem;
  display:flex;
  flex-direction:column;
  align-items:center;
}
h1{
  font-size:clamp(3rem,11vw,7rem);
  text-shadow:0 0 30px #0066ff88,0 0 60px #0044cc66;
  margin-bottom:.5rem;
}
.version{
  position:fixed;
  bottom:20px;
  left:20px;
  color:#aaa;
}
.copyright{
  position:fixed;
  bottom:20px;
  left:50%;
  transform:translateX(-50%);
  color:#666;
}
.editors{
  width:100%;
  max-width:1400px;
  display:grid;
  grid-template-columns:1fr 1fr;
  gap:1.5rem;
}
.editor-box{
  height:520px;
  background:#111;
  border:1px solid #333;
  border-radius:8px;
  overflow:hidden;
  box-shadow:0 10px 40px rgba(0,0,0,.8);
}
.editor-label{
  padding:.8rem 1.2rem;
  background:#1a1a1a;
  border-bottom:1px solid #333;
}
.editor-area{
  position:relative;
  height:100%;
}
textarea{
  position:absolute;
  inset:0;
  background:transparent;
  color:transparent;
  caret-color:#fff;
  z-index:3;
  font-family:Consolas,monospace;
  font-size:1.05rem;
  line-height:1.55;
  border:none;
  outline:none;
  resize:none;
  padding:1.2rem;
}
.highlight-mirror{
  position:absolute;
  inset:0;
  z-index:2;
  padding:1.2rem;
  white-space:pre-wrap;
  word-wrap:break-word;
  font-family:Consolas,monospace;
  font-size:1.05rem;
  line-height:1.55;
  pointer-events:none;
}
#output-container{
  position:absolute;
  inset:0;
  padding:1.2rem;
  overflow:auto;
}
.controls{
  margin-top:1.5rem;
  display:flex;
  gap:1.2rem;
}
.btn{
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
.btn:hover{
  transform:translateY(-3px);
  box-shadow:0 12px 30px rgba(120,100,255,.35);
}
#trail-canvas,#sparkle-canvas{
  position:fixed;
  inset:0;
  pointer-events:none;
}
#trail-canvas{z-index:1}
#sparkle-canvas{z-index:0}
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
<pre class="highlight-mirror"><code id="inputMirror"></code></pre>
<textarea id="input" spellcheck="false"></textarea>
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
<button class="btn" id="obfuscate">⚡ Obfuscate</button>
<button class="btn" id="clear">🧹 Clear</button>
<button class="btn" id="copy">📋 Copy Output</button>
</div>
</div>

<div class="version">v1.0.1</div>
<div class="copyright">© 2026 yourscoper. All rights reserved.</div>

<script>
hljs.configure({languages:['lua']});

const input=document.getElementById('input');
const mirror=document.getElementById('inputMirror');
const output=document.getElementById('output');

function updateMirror(){
  const code=input.value||' ';
  mirror.innerHTML=hljs.highlight(code,{language:'lua'}).value;
}
input.addEventListener('input',updateMirror);
input.addEventListener('scroll',()=>{
  mirror.parentElement.scrollTop=input.scrollTop;
});

function highlightOutput(text){
  output.innerHTML=hljs.highlight(text,{language:'lua'}).value;
}

// Ctrl+A fix
document.addEventListener('keydown',e=>{
  if((e.ctrlKey||e.metaKey)&&e.key.toLowerCase()==='a'){
    const out=e.target.closest('#output-container');
    const inp=e.target.closest('#input');
    if(out){
      e.preventDefault();
      const r=document.createRange();
      r.selectNodeContents(out);
      const s=window.getSelection();
      s.removeAllRanges();
      s.addRange(r);
    }
    if(!out&&!inp)e.preventDefault();
  }
});

// Sparkles (3x)
const sc=document.getElementById('sparkle-canvas');
const sctx=sc.getContext('2d');
sc.width=innerWidth;sc.height=innerHeight;
window.onresize=()=>{sc.width=innerWidth;sc.height=innerHeight};
const sparks=[];
function sparkle(){
  sparks.push({x:Math.random()*innerWidth,y:Math.random()*innerHeight*.6,r:Math.random()*2+1,a:1,t:Date.now()});
}
(function draw(){
  sctx.clearRect(0,0,sc.width,sc.height);
  const n=Date.now();
  for(let i=sparks.length-1;i>=0;i--){
    const s=sparks[i];
    s.a=1-(n-s.t)/1500;
    if(s.a<=0){sparks.splice(i,1);continue}
    sctx.fillStyle='rgba(255,255,255,'+s.a+')';
    sctx.beginPath();
    sctx.arc(s.x,s.y,s.r,0,Math.PI*2);
    sctx.fill();
  }
  requestAnimationFrame(draw);
})();
setInterval(()=>{sparkle();sparkle();sparkle()},400);

// Buttons
document.getElementById('obfuscate').onclick=()=>{
  const c=input.value.trim();
  if(!c)return highlightOutput('-- Nothing to obfuscate');
  const e=c.replace(/\\\\/g,'\\\\\\\\').replace(/'/g,"\\\\'").replace(/\\n/g,'\\\\n').replace(/\\r/g,'\\\\r');
  highlightOutput("loadstring('"+e+"')()");
};
document.getElementById('clear').onclick=()=>{
  input.value='';
  updateMirror();
  highlightOutput('');
};
document.getElementById('copy').onclick=()=>{
  navigator.clipboard.writeText(output.textContent);
};

updateMirror();
</script>
</body>
</html>`;

  res.setHeader('Content-Type','text/html; charset=utf-8');
  res.status(200).send(html);
}
