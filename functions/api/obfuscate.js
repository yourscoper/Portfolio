const XOR_KEY = 0x4B;

function randomString(len) {
  len = len || Math.floor(Math.random() * 8) + 8;
  const chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_";
  let result = "";
  for (let i = 0; i < len; i++) result += chars[Math.floor(Math.random() * chars.length)];
  return result;
}

function minifyCode(src) {
  src = src.replace(/--[^\n]*/g, "");
  src = src.replace(/--\[\[[\s\S]*?\]\]/g, "");
  src = src.replace(/\n+/g, "\n");
  src = src.replace(/\t/g, " ");
  src = src.replace(/  +/g, " ");
  return src;
}

function obfuscateLua(code) {
  if (typeof code !== "string") return "-- input error";
  const lineCount = code.split('\n').length;
  if (lineCount > 10000) return `-- Error: Code exceeds 10,000 lines (${lineCount} lines)`;

  let cleanCode = minifyCode(code);

  function xorEncrypt(str, key) {
    let result = "";
    for (let i = 0; i < str.length; i++)
      result += String.fromCharCode(str.charCodeAt(i) ^ key.charCodeAt(i % key.length));
    return result;
  }

  const encKey = randomString(16);
  let encrypted = xorEncrypt(cleanCode, encKey);
  const payloadBytes = Array.from(encrypted).map(c => c.charCodeAt(0));
  const keyBytes = Array.from(encKey).map(c => c.charCodeAt(0));
  const payloadTable = "{" + payloadBytes.join(",") + "}";
  const keyTable = "{" + keyBytes.join(",") + "}";

  return `--[[
    Scoper's Obfuscator - Working XOR Version
--]]
do
local function xor_bytes(a, b)
  local result = 0
  for i = 0, 7 do
    local a_bit = a % 2
    local b_bit = b % 2
    if a_bit ~= b_bit then result = result + (2 ^ i) end
    a = math.floor(a / 2)
    b = math.floor(b / 2)
  end
  return result
end
local function byte_xor(payload_bytes, key_bytes)
  local result_chars = {}
  for i = 1, #payload_bytes do
    local key_idx = ((i - 1) % #key_bytes) + 1
    result_chars[i] = string.char(xor_bytes(payload_bytes[i], key_bytes[key_idx]))
  end
  return table.concat(result_chars)
end
local encrypted_bytes = ${payloadTable}
local key_bytes = ${keyTable}
local decrypted_code = byte_xor(encrypted_bytes, key_bytes)
local load_func = loadstring or load
load_func(decrypted_code)()
end`;
}

function getHTML() {
  return `<!DOCTYPE html>
<html lang="en" data-theme="dark">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Scoper's Obfuscator - Unlimited Power</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Coming+Soon&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/styles/atom-one-dark.min.css">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.11.1/highlight.min.js"></script>
  <style>
    * { margin:0; padding:0; box-sizing:border-box; }
    html, body { height:100%; font-family:'Coming Soon',cursive; background:#0d0d0d; color:#f0f0f0; overflow-x:hidden; }
    .container { min-height:100vh; padding:2rem 1rem 6rem; display:flex; flex-direction:column; align-items:center; }
    h1 { font-size:clamp(3rem,11vw,7rem); color:#ffffff; text-shadow:0 0 30px #0066ff88,0 0 60px #0044cc66; margin:1rem 0 .5rem; text-align:center; }
    .badge { background: linear-gradient(135deg, #ff3366, #ff6633); padding: 0.3rem 1rem; border-radius: 20px; font-size: 0.8rem; margin-left: 1rem; vertical-align: middle; }
    .version, .copyright { font-family:'Coming Soon',cursive; }
    .version { position:fixed; bottom:20px; left:20px; color:#fff; font-size:1rem; opacity:0.85; z-index:10; }
    .copyright { position:fixed; bottom:20px; left:50%; transform:translateX(-50%); color:#fff; font-size:1rem; opacity:0.7; z-index:10; }
    .editor-box { width:100%; max-width:1600px; height:50vh; background:#111; border:1px solid #333; border-radius:8px; overflow:hidden; box-shadow:0 10px 40px rgba(0,0,0,.8); display:flex; flex-direction:column; position:relative; bottom:-90px; }
    .editor-label { padding:.8rem 1.2rem; background:#1a1a1a; border-bottom:1px solid #333; font-size:1.3rem; color:#aaa; }
    .editor-area { position:relative; flex:1; display:flex; overflow:hidden; }
    .line-numbers { width:40px; background:#0a0a0a; color:#555; text-align:right; padding:1.2rem 0.5rem 1.2rem 0; font-family:Consolas,monospace; font-size:1.05rem; line-height:1.55; user-select:none; pointer-events:none; border-right:1px solid #222; overflow:hidden; white-space:pre; }
    .code-wrapper { flex:1; position:relative; overflow:auto; }
    textarea { position:absolute; inset:0; background:transparent; color:transparent; padding:1.2rem; padding-left:45px; font-family:Consolas,monospace; font-size:1.05rem; line-height:1.55; border:none; outline:none; resize:none; white-space:pre; tab-size:2; caret-color:#fff; z-index:3; }
    .highlight-mirror { position:absolute; inset:0; z-index:2; padding:1.2rem; padding-left:45px; pointer-events:none; white-space:pre; font-family:Consolas,monospace; font-size:1.05rem; line-height:1.55; background:#111; color:#e0e0e0; overflow:hidden; }
    .executor-controls { position:absolute; bottom:12px; right:12px; display:flex; gap:0.8rem; z-index:10; }
    .btn { display:flex; align-items:center; gap:0.5rem; padding:0.6rem 1.2rem; font-size:1rem; background:rgba(40,40,60,.7); color:#fff; border:1px solid rgba(180,180,255,.3); border-radius:8px; cursor:pointer; transition:.2s ease; }
    .btn:hover { background:rgba(255,255,255,0.25); transform:scale(1.05); }
    .limit-badge { background: #00ff88; color: #000; padding: 2px 8px; border-radius: 10px; font-size: 0.7rem; margin-left: 10px; }
  </style>
</head>
<body>
<div class="container">
  <h1>Scoper's Obfuscator <span class="badge">UNLIMITED</span></h1>
  <p style="margin-top: 10px;">No API limits • 10,000+ lines supported • Maximum security</p>
  <div class="editor-box">
    <div class="editor-label">Script Input <span class="limit-badge">No Limits</span></div>
    <div class="editor-area">
      <div class="line-numbers" id="inputLines"></div>
      <div class="code-wrapper">
        <div class="highlight-mirror" id="inputMirror"></div>
        <textarea id="input" spellcheck="false" placeholder='print("Hello, World!")' autofocus></textarea>
      </div>
    </div>
    <div class="executor-controls">
      <button class="btn" id="download">Download Obfuscated</button>
      <button class="btn" id="clear">Clear</button>
    </div>
  </div>
</div>
<div class="version">v1.0.4 - Unlimited</div>
<div class="copyright">© 2026 Scoper. All rights reserved.</div>
<script>
hljs.configure({languages:['lua']});
const input = document.getElementById('input');
const mirror = document.getElementById('inputMirror');
const inputLines = document.getElementById('inputLines');
function updateLineNumbers() {
  const lines = (input.value || '').split('\\n');
  let numbers = '';
  for (let i = 1; i <= lines.length; i++) numbers += i + '\\n';
  inputLines.textContent = numbers;
}
function updateMirror() {
  mirror.innerHTML = hljs.highlight(input.value || ' ', {language: 'lua'}).value;
  updateLineNumbers();
}
input.addEventListener('input', updateMirror);
input.addEventListener('scroll', () => {
  mirror.parentElement.scrollTop = input.scrollTop;
  inputLines.scrollTop = input.scrollTop;
});
input.addEventListener('keydown', e => {
  if (e.key === 'Tab') {
    e.preventDefault();
    const start = e.target.selectionStart;
    e.target.value = e.target.value.substring(0, start) + '  ' + e.target.value.substring(e.target.selectionEnd);
    e.target.selectionStart = e.target.selectionEnd = start + 2;
    updateMirror();
  }
});
document.getElementById('download').onclick = async () => {
  const code = input.value.trim();
  if (!code) return alert('No code to obfuscate');
  const btn = document.getElementById('download');
  btn.textContent = 'Obfuscating...';
  btn.disabled = true;
  try {
    const res = await fetch('/api/obfuscate', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ script: code })
    });
    if (!res.ok) { alert('Obfuscation failed: ' + await res.text()); return; }
    const obfuscated = await res.text();
    const blob = new Blob([obfuscated], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url; a.download = 'obfuscated_' + Math.random().toString(36).substring(2,10) + '.lua';
    document.body.appendChild(a); a.click(); document.body.removeChild(a);
    URL.revokeObjectURL(url);
    alert('Success! Obfuscated file downloaded.');
  } catch (err) { alert('Error: ' + err.message); }
  finally { btn.textContent = 'Download Obfuscated'; btn.disabled = false; }
};
document.getElementById('clear').onclick = () => { input.value = ''; updateMirror(); };
updateMirror();
</script>
</body>
</html>`;
}

export async function onRequest(context) {
  const { request } = context;

  if (request.method === "GET") {
    return new Response(getHTML(), { headers: { "Content-Type": "text/html; charset=utf-8" } });
  }

  if (request.method !== "POST") {
    return new Response("Method Not Allowed", { status: 405 });
  }

  try {
    const body = await request.json();
    const { script } = body || {};
    if (!script || typeof script !== "string" || script.trim() === "") {
      return new Response("No script provided", { status: 400 });
    }
    const obfuscated = obfuscateLua(script);
    return new Response(obfuscated, { headers: { "Content-Type": "text/plain; charset=utf-8" } });
  } catch (err) {
    return new Response("Internal server error: " + err.message, { status: 500 });
  }
}
