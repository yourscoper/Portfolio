// api/obfuscate.js
export default function handler(req, res) {
  res.setHeader("Content-Type", "text/html; charset=utf-8");

  res.status(200).send(`<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Scopefuscator</title>
  <style>
    * { margin:0; padding:0; box-sizing:border-box; user-select:none; }
    body {
      background:#000;
      color:#e0e0e0;
      font-family:sans-serif;
      min-height:100vh;
      position:relative;
      overflow-x:hidden;
    }
    canvas { position:fixed; inset:0; pointer-events:none; z-index:9999; }
    h1 {
      color:#00ffcc;
      text-align:center;
      margin:60px 20px 10px;
      font-size:2.8rem;
      text-shadow:0 0 15px #00ffcc66;
    }
    .subtitle {
      text-align:center;
      color:#888;
      font-size:1.1rem;
      margin-bottom:40px;
    }
    .container {
      max-width:1200px;
      margin:0 auto;
      padding:0 20px;
      display:grid;
      grid-template-columns:1fr 1fr;
      gap:24px;
    }
    textarea, pre#output {
      width:100%;
      height:460px;
      background:rgba(30,30,30,0.65);
      color:#eee;
      border:1px solid #444;
      border-radius:10px;
      padding:16px;
      font-family:Consolas,monospace;
      font-size:14px;
      resize:vertical;
      backdrop-filter:blur(10px);
    }
    pre#output { white-space:pre-wrap; overflow-y:auto; }
    .controls {
      display:flex;
      justify-content:center;
      gap:20px;
      flex-wrap:wrap;
      margin:40px 0;
    }
    button.icon-button {
      display:flex;
      align-items:center;
      gap:10px;
      background:rgba(255,255,255,0.07);
      border:1px solid rgba(255,255,255,0.18);
      color:#00ffcc;
      padding:12px 20px;
      border-radius:10px;
      font-size:1rem;
      cursor:pointer;
      transition:0.25s;
      backdrop-filter:blur(12px);
    }
    button.icon-button:hover {
      background:rgba(0,255,204,0.18);
      box-shadow:0 0 20px rgba(0,255,204,0.35);
      transform:translateY(-2px);
    }
    button.icon-button svg { width:22px; height:22px; stroke:#00ffcc; }
    .version {
      position:fixed;
      bottom:20px;
      left:24px;
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
    @media (max-width:800px) {
      .container { grid-template-columns:1fr; }
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
      <textarea id="input" placeholder="print('test')"></textarea>
    </div>
    <div>
      <h3>Obfuscated Output</h3>
      <pre id="output">-- output will appear here</pre>
    </div>
  </div>

  <div class="controls">
    <button class="icon-button" onclick="obfuscate()">Obfuscate</button>
    <button class="icon-button" onclick="copyOutput()">Copy Output</button>
    <button class="icon-button" onclick="clearAll()">Clear</button>
  </div>

  <div class="version">v1.0.8</div>
  <div class="copyright">© 2026 yourscoper. All rights reserved.</div>

  <script>
    // Trail
    const trail = document.getElementById('trail');
    const tctx = trail.getContext('2d');
    trail.width = innerWidth; trail.height = innerHeight;
    window.addEventListener('resize', ()=>{trail.width=innerWidth;trail.height=innerHeight});
    let tpoints = [];
    document.addEventListener('mousemove', e=>tpoints.push({x:e.clientX,y:e.clientY,t:Date.now()}));
    function drawTrail(){
      tctx.clearRect(0,0,trail.width,trail.height);
      const now=Date.now();
      tpoints=tpoints.filter(p=>now-p.t<700);
      for(let i=1;i<tpoints.length;i++){
        const p1=tpoints[i-1], p2=tpoints[i];
        const age=(now-p2.t)/700;
        tctx.beginPath();
        tctx.moveTo(p1.x,p1.y);
        tctx.lineTo(p2.x,p2.y);
        tctx.strokeStyle=\`rgba(255,255,255,\${1-age})\`;
        tctx.lineWidth=2.5-age*2;
        tctx.stroke();
      }
      requestAnimationFrame(drawTrail);
    }
    drawTrail();

    // Sparkles
    const sparkle = document.getElementById('sparkle');
    const sctx = sparkle.getContext('2d');
    sparkle.width = innerWidth; sparkle.height = innerHeight;
    window.addEventListener('resize', ()=>{sparkle.width=innerWidth;sparkle.height=innerHeight});
    let sparks = [];
    function addSpark(){sparks.push({x:Math.random()*innerWidth,y:Math.random()*innerHeight,r:Math.random()*2.5+1,a:1,t:Date.now()});}
    function drawSparkles(){
      sctx.clearRect(0,0,sparkle.width,sparkle.height);
      const now=Date.now();
      sparks=sparks.filter(s=>now-s.t<1800);
      sparks.forEach(s=>{
        const age=(now-s.t)/1800;
        sctx.fillStyle=\`rgba(0,255,204,\${1-age})\`;
        sctx.beginPath();
        sctx.arc(s.x,s.y,s.r,0,Math.PI*2);
        sctx.fill();
      });
      requestAnimationFrame(drawSparkles);
    }
    drawSparkles();
    setInterval(addSpark,350);

    // Basic obfuscate (safe version)
    function obfuscate(){
      const input = document.getElementById('input').value.trim();
      if(!input){
        document.getElementById('output').textContent = '-- Paste some code first';
        return;
      }
      let out = '-- Obfuscated\\n' + input.split('').reverse().join('') + '\\n-- (test reverse for now)';
      document.getElementById('output').textContent = out;
    }

    function copyOutput(){
      const t = document.getElementById('output').textContent;
      navigator.clipboard.writeText(t).then(()=>alert('Copied!'));
    }

    function clearAll(){
      document.getElementById('input').value = '';
      document.getElementById('output').textContent = '';
    }
  </script>
</body>
</html>`);
}
