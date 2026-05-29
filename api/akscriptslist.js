import fs from 'fs';
import path from 'path';

export default function handler(req, res) {
  try {
    const scriptsDir = path.join(process.cwd(), 'public', 'scripts', 'akadmin', 'scripts');

    console.log("Looking for scripts in:", scriptsDir);

    if (!fs.existsSync(scriptsDir)) {
      console.log("Directory not found!");
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
      });

    console.log(`Found ${files.length} scripts`);
    res.setHeader('Cache-Control', 'public, s-maxage=60');
    res.status(200).json({ scripts: files });
  } catch (error) {
    console.error('Script list error:', error);
    res.status(500).json({ error: 'Internal server error', details: error.message });
  }
}
