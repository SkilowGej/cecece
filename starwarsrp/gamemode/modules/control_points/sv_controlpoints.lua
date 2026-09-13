-- hook.Add('InitPostEntity','ControlPoints_InitPostEntity',function()
    timer.Remove("ControlPoints_Timer")
    timer.Create('ControlPoints_Timer',1,0,function()
        for k, ent in pairs(ents.FindByClass('control_point')) do
            local buff = .01* ent:GetNWInt( "Time" )
            local insphere = ents.FindInSphere(ent:GetPos(), ent:GetNWInt('Radius'))
            local players = {}
            for _, pl in pairs(insphere) do
                if pl and IsValid(pl) and pl:IsPlayer() and re.jobs[pl:Team()] and re.jobs[pl:Team()].control and pl:Alive() and pl:GetMoveType() ~= MOVETYPE_NOCLIP then
                    local pl_fraction = re.jobs[pl:Team()].control
                    players[pl_fraction] = players[pl_fraction] or {}
                    table.insert(players[pl_fraction], pl)
                end
            end

            local fraction_id = ent:GetNWString('Team')
            ent:SetBodygroup( 1, CONTROLPOINT_TEAMS[fraction_id].body )

            -- for _, v in pairs(player.GetAll()) do
                -- if re.jobs[v:Team()].control == CONTROL_REPUBLIC then
                    -- v:SendLua( "surface.PlaySound( \"galactic/capturepoints/ticketclick.wav\" )" )
                -- end
            -- end
            -- ent:SetColor( CONTROLPOINT_TEAMS[fraction_id].color )

            for _, fraction_players in pairs(players) do
                -- if pl and IsValid(pl) and pl:IsPlayer() and pl:Alive() and pl:GetMoveType() ~= MOVETYPE_NOCLIP then
                for _, pl in pairs(fraction_players) do
                    local job = re.jobs[pl:Team()]
                    local pl_fraction = job.control
                    local occupied = ent:GetNWInt( "Occupied" )

                    local can_occupied = true
                    for fr, _ in pairs(CONTROLPOINT_TEAMS) do
                        players[fr] = players[fr] or {}
                        if fr ~= 0 and fr ~= pl_fraction then
                            if ent:GetNWInt( "CountOccupied" ) then
                                if #players[fr] >= #players[pl_fraction] then
                                    can_occupied = false
                                    break
                                end
                            else
                                if #players[fr] >= 1 then
                                    can_occupied = false
                                    break
                                end
                            end
                        end
                    end

                    -- print(can_occupied)

                    if ent:GetNWBool( "CountBuff" ) and #players[pl_fraction] > 1 then
                        buff = buff* (#players[pl_fraction]*.2)
                    end

                    ent:SetNWBool( "Challenging", not can_occupied )

                    if fraction_id == 0 then
                        if occupied <= 1 then
                            ent:SetNWInt( "Occupied", occupied + buff )
                        else
                            ent:SetNWInt( "Team", pl_fraction )
                        end
                    elseif ent:GetNWInt( "Team" ) ~= pl_fraction and can_occupied then
                        if occupied > 0 then
                            ent:SetNWInt( "Occupied", occupied - buff )
                        else
                            if ent:GetNWBool( "MomentOccupied" ) then
                                ent:SetNWInt( "Team", pl_fraction )

                                for _, v in pairs(player.GetAll()) do
                                    if v and IsValid(v) and v:Team() and re.jobs[v:Team()] and re.jobs[v:Team()].control == CONTROL_REPUBLIC then
                                        if pl_fraction == CONTROL_REPUBLIC then
                                            v:SendLua( "surface.PlaySound( \"luna_sound_effects/capturepoints/captured.wav\" )" )
                                        else
                                            v:SendLua( "surface.PlaySound( \"luna_sound_effects/capturepoints/enemycaptured.wav\" )" )
                                        end
                                    end
                                end
                            else
                                ent:SetNWInt( "Team", 0 )
                            end
                        end
                    elseif ent:GetNWInt( "Team" ) == pl_fraction and can_occupied then
                        if occupied < 1 then
                            ent:SetNWInt( "Occupied", occupied + buff )
                        elseif occupied > 1 then
                            ent:SetNWInt( "Occupied", 1 )
                        end
                    end

                    if occupied > 1 then
                        ent:SetNWInt( "Occupied", 1 )
                    end
                end
            end
        end
    end)
-- end)
