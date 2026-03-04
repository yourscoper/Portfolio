// api/verify.js
export default async function handler(req, res) {
  if (req.method === 'POST') {
    try {
      const body = req.body;  // { userId, username, placeId, jobId, version, secret }

      // Your logic: check secret, log user, check if "verified", return tag/features
      if (body.secret !== 'your-hardcoded-or-env-secret') {
        return res.status(401).json({ success: false, error: 'Invalid secret' });
      }

      // Example response for mutual detection
      const isVerified = true; // or check against a DB/array/file
      res.status(200).json({
        success: true,
        tag: isVerified ? '[DEV]' : '',
        features: isVerified ? ['rainbow', 'mutual'] : [],
        // or active users list if you store them server-side
      });
    } catch (err) {
      res.status(500).json({ success: false, error: 'Server error' });
    }
  } else if (req.method === 'GET') {
    // Optional: simple status check
    res.status(200).json({ status: 'API online' });
  } else {
    res.status(405).json({ error: 'Method not allowed' });
  }
}
