const OWNER = "yourscoper";
const REPO = "Portfolio";
const USERDATA_PATH = "userdata.json";
const COMMANDS_PATH = "pendingcommands.json";
const USERTAGS_URL = "https://yourscoper.pages.dev/scripts/bin/usertags.json";

let userdataCache = null, userdataSha = null;
let commandsCache = null, commandsSha = null;
let usertagsCache = null;
let lastUserdataWrite = 0, lastCommandsWrite = 0;
const WRITE_COOLDOWN = 30000;
const COMMANDS_COOLDOWN = 5000;

async function getUsertags() {
  if (usertagsCache) return usertagsCache;
  const res = await fetch(USERTAGS_URL);
  const data = await res.json();
  usertagsCache = data;
  setTimeout(() => { usertagsCache = null; }, 60000);
  return data;
}

async function isStaff(userId) {
  const tags = await getUsertags();
  const numId = parseInt(userId);
  for (const [tag, ids] of Object.entries(tags)) {
    if (tag === "OWNER" || tag === "ADMIN") {
      if (ids.map(Number).includes(numId)) return true;
    }
  }
  return false;
}

async function ghGet(path, token) {
  const res = await fetch(`https://api.github.com/repos/${OWNER}/${REPO}/contents/${path}`, {
    headers: { Authorization: `token ${token}`, Accept: "application/vnd.github.v3+json" }
  });
  if (res.status === 404) return null;
  return res.json();
}

async function ghPut(path, content, sha, message, token) {
  const body = { message, content: btoa(unescape(encodeURIComponent(JSON.stringify(content, null, 2)))) };
  if (sha) body.sha = sha;
  const res = await fetch(`https://api.github.com/repos/${OWNER}/${REPO}/contents/${path}`, {
    method: "PUT",
    headers: { Authorization: `token ${token}`, Accept: "application/vnd.github.v3+json", "Content-Type": "application/json" },
    body: JSON.stringify(body)
  });
  return res.json();
}

async function getUserdata(token) {
  if (userdataCache && userdataSha) return { content: userdataCache, sha: userdataSha };
  const data = await ghGet(USERDATA_PATH, token);
  if (!data) return { content: {}, sha: null };
  const content = JSON.parse(atob(data.content.replace(/\n/g, "")));
  userdataCache = content; userdataSha = data.sha;
  return { content, sha: data.sha };
}

async function getCommands(token) {
  if (commandsCache && commandsSha) return { content: commandsCache, sha: commandsSha };
  const data = await ghGet(COMMANDS_PATH, token);
  if (!data) return { content: { commands: [] }, sha: null };
  const content = JSON.parse(atob(data.content.replace(/\n/g, "")));
  commandsCache = content; commandsSha = data.sha;
  return { content, sha: data.sha };
}

async function saveCommands(content, sha, token) {
  const now = Date.now();
  if (now - lastCommandsWrite < COMMANDS_COOLDOWN) { commandsCache = content; return; }
  const result = await ghPut(COMMANDS_PATH, content, sha, "Update commands", token);
  commandsCache = content; commandsSha = result.content.sha; lastCommandsWrite = now;
}

export async function onRequest(context) {
  const { request, env } = context;
  const SECRET = env.ROBLOX_SECRET;
  const STAFF_SECRET = env.STAFF_SECRET;
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
    const clientSecret = request.headers.get("x-secret") || url.searchParams.get("secret");
    const isStaffSecret = clientSecret === STAFF_SECRET;
    const isUserSecret = clientSecret === SECRET;

    if (!clientSecret || (!isStaffSecret && !isUserSecret)) {
      return new Response(JSON.stringify({ error: "Unauthorized" }), { status: 401, headers });
    }

    if (request.method === "GET") {
      const type = url.searchParams.get("type");
      const userId = url.searchParams.get("userId");

      if (type === "users") {
        if (!isStaffSecret) return new Response(JSON.stringify({ error: "Forbidden" }), { status: 403, headers });
        const { content } = await getUserdata(GITHUB_TOKEN);
        const online = Object.entries(content)
          .filter(([, v]) => v.executed === true)
          .map(([id, v]) => ({ userId: id, tag: v.tag, jobId: v.jobId, placeId: v.placeId, updatedAt: v.updatedAt }));
        return new Response(JSON.stringify({ users: online }), { headers });
      }

      if (type === "commands") {
        if (!isUserSecret || !userId) return new Response(JSON.stringify({ error: "Forbidden" }), { status: 403, headers });
        const { content } = await getCommands(GITHUB_TOKEN);
        const mine = (content.commands || []).filter(c => c.targetId === userId || c.targetId === "ALL");
        return new Response(JSON.stringify({ commands: mine }), { headers });
      }

      return new Response(JSON.stringify({ error: "Invalid type" }), { status: 400, headers });
    }

    if (request.method === "POST") {
      const body = await request.json();

      if (isStaffSecret) {
        const { issuerId, targetId, command, params: cmdParams } = body || {};
        if (!issuerId) return new Response(JSON.stringify({ error: "Missing issuerId" }), { status: 400, headers });
        const staffCheck = await isStaff(issuerId);
        if (!staffCheck) return new Response(JSON.stringify({ error: "Forbidden: not OWNER or ADMIN" }), { status: 403, headers });

        const VALID = ["fling", "kill", "kick", "bring", "message", "broadcast"];
        if (!command || !VALID.includes(command)) return new Response(JSON.stringify({ error: "Invalid command" }), { status: 400, headers });
        if (command !== "broadcast" && !targetId) return new Response(JSON.stringify({ error: "Missing targetId" }), { status: 400, headers });

        const { content, sha } = await getCommands(GITHUB_TOKEN);
        const newCommand = {
          id: Date.now().toString(), targetId: command === "broadcast" ? "ALL" : targetId,
          issuerId, command, params: cmdParams || {}, issuedAt: new Date().toISOString()
        };
        content.commands = content.commands || [];
        content.commands.push(newCommand);
        await saveCommands(content, sha, GITHUB_TOKEN);
        return new Response(JSON.stringify({ ok: true, command: newCommand }), { headers });
      }

      return new Response(JSON.stringify({ error: "Method not allowed" }), { status: 405, headers });
    }

    if (request.method === "DELETE") {
      const body = await request.json();
      const { commandId } = body || {};
      if (!commandId) return new Response(JSON.stringify({ error: "Missing commandId" }), { status: 400, headers });

      commandsCache = null; commandsSha = null;
      const { content, sha } = await getCommands(GITHUB_TOKEN);
      const before = (content.commands || []).length;
      content.commands = (content.commands || []).filter(cmd => cmd.id !== commandId);
      const result = await ghPut(COMMANDS_PATH, content, sha, "Remove executed command", GITHUB_TOKEN);
      commandsCache = content; commandsSha = result.content.sha; lastCommandsWrite = Date.now();
      return new Response(JSON.stringify({ success: true, removed: before - content.commands.length }), { headers });
    }

    return new Response(JSON.stringify({ error: "Method not allowed" }), { status: 405, headers });
  } catch (err) {
    return new Response(JSON.stringify({ error: err.message }), { status: 500, headers });
  }
}
