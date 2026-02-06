export default function handler(req, res) {
  if (req.method !== 'POST' && req.method !== 'GET') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const auth = req.headers.authorization;
  if (auth !== `Bearer ${process.env.API_SECRET_TOKEN || 'default-secret-change-me'}`) {
    return res.status(401).json({ error: 'Unauthorized' });
  }

  const rawKeys = process.env.WHITELISTEDKEYS;

  if (!rawKeys) {
    console.error('WHITELISTEDKEYS env var is missing!');
    return res.status(500).json({ error: 'Server configuration error' });
  }

  const validKeys = rawKeys.split(',').map(key => key.trim());

  if (req.method === 'GET') {
    return res.status(200).json({ keys: validKeys });
  }

  const { key, hwid, discord } = req.body || {};

  if (!key) {
    return res.status(400).json({ valid: false, message: 'No key provided' });
  }

  const isValid = validKeys.includes(key.trim());

  res.status(200).json({
    valid: isValid,
    message: isValid ? 'Access granted' : 'Invalid key'
  });
}
