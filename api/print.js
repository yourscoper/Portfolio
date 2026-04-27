export default function handler(req, res) {
  const accept = req.headers.accept || "";

  // If it's a browser request → redirect
  if (accept.includes("text/html")) {
    res.writeHead(302, { Location: "/" });
    return res.end();
  }

  // Otherwise → return Lua script
  res.setHeader("Content-Type", "text/plain");
  res.send(`
print("hello from lua")
  `);
}
