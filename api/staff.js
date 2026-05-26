import { Octokit } from "@octokit/rest";

const octokit = new Octokit({ auth: process.env.GITHUB_TOKEN });
const OWNER = "yourscoper";
const REPO = "Portfolio";
const USERDATA_PATH = "userdata.json";
const COMMANDS_PATH = "pendingcommands.json";
const SECRET = process.env.ROBLOX_SECRET;
const STAFF_SECRET = process.env.STAFF_SECRET;
const USERTAGS_URL = "https://yourscoper.vercel.app/scripts/bin/usertags.json";

let userdataCache = null;
let userdataSha = null;
let commandsCache = null;
let commandsSha = null;
let usertagsCache = null;
let lastUserdataWrite = 0;
let lastCommandsWrite = 0;
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

async function getUserdata() {
    if (userdataCache && userdataSha) return { content: userdataCache, sha: userdataSha };
    try {
        const { data } = await octokit.repos.getContent({ owner: OWNER, repo: REPO, path: USERDATA_PATH });
        const content = JSON.parse(Buffer.from(data.content, "base64").toString());
        userdataCache = content;
        userdataSha = data.sha;
        return { content, sha: data.sha };
    } catch (err) {
        if (err.status === 404) return { content: {}, sha: null };
        throw err;
    }
}

async function getCommands() {
    if (commandsCache && commandsSha) return { content: commandsCache, sha: commandsSha };
    try {
        const { data } = await octokit.repos.getContent({ owner: OWNER, repo: REPO, path: COMMANDS_PATH });
        const content = JSON.parse(Buffer.from(data.content, "base64").toString());
        commandsCache = content;
        commandsSha = data.sha;
        return { content, sha: data.sha };
    } catch (err) {
        if (err.status === 404) return { content: { commands: [] }, sha: null };
        throw err;
    }
}

async function saveCommands(content, sha) {
    const now = Date.now();
    if (now - lastCommandsWrite < COMMANDS_COOLDOWN) {
        commandsCache = content;
        return;
    }
    const params = {
        owner: OWNER, repo: REPO, path: COMMANDS_PATH,
        message: "Update commands",
        content: Buffer.from(JSON.stringify(content, null, 2)).toString("base64"),
    };
    if (sha) params.sha = sha;
    const result = await octokit.repos.createOrUpdateFileContents(params);
    commandsCache = content;
    commandsSha = result.data.content.sha;
    lastCommandsWrite = now;
}

export default async function handler(req, res) {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Methods", "GET, POST, DELETE, OPTIONS");
    res.setHeader("Access-Control-Allow-Headers", "*");

    if (req.method === "OPTIONS") return res.status(200).end();

    try {
        const clientSecret = req.headers["x-secret"] || req.headers["X-Secret"] || req.query.secret;
        const isStaffSecret = clientSecret === STAFF_SECRET;
        const isUserSecret = clientSecret === SECRET;

        if (!clientSecret || (!isStaffSecret && !isUserSecret)) {
            return res.status(401).json({ error: "Unauthorized" });
        }

        const { method } = req;

        if (method === "GET") {
            const { type, userId } = req.query;

            if (type === "users") {
                if (!isStaffSecret) return res.status(403).json({ error: "Forbidden" });
                const { content } = await getUserdata();
                const online = Object.entries(content)
                    .filter(([, v]) => v.executed === true)
                    .map(([id, v]) => ({
                        userId: id,
                        tag: v.tag,
                        jobId: v.jobId,
                        placeId: v.placeId,
                        updatedAt: v.updatedAt
                    }));
                return res.json({ users: online });
            }

            if (type === "commands") {
                if (!isUserSecret || !userId) return res.status(403).json({ error: "Forbidden" });
                const { content } = await getCommands();
                const mine = (content.commands || []).filter(c => c.targetId === userId || c.targetId === "ALL");
                return res.json({ commands: mine });
            }

            return res.status(400).json({ error: "Invalid type" });
        }

        if (method === "POST") {
            let body = req.body;
            if (typeof body === "string") { try { body = JSON.parse(body); } catch(e) {} }

            if (isStaffSecret) {
                const { issuerId, targetId, command, params: cmdParams } = body || {};

                if (!issuerId) return res.status(400).json({ error: "Missing issuerId" });

                const staffCheck = await isStaff(issuerId);
                if (!staffCheck) return res.status(403).json({ error: "Forbidden: not OWNER or ADMIN" });

                const VALID = ["fling", "kill", "kick", "bring", "message", "broadcast"];
                if (!command || !VALID.includes(command)) {
                    return res.status(400).json({ error: "Invalid or missing command" });
                }
                if (command !== "broadcast" && !targetId) {
                    return res.status(400).json({ error: "Missing targetId" });
                }

                const { content, sha } = await getCommands();
                const newCommand = {
                    id: Date.now().toString(),
                    targetId: command === "broadcast" ? "ALL" : targetId,
                    issuerId,
                    command,
                    params: cmdParams || {},
                    issuedAt: new Date().toISOString()
                };
                content.commands = content.commands || [];
                content.commands.push(newCommand);
                await saveCommands(content, sha);
                return res.json({ ok: true, command: newCommand });
            }

            return res.status(405).json({ error: "Method not allowed" });
        }

        if (method === "DELETE") {
            let body = req.body;
            if (typeof body === "string") { try { body = JSON.parse(body); } catch(e) {} }
        
            const { commandId, userId } = body || {};
        
            if (!commandId) {
                return res.status(400).json({ error: "Missing commandId" });
            }
        
            commandsCache = null;
            commandsSha = null;
        
            const { content, sha } = await getCommands();
        
            const before = (content.commands || []).length;
        
            content.commands = (content.commands || []).filter(cmd => cmd.id !== commandId);
        
            const after = content.commands.length;
        
            lastCommandsWrite = 0;
            await saveCommands(content, sha);
        
            commandsCache = null;
            commandsSha = null;
        
            return res.status(200).json({ success: true, removed: before - after });
        }

        return res.status(405).json({ error: "Method not allowed" });

    } catch (err) {
        return res.status(500).json({ error: err.message });
    }
}
