import { Octokit } from "@octokit/rest";

const octokit = new Octokit({ auth: process.env.GITHUB_TOKEN });
const OWNER = "yourscoper";
const REPO  = "portfolio";
const PATH  = "userdata.json";
const SECRET = process.env.ROBLOX_SECRET;

let memoryCache = null;
const MEMORY_CACHE_TTL_MS = 15000;

async function getFile() {
  try {
    const { data } = await octokit.repos.getContent({
      owner: OWNER,
      repo: REPO,
      path: PATH,
    });
    const content = JSON.parse(Buffer.from(data.content, "base64").toString());
    return { content, sha: data.sha };
  } catch (err) {
    if (err.status === 404) return { content: {}, sha: null };
    throw err;
  }
}

async function saveFile(content, sha) {
  const params = {
    owner: OWNER,
    repo: REPO,
    path: PATH,
    message: "Update userdata",
    content: Buffer.from(JSON.stringify(content, null, 2)).toString("base64"),
  };
  if (sha) params.sha = sha;
  await octokit.repos.createOrUpdateFileContents(params);
}

export default async function handler(req, res) {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "*");

  if (req.method === "OPTIONS") return res.status(200).end();

  try {
    const clientSecret = req.headers["x-secret"] || req.headers["X-Secret"] || req.query.secret;

    if (!clientSecret || clientSecret !== SECRET) {
      res.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
      return res.status(401).json({ error: "Unauthorized", received: clientSecret || "nothing" });
    }

    const { method } = req;

    if (method === "GET") {
      const { userId } = req.query;

      if (memoryCache && Date.now() - memoryCache.timestamp < MEMORY_CACHE_TTL_MS) {
        const content = memoryCache.content;
        const responseData = !userId ? { nametags: content } : { nametag: content[userId] || null };

        res.setHeader("Cache-Control", "public, s-maxage=30, stale-while-revalidate=120");
        return res.json(responseData);
      }

      const { content, sha } = await getFile();

      memoryCache = { content, timestamp: Date.now() };

      const responseData = !userId ? { nametags: content } : { nametag: content[userId] || null };

      res.setHeader("Cache-Control", "public, s-maxage=30, stale-while-revalidate=120");
      return res.json(responseData);
    }

    if (method === "POST") {
      let body = req.body;
      if (typeof body === "string") {
        try { body = JSON.parse(body); } catch(e) {}
      }

      const { userId, displayName, tag, executed } = body || {};
      if (!userId) {
        res.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        return res.status(400).json({ error: "Missing userId" });
      }

      const { content, sha } = await getFile();

      if (content[userId]) {
        content[userId].executed = executed !== undefined ? executed : content[userId].executed;
        content[userId].updatedAt = new Date().toISOString();
      } else {
        content[userId] = {
          displayName: displayName || userId,
          tag: tag || "SCOPER USER",
          executed: executed !== undefined ? executed : false,
          updatedAt: new Date().toISOString()
        };
      }

      await saveFile(content, sha);

      res.setHeader("Cache-Control", "no-store, no-cache, must-revalidate, private");
      return res.json({ ok: true });
    }

    res.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    return res.status(405).json({ error: "Method not allowed" });

  } catch (err) {
    res.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
    return res.status(500).json({ error: err.message, stack: err.stack });
  }
}
