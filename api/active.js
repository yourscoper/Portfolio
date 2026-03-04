import { kv } from '@vercel/kv';

export default async function handler(req, res) {
  if (req.method !== 'GET') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const jobId = req.query.jobId;

  if (!jobId) {
    return res.status(400).json({ error: 'Missing jobId' });
  }

  const key = `active:${jobId}`;
  const active = (await kv.get(key)) || [];

  // Return simplified list (only UserIds + usernames for your script to use)
  const list = active.map(e => ({
    userId: e.userId,
    username: e.username
  }));

  res.status(200).json({ success: true, active: list });
}
