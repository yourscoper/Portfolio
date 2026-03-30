const express = require("express");
const cors = require("cors");
const fs = require("fs");
const path = require("path");

const app = express();
const PORT = process.env.PORT || 3000;
const DB_PATH = path.join(__dirname, "data", "executors.json");

app.use(cors());
app.use(express.json());

function loadDB() {
    if (!fs.existsSync(DB_PATH)) return [];
    return JSON.parse(fs.readFileSync(DB_PATH, "utf8"));
}

function saveDB(data) {
    fs.writeFileSync(DB_PATH, JSON.stringify(data, null, 2));
}

app.get("/api/executors", (req, res) => {
    res.json(loadDB());
});

app.post("/api/execute", (req, res) => {
    const { username } = req.body;

    if (!username) {
        return res.status(400).json({ error: "username is required" });
    }

    const db = loadDB();
    const usernameLower = username.toLowerCase();

    if (!db.includes(usernameLower)) {
        db.push(usernameLower);
        saveDB(db);
    }

    res.json({ success: true, username: usernameLower });
});

app.delete("/api/executor/:username", (req, res) => {
    const { secret } = req.body;

    if (secret !== process.env.ADMIN_SECRET) {
        return res.status(401).json({ error: "Unauthorized" });
    }

    const username = req.params.username.toLowerCase();
    const db = loadDB();
    const index = db.indexOf(username);

    if (index === -1) {
        return res.status(404).json({ error: "User not found" });
    }

    db.splice(index, 1);
    saveDB(db);

    res.json({ success: true, removed: username });
});

app.get("/api/ping", (req, res) => {
    res.json({ status: "ok", uptime: process.uptime() });
});

if (!fs.existsSync(path.join(__dirname, "data"))) {
    fs.mkdirSync(path.join(__dirname, "data"));
}

if (!fs.existsSync(DB_PATH)) saveDB([]);

app.listen(PORT, () => {
    console.log(`Running on port ${PORT}`);
});
