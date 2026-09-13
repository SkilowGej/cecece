--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

--[[--------------------------------------------------------------------------
-- 	Namespace Tables
--------------------------------------------------------------------------]]--

local PANEL = {}

--[[--------------------------------------------------------------------------
--	Namespace Functions
--------------------------------------------------------------------------]]--

--[[--------------------------------------------------------------------------
--
--	PANEL:OpenPresetEditor()
--
--]]--
function PANEL:OpenPresetEditor()
	if ( not self.m_strPreset ) then return end
	self.Window = vgui.Create( "StackerPresetEditor" )
	self.Window:MakePopup()
	self.Window:Center()
	self.Window:SetType( self.m_strPreset )
	self.Window:SetConVars( self.ConVars )
	self.Window:SetPresetControl( self )
end

vgui.Register( "StackerControlPresets", PANEL, "ControlPresets" )

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
