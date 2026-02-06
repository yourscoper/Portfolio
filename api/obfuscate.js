export default async function handler(req, res) {
  // ===== POST → proxy MoonVeil obfuscation (server-side, key not exposed to client) =====
  if (req.method === 'POST') {
    try {
      let body = '';
      await new Promise(resolve => {
        req.on('data', chunk => (body += chunk));
        req.on('end', resolve);
      });

      const { script } = JSON.parse(body || '{}');
      if (!script || typeof script !== 'string') {
        res.status(400).send('Invalid script');
        return;
      }

      const moonveilRes = await fetch('https://moonveil.cc/api/obfuscate', {
        method: 'POST',
        headers: {
          'Authorization': 'Bearer mv-secret-e6bacf31-b60c-4e72-aae5-e10a7931ca3f',
          'Content-Type': 'application/json',
          'accept': 'text/plain'
        },
        body: JSON.stringify({
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
          },
          script
        })
      });

      const text = await moonveilRes.text();
      res.setHeader('Content-Type', 'text/plain; charset=utf-8');
      res.status(moonveilRes.ok ? 200 : moonveilRes.status).send(text);
      return;
    } catch (e) {
      res.status(500).send(String(e));
      return;
    }
  }

  // ===== GET → UI =====
  if (req.method !== 'GET') {
    res.status(405).send('Method Not Allowed');
    return;
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
html,body{height:100%;font-family:'Coming Soon',cursive;background:#0d0d0d;color:#f0f0f0;overflow-x:hidden}
body{cursor:url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12"><circle cx="6" cy="6" r="6" fill="white"/></svg>') 6 6,auto}
.container{min-height:100vh;padding:2rem 1rem 6rem;display:flex;flex-direction:column;align-items:center}
h1{font-size:clamp(3rem,11vw,7rem);color:#fff;text-shadow:0 0 30px #0066ff88,0 0 60px #0044cc66;margin:1rem 0 .5rem;text-align:center}
.version,.copyright,.editor-label,.btn{font-family:'Coming Soon',cursive}
.version{position:fixed;bottom:20px;left:20px;color:#aaa;font-size:1rem;opacity:.85;z-index:10}
.copyright{position:fixed;bottom:20px;left:50%;transform:translateX(-50%);color:#666;font-size:1rem;opacity:.7;z-index:10}
.editors{width:100%;max-width:1400px;display:grid;grid-template-columns:1fr 1fr;gap:1.5rem;margin:1rem 0 2rem;position:relative;z-index:10}
.editor-box{height:520px;background:#111;border:1px solid #333;border-radius:8px;overflow:hidden;box-shadow:0 10px 40px rgba(0,0,0,.8);display:flex;flex-direction:column}
.editor-label{padding:.8rem 1.2rem;background:#1a1a1a;border-bottom:1px solid #333;font-size:1.3rem;color:#aaa}
.editor-area{position:relative;flex:1;display:flex;overflow:hidden}
.line-numbers{width:40px;background:#0a0a0a;color:#555;text-align:right;padding:1.2rem .5rem 1.2rem 0;font-family:Consolas,monospace;font-size:1.05rem;line-height:1.55;user-select:none;pointer-events:none;border-right:1px solid #222;overflow:hidden;white-space:pre}
.code-wrapper{flex:1;position:relative;overflow:auto}
textarea,#output-container{position:absolute;inset:0;background:transparent;color:transparent;padding:1.2rem;padding-left:45px;font-family:Consolas,monospace;font-size:1.05rem;line-height:1.55;border:none;outline:none;resize:none;white-space:pre;tab-size:2;caret-color:#fff}
#input{z-index:3}
#output-container{z-index:3;overflow:auto;cursor:default;padding-left:45px;color:#e0e0e0;background:#111}
.highlight-mirror{position:absolute;inset:0;z-index:2;padding:1.2rem;padding-left:45px;pointer-events:none;white-space:pre;font-family:Consolas,monospace;font-size:1.05rem;line-height:1.55;background:#111;color:#e0e0e0;overflow:hidden}
.controls{margin-top:1.5rem;display:flex;gap:1.2rem;flex-wrap:wrap;justify-content:center}
.btn{display:inline-flex;align-items:center;gap:.6rem;padding:.9rem 1.8rem;font-size:1.2rem;background:rgba(40,40,60,.6);color:#fff;border:1px solid rgba(180,180,255,.25);border-radius:10px;cursor:pointer;transition:.25s ease}
.btn:hover{transform:translateY(-3px);box-shadow:0 12px 30px rgba(120,100,255,.35)}
#trail-canvas,#sparkle-canvas{position:fixed;inset:0;pointer-events:none}
#trail-canvas{z-index:1}#sparkle-canvas{z-index:0}
@media(max-width:900px){.editors{grid-template-columns:1fr}.editor-box{height:380px}}
</style>
</head>
<body>
<canvas id="sparkle-canvas"></canvas>
<canvas id="trail-canvas"></canvas>

<div class="container">
<h1>Scoper's Obfuscator</h1>
<div class="editors">
  <div class="editor-box">
    <div class="editor-label">Script Input</div>
    <div class="editor-area">
      <div class="line-numbers" id="inputLines"></div>
      <div class="code-wrapper">
        <div class="highlight-mirror" id="inputMirror"></div>
        <textarea id="input" spellcheck="false" placeholder='print("Hello, World!")' autofocus></textarea>
      </div>
    </div>
  </div>
  <div class="editor-box">
    <div class="editor-label">Script Output</div>
    <div class="editor-area">
      <div class="line-numbers" id="outputLines"></div>
      <div class="code-wrapper">
        <pre id="output-container"><code id="output" class="language-lua"></code></pre>
      </div>
    </div>
  </div>
</div>

<div class="controls">
<button class="btn" id="obfuscate">Obfuscate</button>
<button class="btn" id="clear">Clear</button>
<button class="btn" id="copy">Copy Output</button>
</div>
</div>

<div class="version">v1.0.2</div>
<div class="copyright">© 2026 yourscoper. All rights reserved.</div>

<script>
hljs.configure({languages:['lua']});

document.addEventListener('selectstart',e=>{if(!e.target.closest('.code-wrapper'))e.preventDefault()});
document.addEventListener('keydown',e=>{if((e.ctrlKey||e.metaKey)&&e.key.toLowerCase()==='a'){if(!e.target.closest('.code-wrapper'))e.preventDefault()}});

const input=document.getElementById('input');
const mirror=document.getElementById('inputMirror');
const output=document.getElementById('output');
const inputLines=document.getElementById('inputLines');
const outputLines=document.getElementById('outputLines');

function updateLineNumbers(el,linesEl){
  const lines=(el.value||el.textContent||'').split('\\n');
  let n='';for(let i=1;i<=lines.length;i++)n+=i+'\\n';
  linesEl.textContent=n;
}
function updateMirror(){
  mirror.innerHTML=hljs.highlight(input.value||' ',{language:'lua'}).value;
  updateLineNumbers(input,inputLines);
}
input.addEventListener('input',updateMirror);
input.addEventListener('scroll',()=>{
  mirror.parentElement.scrollTop=input.scrollTop;
  mirror.parentElement.scrollLeft=input.scrollLeft;
  inputLines.scrollTop=input.scrollTop;
});
function highlightOutput(text){
  output.innerHTML=hljs.highlight(text||' ',{language:'lua'}).value;
  updateLineNumbers(output.parentElement,outputLines);
}

document.getElementById('obfuscate').onclick=async()=>{
  const c=input.value.trim();
  if(!c){highlightOutput('Please Insert Code');return;}
  highlightOutput('Obfuscating...');
  const r=await fetch(location.pathname,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({script:c})});
  const t=await r.text();
  highlightOutput(t);
};
document.getElementById('clear').onclick=()=>{input.value='';updateMirror();highlightOutput('')};
document.getElementById('copy').onclick=()=>navigator.clipboard.writeText(output.textContent);

updateMirror();highlightOutput('');
updateLineNumbers(input,inputLines);updateLineNumbers(output.parentElement,outputLines);
</script>
</body>
</html>`;

  res.setHeader('Content-Type', 'text/html; charset=utf-8');
  res.status(200).send(html);
}
