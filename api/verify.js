import { kv } from '@vercel/kv';

export default async function handler(req, res) {
  if (req.method === 'POST') {
    try {
      const body = req.body;

      if (!body.secret || body.secret !== 'my-super-secret-akv3-8472x') {
        return res.status(401).json({ success: false, error: 'Invalid secret' });
      }

      const userId = body.userId;
      const jobId = body.jobId;
      const username = body.username || 'unknown';
      const timestamp = Date.now();

      const isDev = userId === 9129948947;

      // Store ping: key = "active:<jobId>", value = list of {userId, username, ts}
      const key = `active:${jobId}`;
      const entry = { userId, username, ts: timestamp };

      // Get current list or []
      let active = (await kv.get(key)) || [];

      // Add/update this user (avoid dupes)
      active = active.filter(e => e.userId !== userId);
      active.push(entry);

      // Clean old entries (> 10 min)
      active = active.filter(e => timestamp - e.ts < 600000); // 10 min

      // Save back (expire whole key after 15 min to auto-cleanup)
      await kv.set(key, active, { ex: 900 }); // 15 min TTL

      // Return response
      res.status(200).json({
        success: true,
        tag: isDev ? '[DEV]' : '[Script User]',
        features: isDev ? ['rainbow', 'mutual'] : ['basic']
      });
    } catch (err) {
      console.error(err);
      res.status(500).json({ success: false, error: 'Server error' });
    }
    return;
  }

  // ... keep your GET if any
  res.status(405).json({ error: 'Method not allowed' });
}
