import fs from 'fs';
import path from 'path';

export default function handler(req, res) {
  try {
    const baseDir = process.cwd();
    const scriptsDir = path.join(baseDir, 'public', 'scripts', 'akadmin', 'scripts');

    console.log("Current working directory:", baseDir);
    console.log("Looking for scripts in:", scriptsDir);

    if (!fs.existsSync(scriptsDir)) {
      console.log("❌ Directory NOT found");
      return res.status(200).json({ 
        scripts: [], 
        error: "Directory not found",
        path: scriptsDir 
      });
    }

    const allFiles = fs.readdirSync(scriptsDir);
    console.log("All files in folder:", allFiles);

    const luaFiles = allFiles
      .filter(file => file.toLowerCase().endsWith('.lua'))
      .map(file => {
        const name = file.replace(/\.lua$/i, '');
        return {
          name: name,
          filename: file,
          url: `https://yourscoper.vercel.app/scripts/akadmin/scripts/${file}`
        };
      });

    console.log(`✅ Found ${luaFiles.length} .lua files`);

    res.status(200).json({ 
      scripts: luaFiles,
      total: luaFiles.length,
      path: scriptsDir
    });
  } catch (error) {
    console.error('Error:', error);
    res.status(500).json({ error: error.message });
  }
}
