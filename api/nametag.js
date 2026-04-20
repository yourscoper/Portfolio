import { Octokit } from "@octokit/rest";

const octokit = new Octokit({ auth: process.env.GITHUB_TOKEN });

const OWNER = "yourscoper";
const REPO = "portfolio";
const PATH = "userdata.json";
const SECRET = process.env.ROBLOX_SECRET;

async function getFile() {
  try {
    const { data } = await octokit.repos.getContent({
      owner: OWNER,
      repo: REPO,
      path: PATH,
    });

    const content = JSON.parse(
      Buffer.from(data.content, "base64").toString()
    );

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
    message: "Update nametags",
    content: Buffer.from(
      JSON.stringify(content, null, 2)
    ).toString("base64"),
  };

  if (sha) params.sha = sha;

  await octokit.repos.createOrUpdateFileContents(params);
}

export default async function handler(req, res) {
  res.setHeader("Access-Control-Allow-Origin", "*");
  res.setHeader("Access-Control-Allow-Methods", "GET, POST, DELETE, OPTIONS");
  res.setHeader("Access-Control-Allow-Headers", "*");

  if (req.method === "OPTIONS") return res.status(200).end();

  try {
    const clientSecret = req.headers["x-secret"];

    if (!clientSecret || clientSecret !== SECRET) {
      return res.status(401).json({ error: "Unauthorized" });
    }

    const method = req.method;

    if (method === "GET") {
      const { userId } = req.query;
      const { content } = await getFile();

      if (!userId) return res.json({ nametags: content });

      return res.json({ nametag: content[userId] || null });
    }

    if (method === "POST") {
      let body = req.body;

      if (typeof body === "string") {
        try {
          body = JSON.parse(body);
        } catch {
          return res.status(400).json({ error: "Invalid JSON" });
        }
      }

      const { userId, displayName, tag } = body || {};

      if (!userId || !displayName || !tag) {
        return res.status(400).json({ error: "Missing fields" });
      }

      const { content, sha } = await getFile();

      content[userId] = {
        displayName,
        tag,
        updatedAt: new Date().toISOString(),
      };

      await saveFile(content, sha);

      return res.json({ ok: true });
    }

    if (method === "DELETE") {
      let body = req.body;

      if (typeof body === "string") {
        try {
          body = JSON.parse(body);
        } catch {
          return res.status(400).json({ error: "Invalid JSON" });
        }
      }

      const { userId } = body || {};

      if (!userId) {
        return res.status(400).json({ error: "Missing userId" });
      }

      const { content, sha } = await getFile();

      if (!content[userId]) {
        return res.json({ ok: true, removed: null });
      }

      delete content[userId];

      await saveFile(content, sha);

      return res.json({ ok: true, removed: userId });
    }

    return res.status(405).json({ error: "Method not allowed" });
  } catch (err) {
    return res.status(500).json({ error: err.message });
  }
}
