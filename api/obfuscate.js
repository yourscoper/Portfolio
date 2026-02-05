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
  <title>LuaU Obfuscator | yourscoper</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background: #0d1117;
      color: #c9d1d9;
      margin: 0;
      padding: 20px;
      line-height: 1.5;
    }
    h1 { color: #58a6ff; text-align: center; margin-bottom: 8px; }
    .subtitle { text-align: center; color: #8b949e; font-size: 0.95em; margin-bottom: 24px; }
    .container { max-width: 1200px; margin: 0 auto; display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
    textarea, #output {
      width: 100%;
      height: 420px;
      background: #161b22;
      color: #c9d1d9;
      border: 1px solid #30363d;
      border-radius: 6px;
      padding: 12px;
      font-family: 'Consolas', monospace;
      font-size: 14px;
      resize: vertical;
    }
    #output { white-space: pre-wrap; overflow-y: auto; min-height: 420px; }
    .controls {
      display: flex;
      justify-content: center;
      gap: 16px;
      flex-wrap: wrap;
      margin: 24px 0;
    }
    .icon-button {
      display: inline-flex;
      align-items: center;
      gap: 8px;
      background: #238636;
      color: white;
      border: none;
      padding: 10px 16px;
      border-radius: 6px;
      font-size: 15px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.2s;
    }
    .icon-button:hover { background: #2ea043; transform: translateY(-1px); }
    .icon-button:active { background: #1f6e33; transform: translateY(0); }
    .icon-button svg { width: 20px; height: 20px; }
    @media (max-width: 768px) {
      .container { grid-template-columns: 1fr; }
      textarea, #output { height: 300px; }
      .controls { flex-direction: column; align-items: stretch; }
      .icon-button { justify-content: center; }
    }
  </style>
</head>
<body>
  <h1>Lua / LuaU Obfuscator</h1>
  <p class="subtitle">Paste Lua/LuaU code → Obfuscate → copy result.<br><strong>Note:</strong> Basic client-side obfuscation</p>

  <div class="container">
    <div>
      <h3>Input Lua Code</h3>
      <textarea id="input" placeholder="local player = game.Players.LocalPlayer\nprint(player.Name)"></textarea>
    </div>
    <div>
      <h3>Obfuscated Output</h3>
      <pre id="output">-- output appears here</pre>
    </div>
  </div>

  <div class="controls">
    <button class="icon-button" onclick="obfuscate()">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M5 5a2 2 0 0 1 3.008-1.728l11.997 6.998a2 2 0 0 1 .003 3.458l-12 7A2 2 0 0 1 5 19z"></path>
      </svg>
      Obfuscate
    </button>

    <button class="icon-button" onclick="copyOutput()">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <rect width="14" height="14" x="8" y="8" rx="2" ry="2"></rect>
        <path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2"></path>
      </svg>
      Copy Output
    </button>

    <button class="icon-button" onclick="clearAll()">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
        <path d="M21 21H8a2 2 0 0 1-1.42-.587l-3.994-3.999a2 2 0 0 1 0-2.828l10-10a2 2 0 0 1 2.829 0l5.999 6a2 2 0 0 1 0 2.828L12.834 21"></path>
        <path d="m5.082 11.09 8.828 8.828"></path>
      </svg>
      Clear
    </button>
  </div>

  <script>
    function randomName() {
      const chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_$";
      let name = "_0x";
      for (let i = 0; i < 10; i++) {
        name += chars[Math.floor(Math.random() * chars.length)];
      }
      return name;
    }

    function fakeDeadCode() {
      const junk = [
        "if math.random() > 2 then end\\n",
        "local _ = " + (Math.random()*999|0) + "\\n",
        "for i=1,0 do end\\n",
        "-- junk\\n"
      ];
      return junk[Math.floor(Math.random() * junk.length)];
    }

    function obfuscate() {
      let code = document.getElementById("input").value.trim();
      if (!code) {
        document.getElementById("output").textContent = "-- Paste some code first";
        return;
      }

      // Remove comments
      code = code.replace(/--[^\\n]*/g, '').replace(/\\/\\*[\\s\\S]*?\\*\\//g, '');

      // Simple variable renaming
      const varMap = new Map();
      const words = code.match(/[a-zA-Z_][a-zA-Z0-9_]*/g) || [];
      words.forEach(word => {
        if (!["local","function","if","then","else","end","return","print","true","false","nil"].includes(word)) {
          if (!varMap.has(word)) varMap.set(word, randomName());
        }
      });

      varMap.forEach((newName, oldName) => {
        code = code.replace(new RegExp("\\\\b" + oldName + "\\\\b", "g"), newName);
      });

      // Numbers to hex
      code = code.replace(/\\b\\d+\\b/g, n => {
        const num = parseInt(n);
        return num > 30 ? "0x" + num.toString(16).toUpperCase() : n;
      });

      // Add junk + wrap
      let obf = "do\\n";
      const lines = code.split("\\n");
      lines.forEach(line => {
        if (Math.random() > 0.7) obf += fakeDeadCode();
        obf += line.trim() + "\\n";
      });
      obf += "end";

      document.getElementById("output").textContent = obf;
    }

    function copyOutput() {
      const text = document.getElementById("output").textContent;
      navigator.clipboard.writeText(text).then(() => {
        alert("Copied!");
      }).catch(() => {
        alert("Copy failed – select manually");
      });
    }

    function clearAll() {
      document.getElementById("input").value = "";
      document.getElementById("output").textContent = "";
    }
  </script>
</body>
</html>
  `);
}
