/**
 * _cf_shim/adapter.js
 * Converts a Vercel-style handler into a Cloudflare Pages onRequest function.
 * Your api/ files never need to change.
 */
export function toOnRequest(vercelHandler) {
  return async function onRequest(context) {
    const { request, params, env } = context;

    const url = new URL(request.url);
    const bodyText = await request.text().catch(() => "");
    let bodyJson = null;
    try { bodyJson = JSON.parse(bodyText); } catch (_) {}

    // Merge URL search params + route params into req.query
    const query = Object.fromEntries(url.searchParams.entries());
    for (const [k, v] of Object.entries(params || {})) query[k] = v;

    const headers = {};
    for (const [k, v] of request.headers.entries()) headers[k] = v;

    // Fake Vercel req
    const req = {
      method: request.method,
      url: request.url,
      headers,
      query,
      params: params || {},
      body: bodyJson ?? bodyText,
      cookies: parseCookies(headers["cookie"] || ""),
      env,
    };

    // Polyfill process.env so handlers using process.env.VAR still work
    if (typeof process !== "undefined") {
      Object.assign(process.env, env || {});
    } else {
      globalThis.process = { env: { ...(env || {}) } };
    }

    // Fake Vercel res
    let responseBody = "";
    let responseStatus = 200;
    let responseHeaders = { "Access-Control-Allow-Origin": "*" };

    const res = {
      status(code) { responseStatus = code; return res; },
      setHeader(k, v) { responseHeaders[k] = v; return res; },
      getHeader(k) { return responseHeaders[k]; },
      removeHeader(k) { delete responseHeaders[k]; return res; },
      json(data) {
        responseHeaders["Content-Type"] = "application/json";
        responseBody = JSON.stringify(data);
      },
      send(data) {
        if (typeof data === "object" && data !== null) {
          responseHeaders["Content-Type"] = "application/json";
          responseBody = JSON.stringify(data);
        } else {
          responseBody = String(data ?? "");
          if (!responseHeaders["Content-Type"])
            responseHeaders["Content-Type"] = "text/plain; charset=utf-8";
        }
      },
      end(data) { if (data !== undefined) res.send(data); },
      redirect(statusOrUrl, url) {
        if (typeof statusOrUrl === "number") {
          responseStatus = statusOrUrl;
          responseHeaders["Location"] = url;
        } else {
          responseStatus = 302;
          responseHeaders["Location"] = statusOrUrl;
        }
      },
    };

    await vercelHandler(req, res);

    return new Response(responseBody, {
      status: responseStatus,
      headers: responseHeaders,
    });
  };
}

function parseCookies(str) {
  const out = {};
  for (const part of str.split(";")) {
    const [k, ...v] = part.trim().split("=");
    if (k) out[k.trim()] = decodeURIComponent(v.join("=").trim());
  }
  return out;
}
