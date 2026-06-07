/**
 * functions/[[path]].js
 *
 * Cloudflare Pages catch-all function.
 * This ONE file handles every API route by:
 *   1. Checking if the URL matches a route in _cf_shim/routes.js
 *   2. Importing the matching handler from your existing api/ folder
 *   3. Running it through the adapter (fake Vercel req/res)
 *   4. Returning a real CF Response
 *
 * You never touch this file unless you add a brand new handler file.
 */

import { toOnRequest } from "../_cf_shim/adapter.js";
import { matchRoute }  from "../_cf_shim/routes.js";

// Dispatch table — maps every destination path to its module.
// Add one line here when you add a new api/ file.
const HANDLERS = {
  "/api/scoper/scoper":         () => import("../api/scoper/scoper.js"),
  "/api/scoper/cracked":        () => import("../api/scoper/cracked.js"),
  "/api/scoper/commandlibrary": () => import("../api/scoper/commandlibrary.js"),
  "/api/scoper/animlist":       () => import("../api/scoper/animlist.js"),
  "/api/scoper/nopride":        () => import("../api/scoper/nopride.js"),
  "/api/scoper/nopride2":       () => import("../api/scoper/nopride2.js"),
  "/api/scoper/adonisbypass":   () => import("../api/scoper/adonisbypass.js"),
  "/api/scoper/list":           () => import("../api/scoper/list.js"),
};

export async function onRequest(context) {
  const url      = new URL(context.request.url);
  const pathname = url.pathname;

  // Match against routes (mirrors vercel.json rewrites)
  const match = matchRoute(pathname);

  // No match — pass through to static asset serving
  if (!match) return context.next();

  const loader = HANDLERS[match.destination];
  if (!loader) {
    return new Response(`No handler registered for: ${match.destination}`, { status: 404 });
  }

  let mod;
  try {
    mod = await loader();
  } catch (err) {
    return new Response(`Failed to load handler: ${err.message}`, { status: 500 });
  }

  if (typeof mod.default !== "function") {
    return new Response(`Handler has no default export: ${match.destination}`, { status: 500 });
  }

  // Merge rewrite params into context.params
  const mergedContext = {
    ...context,
    params: { ...context.params, ...match.params },
  };

  return toOnRequest(mod.default)(mergedContext);
}
