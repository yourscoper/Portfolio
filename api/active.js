import { kv } from '@vercel/kv';

export default async function handler(req, res) {
  res.setHeader('Content-Type', 'application/json'); // force JSON header

  if (req.method !== 'GET') {
    return res.status(405).json({ success: false, error: 'Method not allowed' });
  }

  const jobId = req.query.jobId;

  if (!jobId) {
    return res.status(400).json({ success: false, error: 'Missing jobId query param' });
  }

  try {
    const key = `active:${jobId}`;
    const active = (await kv.get(key)) || [];

    const list = active.map(e => ({
      userId: e.userId,
      username: e.username || 'unknown'
    }));

    res.status(200).json({ success: true, active: list });
  } catch (err) {
    console.error('Active endpoint error:', err);
    res.status(500).json({ success: false, error: 'Server error - check logs' });
  }
}
