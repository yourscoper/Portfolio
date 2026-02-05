// obfuscate.js — single file — open directly in browser

document.open();
document.write(`
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
    * {margin:0;padding:0;box-sizing:border-box;font-family:'Coming Soon',cursive;cursor:none !important;}
    body {
      background:#0d0d0d;
      color:#fff;
      min-height:100vh;
      overflow-x:hidden;
      position:relative;
      font-size:1.1rem;
      cursor: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32"><circle cx="16" cy="16" r="14" fill="none" stroke="%23ffffff" stroke-width="3" opacity="0.9"/><circle cx="16" cy="16" r="4" fill="%23ffffff"/></svg>') 16 16, auto;
    }
    .sparkle {
      position:absolute;
      width:5px;
      height:5px;
      background:#fff;
      border-radius:50%;
      pointer-events:none;
      opacity:0;
      animation: sparkle 5s infinite;
      box-shadow: 0 0 10px #fff, 0 0 20px #fff;
    }
    @keyframes sparkle {
      0%,100% {opacity:0; transform: scale(0.3) translateY(0);}
      50% {opacity:0.9; transform: scale(1.4) translateY(-90vh);}
    }
    header {text-align:center; padding:50px 20px 30px; position:relative; z-index:10;}
    h1 {font-size:4.8rem; color:#fff; text-shadow:0 0 40px rgba(255,255,255,0.8); margin-bottom:10px;}
    .version {font-size:2rem; color:#fff; opacity:0.92;}
    .container {
      max-width:1480px;
      margin:0 auto;
      padding:0 30px;
      display:grid;
      grid-template-columns:1fr 1fr;
      gap:40px;
    }
    .editor {display:flex; flex-direction:column; gap:16px;}
    label {font-size:1.7rem; color:#eee;}
    textarea {
      width:100%;
      height:580px;
      background:#0f0f0f;
      color:#e8e8e8;
      border:2px solid #444;
      border-radius:14px;
      padding:20px;
      font-size:1.1rem;
      font-family:Consolas,monospace;
      resize:vertical;
      outline:none;
    }
    textarea:focus {border-color:#888; box-shadow:0 0 25px rgba(255,255,255,0.2);}
    .controls {
      grid-column:1 / -1;
      display:flex;
      justify-content:center;
      gap:40px;
      flex-wrap:wrap;
      margin:40px 0;
    }
    button {
      display:flex;
      align-items:center;
      gap:14px;
      background:#1e1e1e;
      color:#ffffff;
      border:none;
      padding:18px 40px;
      font-size:1.5rem;
      border-radius:14px;
      cursor:pointer;
      transition:all 0.3s;
      text-shadow:0 0 12px rgba(255,255,255,0.7);
      box-shadow:0 0 25px rgba(0,0,0,0.7);
    }
    button:hover {
      background:#2a2a2a;
      transform:translateY(-4px);
      box-shadow:0 15px 40px rgba(255,255,255,0.22);
    }
    button svg {width:30px; height:30px; stroke:#fff; stroke-width:2.3;}
    footer {text-align:center; padding:80px 20px 50px; color:#999; font-size:1.4rem; opacity:0.9;}
    footer span {color:#fff;}
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
    <button id="obf">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M5 5a2 2 0 0 1 3.008-1.728l11.997 6.998a2 2 0 0 1 .003 3.458l-12 7A2 2 0 0 1 5 19z"></path></svg>
      Obfuscate
    </button>
    <button id="clr">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M21 21H8a2 2 0 0 1-1.42-.587l-3.994-3.999a2 2 0 0 1 0-2.828l10-10a2 2 0 0 1 2.829 0l5.999 6a2 2 0 0 1 0 2.828L12.834 21"></path><path d="m5.082 11.09 8.828 8.828"></path></svg>
      Clear
    </button>
    <button id="cpy">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><rect width="14" height="14" x="8" y="8" rx="2" ry="2"></rect><path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2"></path></svg>
      Copy
    </button>
  </div>
</div>

<footer>© <span id="yr"></span> • All Rights Reserved</footer>

<script>
const spark = document.querySelector('.sparkles');
for(let i=0;i<180;i++){
  let s = document.createElement('div');
  s.className = 'sparkle';
  s.style.left = Math.random()*100 + 'vw';
  s.style.top  = Math.random()*180 + 'vh';
  s.style.animationDelay = Math.random()*12 + 's';
  s.style.animationDuration = (6 + Math.random()*8) + 's';
  spark.appendChild(s);
}

document.getElementById('yr').textContent = new Date().getFullYear();

hljs.highlightAll();

const input  = document.getElementById('input');
const output = document.getElementById('output');

document.getElementById('clr').onclick = () => {
  input.value = output.value = '';
  input.focus();
};

document.getElementById('cpy').onclick = () => {
  if (!output.value) return alert('Nothing to copy');
  navigator.clipboard.writeText(output.value);
  const btn = document.getElementById('cpy');
  const old = btn.innerHTML;
  btn.innerHTML = 'Copied!';
  setTimeout(() => btn.innerHTML = old, 1400);
};

document.getElementById('obf').onclick = () => {
  const code = input.value.trim();
  if (!code) {
    output.value = '-- no code to obfuscate';
    hljs.highlightElement(output);
    return;
  }

  // ← Replace everything below this line with your real obfuscation code
  //    ↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

  let escaped = code
    .replace(/\\/g, '\\\\')
    .replace(/"/g, '\\"')
    .replace(/\\n/g, '\\\\n');

  output.value =
\`-- Obfuscated v1.0.8
-- Original length: \${code.length}

return (function()
  local c = "\${escaped}"
  return loadstring(c)()
end)()\`;

  // ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
  // ↑ Paste your actual big obfuscation function / string here ↑

  hljs.highlightElement(output);
};

input.addEventListener('input', () => hljs.highlightElement(input));
</script>
</body>
</html>
`);
document.close();
