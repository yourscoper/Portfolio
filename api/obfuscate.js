// api/obfuscate.js
export default function handler(req, res) {
  res.setHeader("Content-Type", "text/html; charset=utf-8");
  res.setHeader("Cache-Control", "public, max-age=3600, s-maxage=86400");

  res.status(200).send(`
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Scopefuscator</title>
  <style>
    * { margin:0; padding:0; box-sizing:border-box; user-select:none; }
    body {
      background:#000000;
      color:#e0e0e0;
      font-family:'Segoe UI',sans-serif;
      min-height:100vh;
      overflow-x:hidden;
      position:relative;
    }
    canvas#trail, canvas#sparkle { position:fixed; inset:0; pointer-events:none; z-index:9999; }
    h1 {
      color:#00ffcc;
      text-align:center;
      margin:40px 0 8px;
      text-shadow:0 0 15px #00ffcc80;
      font-size:2.8rem;
    }
    .subtitle {
      text-align:center;
      color:#888;
      font-size:1.1rem;
      margin-bottom:30px;
    }
    .container {
      max-width:1200px;
      margin:0 auto;
      display:grid;
      grid-template-columns:1fr 1fr;
      gap:24px;
      padding:0 20px;
    }
    textarea, #output {
      width:100%;
      height:480px;
      background:rgba(20,20,20,0.6);
      color:#e0e0e0;
      border:1px solid #333;
      border-radius:12px;
      padding:16px;
      font-family:'Consolas',monospace;
      font-size:14px;
      resize:vertical;
      backdrop-filter:blur(12px);
      -webkit-backdrop-filter:blur(12px);
      box-shadow:0 8px 32px rgba(0,0,0,0.5);
    }
    #output {
      white-space:pre-wrap;
      overflow-y:auto;
      line-height:1.5;
    }
    .controls {
      display:flex;
      justify-content:center;
      gap:20px;
      flex-wrap:wrap;
      margin:30px 0;
    }
    .icon-button {
      display:inline-flex;
      align-items:center;
      gap:10px;
      background:rgba(255,255,255,0.08);
      border:1px solid rgba(255,255,255,0.15);
      color:#00ffcc;
      padding:12px 20px;
      border-radius:12px;
      font-size:1rem;
      font-weight:500;
      cursor:pointer;
      transition:all 0.25s ease;
      backdrop-filter:blur(10px);
      -webkit-backdrop-filter:blur(10px);
    }
    .icon-button:hover {
      background:rgba(0,255,204,0.2);
      box-shadow:0 0 20px rgba(0,255,204,0.4);
      transform:translateY(-3px);
    }
    .icon-button:active { transform:translateY(0); }
    .icon-button svg { width:22px; height:22px; stroke:#00ffcc; }
    .version {
      position:fixed;
      bottom:20px;
      left:20px;
      color:#555;
      font-size:0.9em;
    }
    .copyright {
      position:fixed;
      bottom:20px;
      left:50%;
      transform:translateX(-50%);
      color:#555;
      font-size:0.9em;
    }
    .lua-keyword { color:#ff79c6; }
    .lua-string { color:#f1fa8c; }
    .lua-number { color:#bd93f9; }
    .lua-comment { color:#6272a4; font-style:italic; }
    @media (max-width:768px) {
      .container { grid-template-columns:1fr; }
      textarea, #output { height:320px; }
    }
  </style>
</head>
<body>
  <canvas id="trail"></canvas>
  <canvas id="sparkle"></canvas>

  <h1>Scoper's Obfuscator</h1>
  <p class="subtitle">Paste Lua or LuaU code → Obfuscate → Copy<br><strong>Note:</strong> Professional Obfuscation</p>

  <div class="container">
    <div>
      <h3>Input Code</h3>
      <textarea id="input" placeholder="local msg = 'hello'\\nprint(msg)"></textarea>
    </div>
    <div>
      <h3>Obfuscated Output</h3>
      <pre id="output">-- output appears here</pre>
    </div>
  </div>

  <div class="controls">
    <button class="icon-button" onclick="obfuscate()">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path d="M5 5a2 2 0 0 1 3.008-1.728l11.997 6.998a2 2 0 0 1 .003 3.458l-12 7A2 2 0 0 1 5 19z"/>
      </svg>
      Obfuscate
    </button>

    <button class="icon-button" onclick="copyOutput()">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <rect width="14" height="14" x="8" y="8" rx="2" ry="2"/>
        <path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2"/>
      </svg>
      Copy Output
    </button>

    <button class="icon-button" onclick="clearAll()">
      <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path d="M21 21H8a2 2 0 0 1-1.42-.587l-3.994-3.999a2 2 0 0 1 0-2.828l10-10a2 2 0 0 1 2.829 0l5.999 6a2 2 0 0 1 0 2.828L12.834 21"/>
        <path d="m5.082 11.09 8.828 8.828"/>
      </svg>
      Clear
    </button>
  </div>

  <div class="version">v1.0.8</div>
  <div class="copyright">© 2026 yourscoper. All rights reserved.</div>

  <script>
    // Mouse trail (smooth white particles)
    const trail = document.getElementById('trail');
    const tctx = trail.getContext('2d');
    trail.width = innerWidth; trail.height = innerHeight;
    window.addEventListener('resize', () => { trail.width = innerWidth; trail.height = innerHeight; });
    let trailPoints = [];
    document.addEventListener('mousemove', e => {
      trailPoints.push({x:e.clientX, y:e.clientY, t:Date.now()});
    });
    function drawTrail() {
      tctx.clearRect(0,0,trail.width,trail.height);
      const now = Date.now();
      trailPoints = trailPoints.filter(p => now - p.t < 800);
      for(let i=1; i<trailPoints.length; i++) {
        const p1 = trailPoints[i-1], p2 = trailPoints[i];
        const age = (now - p2.t) / 800;
        tctx.beginPath();
        tctx.moveTo(p1.x, p1.y);
        tctx.lineTo(p2.x, p2.y);
        tctx.strokeStyle = \`rgba(255,255,255,\${1-age})\`;
        tctx.lineWidth = 2.5 - age*2;
        tctx.stroke();
      }
      requestAnimationFrame(drawTrail);
    }
    drawTrail();

    // Sparkling effects (random fading sparkles)
    const sparkle = document.getElementById('sparkle');
    const sctx = sparkle.getContext('2d');
    sparkle.width = innerWidth; sparkle.height = innerHeight;
    window.addEventListener('resize', () => { sparkle.width = innerWidth; sparkle.height = innerHeight; });
    let sparkles = [];
    function createSparkle() {
      sparkles.push({
        x: Math.random() * innerWidth,
        y: Math.random() * innerHeight,
        r: Math.random()*2.5 + 1,
        a: 1,
        t: Date.now()
      });
    }
    function drawSparkles() {
      sctx.clearRect(0,0,sparkle.width,sparkle.height);
      const now = Date.now();
      sparkles = sparkles.filter(s => now - s.t < 2000);
      sparkles.forEach(s => {
        const age = (now - s.t) / 2000;
        s.a = 1 - age;
        sctx.fillStyle = \`rgba(0,255,204,\${s.a})\`;
        sctx.beginPath();
        sctx.arc(s.x, s.y, s.r, 0, Math.PI*2);
        sctx.fill();
      });
      requestAnimationFrame(drawSparkles);
    }
    drawSparkles();
    setInterval(createSparkle, 300);

    // Obfuscation functions
    function randomName() {
      const c = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_$";
      let n = "_0x";
      for(let i=0;i<14;i++) n += c[Math.floor(Math.random()*c.length)];
      return n;
    }

    function xorEncrypt(str) {
      const k = Math.floor(Math.random()*120) + 60;
      let r = "";
      for(let i=0;i<str.length;i++) {
        r += String.fromCharCode(str.charCodeAt(i) ^ (k + i%29));
      }
      return {enc:btoa(r), key:k};
    }

    function fakeJunk() {
      const junk = [
        \`if math.random()>1.5 then end -- anti tamper\\n\`,
        \`local _ = 0x\${Math.floor(Math.random()*0xFFFFF).toString(16).toUpperCase()}\\n\`,
        \`for i=1,0 do break end\\n\`,
        \`repeat until math.random()>2\\n\`,
        \`-- vm trap ${randomName()}\\n\`
      ];
      return junk[Math.floor(Math.random()*junk.length)];
    }

    function obfuscate() {
      let code = document.getElementById("input").value.trim();
      if (!code) {
        document.getElementById("output").innerHTML = "<span class='lua-comment'>-- Paste code first</span>";
        return;
      }

      // Remove comments
      code = code.replace(/--[^\n]*|\/\*[\s\S]*?\*\//g, '');

      // Variable rename
      const map = new Map();
      const vars = code.match(/\b[a-zA-Z_]\w*\b/g) || [];
      vars.forEach(v => {
        if (!["and","break","do","else","elseif","end","false","for","function","if","in","local","nil","not","or","repeat","return","then","true","until","while","goto"].includes(v)) {
          if (!map.has(v)) map.set(v, randomName());
        }
      });
      map.forEach((nv, ov) => {
        code = code.replace(new RegExp('\\b' + ov.replace(/[.*+?^${}()|[\]\\]/g, '\\\\$&') + '\\b', 'g'), nv);
      });

      // String encryption
      code = code.replace(/(["'])(?:(?=(\\?))\\2.)*?\\1/g, m => {
        const content = m.slice(1,-1);
        if (content.length < 5) return m;
        const {enc,key} = xorEncrypt(content);
        return \`(function(s,k)local r=""for i=1,#s do r=r..string.char(bit32.bxor(s:byte(i),k+(i-1)%29))end return r end)("\${enc}",\${key})\`;
      });

      // Hex numbers
      code = code.replace(/\b\d+\b/g, n => {
        const num = parseInt(n);
        return num > 50 ? "0x" + num.toString(16).toUpperCase() : n;
      });

      // Junk + fake flow
      let obf = "do\\n";
      const lines = code.split('\\n');
      lines.forEach(l => {
        if (Math.random() > 0.55) obf += fakeJunk();
        obf += l.trim() + "\\n";
        if (Math.random() > 0.65) obf += fakeJunk();
      });
      obf += "end";

      // Simple syntax highlight
      obf = obf.replace(/\b(local|function|if|then|else|end|return|for|in|do|while|repeat|until|true|false|nil)\b/g, '<span class="lua-keyword">$1</span>');
      obf = obf.replace(/"([^"]*)"/g, '"<span class="lua-string">$1</span>"');
      obf = obf.replace(/0x[0-9A-F]+|\b\d+\b/g, '<span class="lua-number">$&</span>');
      obf = obf.replace(/--[^\n]*/g, '<span class="lua-comment">$&</span>');

      document.getElementById("output").innerHTML = obf;
    }

    function copyOutput() {
      const text = document.getElementById("output").textContent;
      navigator.clipboard.writeText(text).then(() => alert("Copied!"));
    }

    function clearAll() {
      document.getElementById("input").value = "";
      document.getElementById("output").innerHTML = "";
    }
  </script>
</body>
</html>
  `);
}
