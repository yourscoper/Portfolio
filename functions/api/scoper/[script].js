const SCRIPT_MAP = {
  scoper:         "_lua/scoper.lua",
  cracked:        "_lua/akadmin/cracked.lua",
  commandlibrary: "_lua/akadmin/commandlibrary.lua",
  animlist:       "_lua/akadmin/animlist.lua",
  nopride:        "_lua/bin/nopride.lua",
  nopride2:       "_lua/bin/nopride2.lua",
  adonisbypass:   "_lua/bin/adonisbypass.lua",
  list:           "_lua/list.json",
};

const SCRIPT_DESCRIPTIONS = {
  scoper:         "yourscoper • scoper.lua",
  cracked:        "yourscoper • cracked.lua",
  commandlibrary: "yourscoper • commandlibrary.lua",
  nopride:        "yourscoper • nopride.lua",
};

const ROBLOX_UAS = ["Roblox", "RobloxStudio", "HttpGet"];

export async function onRequest(context) {
  const { request, params } = context;
  const script = params.script;
  const userAgent = request.headers.get("user-agent") || "";
  const referer = request.headers.get("referer") || "";
  const acceptHeader = request.headers.get("accept") || "";

  if (userAgent.includes("Discordbot") || userAgent.includes("Twitterbot")) {
    const description = SCRIPT_DESCRIPTIONS[script] || "yourscoper • Script";
    return new Response(`<!DOCTYPE html>
<html><head>
<meta property="og:title" content="yourscoper • Script" />
<meta property="og:description" content="${description}" />
<meta property="og:site_name" content="yourscoper" />
<meta property="og:color" content="#5865F2" />
<meta name="theme-color" content="#5865F2" />
</head><body></body></html>`, {
      headers: { "Content-Type": "text/html" }
    });
  }

  const isRoblox = ROBLOX_UAS.some(r => userAgent.includes(r)) || userAgent === "";
  const isBrowser = acceptHeader.includes("text/html");

  if (!isRoblox || isBrowser) {
    return Response.redirect("https://yourscoper.pages.dev", 302);
  }

  if (!script || !SCRIPT_MAP[script]) {
    return new Response("Script not found", { status: 404 });
  }

  const baseUrl = new URL(request.url).origin;
  return fetch(`${baseUrl}/${SCRIPT_MAP[script]}`);
}
