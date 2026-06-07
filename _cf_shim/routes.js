/**
 * _cf_shim/routes.js
 *
 * This is a copy of your vercel.json "rewrites" array.
 * It's the ONLY file you need to update if you add new routes.
 * Just keep it in sync with your vercel.json.
 */
export const routes = [
  { source: "/scoper.lua",           destination: "/api/scoper/scoper"         },
  { source: "/cracked.lua",          destination: "/api/scoper/cracked"        },
  { source: "/commandlibrary.lua",   destination: "/api/scoper/commandlibrary" },
  { source: "/animlist.lua",         destination: "/api/scoper/animlist"       },
  { source: "/nopride.lua",          destination: "/api/scoper/nopride"        },
  { source: "/nopride2.lua",         destination: "/api/scoper/nopride2"       },
  { source: "/adonisbypass.lua",     destination: "/api/scoper/adonisbypass"   },
  { source: "/scripts/list.json",    destination: "/api/scoper/list"           },
];

export function matchRoute(pathname) {
  for (const rule of routes) {
    const params = matchPattern(rule.source, pathname);
    if (params !== null) {
      let dest = rule.destination;
      for (const [k, v] of Object.entries(params))
        dest = dest.replace(`:${k}`, v);
      return { destination: dest, params };
    }
  }
  return null;
}

function matchPattern(pattern, pathname) {
  const names = [];
  const rx = pattern
    .replace(/[-[\]{}()+?.,\\^$|#\s]/g, "\\$&")
    .replace(/\\\*/g, "(.*)")
    .replace(/:([a-zA-Z_]\w*)/g, (_, n) => { names.push(n); return "([^/]+)"; });
  const m = pathname.match(new RegExp(`^${rx}$`));
  if (!m) return null;
  const out = {};
  names.forEach((n, i) => { out[n] = m[i + 1]; });
  return out;
}
