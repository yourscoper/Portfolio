export default async function handler(req, res) {
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  const { key } = req.body || {};

  if (!key || typeof key !== 'string') {
    return res.status(400).json({ 
      valid: false, 
      message: 'No valid key provided' 
    });
  }

  const rawKeys = process.env.WHITELISTEDKEYS;

  if (!rawKeys) {
    console.error('WHITELISTEDKEYS env var is missing!');
    return res.status(500).json({ error: 'Server configuration error' });
  }

  const validKeys = rawKeys.split(',').map(k => k.trim().toLowerCase());
  const submittedKey = key.trim().toLowerCase();

  const isValid = validKeys.includes(submittedKey);

  res.setHeader('Content-Type', 'application/json');
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'POST');
  res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

  return res.status(200).json({
    valid: isValid,
    message: isValid ? 'Access granted' : 'Invalid or expired key'
  });
}
