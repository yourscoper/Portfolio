export async function onRequest(context) {
  const { request } = context;
  const baseUrl = new URL(request.url).origin;
  const res = await fetch(`${baseUrl}/api/potassiumeditor.html`);
  if (!res.ok) return new Response("Could not load editor", { status: 500 });
  const html = await res.text();
  return new Response(html, { headers: { "Content-Type": "text/html; charset=utf-8" } });
}
