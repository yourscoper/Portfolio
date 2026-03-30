const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

const permanentTags = {
    "AK OWNER": ["manimboredwannaplay", "inyourscoper", "AvoidingRobloxVoice"],
    "AK ADMIN": ["", ""]
};

let activeUsers = new Set();

app.get('/tags', (req, res) => {
    res.json({
        "AK OWNER": permanentTags["AK OWNER"],
        "AK ADMIN": permanentTags["AK ADMIN"],
        "AK USER": Array.from(activeUsers)
    });
});

app.post('/register', (req, res) => {
    const { username } = req.body;
    if (username) {
        const isOwner = permanentTags["AK OWNER"].includes(username.toLowerCase());
        const isAdmin = permanentTags["AK ADMIN"].includes(username.toLowerCase());
        
        if (!isOwner && !isAdmin) {
            activeUsers.add(username.toLowerCase());
            console.log(`[+] Registered new active user: ${username}`);
        }
        res.json({ success: true, message: "Registered successfully" });
    } else {
        res.status(400).json({ success: false, message: "Username required" });
    }
});

app.get('/', (req, res) => {
    res.send('AK Admin Real-Time Tag Server is Running on Render!');
});

app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
