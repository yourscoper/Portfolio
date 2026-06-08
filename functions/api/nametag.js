const OWNER = "yourscoper";
const REPO = "Portfolio";
const PATH = "userdata.json";

async function getFile(token) {
  const res = await fetch(`https://api.github.com/repos/${OWNER}/${REPO}/contents/${PATH}`, {
    headers: {
      Authorization: `token ${token}`,
      Accept: "application/vnd.github.v3+json",
      "Cache-Control": "no-cache",
      "User-Agent": "yourscoper-app"
    }
  });
  const text = await res.text();
  let data;
  try {
    data = JSON.parse(text);
  } catch(e) {
    throw new Error("GitHub raw response: " + text);
  }
  if (!data.content) throw new Error("No content field: " + JSON.stringify(data));
  const content = JSON.parse(atob(data.content.replace(/\n/g, "")));
  return { content, sha: data.sha };
}

async function saveFile(content, sha, token) {
  const body = {
    message: "Update userdata",
    content: btoa(unescape(encodeURIComponent(JSON.stringify(content, null, 2)))),
  };
  if (sha) body.sha = sha;
  const res = await fetch(`https://api.github.com/repos/${OWNER}/${REPO}/contents/${PATH}`, {
    method: "PUT",
    headers: {
      Authorization: `token ${token}`,
      Accept: "application/vnd.github.v3+json",
      "Content-Type": "application/json",
      "User-Agent": "yourscoper-app"
    },
    body: JSON.stringify(body)
  });
  const text = await res.text();
  try {
    return JSON.parse(text);
  } catch(e) {
    throw new Error("SaveFile raw response: " + text);
  }
}

export async function onRequest(context) {
  const { request, env } = context;
  const SECRET = env.ROBLOX_SECRET;
  const GITHUB_TOKEN = env.GITHUB_TOKEN;

  const headers = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Methods": "GET, POST, DELETE, OPTIONS",
    "Access-Control-Allow-Headers": "*",
    "Content-Type": "application/json"
  };

  if (request.method === "OPTIONS") return new Response(null, { status: 200, headers });

  try {
    const url = new URL(request.url);
    const clientSecret = request.headers.get("x-secret") || request.headers.get("X-Secret") || url.searchParams.get("secret");

    if (!clientSecret || clientSecret !== SECRET) {
      return new Response(JSON.stringify({ error: "Unauthorized" }), { status: 401, headers });
    }

    if (request.method === "GET") {
      const userId = url.searchParams.get("userId");
      const { content } = await getFile(GITHUB_TOKEN);
      if (!userId) return new Response(JSON.stringify({ nametags: content }), { headers });
      return new Response(JSON.stringify({ nametag: content[userId] || null }), { headers });
    }

    if (request.method === "POST") {
      const body = await request.json();
      const { userId, tag, executed, forceTag, jobId, placeId, updatedAt } = body || {};
      if (!userId) return new Response(JSON.stringify({ error: "Missing userId" }), { status: 400, headers });

      const { content, sha } = await getFile(GITHUB_TOKEN);
      const existing = content[userId];

      const newExecuted = executed !== undefined ? executed : (existing?.executed || false);
      const newTag = (forceTag && tag) ? tag : (existing?.tag || tag || "SCOPER USER");
      const newJobId = jobId || existing?.jobId || null;
      const newPlaceId = placeId || existing?.placeId || null;
      const newUpdatedAt = updatedAt || null;

      content[userId] = {
        tag: newTag,
        executed: newExecuted,
        updatedAt: newUpdatedAt,
        jobId: newJobId,
        placeId: newPlaceId
      };

      const saveResult = await saveFile(content, sha, GITHUB_TOKEN);

      if (saveResult.content?.sha) {
        return new Response(JSON.stringify({ ok: true }), { headers });
      } else {
        return new Response(JSON.stringify({ ok: false, error: saveResult.message || "Write failed" }), { status: 500, headers });
      }
    }

    if (request.method === "DELETE") {
      return new Response(JSON.stringify({ ok: true }), { headers });
    }

    return new Response(JSON.stringify({ error: "Method not allowed" }), { status: 405, headers });

  } catch (err) {
    return new Response(JSON.stringify({ error: err.message }), { status: 500, headers });
  }
}
