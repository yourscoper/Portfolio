import fs from "fs";
import path from "path";

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

export default function handler(req, res) {
  const accept = req.headers.accept || "";
  const userAgent = req.headers["user-agent"] || "";
  const { script } = req.query;

  if (userAgent.includes("Discordbot") || userAgent.includes("Twitterbot")) {
    const description = SCRIPT_DESCRIPTIONS[script] || "yourscoper • Script";
    res.setHeader("Content-Type", "text/html");
    return res.send(`
      <!DOCTYPE html>
      <html>
        <head>
          <meta property="og:title" content="yourscoper • Script" />
          <meta property="og:description" content="${description}" />
          <meta property="og:site_name" content="yourscoper" />
          <meta property="og:color" content="#5865F2" />
          <meta name="theme-color" content="#5865F2" />
        </head>
        <body></body>
      </html>
    `);
  }

  if (accept.includes("text/html")) {
    res.writeHead(302, { Location: "/" });
    return res.end();
  }

  if (!script) {
    return res.status(404).send("Script not found");
  }

  if (script === "list") {
    const scriptsDir = path.join(process.cwd(), "scripts", "akadmin", "scripts");
    if (!fs.existsSync(scriptsDir)) return res.status(200).json({ scripts: [] });

    const files = fs.readdirSync(scriptsDir)
      .filter(f => f.toLowerCase().endsWith(".lua"))
      .map(f => ({
        name: f.replace(/\.lua$/i, ""),
        filename: f,
        url: `https://yourscoper.vercel.app/scripts/akadmin/scripts/${f}`
      }));

    return res.status(200).json({ scripts: files });
  }

  if (!SCRIPT_MAP[script]) {
    return res.status(404).send("Script not found");
  }

  const filePath = path.join(process.cwd(), SCRIPT_MAP[script]);

  if (!fs.existsSync(filePath)) {
    return res.status(404).send("File not found");
  }

  const content = fs.readFileSync(filePath, "utf8");
  res.setHeader("Content-Type", "text/plain");
  res.send(content);
}
