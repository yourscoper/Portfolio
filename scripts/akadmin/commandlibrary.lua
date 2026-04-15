_G.__AK_ADMIN_EXECUTED = true

local Library = {}
_G.bp = true

_G.VERIFIED_VALUES = {
    7382, 4921, 6154, 8293, 1047,
    5621, 9384, 2047, 6831, 4502
}

_G.cmds = {
    ["!rizzlines"]              = "https://yourscoper.vercel.app/scripts/akadmin/scripts/rizzlines.lua",
    ["!spotify"]                = "https://yourscoper.vercel.app/scripts/akadmin/scripts/spotify.lua",
    ["!domainexpansion"]        = "https://yourscoper.vercel.app/scripts/akadmin/scripts/domainexpansion.lua",
    ["!inspect user/display"]   = "",
    ["!iy"]                     = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
    ["!colbring"]               = "https://yourscoper.vercel.app/scripts/akadmin/scripts/colbring.lua",
    ["!emotes"]                 = "https://yourscoper.vercel.app/scripts/akadmin/scripts/emotes.lua",
    ["!re"]                     = "https://yourscoper.vercel.app/scripts/akadmin/scripts/re.lua",
    ["!animlogger"]             = "https://yourscoper.vercel.app/scripts/akadmin/scripts/animlogger.lua",
    ["!char username/display"]  = "",
    ["!hug"]                    = "https://yourscoper.vercel.app/scripts/akadmin/scripts/hug.lua",
    ["!shlowest"]               = "https://yourscoper.vercel.app/scripts/akadmin/scripts/shlowest.lua",
    ["!animrecorder"]           = "https://yourscoper.vercel.app/scripts/akadmin/scripts/animrecorder.lua",
    ["!friend user/display"]    = "",
    ["!shmost"]                 = "https://yourscoper.vercel.app/scripts/akadmin/scripts/shmost.lua",
    ["!fling"]                  = "https://yourscoper.vercel.app/scripts/akadmin/scripts/fling.lua",
    ["!antivcban"]              = "https://yourscoper.vercel.app/scripts/akadmin/scripts/antivcban.lua",
    ["!r15"]                    = "https://yourscoper.vercel.app/scripts/akadmin/scripts/r15.lua",
    ["!ftp"]                    = "https://yourscoper.vercel.app/scripts/akadmin/scripts/ftp.lua",
    ["!antislide"]              = "https://yourscoper.vercel.app/scripts/akadmin/scripts/antislide.lua",
    ["!swordreach"]             = "https://yourscoper.vercel.app/scripts/akadmin/scripts/swordreach.lua",
    ["!hide user/display"]      = "",
    ["!animcopy"]               = "https://yourscoper.vercel.app/scripts/akadmin/scripts/animcopy.lua",
    ["!admincheck"]             = "https://yourscoper.vercel.app/scripts/akadmin/scripts/admincheck.lua",
    ["!speed"]                  = "https://yourscoper.vercel.app/scripts/akadmin/scripts/speed.lua",
    ["!call"]                   = "https://yourscoper.vercel.app/scripts/akadmin/scripts/call.lua",
    ["!sfly"]                   = "https://yourscoper.vercel.app/scripts/akadmin/scripts/sfly.lua",
    ["!to user/display"]        = "",
    ["!naturaldisastergodmode"] = "https://yourscoper.vercel.app/scripts/akadmin/scripts/naturaldisastergodmode.lua",
    ["!ftap"]                   = "https://yourscoper.vercel.app/scripts/akadmin/scripts/ftap.lua",
    ["!limborbit"]              = "https://yourscoper.vercel.app/scripts/akadmin/scripts/limborbit.lua",
    ["!antibang"]               = "https://yourscoper.vercel.app/scripts/akadmin/scripts/antibang.lua",
    ["!unfriend user/display"]  = "",
    ["!flip"]                   = "https://yourscoper.vercel.app/scripts/akadmin/scripts/flip.lua",
    ["!voidre"]                 = "https://yourscoper.vercel.app/scripts/akadmin/scripts/voidre.lua",
    ["!coloredbaseplate"]       = "https://yourscoper.vercel.app/scripts/akadmin/scripts/coloredbaseplate.lua",
    ["!headsit user/display"]   = "",
    ["!facebang"]               = "https://yourscoper.vercel.app/scripts/akadmin/scripts/facebang.lua",
    ["!caranims"]               = "https://yourscoper.vercel.app/scripts/akadmin/scripts/caranims.lua",
    ["!facebang2"]              = "https://yourscoper.vercel.app/scripts/akadmin/scripts/facebang2.lua",
    ["!ad"]                     = "https://yourscoper.vercel.app/scripts/akadmin/scripts/ad.lua",
    ["!gokutp"]                 = "https://yourscoper.vercel.app/scripts/akadmin/scripts/gokutp.lua",
    ["!block user/display"]     = "",
    ["!chateditor"]             = "https://yourscoper.vercel.app/scripts/akadmin/scripts/chateditor.lua",
    ["!unblock user/display"]   = "",
    ["!touchkill"]              = "https://yourscoper.vercel.app/scripts/akadmin/scripts/touchkill.lua",
    ["!unchatban"]              = "https://yourscoper.vercel.app/scripts/akadmin/scripts/unchatban.lua",
    ["!autoclicker"]            = "https://yourscoper.vercel.app/scripts/akadmin/scripts/autoclicker.lua",
    ["!kidnap"]                 = "https://yourscoper.vercel.app/scripts/akadmin/scripts/kidnap.lua",
    ["!touchfling"]             = "https://yourscoper.vercel.app/scripts/akadmin/scripts/touchfling.lua",
    ["!antiafk"]                = "https://yourscoper.vercel.app/scripts/akadmin/scripts/antiafk.lua",
    ["!mute user/display"]      = "",
    ["!reverse"]                = "https://yourscoper.vercel.app/scripts/akadmin/scripts/reverse.lua",
    ["!unchar"]                 = "",
    ["!chatcolor"]              = "https://yourscoper.vercel.app/scripts/akadmin/scripts/chatcolor.lua",
    ["!akbypasser"]             = "https://yourscoper.vercel.app/scripts/akadmin/scripts/akbypasser.lua",
    ["!antiall"]                = "https://yourscoper.vercel.app/scripts/akadmin/scripts/antiall.lua",
    ["!fastre"]                 = "https://yourscoper.vercel.app/scripts/akadmin/scripts/fastre.lua",
    ["!possaver"]               = "https://yourscoper.vercel.app/scripts/akadmin/scripts/possaver.lua",
    ["!aimlock"]                = "https://yourscoper.vercel.app/scripts/akadmin/scripts/aimlock.lua",
    ["!aitools"]                = "https://yourscoper.vercel.app/scripts/akadmin/scripts/aitools.lua",
    ["!unhide user/display"]    = "",
    ["!trip"]                   = "https://yourscoper.vercel.app/scripts/akadmin/scripts/trip.lua",
    ["!reanim"]                 = "https://yourscoper.vercel.app/scripts/akadmin/scripts/reanim.lua",
    ["!friendcheck"]            = "https://yourscoper.vercel.app/scripts/akadmin/scripts/friendcheck.lua",
    ["!jerk"]                   = "https://yourscoper.vercel.app/scripts/akadmin/scripts/jerk.lua",
    ["!r6"]                     = "https://yourscoper.vercel.app/scripts/akadmin/scripts/r6.lua",
    ["!pianoplayer"]            = "https://yourscoper.vercel.app/scripts/akadmin/scripts/pianoplayer.lua",
    ["!skymaster"]              = "https://yourscoper.vercel.app/scripts/akadmin/scripts/skymaster.lua",
    ["!antifling"]              = "https://yourscoper.vercel.app/scripts/akadmin/scripts/antifling.lua",
    ["!antikidnap"]             = "https://yourscoper.vercel.app/scripts/akadmin/scripts/antikidnap.lua",
    ["!pinghop"]                = "https://yourscoper.vercel.app/scripts/akadmin/scripts/pinghop.lua",
    ["!shaders"]                = "https://yourscoper.vercel.app/scripts/akadmin/scripts/shaders.lua",
    ["!backpack user/display"]  = "",
    ["!antiheadsit"]            = "https://yourscoper.vercel.app/scripts/akadmin/scripts/antiheadsit.lua",
    ["!antivoid"]               = "https://yourscoper.vercel.app/scripts/akadmin/scripts/antivoid.lua",
    ["!unmute user/display"]    = "",
    ["!unbackpack "]            = "",
    ["!infbaseplate"]           = "https://yourscoper.vercel.app/scripts/akadmin/scripts/infbaseplate.lua",
    ["!uafling"]                = "https://yourscoper.vercel.app/scripts/akadmin/scripts/uafling.lua",
    ["!ugcemotes"]              = "https://yourscoper.vercel.app/scripts/akadmin/scripts/ugcemotes.lua",
    ["!walkonair"]              = "https://yourscoper.vercel.app/scripts/akadmin/scripts/walkonair.lua",
    ["!unheadsit "]             = "",
    ["!chatlogs"]               = "https://yourscoper.vercel.app/scripts/akadmin/scripts/chatlogs.lua",
    ["!stalk"]                  = "https://yourscoper.vercel.app/scripts/akadmin/scripts/stalk.lua",
    ["!invis"]                  = "https://yourscoper.vercel.app/scripts/akadmin/scripts/invis.lua",
    ["!shiftlock"]              = "https://yourscoper.vercel.app/scripts/akadmin/scripts/shiftlock.lua",
    ["!rejoin"]                 = "",
    ["!copyserver"]             = "https://yourscoper.vercel.app/scripts/akadmin/scripts/copyserver.lua",
}

function Library:Execute(input)
    if not input or input == "" then
        --warn("[AK Admin] No input provided")
        return
    end

    local url = _G.cmds[input] or input

    --[[if not url or url == "" then
        warn("[AK Admin] Invalid command or empty URL:", input)
        return
    end]]

    local success, err = pcall(function()
        loadstring(game:HttpGet(url, true))()
    end)

    --[[if success then
        print("[AK Admin] Successfully executed:", input)
    else
        warn("[AK Admin] Execution failed for", input, "| Error:", err)
    end]]
end

return Library
