export default async function handler(req, res) {
  if (req.method === 'GET') {
    return res.status(200).json({ status: 'API online' });
  }

  if (req.method === 'POST') {
    try {
      const body = req.body;

      // Keep your secret check first (change this secret!)
      if (!body.secret || body.secret !== 'my-super-secret-akv3-8472x') {  // ← update this
        return res.status(401).json({ success: false, error: 'Invalid secret' });
      }

      // Dev check: only this exact Roblox UserId gets [DEV]
      const isDev = body.userId === 9129948947;

      // Optional: you could add more UserIds later like:
      // const isDev = [9129948947, 123456789].includes(body.userId);

      res.status(200).json({
        success: true,
        tag: isDev ? '[DEV]' : '[Script User]',  // or '' if you want no tag for normals
        features: isDev ? ['rainbow', 'mutual', 'esp'] : ['basic']  // customize as needed
      });
    } catch (err) {
      console.error(err);
      res.status(500).json({ success: false, error: 'Server error' });
    }
    return;
  }

  res.status(405).json({ error: 'Method not allowed' });
}
