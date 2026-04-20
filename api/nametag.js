import { Octokit } from "@octokit/rest";

const octokit = new Octokit({ auth: process.env.GITHUB_TOKEN });
const OWNER = "yourscoper";
const REPO  = "portfolio";
const PATH  = "nametag.json";
const SECRET = process.env.ROBLOX_SECRET;

async function getFile() {
  try {
    const { data } = await octokit.repos.getContent({ owner: OWNER, repo: REPO, path: PATH });
    const content = JSON.parse(Buffer.from(data.content, "base64").toString());
    return { content, sha: data.sha };
  } catch (err) {
    if (err.status === 404) {
      return { content: {}, sha: null };
    }
    throw err;
  }
}

async function saveFile(content, sha) {
  const params = {
    owner: OWNER, repo: REPO, path: PATH,
    message: "Update nametags",
    content: Buffer.from(JSON.stringify(content, null, 2)).toString("base64"),
  };
  if (sha) params.sha = sha;
  await octokit.repos.createOrUpdateFileContents(params);
}

export default async function handler(req, res) {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "GET, POST, DELETE, OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "*");

  if (req.method === "OPTIONS") {
    return res.status(200).end();
  }

  try {
    const clientSecret = req.headers["x-secret"]
      || req.headers["X-Secret"]
      || req.query.secret;

    if (!clientSecret || clientSecret !== SECRET) {
      return res.status(401).json({ error: "Unauthorized", received: clientSecret || "nothing" });
    }

    const { method } = req;

    if (method === "GET") {
      const { userId } = req.query;
      if (!userId) return res.status(400).json({ error: "Missing userId" });
      const { content } = await getFile();
      return res.json({ nametag: content[userId] || null });
    }

    if (method === "POST") {
      let body = req.body;
      if (typeof body === "string") {
        try { body = JSON.parse(body); } catch(e) {}
      }
      const { userId, displayName, tag } = body || {};
      if (!userId || !tag) return res.status(400).json({ error: "Missing fields", got: body });
      const { content, sha } = await getFile();
      content[userId] = { displayName, tag, updatedAt: new Date().toISOString() };
      await saveFile(content, sha);
      return res.json({ ok: true });
    }

    if (method === "DELETE") {
      let body = req.body;
      if (typeof body === "string") {
        try { body = JSON.parse(body); } catch(e) {}
      }
      const { userId } = body || {};
      if (!userId) return res.status(400).json({ error: "Missing userId" });
      const { content, sha } = await getFile();
      if (content[userId]) {
        delete content[userId];
        await saveFile(content, sha);
        return res.json({ ok: true, removed: userId });
      }
      return res.json({ ok: true, removed: null });
    }

    return res.status(405).json({ error: "Method not allowed" });

  } catch (err) {
    return res.status(500).json({ error: err.message, stack: err.stack });
  }
}
