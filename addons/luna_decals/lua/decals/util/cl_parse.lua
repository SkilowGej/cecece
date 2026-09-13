--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

Decals.Parse = Decals.Parse or {
    Patterns = {
        Imgur = {
            "https?://[www%.]*.?i.imgur.com/(%w+)",
            "https?://[www%.]*.?imgur.com/a/(%w+)",
            "https?://[www%.]*.?imgur.com/gallery/(%w+)"
        }
    }
}

function Decals.Parse.Imgur( url )
    if !url:find "imgur" then
        return false
    end

    for _, pattern in ipairs( Decals.Parse.Patterns.Imgur ) do
        local res = url:match( pattern )

        if res then
            return "https://i.imgur.com/" .. res .. ".png"
        end
    end

    return nil
end

function Decals.Parse.Error( url )
    return Decals.Load.Valid[ url:GetExtensionFromFilename() ]
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
