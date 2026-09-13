--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

Prometheus_ClientsideModel = Prometheus_ClientsideModel or ClientsideModel
prometheus.csents = prometheus.csents or {}

local MISSING = '_MISSING_'
local HARD_LIMIT = 6000
local nextSpawn = 0

local function generateReport( ignore, bShort )
    local name = 'prometheus_csent_report_' .. os.date( '%d%m%y_%H%M%S' ) .. '.txt'
    local amount = #prometheus.csents
    local other = ents.FindByClass( 'class C_BaseFlex' )
    local missing = {}
    local text = {}

    for _, ent in ipairs( other ) do
        local found = false

        for _, data in ipairs( prometheus.csents ) do
            if ( ent == data.csent ) then
                found = true
                break
            end
        end

        if ( not found ) then
            table.insert( missing, ent )
        end
    end

    table.insert( text, 'Generated clientside report.' )
    table.insert( text, os.date( '[ %d.%m.%y %H:%M:%S ]' ) )
    if ( bShort ) then table.insert( text, '[ SHORT ]' ) end
    table.insert( text, string.format( 'Map: %s', game.GetMap() ) )
    table.insert( text, string.format( 'IP: %s', game.GetIPAddress() ) )
    table.insert( text, string.format( 'Server: %s', GetHostName() ) )
    table.insert( text, string.format( 'Architecture: %s', jit.arch ) )

    table.insert( text, '' )
    table.insert( text, '---- DETAILS ----' )
    table.insert( text, string.format( 'C_PhysPropClientside (offtop) amount: %d', #ents.FindByClass( 'class C_PhysPropClientside' ) ) )
    table.insert( text, string.format( 'C_BaseFlex amount: %d', #other ) )
    table.insert( text, string.format( 'Registered amount: %d', #prometheus.csents ) )
    table.insert( text, string.format( 'Unregistered: %d', #missing ) )
    
    if ( not bShort ) then
        table.insert( text, '' )
        table.insert( text, '---- REGISTERED ----' )
        for _, data in ipairs( prometheus.csents ) do
            local ent = data.csent
            table.insert( text, string.format( '%s (%s) | %s : %s', ent:GetClass(), ent:GetModel(), data.source, data.name ) )
        end
    
        table.insert( text, '' )
        table.insert( text, '---- UNREGISTERED ----' )
        for _, ent in ipairs( missing ) do
            local parent = ent:GetParent()
            table.insert( text, string.format( '%s (%s) (Parent: %s)', ent:GetClass(), ent:GetModel(), tostring( parent ) ) )
        end
    
        table.insert( text, '---- FINISHED ----' )
    end

    file.Write( name, table.concat( text, '\n' ) )
    
    if ( not ignore ) then
        for _, line in ipairs( text ) do
            prometheus.Print( line )
        end
    end

    return name
end

local function handleCase()
    local success, name = pcall( generateReport, true )

    for _, data in ipairs( prometheus.csents ) do
        local ent = data.csent
        if ( IsValid( ent ) ) then
            ent:Remove()
        end
    end

    prometheus.csents = {}
    prometheus.PrintError( 'Reached clientside entity limit, generated report.' )

    if ( success ) then
        prometheus.PrintError( 'File name: garrysmod/data/%s', name )
    else
        prometheus.PrintError( 'Failed to generate report: %s', name )
    end

    notification.AddLegacy( 'Предотвращено нарушение лимита, проверьте консоль и сообщите администрации.', 1, 6 )
end

function ClientsideModel( path, ... )
    if ( nextSpawn > CurTime() ) then return end
    if ( #prometheus.csents >= HARD_LIMIT ) then
        nextSpawn = CurTime() + engine.TickInterval() * 10
        handleCase()
        return
    end

    local info = debug.getinfo( 2 ) or {}
    local csent = Prometheus_ClientsideModel( path, ... )

    if ( IsValid( csent ) ) then
        csent:CallOnRemove( 'prometheus.protection', function( ent )
            for index, data in ipairs( prometheus.csents ) do
                if ( data.csent == ent ) then
                    table.remove( prometheus.csents, index )
                    break
                end
            end
        end )
    
        table.insert( prometheus.csents, {
            csent = csent,
            source = info.source or MISSING,
            name = info.name or MISSING,
            path = path
        } )
    end

    return csent
end

concommand.Add( 'prometheus_csent_report', function()
    generateReport()
end )

concommand.Add( 'prometheus_csent_report_short', function()
    generateReport( false, true )
end )

concommand.Add( 'prometheus_csent_cleanup', function()
    for _, ent in ipairs( ents.FindByClass( 'class C_BaseFlex' ) ) do
        ent:Remove()
    end
end )

do
    local nextPrint = 0
    local convar = CreateClientConVar( 'cl_prometheus_csent_debug', '0', false, false )
    local enabled = convar:GetBool()

    cvars.AddChangeCallback( 'cl_prometheus_csent_debug', function( _, _, new )
        enabled = new == '1'
    end, 'internal' )

    hook.Add( 'Think', 'prometheus.ClientsideEntityPrint', function()
        if ( enabled and nextPrint <= CurTime() ) then
            nextPrint = CurTime() + 1
            prometheus.PrintDebug( 'Clientside entity amount: ' .. #prometheus.csents )
        end
    end )
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
