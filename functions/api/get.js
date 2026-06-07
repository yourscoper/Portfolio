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

  const countryMap = {
    AF:"Afghanistan",AL:"Albania",DZ:"Algeria",AS:"American Samoa",AD:"Andorra",AO:"Angola",
    AI:"Anguilla",AQ:"Antarctica",AG:"Antigua and Barbuda",AR:"Argentina",AM:"Armenia",
    AU:"Australia",AT:"Austria",AZ:"Azerbaijan",BE:"Belgium",BR:"Brazil",CA:"Canada",
    CN:"China",FR:"France",DE:"Germany",IN:"India",IT:"Italy",JP:"Japan",MX:"Mexico",
    NL:"Netherlands",RU:"Russia",ES:"Spain",SE:"Sweden",CH:"Switzerland",
    GB:"United Kingdom",US:"United States",VN:"Vietnam"
  };

  const regionMap = {
    AL:"Alabama",AK:"Alaska",AZ:"Arizona",AR:"Arkansas",CA:"California",CO:"Colorado",
    CT:"Connecticut",FL:"Florida",GA:"Georgia",HI:"Hawaii",IL:"Illinois",
    NY:"New York",NV:"Nevada",TX:"Texas",WA:"Washington",DC:"District of Columbia"
  };

  const continentMap = {
    NA:"North America",SA:"South America",EU:"Europe",AS:"Asia",AF:"Africa",OC:"Oceania",AT:"Australia"
  };

  const countryCode = request.headers.get("cf-ipcountry") || "";
  const ip = request.headers.get("cf-connecting-ip") || request.headers.get("x-real-ip") || "";

  const location = {
    ip,
    city: request.headers.get("cf-ipcity") || "",
    region: regionMap[request.headers.get("cf-region-code")] || request.headers.get("cf-region-code") || "",
    postal: request.headers.get("cf-postal-code") || "",
    countryCode,
    countryName: countryMap[countryCode] || countryCode || "Unknown",
    country: countryCode ? getFlagEmoji(countryCode) : "🏳️",
    continent: continentMap[request.headers.get("cf-ipcontinent")] || request.headers.get("cf-ipcontinent") || "",
    latitude: request.headers.get("cf-iplatitude") || "",
    longitude: request.headers.get("cf-iplongitude") || ""
  };

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
