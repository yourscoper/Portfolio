import fs from 'fs';
import path from 'path';

export default function handler(req, res) {
  try {
    const scriptsDir = path.join(process.cwd(), 'public', 'scripts');
    
    if (!fs.existsSync(scriptsDir)) {
      return res.status(200).json({ scripts: [] });
    }

    const files = fs.readdirSync(scriptsDir)
      .filter(file => file.endsWith('.lua'))
      .map(file => {
        const nameWithoutExt = file.replace(/\.lua$/, '');
        return {
          name: nameWithoutExt,
          filename: file,
          url: `https://yourscoper.vercel.app/scripts/${file}`
        };
      })
      .sort((a, b) => a.name.localeCompare(b.name));

    res.status(200).json({ scripts: files });
  } catch (error) {
    console.error('Error listing scripts:', error);
    res.status(500).json({ error: 'Failed to list scripts' });
  }
}
