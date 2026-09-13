local PLAYER = FindMetaTable('Player')

function PLAYER:SetBanners(tbl)
    if not tbl or type(tbl) ~= 'table' then return end
    self:SetMetadata('banners', tbl)
end

function PLAYER:AddBanner(bannerPath)
    if not bannerPath then return end
    local banners = self:GetBanners()
    banners[bannerPath] = true
    self:SetBanners(banners)
end

function PLAYER:SetCurrentBanner(bannerPath)
    self:SetMetadata('current_banner', bannerPath)
end

function PLAYER:SetAvatarMask(maskPath)
    self:SetMetadata('avatar_mask', maskPath)
end

function PLAYER:SetAvatarFrame(framePath)
    self:SetMetadata('avatar_frame', framePath)
end

function PLAYER:SetScoreboardDescription(description)
    self:SetMetadata('scoreboard_description', description)
end