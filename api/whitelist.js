const whitelistData = {
  "whitelist": {
    "product": {
      "discord": "765706304656113664",
      "key": "5wn1Ger8HaWutECX9BLwQtLl1i1h1I",
      "hwid": "f0a9890c96a38a70555322fad30a7582071c953dc3f4f8a93f5c05377e8d3daf7e3feac042caada1e5595b91c54e86d1378ef2ece37598278298d90eaaacff44"
    }
  }
};

export default function handler(req, res) {
  if (req.method !== 'GET') {
    return res.status(405).json({ error: 'Method Not Allowed' });
  }
  res.setHeader('Content-Type', 'application/json');
  res.status(200).json(whitelistData);
}
