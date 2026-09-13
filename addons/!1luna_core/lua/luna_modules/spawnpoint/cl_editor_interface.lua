--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

-- Created by: _Dubrovski_ (https://steamcommunity.com/id/dubrovski25)
-- Специально для проекта STAR WARS Renaissance

local SpawnList
local spawn_table = {}

local function RefreshSpawnPoints()
	SpawnList:Clear()
	for id,spawn in pairs(spawn_table) do
		local dist = math.Round(LocalPlayer():GetPos():Distance(spawn.pos)/52.5) .. " м"
		SpawnList:AddLine( id, spawn.prio, dist, #spawn.jobs )
	end
	SpawnList:SortByColumn( 2 )
end

function OpenSpawnEditorMenu()

	if not LocalPlayer():IsSpawnPointAdmin() then return false end

	local MainFrame = vgui.Create( "DFrame" )
	MainFrame:SetSize( 600, 400 )
	MainFrame:Center()
	MainFrame:SetTitle("Spawn Point Editor")
	MainFrame:SetDeleteOnClose(false)
	MainFrame:MakePopup()

	local sheet = vgui.Create( "DPropertySheet", MainFrame )
	sheet:Dock( FILL )
	function sheet:OnActiveTabChanged( old, new )
		RefreshSpawnPoints()
	end

	local CreatePanel = vgui.Create( "DPanel", sheet )
	CreatePanel.Paint = function( self, w, h ) end 
	sheet:AddSheet( "Dodawanie punktów", CreatePanel, "icon16/add.png" )

	local EditPanel = vgui.Create( "DPanel", sheet )
	EditPanel:DockMargin(5, 10, 5, 5)
	EditPanel.Paint = function( self, w, h ) end 
	sheet:AddSheet( "Zarządzanie spawnami", EditPanel, "icon16/application_edit.png" )

	local AdminPanel = vgui.Create( "DPanel", sheet )
	AdminPanel:Hide()
	if LocalPlayer():IsSpawnPointSuperAdmin() then
		AdminPanel:Show()
		sheet:AddSheet( "Panel dewe", AdminPanel, "icon16/wrench.png" )
	end
		
	AdminPanel.Paint = function( self, w, h ) end 
	

	--------------------= Панель добавления точки =--------------------

	local PrioSlider = vgui.Create( "DNumSlider", CreatePanel )
	PrioSlider:Dock( TOP )
	PrioSlider:SetSize( CreatePanel:GetWide()*0.9, 50 )
	PrioSlider:SetText( "Priorytet punktu spawowania" )
	PrioSlider:SetMin( 0 )	
	PrioSlider:SetMax( 100 )
	PrioSlider:SetDecimals( 0 )
	PrioSlider:SetValue( new_spawn_priority )
	PrioSlider.OnValueChanged = function( self, value )
		new_spawn_priority = math.Round(value)
	end

	local JobList = vgui.Create( "DListView", CreatePanel )
	JobList:Dock( FILL )
	JobList:DockMargin(5, 10, 5, 5)
	JobList:SetMultiSelect( true )
	JobList:AddColumn( "Kategoria" )
	JobList:AddColumn( "Specjalizacja" )
	JobList:AddColumn( "ID" )

	for id,jobtbl in pairs(re.jobs) do
		local name = jobtbl.Name
		local cat = jobtbl.customCategory or "-"
		local id = jobtbl.jobID
		local selected = table.HasValue(new_spawn_jobs, id)
		JobList:AddLine( cat, name, id ):SetSelected( selected )
	end

	JobList.OnRowSelected = function( lst, index, pnl )
		new_spawn_jobs = {}
		for k,v in pairs(JobList:GetSelected()) do
			new_spawn_jobs[k] = v:GetValue( 3 )
		end
	end

	local DLabel = vgui.Create( "DLabel", CreatePanel )
	DLabel:Dock( TOP )
	DLabel:DockMargin(5, 0, 0, 0)
	DLabel:SetWrap( true )
	DLabel:SetAutoStretchVertical(true)
	DLabel:SetText( "Aby wybrać kilka specjalizacji - przytrzymaj CTRL" )

	local BeginSpawnCreation = vgui.Create( "DButton", CreatePanel )
	BeginSpawnCreation:Dock( BOTTOM )
	BeginSpawnCreation:DockMargin(5, 1, 5, 1)
	BeginSpawnCreation:SetSize( 0, 30 )
	BeginSpawnCreation:SetText( "Rozpocząć" )
	BeginSpawnCreation:SetFont("GModToolSubtitle")
	BeginSpawnCreation.DoClick = function()
		MainFrame:Close()
	end

	--------------------= Панель разработчика =--------------------

	local DeleteMapSpawns = vgui.Create( "DButton", AdminPanel )
	DeleteMapSpawns:Dock( TOP )
	DeleteMapSpawns:DockMargin(5, 5, 5, 5)
	DeleteMapSpawns:SetSize( 250, 30 )
	DeleteMapSpawns:SetText( "Usuń spawn'y dla aktualnej mapy" )
	DeleteMapSpawns:SetIcon("icon16/map_delete.png")
	DeleteMapSpawns.DoClick = function()
		Derma_Query(
		    "Czy na pewno chcesz usunąć wszystkie punkty spawnu dla tej mapy?",
		    "Usuwanie punktów spawnu aktualnej mapy",
		    "Usuń na zawsze",
		    function() 
		    	DeleteMapSpawns:SetEnabled(false)

				net.Start("SpawnPoints:RemoveAllSpawns")
				net.SendToServer()

				net.Start("SpawnPoints:RefreshClientSpawns")
				net.SendToServer()
		    end,
			"Anulowanie",
			function() end
		)
	end

	local DeleteAllSpawns = vgui.Create( "DButton", AdminPanel )
	DeleteAllSpawns:Dock( TOP )
	DeleteAllSpawns:DockMargin(5, 5, 5, 5)
	DeleteAllSpawns:SetSize( 250, 30 )
	DeleteAllSpawns:SetTextColor(Color(255,0,0))
	DeleteAllSpawns:SetText( "Wyczyść bazę danych" )
	DeleteAllSpawns:SetIcon("icon16/database_delete.png")
	DeleteAllSpawns.DoClick = function()
		Derma_Query(
		    "Czy na pewno chcesz usunąć WSZYSTKIE punkty spawnu? Może lepiej usunąć tylko dla aktualnej mapy?",
		    "Usuwanie punktów spawnu z bazy danych",
		    "Usuń na zawsze",
		    function()
		    	DeleteMapSpawns:SetEnabled(false)
		    	DeleteAllSpawns:SetEnabled(false)

				net.Start("SpawnPoints:RemoveAllSpawns")
					net.WriteBool(true)
				net.SendToServer()

				net.Start("SpawnPoints:RefreshClientSpawns")
				net.SendToServer()
		    end,
			"Anulowanie",
			function() end
		)
	end

	--------------------= Редактирование спавнов =--------------------

	local selected_spawn_id, selected_spawn_pnl 

	local AllowedJobs, ButtonsPanel, Button_Add_Job, Button_Remove_Job, Button_Save_Jobs, PrioriryNum, Button_Delete_Spawn

	local main_w = MainFrame:GetWide()

	local RefreshButton = vgui.Create( "DButton", EditPanel )
	RefreshButton:SetIcon("icon16/arrow_refresh.png")
	RefreshButton:Dock( TOP )
	RefreshButton:DockMargin(5, 5, 5, 5)
	RefreshButton:SetText( "Odśwież listę" )
	RefreshButton:SetPos( 25, 50 )
	RefreshButton:SetSize( 250, 30 )
	RefreshButton.DoClick = function()
		net.Start("SpawnPoints:RefreshClientSpawns")
		net.SendToServer()
	end
	
	SpawnList = vgui.Create( "DListView", EditPanel )
	SpawnList:Dock( LEFT )
	SpawnList:DockMargin(5, 10, 5, 5)
	SpawnList:SetSize( main_w*0.45, 0)
	SpawnList:SetMultiSelect(false)
	SpawnList:AddColumn( "ID" )         :SetWidth(SpawnList:GetWide()*0.15)
	SpawnList:AddColumn( "Priorytet" )  :SetWidth(SpawnList:GetWide()*0.25)
	SpawnList:AddColumn( "Odległość" ) :SetWidth(SpawnList:GetWide()*0.3)
	SpawnList:AddColumn( "Specjalizacja" )  :SetWidth(SpawnList:GetWide()*0.3)
	SpawnList.OnRowSelected = function( lst, index, pnl )

		selected_spawn_id, selected_spawn_pnl = pnl:GetValue(1), pnl

		local jobtbl = spawn_table[selected_spawn_id].jobs
		AllowedJobs:Clear()
		for k, job in pairs(jobtbl) do
			AllowedJobs:AddLine( job )
		end

		PrioriryNum:SetValue(jobtbl.prio)
		AllowedJobs:SetVisible( true )
		ButtonsPanel:SetVisible( true )
		Button_Remove_Job:SetEnabled(false)
		Button_Delete_Spawn:SetEnabled(true)
		Button_Goto_Spawn:SetEnabled(true)
	end

	AllowedJobs = vgui.Create( "DListView", EditPanel )
	AllowedJobs:Dock( LEFT )
	AllowedJobs:DockMargin(5, 10, 5, 5)
	AllowedJobs:SetSize( main_w*0.15, 0)
	AllowedJobs:SetMultiSelect(false)
	AllowedJobs:AddColumn( "Specjalizacja" )
	AllowedJobs:SetVisible( false )
	AllowedJobs.OnRowSelected = function( lst, index, pnl )
		Button_Remove_Job:SetEnabled(true)
	end

	ButtonsPanel = vgui.Create( "DPanel", EditPanel )
	ButtonsPanel:Dock( LEFT )
	ButtonsPanel:DockMargin(5, 10, 5, 5)
	ButtonsPanel:SetSize( main_w*0.3, 0)
	ButtonsPanel:SetVisible( false )
	ButtonsPanel.Paint = function() end 

	Button_Add_Job = vgui.Create( "DButton", ButtonsPanel )
	Button_Add_Job:Dock( TOP )
	Button_Add_Job:DockMargin(5, 0, 0, 5)
	Button_Add_Job:SetIcon( "icon16/add.png" )
	Button_Add_Job:SetText( "Dodaj specjalizację" )
	Button_Add_Job.DoClick = function()
		local Dropmenu = vgui.Create( "DMenu", ButtonsPanel )
		local jobtbl = spawn_table[selected_spawn_id].jobs
		for k,job in pairs(re.jobs) do
			local id = job.jobID
			if not table.HasValue(jobtbl, id) then
				Dropmenu:AddOption(id, function()
					jobtbl[#jobtbl+1] = id
					SpawnList.OnRowSelected(nil, nil, selected_spawn_pnl)
				end)
			end
		end
		Button_Save_Jobs:SetEnabled(true)
	end

	Button_Remove_Job = vgui.Create( "DButton", ButtonsPanel )
	Button_Remove_Job:Dock( TOP )
	Button_Remove_Job:DockMargin(5, 0, 0, 5)
	Button_Remove_Job:SetIcon( "icon16/delete.png" )
	Button_Remove_Job:SetText( "Usuń specjalizację" )
	Button_Remove_Job.DoClick = function()
		local _, job = AllowedJobs:GetSelectedLine()
		job = job:GetValue(1)

		local jobtbl = spawn_table[selected_spawn_id].jobs
		table.RemoveByValue( jobtbl, job )

		SpawnList.OnRowSelected(nil, nil, selected_spawn_pnl)
		Button_Remove_Job:SetEnabled(false)
		Button_Save_Jobs:SetEnabled(true)
	end

	Button_Save_Jobs = vgui.Create( "DButton", ButtonsPanel )
	Button_Save_Jobs:Dock( BOTTOM )
	Button_Save_Jobs:DockMargin(5, 0, 0, 5)
	Button_Save_Jobs:SetSize( 0, 30 )
	Button_Save_Jobs:SetEnabled(false)
	Button_Save_Jobs:SetIcon( "icon16/disk.png" )
	Button_Save_Jobs:SetText( "Zapisz" )
	Button_Save_Jobs.DoClick = function()
		Button_Save_Jobs:SetEnabled(false)
		net.Start("SpawnPoints:UpdateSpawn")
			net.WriteUInt(selected_spawn_id, 32)
			net.WriteTable(spawn_table[selected_spawn_id])
		net.SendToServer()
	end

	local DLabel = vgui.Create( "DLabel", ButtonsPanel )
	DLabel:Dock( TOP )
	DLabel:DockMargin(5, 0, 0, 0)
	DLabel:SetText( "Priorytet: (od 0 do 100)" )

	PrioriryNum = vgui.Create("DNumberWang", ButtonsPanel)
	PrioriryNum:Dock( TOP )
	PrioriryNum:DockMargin(5, 0, 100, 5)
	PrioriryNum:SetSize(45, 26)
	PrioriryNum:SetMin(0)
	PrioriryNum:SetMax(100)
	PrioriryNum.OnValueChanged = function(self)
		spawn_table[selected_spawn_id].prio = self:GetValue()
		Button_Save_Jobs:SetEnabled(true)
	end

	local DLabel = vgui.Create( "DLabel", ButtonsPanel )
	DLabel:Dock( TOP )
	DLabel:DockMargin(5, 0, 0, 0)
	DLabel:SetWrap( true )
	DLabel:SetAutoStretchVertical(true)
	DLabel:SetText( "Gracze zawsze pojawiają się w losowym miejscu z najwyższym priorytetem." )

	Button_Goto_Spawn = vgui.Create( "DButton", ButtonsPanel )
	Button_Goto_Spawn:Dock( BOTTOM )
	Button_Goto_Spawn:DockMargin(5, 0, 0, 5)
	Button_Goto_Spawn:SetSize( 0, 30 )
	Button_Goto_Spawn:SetEnabled(false)
	Button_Goto_Spawn:SetIcon( "icon16/arrow_right.png" )
	Button_Goto_Spawn:SetText( "Teleportować się" )
	Button_Goto_Spawn.DoClick = function()
		net.Start("SpawnPoints:GotoSpawn")
			net.WriteUInt(selected_spawn_id, 32)
		net.SendToServer()
	end

	Button_Delete_Spawn = vgui.Create( "DButton", ButtonsPanel )
	Button_Delete_Spawn:Dock( BOTTOM )
	Button_Delete_Spawn:DockMargin(5, 0, 0, 5)
	Button_Delete_Spawn:SetSize( 0, 30 )
	Button_Delete_Spawn:SetEnabled(false)
	Button_Delete_Spawn:SetIcon( "icon16/cancel.png" )
	Button_Delete_Spawn:SetText( "Usuń punkt spawnu" )
	Button_Delete_Spawn.DoClick = function()
		Derma_Query(
		    "Czy na pewno chcesz bezpowrotnie usunąć punkt spawnu?",
		    "Usuwanie punktu spawnu "..selected_spawn_id,
		    "Usuń na zawsze",
		    function() 
		    	Button_Delete_Spawn:SetEnabled(false)
				net.Start("SpawnPoints:DeleteSpawn")
					net.WriteUInt(selected_spawn_id, 32)
				net.SendToServer()
				spawn_table[selected_spawn_id] = nil
				selected_spawn_id = nil
				net.Start("SpawnPoints:RefreshClientSpawns")
				net.SendToServer()
		    end,
			"Anuluj",
			function() end
		)
	end

	net.Start("SpawnPoints:RefreshClientSpawns")
	net.SendToServer()
end

net.Receive("SpawnPoints:RefreshClientSpawns", function()
	if not ispanel(SpawnList) then return end
	local tbl = net.ReadTable()
	spawn_table = tbl
	RefreshSpawnPoints()
end)



--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
