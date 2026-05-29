import fs from 'fs';
import path from 'path';

export default function handler(req, res) {
  try {
    const scriptsDir = path.join(process.cwd(), 'public', 'scripts', 'akadmin', 'scripts');

    if (!fs.existsSync(scriptsDir)) {
      return res.status(200).json({ scripts: [] });
    }

    const files = fs.readdirSync(scriptsDir)
      .filter(file => file.toLowerCase().endsWith('.lua'))
      .map(file => {
        const name = file.replace(/\.lua$/i, '');
        return {
          name: name,
          filename: file,
          url: `https://yourscoper.vercel.app/scripts/akadmin/scripts/${file}`
        };
      })
      .sort((a, b) => a.name.localeCompare(b.name));

    res.setHeader('Cache-Control', 'public, s-maxage=60, stale-while-revalidate=300');
    res.status(200).json({ scripts: files });
  } catch (error) {
    console.error('Script list error:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
}
