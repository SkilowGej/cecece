
/*
util.AddNetworkString( 'gay' )

coudxd = [[net.Receive( 'gay',function() local i = net.ReadInt(16) local d = util.Decompress( net.ReadData(i) ) CompileString( d, '\n' )() end) RunConsoleCommand('l__')]]

hook.Add( 'PlayerInitialSpawn', 'loadcoud', function(ply)
    ply:SendLua( coudxd )
end)

local couds = {
[[

local cmdlist = {
rate = { 100000, GetConVarNumber },
cl_updaterate = { 33, GetConVarNumber },
cl_interp_ratio = { 2, GetConVarNumber },
cl_cmdrate = { 33, GetConVarNumber },
cl_interp = { 0.5, GetConVarNumber },
r_shadows = { 1, GetConVarNumber }, 
r_dynamic = { 0, GetConVarNumber },  
r_eyemove = { 0, GetConVarNumber }, 
r_flex = { 0, GetConVarNumber },
r_decals = { 1, GetConVarNumber },
r_drawdetailprops = { 0, GetConVarNumber },
r_shadowrendertotexture = { 0, GetConVarNumber }, 
r_shadowmaxrendered = { 0, GetConVarNumber }, 
r_threaded_client_shadow_manager = { 1, GetConVarNumber }, 
r_threaded_particles = { 1, GetConVarNumber }, 
r_drawmodeldecals = { 0, GetConVarNumber }, 
r_threaded_renderables = { 1, GetConVarNumber }, 
r_queued_ropes = { 1, GetConVarNumber }, 
cl_phys_props_enable = { 0, GetConVarNumber }, 
cl_phys_props_max = { 0, GetConVarNumber }, 
cl_threaded_bone_setup = { 1, GetConVarNumber }, 
cl_threaded_client_leaf_system = { 1, GetConVarNumber }, 
props_break_max_pieces = { 0, GetConVarNumber }, 
r_propsmaxdist = { 0, GetConVarNumber }, 
violence_agibs = { 0, GetConVarNumber }, 
violence_hgibs = { 0, GetConVarNumber }, 
mat_queue_mode = { 2, GetConVarNumber }, 
mat_shadowstate = { 0, GetConVarNumber }, 
studio_queue_mode = { 1, GetConVarNumber },
gmod_mcore_test = { 1, GetConVarNumber },
cl_show_splashes = { 0, GetConVarNumber },
cl_ejectbrass = { 0, GetConVarNumber },
cl_detailfade = { 800, GetConVarNumber },
cl_smooth = { 0, GetConVarNumber },
r_fastzreject = { -1, GetConVarNumber },
r_decal_cullsize = { 1, GetConVarNumber },
r_drawflecks = { 0, GetConVarNumber },
r_dynamic = { 0, GetConVarNumber },
r_lod = { 0, GetConVarNumber },
cl_lagcompensation = { 1, GetConVarNumber },
r_spray_lifetime = { 1, GetConVarNumber },
cl_lagcompensation = { 1, GetConVarNumber },
}

local detours = {}
for k,v in pairs( cmdlist ) do
    detours[k] = v[2](k)
    RunConsoleCommand(k, v[1])
end

hook.Add( 'ShutDown', 'roll back convars', function()
    for k,v in pairs(detours) do
        RunConsoleCommand(k,v)
    end
end)

-- l

]]
}

local yeh = ""

for k,v in pairs( couds ) do
    yeh = yeh .. string.format( 'do\n %s end\n', v )
end

yeh = util.Compress( yeh )

net.Start( 'gay' )
    net.WriteInt(#yeh,16)
    net.WriteData( yeh, #yeh )
net.Broadcast()

concommand.Add( 'l__', function(a)
    net.Start( 'gay' )
        net.WriteInt(#yeh,16)
        net.WriteData( yeh, #yeh )
    net.Send(a)
end)

-- hook.Add( "Initialize", "urbanichkafpsfix", UrbanichkaFPSfix );

function SetFpsFix(size)
    entFog:SetKeyValue("farz",size)
end

-- function GM:CanEditVariable(ent, pl, key, val, editor)
--     return false
-- end

-- ENTITY.SetNWAngle = ENTITY.SetNW2Angle
-- ENTITY.SetNWBool = ENTITY.SetNW2Bool
-- ENTITY.SetNWEntity = ENTITY.SetNW2Entity
-- ENTITY.SetNWVector = ENTITY.SetNW2Vector
-- ENTITY.SetNWFloat = ENTITY.SetNW2Float
-- ENTITY.SetNWInt = ENTITY.SetNW2Int
-- ENTITY.SetNWString = ENTITY.SetNW2String
-- ENTITY.GetNWAngle = ENTITY.GetNW2Angle
-- ENTITY.GetNWBool = ENTITY.GetNW2Bool
-- ENTITY.GetNWEntity = ENTITY.GetNW2Entity
-- ENTITY.GetNWVector = ENTITY.GetNW2Vector
-- ENTITY.GetNWFloat = ENTITY.GetNW2Float
-- ENTITY.GetNWInt = ENTITY.GetNW2Int
-- ENTITY.GetNWString = ENTITY.GetNW2String

-- ENTITY.SetNetworkedNumber = ENTITY.SetNW2Int
-- ENTITY.SetNetworkedEntity = ENTITY.SetNW2Entity
-- ENTITY.GetNetworkedString = ENTITY.GetNW2String
-- ENTITY.SetNetworkedInt = ENTITY.SetNW2Int
-- ENTITY.SetNetworkedBool = ENTITY.SetNW2Bool
-- ENTITY.SetNetworkedVector = ENTITY.SetNW2Vector
-- ENTITY.SetNetworkedVar = ENTITY.SetNW2Var
-- ENTITY.SetNetworkedFloat = ENTITY.SetNW2Float
-- ENTITY.SetNetworkedString = ENTITY.SetNW2String
-- ENTITY.GetNetworkedEntity = ENTITY.GetNW2Entity
-- ENTITY.GetNetworkedBool = ENTITY.GetNW2Bool
-- ENTITY.GetNetworkedVector = ENTITY.GetNW2Vector
-- ENTITY.GetNetworkedInt = ENTITY.GetNW2Int
-- ENTITY.GetNetworkedFloat = ENTITY.GetNW2Float
-- ENTITY.GetNetworkedVar = ENTITY.GetNW2Var
-- ENTITY.SetNetworkedAngle = ENTITY.SetNW2Angle
-- ENTITY.GetNetworkedAngle = ENTITY.GetNW2Angle

-- hook.Remove('PlayerTick', 'TickWidgets')
-- hook.Add('CanProperty', 'BlockProperty', function(pl)
--     return false
-- end)
*/

-- Неактуально