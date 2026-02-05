// obfuscate.js — single file version (open directly in browser)

document.body.innerHTML = `
<!DOCTYPE html>
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
    *{margin:0;padding:0;box-sizing:border-box;font-family:'Coming Soon',cursive;cursor:none !important;}
    body{background:#0d0d0d;color:#fff;min-height:100vh;overflow-x:hidden;position:relative;font-size:1.1rem;
      cursor:url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32"><circle cx="16" cy="16" r="14" fill="none" stroke="%23ffffff" stroke-width="3" opacity="0.9"/><circle cx="16" cy="16" r="4" fill="%23ffffff"/></svg>') 16 16,auto;}
    .sparkle{position:absolute;width:6px;height:6px;background:#fff;border-radius:50%;pointer-events:none;opacity:0;
      animation:sparkleAnim 4s infinite;box-shadow:0 0 12px #fff,0 0 24px #fff;}
    @keyframes sparkleAnim{0%,100%{opacity:0;transform:scale(0.2) translateY(0);}50%{opacity:0.95;transform:scale(1.3) translateY(-80vh);}}
    header{text-align:center;padding:40px 20px 20px;position:relative;z-index:10;}
    h1{font-size:4.2rem;color:#fff;text-shadow:0 0 30px rgba(255,255,255,0.7);margin-bottom:8px;}
    .version{font-size:1.8rem;color:#fff;opacity:0.9;letter-spacing:2px;}
    .container{max-width:1400px;margin:0 auto;padding:0 20px;display:grid;grid-template-columns:1fr 1fr;gap:30px;position:relative;z-index:5;}
    .editor{display:flex;flex-direction:column;gap:12px;}
    label{font-size:1.5rem;color:#ddd;}
    textarea{width:100%;height:520px;background:#111;color:#e0e0e0;border:2px solid #333;border-radius:12px;padding:16px;font-size:1.05rem;
      font-family:Consolas,monospace;resize:vertical;outline:none;}
    textarea:focus{border-color:#777;box-shadow:0 0 20px rgba(255,255,255,0.15);}
    .controls{grid-column:1/-1;display:flex;justify-content:center;gap:30px;flex-wrap:wrap;margin:30px 0;}
    button{display:flex;align-items:center;gap:12px;background:#222;color:#fff;border:none;padding:16px 32px;font-size:1.4rem;border-radius:12px;
      cursor:pointer;transition:all .25s;text-shadow:0 0 10px rgba(255,255,255,0.6);box-shadow:0 0 20px rgba(0,0,0,0.6);}
    button:hover{background:#333;transform:translateY(-3px);box-shadow:0 12px 30px rgba(255,255,255,0.18);}
    button svg{width:28px;height:28px;stroke:#fff;stroke-width:2.2;}
    footer{text-align:center;padding:60px 20px 40px;color:#aaa;font-size:1.3rem;opacity:0.85;}
    footer span{color:#fff;}
  </style>
</head>
<body>

<div class="sparkles"></div>

<header>
  <h1>Obfuscate Lua</h1>
  <div class="version">v1.0.8</div>
</header>

<div class="container">
  <div class="editor">
    <label>Input Lua Code</label>
    <textarea id="input" placeholder="-- paste your lua code here..."></textarea>
  </div>
  <div class="editor">
    <label>Obfuscated Output</label>
    <textarea id="output" readonly placeholder="obfuscated code will appear here..."></textarea>
  </div>
  <div class="controls">
    <button id="obfuscate">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 5a2 2 0 0 1 3.008-1.728l11.997 6.998a2 2 0 0 1 .003 3.458l-12 7A2 2 0 0 1 5 19z"></path></svg>
      Obfuscate
    </button>
    <button id="clear">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 21H8a2 2 0 0 1-1.42-.587l-3.994-3.999a2 2 0 0 1 0-2.828l10-10a2 2 0 0 1 2.829 0l5.999 6a2 2 0 0 1 0 2.828L12.834 21"></path><path d="m5.082 11.09 8.828 8.828"></path></svg>
      Clear
    </button>
    <button id="copy">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="14" height="14" x="8" y="8" rx="2" ry="2"></rect><path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2"></path></svg>
      Copy Output
    </button>
  </div>
</div>

<footer>© <span id="year"></span> • All Rights Reserved</footer>

<script>
// Sparkles — more of them
const sc = document.querySelector('.sparkles');
for(let i=0;i<140;i++){
  const s=document.createElement('div');s.className='sparkle';
  s.style.left=Math.random()*100+'vw';s.style.top=Math.random()*160+'vh';
  s.style.animationDelay=Math.random()*10+'s';s.style.animationDuration=(5+Math.random()*7)+'s';
  sc.appendChild(s);
}

document.getElementById('year').textContent = new Date().getFullYear();
hljs.highlightAll();

const input  = document.getElementById('input');
const output = document.getElementById('output');

document.getElementById('clear').onclick = ()=>{ input.value=output.value=''; input.focus(); };

document.getElementById('copy').onclick = ()=>{
  if(!output.value) return;
  navigator.clipboard.writeText(output.value);
  const b = document.getElementById('copy');
  const t = b.innerHTML; b.innerHTML='Copied!'; setTimeout(()=>b.innerHTML=t, 1400);
};

// === PASTE YOUR REAL OBFUSCATION CODE / FUNCTION HERE ===
document.getElementById('obfuscate').onclick = ()=>{
  const code = input.value.trim();
  if(!code){
    output.value = '-- nothing to obfuscate';
    hljs.highlightElement(output);
    return;
  }

  // ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
  // REPLACE THIS PART WITH YOUR ACTUAL OBFUSCATOR CODE

  const escaped = code
    .replace(/\\/g, '\\\\')
    .replace(/"/g,  '\\"')
    .replace(/\n/g, '\\n')
    .replace(/\r/g, '');

  const result = 
\`-- Obfuscated v1.0.8
-- Original length: \${code.length}

return (function()
  local s = "\${escaped}"
  return loadstring(s)()
end)()\`;

  // ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

  output.value = result;
  hljs.highlightElement(output);
};

input.oninput = ()=> hljs.highlightElement(input);
</script>
</body>
</html>
`;

// This line makes the file behave like an HTML page when opened directly
document.documentElement.innerHTML = document.body.innerHTML;
