// api/obfuscate.js
export default function handler(req, res) {
  // Set content type to HTML so the browser renders it as a webpage
  res.setHeader("Content-Type", "text/html; charset=utf-8");

  // Optional: Add cache headers so Vercel/CDN can cache the static page
  res.setHeader("Cache-Control", "public, max-age=3600, s-maxage=86400");

  // The full HTML page (obfuscator) is served as string
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
    .container {
      max-width: 1200px;
      margin: 0 auto;
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
    }
    textarea, #output {
      width: 100%;
      height: 420px;
      background: #161b22;
      color: #c9d1d9;
      border: 1px solid #30363d;
      border-radius: 6px;
      padding: 12px;
      font-family: 'Consolas', 'Courier New', monospace;
      font-size: 14px;
      resize: vertical;
    }
    #output {
      white-space: pre-wrap;
      overflow-y: auto;
      min-height: 420px;
    }
    .controls {
      text-align: center;
      margin: 20px 0;
    }
    button {
      background: #238636;
      color: white;
      border: none;
      padding: 12px 24px;
      border-radius: 6px;
      font-size: 16px;
      cursor: pointer;
      margin: 0 8px;
      transition: background 0.2s;
    }
    button:hover { background: #2ea043; }
    button:active { background: #1f6e33; }
    @media (max-width: 768px) {
      .container { grid-template-columns: 1fr; }
      textarea, #output { height: 300px; }
    }
  </style>
</head>
<body>
  <h1>Lua / LuaU Obfuscator</h1>
  <p class="subtitle">Paste your Lua/LuaU code below → click Obfuscate → copy the result.<br>
  <strong>Note:</strong> Client-side only — basic protection / annoyance level (not military-grade).</p>

  <div class="container">
    <div>
      <h3>Input Lua Code</h3>
      <textarea id="input" placeholder="local msg = 'hello'\nprint(msg + ' world')"></textarea>
    </div>

    <div>
      <h3>Obfuscated Output</h3>
      <pre id="output">-- output appears here</pre>
    </div>
  </div>

  <div class="controls">
    <button onclick="obfuscate()">Obfuscate</button>
    <button onclick="copyOutput()">Copy Output</button>
    <button onclick="clearAll()">Clear</button>
  </div>

  <script>
    function randomName() {
      const chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_$";
      let name = "_0x";
      for (let i = 0; i < 8 + Math.floor(Math.random()*8); i++) {
        name += chars[Math.floor(Math.random() * chars.length)];
      }
      return name;
    }

    function xorEncrypt(str) {
      const key = Math.floor(Math.random()*180) + 70;
      let result = "";
      for (let i = 0; i < str.length; i++) {
        result += String.fromCharCode(str.charCodeAt(i) ^ (key + i % 23));
      }
      return { enc: btoa(result), key };
    }

    function fakeDeadCode() {
      const junk = [
        \`if math.random() > 2 then end\`,
        \`local _ = \${Math.random()*999|0} * \${Math.random()*999|0}\`,
        \`for _=1,0 do end\`,
        \`-- dead code \${randomName()}\`
      ];
      return junk[Math.floor(Math.random()*junk.length)] + "\\n";
    }

    function obfuscate() {
      let code = document.getElementById("input").value.trim();
      if (!code) {
        document.getElementById("output").textContent = "-- Nothing to obfuscate";
        return;
      }

      // Remove comments (basic)
      code = code.replace(/--[^\n]*|\/\*[\s\S]*?\*\//g, '');

      // Variable & function renaming
      const varMap = new Map();
      const varRegex = /(?:local\\s+)?([a-zA-Z_][a-zA-Z0-9_]*)(?=\\s*[=,)\\]])|\\bfunction\\s+([a-zA-Z_][a-zA-Z0-9_]*)/g;
      let match;
      while ((match = varRegex.exec(code)) !== null) {
        const name = match[1] || match[2];
        if (name && !["function","local","if","for","while","return","end","then","else","true","false","nil"].includes(name)) {
          if (!varMap.has(name)) varMap.set(name, randomName());
        }
      }

      // Replace names
      for (const [old, neu] of varMap) {
        code = code.replace(new RegExp(\`\\\\b\${old}\\\\b\`, "g"), neu);
      }

      // String encryption (XOR + base64 + decoder function)
      code = code.replace(/(["'])(?:(?=(\\\\?))\\2.)*?\\1/g, (match) => {
        const content = match.slice(1, -1);
        if (content.length < 4) return match;
        const { enc, key } = xorEncrypt(content);
        return \`(function(x,k) local r="" for i=1,#x do r=r..string.char(x:byte(i) ~ (k + (i-1)%23)) end return r end)("\${enc}",\${key})\`;
      });

      // Numbers to hex (for larger ones)
      code = code.replace(/\\b\\d+\\b/g, n => {
        const num = parseInt(n);
        return num > 20 ? "0x" + num.toString(16).toUpperCase() : n;
      });

      // Minify whitespace a bit
      code = code.replace(/\\s+/g, " ").trim();

      // Add random dead code
      let obf = "do\\n";
      const lines = code.split("\\n");
      for (let line of lines) {
        if (Math.random() > 0.65) obf += fakeDeadCode();
        obf += line + "\\n";
        if (Math.random() > 0.75) obf += fakeDeadCode();
      }
      obf += "end\\n";

      document.getElementById("output").textContent = obf;
    }

    function copyOutput() {
      const text = document.getElementById("output").textContent;
      navigator.clipboard.writeText(text).then(() => alert("Copied to clipboard!"));
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
