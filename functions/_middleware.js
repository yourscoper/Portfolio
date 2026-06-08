const GITHUB_BASE = "https://raw.githubusercontent.com/yourscoper/Portfolio/main";

const SCRIPT_MAP = {
  "scoper.lua":         "scripts/scoper.lua",
  "cracked.lua":        "scripts/akadmin/cracked.lua",
  "commandlibrary.lua": "scripts/akadmin/commandlibrary.lua",
  "animlist.lua":       "scripts/akadmin/animlist.lua",
  "nopride.lua":        "scripts/bin/nopride.lua",
  "nopride2.lua":       "scripts/bin/nopride2.lua",
  "adonisbypass.lua":   "scripts/bin/adonisbypass.lua",
};

const SCRIPT_DESCRIPTIONS = {
  "scoper.lua":         "yourscoper • scoper.lua",
  "cracked.lua":        "yourscoper • cracked.lua",
  "commandlibrary.lua": "yourscoper • commandlibrary.lua",
  "animlist.lua":       "yourscoper • animlist.lua",
  "nopride.lua":        "yourscoper • nopride.lua",
  "nopride2.lua":       "yourscoper • nopride2.lua",
  "adonisbypass.lua":   "yourscoper • adonisbypass.lua",
};

const ROBLOX_UAS = ["Roblox", "RobloxStudio", "HttpGet"];

export async function onRequest(context) {
  const { request } = context;
  const url = new URL(request.url);
  const pathKey = url.pathname.replace(/^\//, "");
  const userAgent = request.headers.get("user-agent") || "";
  const acceptHeader = request.headers.get("accept") || "";

  if (!SCRIPT_MAP[pathKey]) return context.next();

  if (userAgent.includes("Discordbot") || userAgent.includes("Twitterbot")) {
    const description = SCRIPT_DESCRIPTIONS[pathKey] || "yourscoper • Script";
    return new Response(`<!DOCTYPE html><html><head>
<meta property="og:title" content="yourscoper • Script" />
<meta property="og:description" content="${description}" />
<meta property="og:site_name" content="yourscoper" />
<meta name="theme-color" content="#5865F2" />
</head><body></body></html>`, { headers: { "Content-Type": "text/html" } });
  }

  const isRoblox = ROBLOX_UAS.some(r => userAgent.includes(r)) || userAgent === "";
  const isBrowser = acceptHeader.includes("text/html");

  if (!isRoblox || isBrowser) return Response.redirect("https://yourscoper.pages.dev", 302);

  const res = await fetch(`${GITHUB_BASE}/${SCRIPT_MAP[pathKey]}`);
  if (!res.ok) return new Response("Script not found", { status: 404 });
  return new Response(await res.text(), { headers: { "Content-Type": "text/plain" } });
}
