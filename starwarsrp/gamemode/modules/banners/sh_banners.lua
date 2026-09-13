local PLAYER = FindMetaTable('Player')

function PLAYER:GetBanners()
    return self:GetMetadata('banners', {} )
end

function PLAYER:GetCurrentBanner()
    return self:GetMetadata('current_banner', '')
end

function PLAYER:HasBanner(bannerPath)
    local banners = self:GetBanners()
    return banners[bannerPath] == true
end

function PLAYER:GetAvatarMask()
    return self:GetMetadata('avatar_mask', '')
end

function PLAYER:GetAvatarFrame()
    return self:GetMetadata('avatar_frame', '')
end

function PLAYER:GetScoreboardDescription()
    return self:GetMetadata('scoreboard_description', '')
end