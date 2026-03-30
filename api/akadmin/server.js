const express = require("express");
const cors = require("cors");
const fs = require("fs");
const path = require("path");

const app = express();
const PORT = process.env.PORT || 3000;
const DB_PATH = path.join(__dirname, "data", "users.json");
const TAGS_PATH = path.join(__dirname, "data", "tags.json");

app.use(cors());
app.use(express.json());

function loadDB() {
    if (!fs.existsSync(DB_PATH)) return {};
    return JSON.parse(fs.readFileSync(DB_PATH, "utf8"));
}

function saveDB(data) {
    fs.writeFileSync(DB_PATH, JSON.stringify(data, null, 2));
}

function loadTags() {
    if (!fs.existsSync(TAGS_PATH)) return {};
    return JSON.parse(fs.readFileSync(TAGS_PATH, "utf8"));
}

app.get("/api/tags", (req, res) => {
    const tags = loadTags();
    res.json(tags);
});

app.get("/api/users", (req, res) => {
    const db = loadDB();
    res.json(db);
});

app.get("/api/user/:username", (req, res) => {
    const username = req.params.username.toLowerCase();
    const db = loadDB();
    const tags = loadTags();

    const tagName = db[username];
    if (!tagName) {
        return res.status(404).json({ error: "User not found", username });
    }

    const tagData = tags[tagName];
    if (!tagData) {
        return res.status(404).json({ error: "Tag config not found", tagName });
    }

    res.json({
        username,
        tagName,
        tagData
    });
});

app.get("/api/combined", (req, res) => {
    const db = loadDB();
    const tags = loadTags();
    const result = {};

    for (const [username, tagName] of Object.entries(db)) {
        const tagData = tags[tagName];
        if (tagData) {
            result[username] = {
                tagName,
                ...tagData
            };
        }
    }

    res.json(result);
});

app.get("/api/Tags.json", (req, res) => {
    const db = loadDB();
    const result = {};

    for (const [username, tagName] of Object.entries(db)) {
        if (!result[tagName]) result[tagName] = [];
        result[tagName].push(username);
    }

    res.json(result);
});

app.post("/api/register", (req, res) => {
    const { username, tagName, secret } = req.body;

    if (!username || !tagName) {
        return res.status(400).json({ error: "username and tagName are required" });
    }

    if (secret !== process.env.ADMIN_SECRET) {
        return res.status(401).json({ error: "Unauthorized" });
    }

    const tags = loadTags();
    if (!tags[tagName]) {
        return res.status(400).json({ error: "Tag does not exist", tagName });
    }

    const db = loadDB();
    db[username.toLowerCase()] = tagName;
    saveDB(db);

    res.json({ success: true, username: username.toLowerCase(), tagName });
});

app.delete("/api/user/:username", (req, res) => {
    const { secret } = req.body;

    if (secret !== process.env.ADMIN_SECRET) {
        return res.status(401).json({ error: "Unauthorized" });
    }

    const username = req.params.username.toLowerCase();
    const db = loadDB();

    if (!db[username]) {
        return res.status(404).json({ error: "User not found" });
    }

    delete db[username];
    saveDB(db);

    res.json({ success: true, removed: username });
});

app.post("/api/tag", (req, res) => {
    const { tagName, tagData, secret } = req.body;

    if (!tagName || !tagData) {
        return res.status(400).json({ error: "tagName and tagData are required" });
    }

    if (secret !== process.env.ADMIN_SECRET) {
        return res.status(401).json({ error: "Unauthorized" });
    }

    const tags = loadTags();
    tags[tagName] = tagData;
    fs.writeFileSync(TAGS_PATH, JSON.stringify(tags, null, 2));

    res.json({ success: true, tagName, tagData });
});

app.delete("/api/tag/:tagName", (req, res) => {
    const { secret } = req.body;

    if (secret !== process.env.ADMIN_SECRET) {
        return res.status(401).json({ error: "Unauthorized" });
    }

    const tagName = req.params.tagName;
    const tags = loadTags();

    if (!tags[tagName]) {
        return res.status(404).json({ error: "Tag not found" });
    }

    delete tags[tagName];
    fs.writeFileSync(TAGS_PATH, JSON.stringify(tags, null, 2));

    res.json({ success: true, removed: tagName });
});

app.get("/api/ping", (req, res) => {
    res.json({ status: "ok", uptime: process.uptime() });
});

if (!fs.existsSync(path.join(__dirname, "data"))) {
    fs.mkdirSync(path.join(__dirname, "data"));
}

if (!fs.existsSync(DB_PATH)) saveDB({});
if (!fs.existsSync(TAGS_PATH)) fs.writeFileSync(TAGS_PATH, JSON.stringify({}, null, 2));

app.listen(PORT, () => {
    console.log(`AK Admin API running on port ${PORT}`);
});
