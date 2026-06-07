const SCRIPT_MAP = {
  scoper:         "scripts/scoper.lua",
  cracked:        "scripts/akadmin/cracked.lua",
  commandlibrary: "scripts/akadmin/commandlibrary.lua",
  nopride:        "scripts/bin/nopride.lua",
};

const SCRIPT_DESCRIPTIONS = {
  scoper:         "yourscoper • scoper.lua",
  cracked:        "yourscoper • cracked.lua",
  commandlibrary: "yourscoper • commandlibrary.lua",
  nopride:        "yourscoper • nopride.lua",
};

const BROWSER_UAS = ["Mozilla", "Chrome", "Safari", "Firefox", "Edge", "Opera"];

export async function onRequest(context) {
  const { request, params } = context;
  const script = params.script;
  const userAgent = request.headers.get("user-agent") || "";

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

  if (BROWSER_UAS.some(b => userAgent.includes(b))) {
    return Response.redirect("/", 302);
  }

  if (!script || !SCRIPT_MAP[script]) {
    return new Response("Script not found", { status: 404 });
  }

  const baseUrl = new URL(request.url).origin;
  return fetch(`${baseUrl}/${SCRIPT_MAP[script]}`);
}
