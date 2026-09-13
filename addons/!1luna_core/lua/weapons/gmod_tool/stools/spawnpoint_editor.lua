--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

TOOL.Category		= "Renaissance Tools"
TOOL.Name			=	"Spawn Editor"
TOOL.Command		=	nil
TOOL.ConfigName		=	""
TOOL.NextUse        =   0

if CLIENT then
	language.Add("Tool.spawnpoints.name", "Spawnpoints")
	language.Add("Tool.spawnpoints.desc", "Zarządzanie spawnami na mapie")
	language.Add("Tool.spawnpoints.0", "LPM: Dodaj spawn na kursorze R: Ustawienia")

	surface.CreateFont("SpawnToolScreenFont", { font = "Arial", size = 40, weight = 1000, antialias = true, additive = false })
	surface.CreateFont("SpawnToolScreenSubFont", { font = "Arial", size = 30, weight = 1000, antialias = true, additive = false })
end

new_spawn_priority = 0
new_spawn_jobs = {}

function TOOL:LeftClick(trace)
	if self.NextUse > CurTime() then return false end
	self.NextUse = CurTime() + 0.5

	if not self:GetOwner():IsSpawnPointAdmin() then 
		self:GetOwner():ChatPrint("Nie masz dostępu do korzystania z tej funkcji.")
		return false 
	end

	if ( IsValid( trace.Entity ) && trace.Entity:IsPlayer() ) then return false end
	
	local pos = trace.HitPos
	pos = pos + Vector(0, 0, 32)
	pos:SetUnpacked(math.Round(pos.x), math.Round(pos.y), math.Round(pos.z))
	if CLIENT then 
		net.Start("SpawnPoints:CreateSpawn")
			net.WriteVector(pos)
			net.WriteUInt(new_spawn_priority, 7)
			net.WriteTable(new_spawn_jobs)
		net.SendToServer()
	end

	

	--SPAWNS.CreateSpawn(pos, self.Cur_Prioity, self.Cur_Teams)

	return true

end

function TOOL:RightClick(trace)
	return false
end

function TOOL:Reload(trace)
	if self.NextUse > CurTime() then return false end
	self.NextUse = CurTime() + 0.5
	if not self:GetOwner():IsSpawnPointAdmin() then 
		self:GetOwner():ChatPrint("Nie masz dostępu do korzystania z tej funkcji.")
		return false 
	end
	if CLIENT then OpenSpawnEditorMenu() end

	return false

end

function TOOL.BuildCPanel(panel)

	panel:AddControl("Header",{Description = "Edytor spawnów\n\nZarządzanie spawnami dla profesji i ich priorytetami.\n"})

end

function TOOL:DrawToolScreen(width, height)

	if SERVER then return end

	surface.SetDrawColor(17, 148, 240, 255)
	surface.DrawRect(0, 0, 256, 256)

	surface.SetFont("SpawnToolScreenFont")
	local w, h = surface.GetTextSize(" ")
	surface.SetFont("SpawnToolScreenSubFont")
	local w2, h2 = surface.GetTextSize(" ")

	draw.SimpleText("Stwórz spawn", "SpawnToolScreenFont", 128, 30, Color(224, 224, 224, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, Color(17, 148, 240, 255), 4)
	draw.SimpleText("Priorytet: "..new_spawn_priority, "SpawnToolScreenSubFont", 128, 75, Color(200, 200, 200, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, Color(17, 148, 240, 255), 4)
	for k,v in pairs(new_spawn_jobs) do
		draw.SimpleText(v, "SpawnToolScreenSubFont", 128, 75+k*25, Color(0, 0, 0, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, Color(17, 148, 240, 255), 4)
	end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
