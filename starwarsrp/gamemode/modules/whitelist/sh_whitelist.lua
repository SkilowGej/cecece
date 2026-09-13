function pMeta:CanUseWhitelist()
    return WHITELIST_ADMINS[self:GetUserGroup()] or LEGION_CMDS[self:Team()]
end

function pMeta:CanGiveTeam(tm)
    if WHITELIST_ADMINS[self:GetUserGroup()] then
        return true
    end

    local job = re.jobs[tm] or re.jobs[TEAM_CADET]
    if LEGION_CMDS[self:Team()][job.legion] then
        return true
    end
    return false
end
