function toCFrameString(d) {
  if (d.length === 7) {
    const [px,py,pz,qx,qy,qz,qw] = d;
    const x2=qx*2,y2=qy*2,z2=qz*2;
    const xx=qx*x2,xy=qx*y2,xz=qx*z2,yy=qy*y2,yz=qy*z2,zz=qz*z2,wx=qw*x2,wy=qw*y2,wz=qw*z2;
    return fmt(px,py,pz,1-(yy+zz),xy-wz,xz+wy,xy+wz,1-(xx+zz),yz-wx,xz-wy,yz+wx,1-(xx+yy));
  }
  if (d.length === 12) return fmt(...d);
  if (d.length === 3) return `CFrame.new(${d.map(n=>n.toFixed(6)).join(', ')})`;
  return null;
}

function orientationFmt(px, py, pz, ox, oy, oz) {
  const rx=ox*Math.PI/180, ry=oy*Math.PI/180, rz=oz*Math.PI/180;
  const cx=Math.cos(rx),sx=Math.sin(rx),cy=Math.cos(ry),sy=Math.sin(ry),cz=Math.cos(rz),sz=Math.sin(rz);
  return fmt(px,py,pz, cy*cz,cy*-sz,sy, sx*sy*cz+cx*sz,sx*sy*-sz+cx*cz,-sx*cy, cx*sy*cz-sx*sz,cx*sy*-sz+sx*cz,cx*cy);
}

function fmt(...n) {
  return `CFrame.new(${n.map(v=>v.toFixed(6)).join(', ')})`;
}

function decodeAnimation(raw) {
  const lines = ['return {'];

  if (raw.animData) {
    for (const [clipName, keyframes] of Object.entries(raw.animData)) {
      lines.push(`  ["${clipName}"] = {`);
      keyframes.sort((a, b) => a.Time - b.Time);
      for (const kf of keyframes) {
        lines.push(`    {Time = ${kf.Time.toFixed(3)}, Data = {`);
        if (kf.Data) {
          for (const bone of Object.keys(kf.Data).sort()) {
            const r = kf.Data[bone];
            const arr = (typeof r[0] === 'number') ? r : (r[0] || r.CFrame || r.Data);
            if (arr) { const cf = toCFrameString(arr); if (cf) lines.push(`      ["${bone}"] = ${cf},`); }
          }
        }
        lines.push('    }},');
      }
      lines.push('  }');
    }
  } else if (Array.isArray(raw) && raw[0] && raw[0].Time != null && raw[0].Poses) {
    lines.push('  ["Animation"] = {');
    raw.sort((a, b) => a.Time - b.Time);
    for (const kf of raw) {
      lines.push(`    {Time = ${kf.Time.toFixed(3)}, Data = {`);
      if (kf.Poses) {
        for (const bone of Object.keys(kf.Poses).sort()) {
          const pd = kf.Poses[bone];
          if (pd.CFrame) {
            const pos = pd.CFrame.Position || [0,0,0];
            const ori = pd.CFrame.Orientation || [0,0,0];
            const px = pos[0]??pos.X??0, py = pos[1]??pos.Y??0, pz = pos[2]??pos.Z??0;
            const ox = ori[0]??ori.X??0, oy = ori[1]??ori.Y??0, oz = ori[2]??ori.Z??0;
            lines.push(`      ["${bone}"] = ${orientationFmt(px, py, pz, ox, oy, oz)},`);
          }
        }
      }
      lines.push('    }},');
    }
    lines.push('  }');
  } else {
    return null;
  }

  lines.push('}');
  return lines.join('\n');
}

function getHTML() {
  return `<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Scoper's Animation Decoder</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Coming+Soon&display=swap" rel="stylesheet">
  <style>
    *{margin:0;padding:0;box-sizing:border-box;}
    html,body{height:100%;font-family:'Coming Soon',cursive;background:#0d0d0d;color:#f0f0f0;overflow-x:hidden;}
    #sparkle-canvas,#trail-canvas{position:fixed;inset:0;pointer-events:none;}
    #sparkle-canvas{z-index:0;}#trail-canvas{z-index:1;}
    .container{position:relative;z-index:2;min-height:100vh;padding:2.5rem 1rem 5rem;display:flex;flex-direction:column;align-items:center;gap:1.5rem;}
    h1{font-size:clamp(2.2rem,8vw,5rem);color:#fff;text-shadow:0 0 30px rgba(100,180,255,.4);text-align:center;line-height:1.1;}
    .sub{color:#888;font-size:1rem;text-align:center;}
    .drop-zone{width:100%;max-width:860px;border:2px dashed #333;border-radius:12px;padding:2.5rem 2rem;display:flex;flex-direction:column;align-items:center;gap:.8rem;cursor:pointer;transition:border-color .2s,background .2s;}
    .drop-zone.dragover{border-color:#6af;background:rgba(100,170,255,.05);}
    .drop-zone svg{opacity:.4;}.drop-zone p{color:#666;font-size:.95rem;}.drop-zone .fname{color:#adf;font-size:.9rem;margin-top:.3rem;}
    .divider{width:100%;max-width:860px;display:flex;align-items:center;gap:1rem;color:#444;}
    .divider::before,.divider::after{content:'';flex:1;height:1px;background:#222;}
    .textarea-wrap{width:100%;max-width:860px;background:#111;border:1px solid #2a2a2a;border-radius:12px;overflow:hidden;}
    .textarea-header{padding:.6rem 1rem;background:#161616;border-bottom:1px solid #222;display:flex;align-items:center;justify-content:space-between;}
    .textarea-label{color:#666;font-size:.85rem;}.auto-decoded{color:#4ade80;font-size:.85rem;opacity:0;transition:opacity .3s;}.auto-decoded.show{opacity:1;}
    textarea{width:100%;height:220px;background:#111;color:#c8f5b0;border:none;outline:none;resize:vertical;padding:1rem;font-family:Consolas,monospace;font-size:.9rem;line-height:1.6;}
    textarea::placeholder{color:#333;}
    .btn{display:inline-flex;align-items:center;gap:.6rem;padding:.75rem 2rem;font-family:'Coming Soon',cursive;font-size:1rem;background:#fff;color:#000;border:none;border-radius:8px;cursor:pointer;transition:opacity .2s,transform .15s;}
    .btn:hover{opacity:.88;transform:scale(1.03);}.btn:disabled{opacity:.4;cursor:not-allowed;transform:none;}
    .btn.secondary{background:transparent;color:#666;border:1px solid #2a2a2a;}.btn.secondary:hover{color:#fff;border-color:#555;}
    .actions{display:flex;gap:.8rem;flex-wrap:wrap;justify-content:center;}
    .status{font-size:.9rem;color:#888;min-height:1.4em;text-align:center;}.status.ok{color:#6dfc9a;}.status.err{color:#fc6d6d;}
    .version{position:fixed;bottom:18px;left:20px;color:#fff;font-size:.85rem;opacity:.5;z-index:10;}
    .copyright{position:fixed;bottom:18px;left:50%;transform:translateX(-50%);color:#fff;font-size:.85rem;opacity:.4;z-index:10;white-space:nowrap;}
  </style>
</head>
<body>
<canvas id="sparkle-canvas"></canvas>
<canvas id="trail-canvas"></canvas>
<div class="container">
  <h1>Animation Decoder</h1>
  <p class="sub">Drop a Moon Animator JSON file or paste the code — get a decoded <code>.lua</code> KeyframeSequence</p>
  <div class="drop-zone" id="dropZone">
    <svg width="40" height="40" viewBox="0 0 24 24" fill="none" stroke="#fff" stroke-width="1.5">
      <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
      <polyline points="17 8 12 3 7 8"/><line x1="12" y1="3" x2="12" y2="15"/>
    </svg>
    <p>Drop your <strong>.json</strong> or <strong>.lua</strong> animation file here</p>
    <p class="fname" id="dropName" style="display:none"></p>
    <input type="file" id="fileInput" accept=".json,.lua,.txt" style="display:none"/>
  </div>
  <div class="divider">or paste JSON</div>
  <div class="textarea-wrap">
    <div class="textarea-header">
      <span class="textarea-label">Animation JSON</span>
      <span class="auto-decoded" id="autoDecodedTag">✦ Auto-Decoded Successfully</span>
    </div>
    <textarea id="jsonInput" spellcheck="false" placeholder='{"raw":true,"name":"my anim","format":2,"animData":{...}}'></textarea>
  </div>
  <div class="actions">
    <button class="btn" id="decodeBtn">Decode &amp; Download</button>
    <button class="btn secondary" id="copyBtn">Copy Output</button>
    <button class="btn secondary" id="clearBtn">Clear</button>
  </div>
  <p class="status" id="status"></p>
</div>
<div class="version">v1.0.0</div>
<div class="copyright">© 2026 yourscoper. All rights reserved.</div>
<script>
  let droppedFilename=null,decodedOutput=null,autoDecodeTimer=null;
  const dropZone=document.getElementById('dropZone'),fileInput=document.getElementById('fileInput');
  const dropName=document.getElementById('dropName'),jsonInput=document.getElementById('jsonInput');
  const autoDecodedTag=document.getElementById('autoDecodedTag'),status=document.getElementById('status');
  dropZone.addEventListener('click',()=>fileInput.click());
  dropZone.addEventListener('dragover',e=>{e.preventDefault();dropZone.classList.add('dragover');});
  dropZone.addEventListener('dragleave',()=>dropZone.classList.remove('dragover'));
  dropZone.addEventListener('drop',e=>{e.preventDefault();dropZone.classList.remove('dragover');const f=e.dataTransfer.files[0];if(f)loadFile(f);});
  fileInput.addEventListener('change',()=>{if(fileInput.files[0])loadFile(fileInput.files[0]);});
  function loadFile(file){
    droppedFilename=file.name.replace(/\\.(json|lua|txt)$/i,'');
    dropName.textContent='📄 '+file.name;dropName.style.display='block';
    const r=new FileReader();r.onload=e=>{jsonInput.value=e.target.result;triggerAutoDecode();};r.readAsText(file);
  }
  jsonInput.addEventListener('input',()=>{autoDecodedTag.classList.remove('show');decodedOutput=null;clearTimeout(autoDecodeTimer);autoDecodeTimer=setTimeout(triggerAutoDecode,300);});
  async function triggerAutoDecode(){
    const json=jsonInput.value.trim();if(!json)return;
    try{JSON.parse(json);}catch(e){return;}
    try{const result=await callAPI(json,droppedFilename||'animation');if(!result)return;decodedOutput=result.text;jsonInput.value=decodedOutput;autoDecodedTag.classList.add('show');setStatus('');}catch(e){}
  }
  async function callAPI(json,filename){
    const res=await fetch('/api/decodeanimation',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({json,filename})});
    if(!res.ok){setStatus('Error: '+await res.text(),'err');return null;}
    const text=await res.text();
    const outName=res.headers.get('X-Filename')||((filename||'animation')+'_decoded.lua');
    return{text,outName};
  }
  document.getElementById('decodeBtn').addEventListener('click',async()=>{
    const json=jsonInput.value.trim();if(!json){setStatus('Paste some JSON or drop a file first.','err');return;}
    const btn=document.getElementById('decodeBtn');btn.disabled=true;btn.textContent='⏳ Decoding...';setStatus('');
    try{
      const result=await callAPI(json,droppedFilename||'animation');if(!result)return;
      decodedOutput=result.text;jsonInput.value=decodedOutput;autoDecodedTag.classList.add('show');
      const blob=new Blob([result.text],{type:'text/plain'});const url=URL.createObjectURL(blob);
      const a=document.createElement('a');a.href=url;a.download=result.outName;document.body.appendChild(a);a.click();document.body.removeChild(a);URL.revokeObjectURL(url);
      setStatus('✅ Downloaded '+result.outName,'ok');
    }catch(err){setStatus('Error: '+err.message,'err');}
    finally{btn.disabled=false;btn.textContent='Decode & Download';}
  });
  document.getElementById('copyBtn').addEventListener('click',async()=>{
    const text=jsonInput.value.trim();if(!text){setStatus('Nothing to copy.','err');return;}
    try{await navigator.clipboard.writeText(text);setStatus('✅ Copied!','ok');}catch(e){setStatus('Copy failed: '+e.message,'err');}
  });
  document.getElementById('clearBtn').addEventListener('click',()=>{
    jsonInput.value='';droppedFilename=null;decodedOutput=null;dropName.style.display='none';fileInput.value='';autoDecodedTag.classList.remove('show');setStatus('');
  });
  function setStatus(msg,type){status.textContent=msg;status.className='status'+(type?' '+type:'');}
  const sc=document.getElementById('sparkle-canvas'),sx=sc.getContext('2d');
  function resizeSC(){sc.width=innerWidth;sc.height=innerHeight;}resizeSC();window.addEventListener('resize',resizeSC);
  const stars=Array.from({length:120},()=>({x:Math.random()*innerWidth,y:Math.random()*innerHeight,r:Math.random()*1.2+0.3,base:Math.random()*0.5+0.15,phase:Math.random()*Math.PI*2}));
  (function drawS(){sx.clearRect(0,0,sc.width,sc.height);const t=Date.now()/1000;for(const s of stars){const a=Math.max(0.05,Math.min(0.85,s.base+Math.sin(t*0.7+s.phase)*0.3));sx.fillStyle=\`rgba(240,248,255,\${a})\`;sx.beginPath();sx.arc(s.x,s.y,s.r,0,Math.PI*2);sx.fill();}requestAnimationFrame(drawS);})();
  const tc=document.getElementById('trail-canvas'),tx=tc.getContext('2d');
  function resizeTC(){tc.width=innerWidth;tc.height=innerHeight;}resizeTC();window.addEventListener('resize',resizeTC);
  const pts=[];document.addEventListener('mousemove',e=>pts.push({x:e.clientX,y:e.clientY,t:Date.now()}));
  (function drawT(){tx.clearRect(0,0,tc.width,tc.height);const now=Date.now();for(let i=pts.length-1;i>=0;i--){if(now-pts[i].t>800){pts.splice(0,i+1);break;}}for(let i=1;i<pts.length;i++){const age=(now-pts[i].t)/800;tx.beginPath();tx.moveTo(pts[i-1].x,pts[i-1].y);tx.lineTo(pts[i].x,pts[i].y);tx.strokeStyle=\`rgba(255,255,255,\${(1-age)*0.85})\`;tx.lineWidth=2;tx.lineCap='round';tx.stroke();}requestAnimationFrame(drawT);})();
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
    const { json, filename } = body || {};
    if (!json || typeof json !== "string" || !json.trim()) {
      return new Response("No JSON provided", { status: 400 });
    }

    let raw;
    try { raw = JSON.parse(json); }
    catch (e) { return new Response("Invalid JSON: " + e.message, { status: 400 }); }

    const result = decodeAnimation(raw);
    if (!result) return new Response("Unknown animation format", { status: 400 });

    const base = (filename || "animation").replace(/\.lua$/i, "").replace(/[^a-zA-Z0-9_\-. ]/g, "");
    return new Response(result, {
      headers: {
        "Content-Type": "text/plain; charset=utf-8",
        "X-Filename": `${base}_decoded.lua`
      }
    });
  } catch (err) {
    return new Response("Internal server error: " + err.message, { status: 500 });
  }
}
