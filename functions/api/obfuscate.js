const XOR_KEY = 0x4B;

function randomString(len) {
  len = len || Math.floor(Math.random() * 8) + 8;
  const chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_";
  let result = "";
  for (let i = 0; i < len; i++) result += chars[Math.floor(Math.random() * chars.length)];
  return result;
}

const NAME_POOL = [
  "data","info","node","list","temp","flag","size","base","core","init",
  "load","save","read","send","recv","pack","wrap","bind","hook","call",
  "iter","step","slot","pool","pipe","grid","mesh","blob","heap","tree",
  "hash","bits","mask","seed","salt","rand","tick","time","rate","mode",
  "type","kind","role","name","path","root","head","tail","next","prev",
  "curr","last","best","fast","slow","raw","key","val","ref","idx","off",
  "buf","cap","len","cnt","num","sum","max","min","avg","res","out","err",
  "ctx","env","cfg","opt","arg","src","dst","tag","map","set","seq","row",
  "col","pos","vec","dir","rot","mat","cam","obj","ent","sys","srv","cli",
  "req","rsp","msg","evt","job","run","exe","lib","mod","pkg","sub","pub",
  "mgr","hdl","drv","dev","net","io","db","fs","ui","fx",
  "Handler","Manager","Builder","Factory","Parser","Loader","Writer",
  "Reader","Buffer","Stream","Queue","Stack","Cache","Store","Index",
  "Table","Block","Frame","Chunk","Packet","Token","Cursor","Scope",
  "State","Event","Signal","Hook","Proxy","Guard","Filter","Mapper",
  "Codec","Cipher","Digest","Hasher","Signer","Packer","Encoder"
];

function makeNameGen() {
  const used = new Set();
  function word() { return NAME_POOL[Math.floor(Math.random() * NAME_POOL.length)]; }
  function cap(s) { return s.charAt(0).toUpperCase() + s.slice(1); }
  function rn() {
    const abbrevs = ["buf","len","src","dst","tmp","key","val","ref","idx","ptr","cnt","sz","cap","res","err","ok"];
    let candidate;
    const strategy = Math.floor(Math.random() * 5);
    if (strategy === 0) {
      candidate = word();
      if (Math.random() < 0.5) candidate += Math.floor(Math.random() * 99) + 1;
    } else if (strategy === 1) {
      candidate = word() + cap(word());
      if (Math.random() < 0.33) candidate += Math.floor(Math.random() * 9) + 1;
    } else if (strategy === 2) {
      candidate = word() + "_" + word();
      if (Math.random() < 0.33) candidate += Math.floor(Math.random() * 90) + 10;
    } else if (strategy === 3) {
      candidate = word() + cap(word()) + cap(word());
    } else {
      candidate = abbrevs[Math.floor(Math.random() * abbrevs.length)] + cap(abbrevs[Math.floor(Math.random() * abbrevs.length)]);
      if (Math.random() < 0.5) candidate += Math.floor(Math.random() * 99) + 1;
    }
    if (/^[^a-zA-Z_]/.test(candidate)) candidate = "v" + candidate;
    let tries = 0;
    while (used.has(candidate)) {
      candidate += Math.floor(Math.random() * 9) + 1;
      if (++tries > 30) { candidate += "_" + (Math.floor(Math.random() * 900) + 100); break; }
    }
    used.add(candidate);
    return candidate;
  }
  return rn;
}

function minifyCode(src) {
  src = src.replace(/--\[\[[\s\S]*?\]\]/g, "");
  src = src.replace(/--[^\n]*/g, "");
  src = src.replace(/\n+/g, "\n");
  src = src.replace(/\t/g, " ");
  src = src.replace(/ {2,}/g, " ");
  return src.trim();
}

function xorBytes(str, key) {
  let result = "";
  for (let i = 0; i < str.length; i++)
    result += String.fromCharCode(str.charCodeAt(i) ^ key.charCodeAt(i % key.length));
  return result;
}

function xorByteNum(str, key) {
  let result = "";
  for (let i = 0; i < str.length; i++)
    result += String.fromCharCode(str.charCodeAt(i) ^ key);
  return result;
}

function toBase64(str) {
  return btoa(unescape(encodeURIComponent(str)));
}

function bytesLiteral(s) {
  const parts = [];
  for (let i = 0; i < s.length; i++) parts.push(s.charCodeAt(i));
  return "string.char(" + parts.join(",") + ")";
}

function obfNum(n) {
  const a = Math.floor(Math.random() * 500) + 1;
  const b = n - a;
  const c = Math.floor(Math.random() * 100) + 1;
  const d = c * 13;
  return `bit32.bxor(bit32.bxor(${a}+${b},0x${d.toString(16).toUpperCase()}),0x${d.toString(16).toUpperCase()})`;
}

function junkStatement(rn) {
  const v1 = rn(), v2 = rn();
  const n1 = Math.floor(Math.random() * 99) + 1;
  const n2 = Math.floor(Math.random() * 99) + 1;
  const n3 = Math.floor(Math.random() * 8) + 2;
  const t = Math.floor(Math.random() * 4);
  if (t === 0) {
    return `do local ${v1}=${n1}+${n2} local ${v2}=${v1}*${n3} if ${v2}>${n1} then ${v2}=${v2}-${n2} end end`;
  } else if (t === 1) {
    return `do local ${v1}={} for i=1,${n1} do ${v1}[i]=i*${n3} end end`;
  } else if (t === 2) {
    return `do local ${v1}=math.floor(${n1}*${n3}+${n2}) local ${v2}=${v1}+${n1} end`;
  } else {
    const tv = rn();
    const keys = ["width","height","depth","alpha","beta","gamma","delta","epsilon"];
    const k1 = keys[Math.floor(Math.random() * keys.length)];
    const k2 = keys[Math.floor(Math.random() * keys.length)];
    return `do local ${tv}={${k1}=${n1},${k2}=${n2}} ${tv}.${k1}=${tv}.${k2}+${n3} end`;
  }
}

const WATERMARK = `--[[
    .----. .---.  .----. .----. .----..----.  .----.    .----. .----. .----..-. .-. .----. .---.   .--.  .---.  .----. .----.
    { {__  /  ___}/  {}  \\| {}  }| {_  | {}  }{ {__     /  {}  \\| {}  }| {_  | { } |{ {__  /  ___} / {} \\{_   _}/  {}  \\| {}  }
    .-._} }\\     }\\      /| .--' | {__ | .-. \\.-._} }   \\      /| {}  }| |   | {_} |.-._} }\\     }/  /\\  \\ | |  \\      /| .-. \\
    \`----'  \`---'  \`----' \`-'    \`----'\`-' \`-'\`----'     \`----' \`----' \`-'   \`-----'\`----'  \`---' \`-'  \`-' \`-'   \`----' \`-' \`-'
--]]
`;

function obfuscateLua(code) {
  if (typeof code !== "string") return "-- input error";
  const lineCount = code.split('\n').length;
  if (lineCount > 10000) return `-- Error: Code exceeds 10,000 lines (${lineCount} lines)`;

  const rn = makeNameGen();
  const cleanCode = minifyCode(code);

  // Layer 1: XOR with fixed key
  const xored = xorByteNum(cleanCode, XOR_KEY);

  // Layer 2: base64
  let b64;
  try { b64 = toBase64(xored); } catch(e) { b64 = btoa(xored.split('').map(c => c.charCodeAt(0) > 127 ? '?' : c).join('')); }

  // Layer 3: second XOR with random key
  const key2 = Math.floor(Math.random() * (0xFE - 0x10 + 1)) + 0x10;
  const doubled = xorByteNum(b64, key2);

  // Split into shuffled chunks
  const chunkExprs = [];
  let pos = 0;
  while (pos < doubled.length) {
    const step = Math.floor(Math.random() * 121) + 60;
    const piece = doubled.slice(pos, pos + step);
    const bytes = [];
    for (let i = 0; i < piece.length; i++) bytes.push(piece.charCodeAt(i));
    chunkExprs.push("string.char(" + bytes.join(",") + ")");
    pos += step;
  }

  // Fisher-Yates shuffle
  const order = chunkExprs.map((_, i) => i);
  for (let i = order.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [order[i], order[j]] = [order[j], order[i]];
  }
  const shuffled = order.map(origIdx => chunkExprs[origIdx]);
  const permutation = new Array(chunkExprs.length);
  order.forEach((origIdx, newPos) => { permutation[origIdx] = newPos + 1; });

  // Build chunk table assignments
  const tableVar = rn();
  const chunkLines = [`local ${tableVar}={}`];
  shuffled.forEach((expr, i) => chunkLines.push(`${tableVar}[${i+1}]=${expr}`));

  // Build permutation table
  const permVar = rn();
  const permDecl = `local ${permVar}={${permutation.join(",")}}`;

  // Reassembly loop
  const reassembleVar = rn();
  const loopVar = rn();
  const reassembleBlock = `local ${reassembleVar}='' for ${loopVar}=1,#${permVar} do ${reassembleVar}=${reassembleVar}..${tableVar}[${permVar}[${loopVar}]] end`;

  // XOR function in Lua (using bit32)
  const xf = rn(), xt = rn();
  const xorFuncDef = `local function ${xf}(s,k) local ${xt}={} for i=1,#s do ${xt}[i]=string.char(bit32.bxor(string.byte(s,i),k)) end return table.concat(${xt}) end`;

  // Decode expression
  const decVar = rn();
  const dec2Var = rn();
  const key2Expr = obfNum(key2);
  const XORExpr = obfNum(XOR_KEY);

  // base64decode accessor via getgenv
  const bsfVar = rn(), kVar = rn(), eVar = rn(), dVar = rn();
  const bsfBlock = `local ${bsfVar}=setmetatable({},{__index=function(_,${kVar}) local ${eVar}=${bytesLiteral("bENCO")} local ${dVar}=${bytesLiteral("bDECO")} if ${kVar}==${eVar} then return getgenv()[${bytesLiteral("base64encode")}] elseif ${kVar}==${dVar} then return getgenv()[${bytesLiteral("base64decode")}] end end})`;

  const junk = [junkStatement(rn), junkStatement(rn), junkStatement(rn), junkStatement(rn)];

  const parts = [
    "return(function()",
      bsfBlock,
      junk[0],
      chunkLines.join(" "),
      permDecl,
      junk[1],
      reassembleBlock,
      junk[2],
      xorFuncDef,
      `local ${decVar}=${bsfVar}.bDECO(${xf}(${reassembleVar},${key2Expr}))`,
      `local ${dec2Var}=${xf}(${decVar},${XORExpr})`,
      junk[3],
      `return(loadstring or load)(${dec2Var})()`,
    "end)()"
  ];

  let output = parts.join(" ").replace(/ {2,}/g, " ").trim();
  return WATERMARK + "\n" + output;
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
    .btn { display:flex; align-items:center; gap:0.5rem; padding:0.6rem 1.2rem; font-size:1rem; background:rgba(40,40,60,.7); color:#fff; border:1px solid rgba(180,180,255,.3); border-radius:8px; cursor:pointer; transition:.2s ease; font-family:'Coming Soon',cursive; }
    .btn:hover { background:rgba(255,255,255,0.25); transform:scale(1.05); }
    .btn:disabled { opacity:0.5; cursor:not-allowed; transform:none; }
    .btn.copied { background:rgba(0,200,100,0.3); border-color:rgba(0,200,100,0.6); }
    .limit-badge { background: #00ff88; color: #000; padding: 2px 8px; border-radius: 10px; font-size: 0.7rem; margin-left: 10px; }
  </style>
</head>
<body>
<div class="container">
  <h1>Scoper's Obfuscator <span class="badge">UNLIMITED</span></h1>
  <p style="margin-top: 10px;">No API limits &bull; 10,000+ lines supported &bull; Maximum security</p>
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
      <button class="btn" id="copyBtn">Copy Obfuscated</button>
      <button class="btn" id="download">Download Obfuscated</button>
      <button class="btn" id="clear">Clear</button>
    </div>
  </div>
</div>
<div class="version">v2.0.0 - Unlimited</div>
<div class="copyright">&copy; 2026 Scoper. All rights reserved.</div>
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

async function getObfuscated() {
  const code = input.value.trim();
  if (!code) { alert('No code to obfuscate'); return null; }
  const res = await fetch('/api/obfuscate', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ script: code })
  });
  if (!res.ok) { alert('Obfuscation failed: ' + await res.text()); return null; }
  return await res.text();
}

document.getElementById('download').onclick = async () => {
  const btn = document.getElementById('download');
  btn.textContent = 'Obfuscating...';
  btn.disabled = true;
  try {
    const obfuscated = await getObfuscated();
    if (!obfuscated) return;
    const blob = new Blob([obfuscated], { type: 'text/plain' });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = 'obfuscated_' + Math.random().toString(36).substring(2,10) + '.lua';
    document.body.appendChild(a); a.click(); document.body.removeChild(a);
    URL.revokeObjectURL(url);
    alert('Success! Obfuscated file downloaded.');
  } catch (err) { alert('Error: ' + err.message); }
  finally { btn.textContent = 'Download Obfuscated'; btn.disabled = false; }
};

document.getElementById('copyBtn').onclick = async () => {
  const btn = document.getElementById('copyBtn');
  btn.textContent = 'Obfuscating...';
  btn.disabled = true;
  try {
    const obfuscated = await getObfuscated();
    if (!obfuscated) return;
    await navigator.clipboard.writeText(obfuscated);
    btn.textContent = 'Copied!';
    btn.classList.add('copied');
    setTimeout(() => {
      btn.textContent = 'Copy Obfuscated';
      btn.classList.remove('copied');
    }, 2000);
  } catch (err) { alert('Error: ' + err.message); }
  finally { btn.disabled = false; }
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
