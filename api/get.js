export default function handler(req, res) {
  const headers = req.headers;
  const ua = headers["user-agent"] || "";

  /* ---------------- DEVICE DETECTION ---------------- */
  let device = "Unknown";
  const secPlatform = headers["sec-ch-ua-platform"] || "";

  if (/windows/i.test(ua) || /"Windows"/i.test(secPlatform)) {
    device = "Windows";
  } else if (/macintosh|mac os/i.test(ua) || /"macOS"/i.test(secPlatform)) {
    device = "macOS";
  } else if (/iphone|ipad|ipod/i.test(ua)) {
    device = "iOS";
  } else if (/android/i.test(ua)) {
    device = "Android";
  }

  /* ---------------- COUNTRY MAP ---------------- */
  const countryMap = {
    AF: "Afghanistan", AL: "Albania", DZ: "Algeria", AS: "American Samoa",
    AD: "Andorra", AO: "Angola", AI: "Anguilla", AQ: "Antarctica",
    AG: "Antigua and Barbuda", AR: "Argentina", AM: "Armenia",
    AU: "Australia", AT: "Austria", AZ: "Azerbaijan", BE: "Belgium",
    BR: "Brazil", CA: "Canada", CN: "China", FR: "France",
    DE: "Germany", IN: "India", IT: "Italy", JP: "Japan",
    MX: "Mexico", NL: "Netherlands", RU: "Russia",
    ES: "Spain", SE: "Sweden", CH: "Switzerland",
    GB: "United Kingdom", US: "United States", VN: "Vietnam"
  };

  /* ---------------- US STATE MAP ---------------- */
  const regionMap = {
    AL: "Alabama", AK: "Alaska", AZ: "Arizona", AR: "Arkansas",
    CA: "California", CO: "Colorado", CT: "Connecticut",
    FL: "Florida", GA: "Georgia", HI: "Hawaii", IL: "Illinois",
    NY: "New York", NV: "Nevada", TX: "Texas", WA: "Washington",
    DC: "District of Columbia"
  };

  /* ---------------- CONTINENT MAP ---------------- */
  const continentMap = {
    NA: "North America",
    SA: "South America",
    EU: "Europe",
    AS: "Asia",
    AF: "Africa",
    OC: "Oceania",
    AT: "Australia"
  };

  /* ---------------- LOCATION ---------------- */
  const location = {
    ip: headers["x-real-ip"] || "",
    city: headers["x-vercel-ip-city"]
      ? decodeURIComponent(headers["x-vercel-ip-city"])
      : "",
    region:
      regionMap[headers["x-vercel-ip-country-region"]] ||
      headers["x-vercel-ip-country-region"] ||
      "",
    postal: headers["x-vercel-ip-postal-code"] || "",
    country:
      countryMap[headers["x-vercel-ip-country"]] ||
      headers["x-vercel-ip-country"] ||
      "",
    continent:
      continentMap[headers["x-vercel-ip-continent"]] ||
      headers["x-vercel-ip-continent"] ||
      "",
    latitude: headers["x-vercel-ip-latitude"] || "",
    longitude: headers["x-vercel-ip-longitude"] || ""
  };

  /* ---------------- HEADERS (CLEAN) ---------------- */
  const outputHeaders = {
    "Accept": headers["accept"] || "",
    "Accept-Encoding": headers["accept-encoding"] || "",
    "Accept-Language": headers["accept-language"] || "",
    "Host": headers["host"] || "",
    "Device": device,
    "User-Agent": ua,
    "X-Amzn-Trace-Id": headers["x-amzn-trace-id"] || ""
  };

  for (const key in headers) {
    const lower = key.toLowerCase();

    // ❌ Vercel + Roblox session junk
    if (
      lower.startsWith("x-vercel-") ||
      lower.startsWith("roblox-session-id")
    ) continue;

    // ❌ Location headers (already normalized)
    if (
      lower.startsWith("x-real-ip") ||
      lower.startsWith("x-forwarded") ||
      lower.startsWith("x-vercel-ip")
    ) continue;

    // ❌ Browser / routing noise
    if (
      lower === "cache-control" ||
      lower === "forwarded" ||
      lower === "priority" ||
      lower === "upgrade-insecure-requests" ||
      lower === "x-invocation-id" ||
      lower.startsWith("sec-")
    ) continue;

    const normalizedKey = key
      .split("-")
      .map(k => k.charAt(0).toUpperCase() + k.slice(1))
      .join("-");

    if (!(normalizedKey in outputHeaders)) {
      outputHeaders[normalizedKey] = headers[key];
    }
  }

  /* ---------------- RESPONSE ---------------- */
  const response = {
    args: req.query || {},
    headers: outputHeaders,
    location,
    origin: location.ip,
    url: `https://${headers["host"]}${req.url}`
  };

  res.setHeader("Content-Type", "application/json");
  res.status(200).send(JSON.stringify(response, null, 2));
}
