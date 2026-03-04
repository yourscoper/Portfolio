// api/verify/route.js  (for App Router style, if using Next.js project)
export async function POST(request) {
  const body = await request.json();
  // same logic as above...
  return Response.json({ success: true, tag: '[DEV]' });
}
