export default async function handler(req, res) {
  try {
    const response = await fetch(
      "https://raw.githubusercontent.com/yourscoper/Portfolio/refs/heads/main/acdata/keys.json"
    );

    const data = await response.json();
    const keys = data.keys;

    const startDate = new Date("2026-04-06T00:00:00Z");
    const now = new Date();

    const diffTime = now - startDate;
    const daysPassed = Math.floor(diffTime / (1000 * 60 * 60 * 24));

    const index = Math.floor(daysPassed / 2) % keys.length;

    const selectedKey = keys[index];

    res.setHeader("Content-Type", "text/plain");
    res.status(200).send(selectedKey);

  } catch (err) {
    res.status(500).send("Error fetching keys");
  }
}
