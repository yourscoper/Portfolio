const whitelistData = {
  "whitelist": {
    "f0a9890c96a38a70555322fad30a7582071c953dc3f4f8a93f5c05377e8d3daf7e3feac042caada1e5595b91c54e86d1378ef2ece37598278298d90eaaacff44": {
      "discord": "765706304656113664",
      "key": "scoper-QwUWUeXQHM3Y4p1sO7fmFqQADmLI1e"
    },
    "e468867bb1f1e32befd01431089dd5621dcc69a14e3bc2a404ac0866fff23402": {
      "discord": "1312924157578711071",
      "key": "scoper-pd8bDG1TgZKTH2svNH3VAogwb9ZKRK"
    },
    "34e9c95c-0b0d-11f1-b000-806e6f6e6963": {
      "discord": "1439964270434717826",
      "key": "scoper-PoV3hnlsy8uzKTwYLkMkkyIaAiXNYv"
    },
    "295b846a-b8ca-11f0-92f3-806e6f6e6963": {
      "discord": "1140785097684037745",
      "key": "scoper-ruS3MHWL6VDklQNR2q1CUX3U01SY8Z"
    }
  },

  "shared": {
    "status": true,
    "key": "scoper-limited20127889ef1zq19lZkKEIJCXJI"
  }
};

export default function handler(req, res) {
  if (req.method !== 'GET') {
    return res.status(405).json({ error: 'Method Not Allowed' });
  }

  res.setHeader('Content-Type', 'application/json');
  res.status(200).send(JSON.stringify(whitelistData, null, 2));
}
