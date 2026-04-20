import { Octokit } from "@octokit/rest";

const octokit = new Octokit({ auth: process.env.GITHUB_TOKEN });
const OWNER = "YOUR_GITHUB_USERNAME";
const REPO  = "roblox-nametags";
const PATH  = "nametags.json";
const SECRET = process.env.ROBLOX_SECRET; // a password your script sends

async function getFile() {
  const { data } = await octokit.repos.getContent({ owner: OWNER, repo: REPO, path: PATH });
  const content = JSON.parse(Buffer.from(data.content, "base64").toString());
  return { content, sha: data.sha };
}

async function saveFile(content, sha) {
  await octokit.repos.createOrUpdateFileContents({
    owner: OWNER, repo: REPO, path: PATH,
    message: "Update nametags",
    content: Buffer.from(JSON.stringify(content, null, 2)).toString("base64"),
    sha,
  });
}

export default async function handler(req, res) {
  // Validate secret
  if (req.headers["x-secret"] !== Secret) {
    return res.status(401).json({ error: "Unauthorized" });
  }

  const { method } = req;

  // GET /api/nametag?userId=123  → fetch one user's tag
  if (method === "GET") {
    const { userId } = req.query;
    const { content } = await getFile();
    return res.json({ nametag: content[userId] || null });
  }

  // POST /api/nametag  { userId, displayName, tag }  → upsert
  if (method === "POST") {
    const { userId, displayName, tag } = req.body;
    const { content, sha } = await getFile();
    content[userId] = { displayName, tag, updatedAt: new Date().toISOString() };
    await saveFile(content, sha);
    return res.json({ ok: true });
  }

  res.status(405).json({ error: "Method not allowed" });
}
