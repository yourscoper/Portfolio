<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Potassium Theme Editor — yourscoper</title>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link href="https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@300;400;500;600;700&family=Syne:wght@400;500;600;700;800&display=swap" rel="stylesheet" />
<style>
  :root {
    --win-bg: #000000;
    --page-bg: #000000;
    --content-bg: #0D0D0D;
    --input-bg: #050505;
    --titlebar-bg: #00000000;
    --card-bg: #0A0A0A;
    --editor-bg: #0D0D0D;
    --editor-line-hl: #111111;
    --console-bg: #050505;
    --tab-bg: #101010;
    --tab-active-bg: #1A1A1A;
    --tab-hover-bg: #151515;
    --tab-inactive-bg: #0A0A0A;
    --search-bg: #121212;
    --title-text: #FFFFFF;
    --primary-text: #F5F5F5;
    --secondary-text: #CFCFCF;
    --tertiary-text: #AFAFAF;
    --placeholder-text: #5A5A5A;
    --icon-fg: #B0B0B0;
    --search-text: #EAEAEA;
    --script-file-text: #D6D6D6;
    --tab-active-text: #FFFFFF;
    --tab-inactive-text: #777777;
    --icon-default: #8C8C8C;
    --icon-hover: #FFFFFF;
    --add-tab-btn: #777777;
    --ctrl-btn-fg: #FFFFFF;
    --ctrl-btn-bg: #0A0A0A;
    --btn-bg: #111111;
    --btn-bg-hover: #1A1A1A;
    --btn-fg: #e8f0ff;
    --btn-fg-hover: #9399a3;
    --btn-disabled-bg: #080808;
    --btn-disabled-text: #555555;
    --scrollbar-track: #FFFFFF;
    --scrollbar-thumb: #FFFFFF;
    --btn-border: #2A2A2A;
    --card-border: #1E1E1E;
    --separator: #1A1A1A;
    --tabbar-border: #141414;
    --editor-line-hl-border: #252525;
    --accent-blue: #FFFFFF;
    --accent-green: #BFBFBF;
    --neutral-gray: #8C8C8C;
    --checkbox-checked: #FFFFFF;
  }

  * { margin: 0; padding: 0; box-sizing: border-box; }

  body {
    background: #0a0a0a;
    color: #e0e0e0;
    font-family: 'JetBrains Mono', monospace;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
  }

  /* ── PAGE HEADER ── */
  .page-header {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 14px 24px;
    border-bottom: 1px solid #1a1a1a;
    background: #050505;
    position: sticky;
    top: 0;
    z-index: 100;
  }
  .page-header .logo {
    font-family: 'Syne', sans-serif;
    font-weight: 800;
    font-size: 15px;
    color: #fff;
    letter-spacing: 0.05em;
    display: flex;
    align-items: center;
    gap: 8px;
  }
  .page-header .logo span { color: #666; font-weight: 400; }
  .page-header .actions { display: flex; gap: 8px; }
  .page-header button {
    background: #111;
    border: 1px solid #252525;
    color: #ccc;
    padding: 7px 16px;
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px;
    cursor: pointer;
    border-radius: 4px;
    transition: all .15s;
  }
  .page-header button:hover { background: #1a1a1a; color: #fff; border-color: #444; }
  .page-header button.primary { background: #1e1e1e; color: #fff; border-color: #3a3a3a; }
  .page-header button.primary:hover { background: #2a2a2a; }

  /* ── LAYOUT ── */
  .workspace {
    display: grid;
    grid-template-columns: 280px 1fr 300px;
    flex: 1;
    overflow: hidden;
    height: calc(100vh - 53px);
  }

  /* ── LEFT PANEL: THEME CATEGORIES ── */
  .left-panel {
    background: #080808;
    border-right: 1px solid #1a1a1a;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
  }
  .left-panel::-webkit-scrollbar { width: 4px; }
  .left-panel::-webkit-scrollbar-track { background: transparent; }
  .left-panel::-webkit-scrollbar-thumb { background: #222; border-radius: 2px; }

  .panel-header {
    padding: 14px 16px 10px;
    font-family: 'Syne', sans-serif;
    font-size: 11px;
    font-weight: 700;
    letter-spacing: .1em;
    text-transform: uppercase;
    color: #444;
    border-bottom: 1px solid #111;
  }

  .category-group { border-bottom: 1px solid #111; }
  .category-label {
    padding: 10px 16px;
    font-size: 11px;
    font-weight: 600;
    letter-spacing: .08em;
    text-transform: uppercase;
    color: #555;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: space-between;
    transition: color .15s;
    user-select: none;
  }
  .category-label:hover { color: #999; }
  .category-label.active { color: #ccc; }
  .category-label .arrow { font-size: 9px; transition: transform .2s; }
  .category-label.active .arrow { transform: rotate(90deg); }

  .color-entry {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 6px 16px 6px 24px;
    cursor: pointer;
    border-radius: 0;
    transition: background .1s;
  }
  .color-entry:hover { background: #111; }
  .color-entry.active { background: #131313; }
  .color-entry .swatch {
    width: 14px; height: 14px;
    border-radius: 3px;
    border: 1px solid rgba(255,255,255,.08);
    flex-shrink: 0;
  }
  .color-entry .key-name {
    font-size: 11px;
    color: #888;
    flex: 1;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
  .color-entry.active .key-name { color: #ccc; }

  /* ── CENTER: LIVE PREVIEW ── */
  .preview-panel {
    background: #080808;
    overflow: hidden;
    display: flex;
    flex-direction: column;
  }
  .preview-toolbar {
    padding: 8px 16px;
    border-bottom: 1px solid #111;
    display: flex;
    align-items: center;
    gap: 12px;
    background: #050505;
  }
  .preview-toolbar span {
    font-size: 11px;
    color: #444;
    letter-spacing: .06em;
    text-transform: uppercase;
    font-family: 'Syne', sans-serif;
    font-weight: 700;
  }
  .preview-scale-btns { display: flex; gap: 4px; }
  .preview-scale-btns button {
    background: #111;
    border: 1px solid #1e1e1e;
    color: #666;
    padding: 3px 8px;
    font-family: 'JetBrains Mono', monospace;
    font-size: 10px;
    cursor: pointer;
    border-radius: 3px;
    transition: all .1s;
  }
  .preview-scale-btns button:hover, .preview-scale-btns button.active { background: #1a1a1a; color: #ccc; border-color: #333; }

  .preview-frame-wrap {
    flex: 1;
    overflow: auto;
    padding: 20px;
    display: flex;
    align-items: flex-start;
    justify-content: center;
  }

  /* ── POTASSIUM UI MOCKUP ── */
  .potassium-window {
    width: 760px;
    min-width: 760px;
    border-radius: 8px;
    overflow: hidden;
    border: 1px solid rgba(255,255,255,.07);
    box-shadow: 0 32px 80px rgba(0,0,0,.8);
    font-family: 'JetBrains Mono', monospace;
    font-size: 12px;
  }

  .k-titlebar {
    background: var(--titlebar-bg, #000);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 8px 12px;
    border-bottom: 1px solid var(--tabbar-border);
  }
  .k-titlebar .k-title {
    font-family: 'Syne', sans-serif;
    font-size: 12px;
    font-weight: 700;
    color: var(--title-text);
    letter-spacing: .05em;
  }
  .k-titlebar .k-win-btns { display: flex; gap: 6px; }
  .k-win-btn {
    width: 12px; height: 12px;
    border-radius: 50%;
    cursor: pointer;
    opacity: .7;
  }
  .k-win-btn.close { background: #ff5f57; }
  .k-win-btn.min { background: #ffbd2e; }
  .k-win-btn.max { background: #28c940; }

  .k-icons { display: flex; gap: 10px; align-items: center; }
  .k-icon-btn {
    width: 22px; height: 22px;
    display: flex; align-items: center; justify-content: center;
    color: var(--icon-default);
    cursor: pointer;
    border-radius: 4px;
    font-size: 12px;
    transition: color .15s;
  }
  .k-icon-btn:hover { color: var(--icon-hover); }

  .k-body { background: var(--page-bg); display: flex; }
  
  .k-sidebar {
    width: 46px;
    background: var(--win-bg);
    border-right: 1px solid var(--separator);
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 8px 0;
    gap: 4px;
  }
  .k-sidebar-btn {
    width: 32px; height: 32px;
    display: flex; align-items: center; justify-content: center;
    border-radius: 6px;
    cursor: pointer;
    color: var(--icon-default);
    font-size: 13px;
    transition: background .15s, color .15s;
  }
  .k-sidebar-btn:hover, .k-sidebar-btn.active { background: var(--icon-selected-bg, #20ffffff); color: var(--icon-selected, #fff); }

  .k-main { flex: 1; display: flex; flex-direction: column; }
  .k-tabs {
    display: flex;
    align-items: center;
    background: var(--tab-bg);
    border-bottom: 1px solid var(--tabbar-border);
  }
  .k-tab {
    padding: 7px 14px;
    font-size: 11px;
    cursor: pointer;
    display: flex;
    align-items: center;
    gap: 6px;
    transition: background .1s;
    color: var(--tab-inactive-text);
    background: var(--tab-inactive-bg);
    border-right: 1px solid var(--tabbar-border);
  }
  .k-tab.active { background: var(--tab-active-bg); color: var(--tab-active-text); }
  .k-tab:hover:not(.active) { background: var(--tab-hover-bg); }
  .k-tab-dot { width: 5px; height: 5px; border-radius: 50%; background: var(--accent-green); opacity: .6; }
  .k-tab-close { opacity: .4; font-size: 10px; cursor: pointer; }
  .k-tab-close:hover { opacity: 1; }
  .k-add-tab {
    padding: 7px 10px;
    color: var(--add-tab-btn);
    cursor: pointer;
    font-size: 14px;
  }

  .k-editor {
    background: var(--editor-bg);
    padding: 10px 0;
    font-size: 12px;
    line-height: 1.7;
    min-height: 160px;
    flex: 1;
  }
  .k-line {
    display: flex;
    padding: 1px 0;
  }
  .k-line.hl { background: var(--editor-line-hl); border-left: 2px solid var(--editor-line-hl-border); }
  .k-linenum {
    width: 36px;
    text-align: right;
    padding-right: 14px;
    color: var(--placeholder-text);
    font-size: 11px;
    user-select: none;
    flex-shrink: 0;
  }
  .k-code { color: var(--primary-text); }
  .k-kw { color: var(--accent-blue); font-weight: 500; }
  .k-fn { color: var(--secondary-text); }
  .k-str { color: var(--accent-green); }
  .k-num { color: var(--tertiary-text); }
  .k-comment { color: var(--placeholder-text); font-style: italic; }
  .k-cursor {
    display: inline-block;
    width: 2px;
    height: 13px;
    background: var(--accent-blue);
    animation: blink 1.1s step-end infinite;
    vertical-align: text-bottom;
    margin-left: 1px;
  }
  @keyframes blink { 0%,100%{opacity:1} 50%{opacity:0} }

  .k-statusbar {
    background: var(--console-bg);
    border-top: 1px solid var(--separator);
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 5px 12px;
    font-size: 10px;
    color: var(--tertiary-text);
  }
  .k-statusbar .k-btns { display: flex; gap: 6px; }
  .k-status-btn {
    background: var(--btn-bg);
    border: 1px solid var(--btn-border);
    color: var(--btn-fg);
    padding: 4px 12px;
    font-family: 'JetBrains Mono', monospace;
    font-size: 10px;
    cursor: pointer;
    border-radius: 3px;
    transition: background .12s, color .12s;
  }
  .k-status-btn:hover { background: var(--btn-bg-hover); color: var(--btn-fg-hover); }
  .k-status-btn.execute { color: var(--accent-green); border-color: var(--accent-green); opacity: .9; }
  .k-status-btn.execute:hover { background: rgba(191,191,191,.08); }

  /* ── RIGHT PANEL: EDITOR ── */
  .right-panel {
    background: #070707;
    border-left: 1px solid #111;
    overflow-y: auto;
    display: flex;
    flex-direction: column;
  }
  .right-panel::-webkit-scrollbar { width: 4px; }
  .right-panel::-webkit-scrollbar-track { background: transparent; }
  .right-panel::-webkit-scrollbar-thumb { background: #1e1e1e; border-radius: 2px; }

  .editor-section {
    padding: 14px 16px 10px;
    border-bottom: 1px solid #0f0f0f;
  }
  .editor-section-title {
    font-size: 10px;
    font-family: 'Syne', sans-serif;
    font-weight: 700;
    letter-spacing: .1em;
    text-transform: uppercase;
    color: #333;
    margin-bottom: 12px;
  }

  .color-field {
    display: flex;
    align-items: center;
    gap: 8px;
    margin-bottom: 10px;
  }
  .color-field label {
    font-size: 10px;
    color: #555;
    flex: 1;
  }
  .color-field-wrap {
    display: flex;
    align-items: center;
    gap: 6px;
  }
  input[type="color"] {
    width: 26px;
    height: 26px;
    border: 1px solid #1e1e1e;
    background: #111;
    cursor: pointer;
    border-radius: 4px;
    padding: 2px;
    -webkit-appearance: none;
  }
  input[type="color"]::-webkit-color-swatch-wrapper { padding: 0; border-radius: 2px; }
  input[type="color"]::-webkit-color-swatch { border: none; border-radius: 2px; }
  .hex-input {
    width: 84px;
    background: #0d0d0d;
    border: 1px solid #1a1a1a;
    color: #aaa;
    font-family: 'JetBrains Mono', monospace;
    font-size: 10px;
    padding: 4px 8px;
    border-radius: 3px;
    outline: none;
    transition: border-color .15s;
  }
  .hex-input:focus { border-color: #333; color: #eee; }

  .theme-name-input {
    width: 100%;
    background: #0d0d0d;
    border: 1px solid #1a1a1a;
    color: #ccc;
    font-family: 'JetBrains Mono', monospace;
    font-size: 12px;
    padding: 8px 10px;
    border-radius: 4px;
    outline: none;
    margin-bottom: 10px;
    transition: border-color .15s;
  }
  .theme-name-input:focus { border-color: #333; }

  .import-area {
    width: 100%;
    background: #0a0a0a;
    border: 1px solid #161616;
    color: #777;
    font-family: 'JetBrains Mono', monospace;
    font-size: 9px;
    padding: 8px 10px;
    border-radius: 4px;
    outline: none;
    resize: vertical;
    min-height: 80px;
    transition: border-color .15s;
    margin-bottom: 6px;
  }
  .import-area:focus { border-color: #2a2a2a; color: #aaa; }

  .side-btn {
    background: #111;
    border: 1px solid #1e1e1e;
    color: #888;
    padding: 7px 12px;
    font-family: 'JetBrains Mono', monospace;
    font-size: 10px;
    cursor: pointer;
    border-radius: 4px;
    width: 100%;
    text-align: left;
    transition: all .13s;
    margin-bottom: 5px;
    display: flex;
    align-items: center;
    gap: 7px;
  }
  .side-btn:hover { background: #161616; color: #ccc; border-color: #2a2a2a; }
  .side-btn.export { color: #a0a0a0; }

  .output-json {
    background: #050505;
    border: 1px solid #111;
    border-radius: 4px;
    padding: 10px;
    font-size: 9px;
    color: #555;
    line-height: 1.6;
    overflow-x: auto;
    white-space: pre;
    max-height: 200px;
    overflow-y: auto;
    display: none;
  }
  .output-json.show { display: block; }
  .output-json::-webkit-scrollbar { width: 3px; height: 3px; }
  .output-json::-webkit-scrollbar-thumb { background: #222; }

  /* toast */
  .toast {
    position: fixed;
    bottom: 24px;
    right: 24px;
    background: #1a1a1a;
    border: 1px solid #2a2a2a;
    color: #ccc;
    font-family: 'JetBrains Mono', monospace;
    font-size: 11px;
    padding: 10px 18px;
    border-radius: 5px;
    z-index: 999;
    opacity: 0;
    transform: translateY(8px);
    transition: all .2s;
    pointer-events: none;
  }
  .toast.show { opacity: 1; transform: translateY(0); }

  /* collapsed group content */
  .group-content { display: none; }
  .group-content.open { display: block; }
</style>
</head>
<body>

<!-- PAGE HEADER -->
<header class="page-header">
  <div class="logo">Potassium <span>/</span> Theme Editor</div>
  <div class="actions">
    <button onclick="importJSON()">↑ Import JSON</button>
    <button onclick="resetTheme()">↺ Reset</button>
    <button class="primary" onclick="exportJSON()">↓ Export Theme</button>
  </div>
</header>

<div class="workspace">

  <!-- LEFT: category tree -->
  <div class="left-panel">
    <div class="panel-header">Theme Properties</div>
    <div id="categoryTree"></div>
  </div>

  <!-- CENTER: live preview -->
  <div class="preview-panel">
    <div class="preview-toolbar">
      <span>Live Preview</span>
      <div class="preview-scale-btns">
        <button class="active" onclick="setScale(1, this)">100%</button>
        <button onclick="setScale(.8, this)">80%</button>
        <button onclick="setScale(.6, this)">60%</button>
      </div>
    </div>
    <div class="preview-frame-wrap" id="previewWrap">
      <!-- POTASSIUM WINDOW -->
      <div class="potassium-window" id="potassiumWindow">
        <div class="k-titlebar">
          <div class="k-title">Potassium</div>
          <div class="k-icons">
            <div class="k-icon-btn">⟨/⟩</div>
            <div class="k-icon-btn">⚙</div>
            <div class="k-icon-btn">⊕</div>
            <div class="k-icon-btn">✎</div>
          </div>
          <div class="k-win-btns">
            <div class="k-win-btn close"></div>
            <div class="k-win-btn min"></div>
            <div class="k-win-btn max"></div>
          </div>
        </div>
        <div class="k-body">
          <div class="k-sidebar">
            <div class="k-sidebar-btn active">◧</div>
            <div class="k-sidebar-btn">⊞</div>
            <div class="k-sidebar-btn">🔍</div>
            <div class="k-sidebar-btn">⚙</div>
          </div>
          <div class="k-main">
            <div class="k-tabs">
              <div class="k-tab active">
                <div class="k-tab-dot"></div>
                Scoper.lua
                <span class="k-tab-close">✕</span>
              </div>
              <div class="k-tab">
                Exploit.lua
                <span class="k-tab-close">✕</span>
              </div>
              <div class="k-add-tab">+</div>
            </div>
            <div class="k-editor">
              <div class="k-line"><span class="k-linenum">1</span><span class="k-code"><span class="k-comment">-- Scoper theme test script</span></span></div>
              <div class="k-line hl"><span class="k-linenum">2</span><span class="k-code"><span class="k-kw">local</span> <span class="k-fn">Players</span> = game:<span class="k-fn">GetService</span>(<span class="k-str">"Players"</span>)</span></div>
              <div class="k-line"><span class="k-linenum">3</span><span class="k-code"><span class="k-kw">local</span> plr = Players.LocalPlayer</span></div>
              <div class="k-line"><span class="k-linenum">4</span><span class="k-code"></span></div>
              <div class="k-line"><span class="k-linenum">5</span><span class="k-code"><span class="k-kw">local function</span> <span class="k-fn">greet</span>(name)</span></div>
              <div class="k-line"><span class="k-linenum">6</span><span class="k-code">&nbsp;&nbsp;&nbsp;&nbsp;<span class="k-fn">print</span>(<span class="k-str">"Hello, "</span> .. name .. <span class="k-str">"!"</span>)</span></div>
              <div class="k-line"><span class="k-linenum">7</span><span class="k-code"><span class="k-kw">end</span></span></div>
              <div class="k-line"><span class="k-linenum">8</span><span class="k-code"></span></div>
              <div class="k-line"><span class="k-linenum">9</span><span class="k-code"><span class="k-fn">greet</span>(plr.Name)<span class="k-cursor"></span></span></div>
            </div>
            <div class="k-statusbar">
              <div class="k-btns">
                <button class="k-status-btn execute">▶ Execute</button>
                <button class="k-status-btn">⊘ Clear</button>
                <button class="k-status-btn">⊡ Open</button>
                <button class="k-status-btn">↓ Save</button>
              </div>
              <div>Ln 9, Col 14 &nbsp;·&nbsp; Lua 5.1 &nbsp;·&nbsp; 7836</div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- RIGHT: color editor -->
  <div class="right-panel" id="rightPanel">
    <div class="editor-section">
      <div class="editor-section-title">Theme Info</div>
      <input class="theme-name-input" id="themeName" type="text" value="Scoper" placeholder="Theme name..." />
      <button class="side-btn" onclick="loadPreset('dark')">⬤ Dark Preset</button>
      <button class="side-btn" onclick="loadPreset('light')">○ Light Preset</button>
      <button class="side-btn" onclick="loadPreset('red')">◆ Crimson Preset</button>
    </div>
    <div class="editor-section">
      <div class="editor-section-title">Import JSON</div>
      <textarea class="import-area" id="importArea" placeholder='Paste theme JSON here...'></textarea>
      <button class="side-btn" onclick="parseImport()">↑ Apply Import</button>
    </div>
    <div id="colorEditorPanels"></div>
    <div class="editor-section">
      <div class="editor-section-title">Export</div>
      <button class="side-btn export" onclick="exportJSON()">↓ Copy JSON to Clipboard</button>
      <button class="side-btn export" onclick="downloadJSON()">⬇ Download .json</button>
      <div class="output-json" id="outputJson"></div>
    </div>
  </div>

</div>

<div class="toast" id="toast"></div>

<script>
const themeSchema = {
  Surfaces: {
    WindowBackground: "#000000",
    PageBackground: "#000000",
    ContentBackground: "#0D0D0D",
    InputBackground: "#050505",
    TitleBarBackground: "#000000",
    CardBackground: "#0A0A0A",
    DialogBackground: "#0A0A0A",
    EditorBackground: "#0D0D0D",
    EditorLineHighlightBackground: "#111111",
    ConsoleBackground: "#050505",
    ScriptsFolderBackground: "#0A0A0A",
    ScriptsFolderSeparator: "#141414",
    SettingsCategoryBackground: "#111111",
    SearchBackground: "#121212",
    TabBackground: "#101010",
    TabActiveBackground: "#1A1A1A",
    TabHoverBackground: "#151515",
    TabInactiveBackground: "#0A0A0A",
    TabShadow: "#050505",
    CheckboxBackground: "#141414",
    ProgressBarBackground: "#141414",
    LoginOverlay: "#000000",
    LoadingOverlay: "#000000"
  },
  Text: {
    TitleText: "#FFFFFF",
    PrimaryText: "#F5F5F5",
    SecondaryText: "#CFCFCF",
    TertiaryText: "#AFAFAF",
    PlaceholderText: "#5A5A5A",
    IconTextForeground: "#B0B0B0",
    AuthorText: "#8A8A8A",
    SearchText: "#EAEAEA",
    ScriptFileText: "#D6D6D6",
    TabActiveText: "#FFFFFF",
    TabInactiveText: "#777777",
    IconDefault: "#8C8C8C",
    IconHover: "#FFFFFF",
    IconSelected: "#FFFFFF",
    IconSelectedBackground: "#1a1a1a",
    SearchIcon: "#777777",
    ScriptFileIcon: "#C0C0C0",
    AddTabButton: "#777777",
    CheckMarkStroke: "#000000",
    ComboBoxText: "#E0E0E0"
  },
  Controls: {
    ControlButtonForeground: "#FFFFFF",
    ControlButtonBackground: "#0A0A0A",
    ControlButtonHoverOverlay: "#FFFFFF",
    ButtonBackground: "#111111",
    ButtonBackgroundHover: "#1A1A1A",
    ButtonBackgroundHoverEnd: "#222222",
    ButtonForeground: "#e8f0ff",
    ButtonForegroundHover: "#9399a3",
    ButtonDisabledBackground: "#080808",
    ButtonDisabledBackgroundEnd: "#0D0D0D",
    ButtonDisabledText: "#555555",
    ButtonStyle1Background: "#161616",
    ButtonStyle1BackgroundHover: "#202020",
    ButtonStyle1BackgroundPressed: "#0F0F0F",
    ButtonStyle1DisabledBackground: "#0B0B0B",
    GeneralButtonBackground: "#1F1F1F",
    GeneralButtonForeground: "#E0E0E0",
    RoundedButtonBackground: "#111111",
    RoundedButtonHover: "#2A2A2A",
    ScrollbarTrack: "#FFFFFF",
    ScrollbarThumb: "#FFFFFF"
  },
  Borders: {
    ButtonBorder: "#2A2A2A",
    ButtonStyle1Border: "#3A3A3A",
    CardBorder: "#1E1E1E",
    DialogBorder: "#1E1E1E",
    CheckboxBorder: "#3A3A3A",
    RoundedButtonBorder: "#3A3A3A",
    SeparatorColor: "#1A1A1A",
    TabBarBorder: "#141414",
    EditorLineHighlightBorder: "#252525"
  },
  Accents: {
    AccentBlue: "#FFFFFF",
    AccentGreen: "#BFBFBF",
    NeutralGray: "#8C8C8C",
    CheckboxChecked: "#FFFFFF"
  }
};

// map schema keys → CSS vars
const cssVarMap = {
  WindowBackground: '--win-bg',
  PageBackground: '--page-bg',
  ContentBackground: '--content-bg',
  InputBackground: '--input-bg',
  TitleBarBackground: '--titlebar-bg',
  CardBackground: '--card-bg',
  EditorBackground: '--editor-bg',
  EditorLineHighlightBackground: '--editor-line-hl',
  ConsoleBackground: '--console-bg',
  TabBackground: '--tab-bg',
  TabActiveBackground: '--tab-active-bg',
  TabHoverBackground: '--tab-hover-bg',
  TabInactiveBackground: '--tab-inactive-bg',
  SearchBackground: '--search-bg',
  TitleText: '--title-text',
  PrimaryText: '--primary-text',
  SecondaryText: '--secondary-text',
  TertiaryText: '--tertiary-text',
  PlaceholderText: '--placeholder-text',
  IconTextForeground: '--icon-fg',
  SearchText: '--search-text',
  ScriptFileText: '--script-file-text',
  TabActiveText: '--tab-active-text',
  TabInactiveText: '--tab-inactive-text',
  IconDefault: '--icon-default',
  IconHover: '--icon-hover',
  AddTabButton: '--add-tab-btn',
  ControlButtonForeground: '--ctrl-btn-fg',
  ControlButtonBackground: '--ctrl-btn-bg',
  ButtonBackground: '--btn-bg',
  ButtonBackgroundHover: '--btn-bg-hover',
  ButtonForeground: '--btn-fg',
  ButtonForegroundHover: '--btn-fg-hover',
  ButtonDisabledBackground: '--btn-disabled-bg',
  ButtonDisabledText: '--btn-disabled-text',
  ScrollbarTrack: '--scrollbar-track',
  ScrollbarThumb: '--scrollbar-thumb',
  ButtonBorder: '--btn-border',
  CardBorder: '--card-border',
  SeparatorColor: '--separator',
  TabBarBorder: '--tabbar-border',
  EditorLineHighlightBorder: '--editor-line-hl-border',
  AccentBlue: '--accent-blue',
  AccentGreen: '--accent-green',
  NeutralGray: '--neutral-gray',
  CheckboxChecked: '--checkbox-checked',
};

let currentTheme = JSON.parse(JSON.stringify(themeSchema));

function toHex6(val) {
  if (!val) return '#000000';
  val = val.trim();
  // strip alpha prefix like #70000000
  if (val.startsWith('#') && val.length === 9) val = '#' + val.slice(3);
  if (val.startsWith('#') && val.length === 8) val = '#' + val.slice(3); // AARRGGBB? just take last 6
  if (!val.startsWith('#')) val = '#' + val;
  if (val.length === 4) val = '#' + val[1]+val[1]+val[2]+val[2]+val[3]+val[3];
  if (val.length < 7) return '#000000';
  return val.slice(0, 7).toUpperCase();
}

function applyThemeToCSSVars() {
  const win = document.getElementById('potassiumWindow');
  for (const [cat, entries] of Object.entries(currentTheme)) {
    for (const [key, val] of Object.entries(entries)) {
      const cssVar = cssVarMap[key];
      if (cssVar) {
        win.style.setProperty(cssVar, toHex6(val));
      }
    }
  }
}

function buildCategoryTree() {
  const tree = document.getElementById('categoryTree');
  tree.innerHTML = '';
  for (const [cat, entries] of Object.entries(themeSchema)) {
    const group = document.createElement('div');
    group.className = 'category-group';

    const label = document.createElement('div');
    label.className = 'category-label active';
    label.innerHTML = `${cat} <span class="arrow">▶</span>`;
    label.onclick = () => {
      const content = group.querySelector('.group-content');
      content.classList.toggle('open');
      label.classList.toggle('active');
    };

    const content = document.createElement('div');
    content.className = 'group-content open';

    for (const key of Object.keys(entries)) {
      const val = currentTheme[cat][key];
      const entry = document.createElement('div');
      entry.className = 'color-entry';
      entry.id = `tree-${cat}-${key}`;
      entry.innerHTML = `
        <div class="swatch" id="swatch-${cat}-${key}" style="background:${toHex6(val)}"></div>
        <div class="key-name">${key}</div>
      `;
      entry.onclick = () => scrollToEditorField(cat, key);
      content.appendChild(entry);
    }

    group.appendChild(label);
    group.appendChild(content);
    tree.appendChild(group);
  }
}

function buildColorEditorPanels() {
  const panels = document.getElementById('colorEditorPanels');
  panels.innerHTML = '';
  for (const [cat, entries] of Object.entries(themeSchema)) {
    const section = document.createElement('div');
    section.className = 'editor-section';
    section.id = `editorsec-${cat}`;
    section.innerHTML = `<div class="editor-section-title">${cat}</div>`;
    for (const [key, defaultVal] of Object.entries(entries)) {
      const val = currentTheme[cat][key] || defaultVal;
      const field = document.createElement('div');
      field.className = 'color-field';
      field.id = `field-${cat}-${key}`;
      field.innerHTML = `
        <label>${key}</label>
        <div class="color-field-wrap">
          <input type="color" id="picker-${cat}-${key}" value="${toHex6(val)}" />
          <input type="text" class="hex-input" id="hex-${cat}-${key}" value="${toHex6(val)}" maxlength="9" spellcheck="false" />
        </div>
      `;
      const picker = field.querySelector(`#picker-${cat}-${key}`);
      const hexIn = field.querySelector(`#hex-${cat}-${key}`);

      picker.addEventListener('input', () => {
        const v = picker.value;
        hexIn.value = v.toUpperCase();
        currentTheme[cat][key] = v;
        updateSwatch(cat, key, v);
        applyThemeToCSSVars();
      });
      hexIn.addEventListener('input', () => {
        let v = hexIn.value.trim();
        if (!v.startsWith('#')) v = '#' + v;
        if (/^#[0-9a-fA-F]{6}$/.test(v)) {
          picker.value = v;
          currentTheme[cat][key] = v;
          updateSwatch(cat, key, v);
          applyThemeToCSSVars();
        }
      });
      section.appendChild(field);
    }
    panels.appendChild(section);
  }
}

function updateSwatch(cat, key, val) {
  const sw = document.getElementById(`swatch-${cat}-${key}`);
  if (sw) sw.style.background = toHex6(val);
}

function scrollToEditorField(cat, key) {
  const field = document.getElementById(`field-${cat}-${key}`);
  if (field) field.scrollIntoView({ behavior: 'smooth', block: 'center' });
  // highlight
  document.querySelectorAll('.color-field').forEach(f => f.style.background = '');
  field.style.background = '#111';
  setTimeout(() => { field.style.background = ''; }, 1200);
}

function setScale(s, btn) {
  document.querySelector('#potassiumWindow').style.transform = `scale(${s})`;
  document.querySelector('#potassiumWindow').style.transformOrigin = 'top center';
  document.querySelectorAll('.preview-scale-btns button').forEach(b => b.classList.remove('active'));
  btn.classList.add('active');
}

function showToast(msg) {
  const t = document.getElementById('toast');
  t.textContent = msg;
  t.classList.add('show');
  setTimeout(() => t.classList.remove('show'), 2200);
}

function exportJSON() {
  const output = {
    Name: document.getElementById('themeName').value || 'MyTheme',
    EditorImage: "https://cdnb.artstation.com/p/assets/images/images/077/404/713/original/ivan-boyko-ornaments4-2.gif",
    Categories: currentTheme
  };
  const str = JSON.stringify(output, null, 2);
  navigator.clipboard.writeText(str).then(() => showToast('✓ JSON copied to clipboard!'));
  const el = document.getElementById('outputJson');
  el.textContent = str;
  el.classList.add('show');
}

function downloadJSON() {
  const output = {
    Name: document.getElementById('themeName').value || 'MyTheme',
    EditorImage: "https://cdnb.artstation.com/p/assets/images/images/077/404/713/original/ivan-boyko-ornaments4-2.gif",
    Categories: currentTheme
  };
  const blob = new Blob([JSON.stringify(output, null, 2)], {type: 'application/json'});
  const a = document.createElement('a');
  a.href = URL.createObjectURL(blob);
  a.download = (document.getElementById('themeName').value || 'theme') + '.json';
  a.click();
  showToast('⬇ Download started!');
}

function parseImport() {
  try {
    const raw = document.getElementById('importArea').value.trim();
    const obj = JSON.parse(raw);
    const cats = obj.Categories || obj;
    for (const [cat, entries] of Object.entries(cats)) {
      if (currentTheme[cat]) {
        for (const [key, val] of Object.entries(entries)) {
          if (key in currentTheme[cat]) currentTheme[cat][key] = val;
        }
      }
    }
    if (obj.Name) document.getElementById('themeName').value = obj.Name;
    refreshAllFields();
    applyThemeToCSSVars();
    buildCategoryTree();
    showToast('✓ Theme imported!');
  } catch(e) {
    showToast('✗ Invalid JSON');
  }
}

function importJSON() {
  document.getElementById('importArea').scrollIntoView({ behavior: 'smooth', block: 'center' });
  document.getElementById('importArea').focus();
}

function refreshAllFields() {
  for (const [cat, entries] of Object.entries(currentTheme)) {
    for (const [key, val] of Object.entries(entries)) {
      const picker = document.getElementById(`picker-${cat}-${key}`);
      const hexIn = document.getElementById(`hex-${cat}-${key}`);
      if (picker) picker.value = toHex6(val);
      if (hexIn) hexIn.value = toHex6(val);
    }
  }
}

function resetTheme() {
  currentTheme = JSON.parse(JSON.stringify(themeSchema));
  refreshAllFields();
  buildCategoryTree();
  applyThemeToCSSVars();
  showToast('↺ Reset to defaults');
}

const presets = {
  dark: { WindowBackground:'#000000', PageBackground:'#000000', EditorBackground:'#0D0D0D', TitleText:'#FFFFFF', PrimaryText:'#F5F5F5', AccentBlue:'#FFFFFF', AccentGreen:'#BFBFBF', TabActiveBackground:'#1A1A1A', ButtonBackground:'#111111' },
  light: { WindowBackground:'#F8F8F8', PageBackground:'#F0F0F0', EditorBackground:'#FAFAFA', TitleText:'#111111', PrimaryText:'#222222', AccentBlue:'#1a1aff', AccentGreen:'#1a9a1a', TabActiveBackground:'#E0E0E0', ButtonBackground:'#DDDDDD', TabBackground:'#CCCCCC', TabInactiveBackground:'#D5D5D5', SeparatorColor:'#CCCCCC', TabBarBorder:'#BBBBBB', ConsoleBackground:'#ECECEC', ButtonBorder:'#BBBBBB' },
  red: { WindowBackground:'#0a0000', PageBackground:'#0a0000', EditorBackground:'#0f0303', TitleText:'#FFFFFF', PrimaryText:'#F5F5F5', AccentBlue:'#ff3333', AccentGreen:'#ff6666', TabActiveBackground:'#1a0505', ButtonBackground:'#150303', TabBackground:'#100202', SeparatorColor:'#1f0505', TabBarBorder:'#190303', ConsoleBackground:'#070000' }
};

function loadPreset(name) {
  const p = presets[name];
  for (const [cat, entries] of Object.entries(currentTheme)) {
    for (const key of Object.keys(entries)) {
      if (p[key]) currentTheme[cat][key] = p[key];
    }
  }
  refreshAllFields();
  buildCategoryTree();
  applyThemeToCSSVars();
  showToast(`⬤ ${name.charAt(0).toUpperCase()+name.slice(1)} preset applied`);
}

// INIT
buildCategoryTree();
buildColorEditorPanels();
applyThemeToCSSVars();
</script>
</body>
</html>
