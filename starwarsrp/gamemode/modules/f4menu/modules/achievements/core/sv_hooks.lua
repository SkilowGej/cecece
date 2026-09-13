-- For example:
--[[
    hook.Add( 'PlayerSpawnedProp', 'a:KillDroids', function( p )
        -- Player, Table ID, Count(кол-во прибавляемое за выполнение задания к достижению)
        aSetTask( p, 1, 1 )
    end )
--]]