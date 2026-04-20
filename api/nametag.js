import { Octokit } from "@octokit/rest";

const octokit = new Octokit({ auth: process.env.GITHUB_TOKEN });
const OWNER = "yourscoper";
const REPO  = "portfolio";
const PATH  = "nametags.json";
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
  try {
    if (req.headers["x-secret"] !== SECRET) {
      return res.status(401).json({ error: "Unauthorized" });
    }

    const { method } = req;

    if (method === "GET") {
      const { userId } = req.query;
      if (!userId) return res.status(400).json({ error: "Missing userId" });
      const { content } = await getFile();
      return res.json({ nametag: content[userId] || null });
    }

    if (method === "POST") {
      const { userId, displayName, tag } = req.body;
      if (!userId || !tag) return res.status(400).json({ error: "Missing fields" });
      const { content, sha } = await getFile();
      content[userId] = { displayName, tag, updatedAt: new Date().toISOString() };
      await saveFile(content, sha);
      return res.json({ ok: true });
    }

    return res.status(405).json({ error: "Method not allowed" });

  } catch (err) {
    return res.status(500).json({ error: err.message, stack: err.stack });
  }
}
