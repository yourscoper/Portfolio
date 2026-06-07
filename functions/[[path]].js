import { toOnRequest } from "../_cf_shim/adapter.js";
import { matchRoute }  from "../_cf_shim/routes.js";

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

  const match = matchRoute(pathname);

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

  const mergedContext = {
    ...context,
    params: { ...context.params, ...match.params },
  };

  return toOnRequest(mod.default)(mergedContext);
}
