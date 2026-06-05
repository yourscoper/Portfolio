import fs from "fs";
import path from "path";

const SCRIPT_MAP = {
  scoper:         "scripts/scoper.lua",
  cracked:        "scripts/akadmin/cracked.lua",
  commandlibrary: "scripts/akadmin/commandlibrary.lua",
  nopride:        "scripts/bin/nopride.lua",
};

export default function handler(req, res) {
  const accept = req.headers.accept || "";
  if (accept.includes("text/html")) {
    res.writeHead(302, { Location: "/" });
    return res.end();
  }

  const { script } = req.query;

  if (!script || !SCRIPT_MAP[script]) {
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
