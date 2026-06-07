export async function onRequest(context) {
  const request = context.request;
  const ua = request.headers.get("user-agent") || "";

  let device = "Unknown";
  const secPlatform = request.headers.get("sec-ch-ua-platform") || "";
  if (/windows/i.test(ua) || /"Windows"/i.test(secPlatform)) device = "Windows";
  else if (/macintosh|mac os/i.test(ua) || /"macOS"/i.test(secPlatform)) device = "macOS";
  else if (/iphone|ipad|ipod/i.test(ua)) device = "iOS";
  else if (/android/i.test(ua)) device = "Android";

  function getFlagEmoji(countryCode) {
    if (!countryCode || countryCode.length !== 2 || !/^[A-Za-z]{2}$/.test(countryCode)) return "🏳️";
    const codePoints = countryCode.toUpperCase().split("").map(c => 127397 + c.charCodeAt(0));
    return String.fromCodePoint(...codePoints);
  }

  const continentMap = {
    NA:"North America",SA:"South America",EU:"Europe",AS:"Asia",AF:"Africa",OC:"Oceania",AT:"Australia"
  };

  const ip = request.headers.get("cf-connecting-ip") || request.headers.get("x-real-ip") || "";

  let location = {
    ip,
    city: "",
    region: "",
    postal: "",
    countryCode: "",
    countryName: "",
    country: "🏳️",
    continent: "",
    latitude: "",
    longitude: ""
  };

  try {
    const geoRes = await fetch(`http://ip-api.com/json/${ip}?fields=status,country,countryCode,region,regionName,city,zip,lat,lon,continent,continentCode`);
    const geo = await geoRes.json();
    if (geo.status === "success") {
      location = {
        ip,
        city: geo.city || "",
        region: geo.regionName || "",
        postal: geo.zip || "",
        countryCode: geo.countryCode || "",
        countryName: geo.country || "",
        country: geo.countryCode ? getFlagEmoji(geo.countryCode) : "🏳️",
        continent: continentMap[geo.continentCode] || geo.continent || "",
        latitude: geo.lat ? String(geo.lat) : "",
        longitude: geo.lon ? String(geo.lon) : ""
      };
    }
  } catch (_) {}

  const url = new URL(request.url);
  const args = {};
  for (const [k, v] of url.searchParams) args[k] = v;

  const outputHeaders = {
    Accept: request.headers.get("accept") || "",
    "Accept-Encoding": request.headers.get("accept-encoding") || "",
    "Accept-Language": request.headers.get("accept-language") || "",
    Host: request.headers.get("host") || "",
    Device: device,
    "User-Agent": ua,
    "X-Amzn-Trace-Id": request.headers.get("x-amzn-trace-id") || "not present"
  };

  for (const [key, value] of request.headers.entries()) {
    const lower = key.toLowerCase();
    if (lower.startsWith("cf-") || lower.startsWith("roblox-session-id")) continue;
    if (lower.startsWith("x-real-ip") || lower.startsWith("x-forwarded")) continue;
    if (
      lower === "cache-control" ||
      lower === "forwarded" ||
      lower === "priority" ||
      lower === "upgrade-insecure-requests" ||
      lower === "x-invocation-id" ||
      lower.startsWith("sec-")
    ) continue;
    const normalizedKey = key.split("-").map(k => k.charAt(0).toUpperCase() + k.slice(1)).join("-");
    if (!(normalizedKey in outputHeaders)) outputHeaders[normalizedKey] = value;
  }

  return new Response(JSON.stringify({ args, headers: outputHeaders, location, origin: ip, url: request.url }, null, 2), {
    headers: { "Content-Type": "application/json" }
  });
}
