import fs from 'fs';
import path from 'path';

export default function handler(req, res) {
  try {
    const scriptsDir = path.join(process.cwd(), 'scripts', 'akadmin', 'scripts');

    console.log("Looking for scripts in:", scriptsDir);

    if (!fs.existsSync(scriptsDir)) {
      console.log("Directory NOT found");
      return res.status(200).json({ 
        scripts: [], 
        error: "Directory not found",
        path: scriptsDir 
      });
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
    
    res.status(200).json({ scripts: files });
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: error.message });
  }
}
