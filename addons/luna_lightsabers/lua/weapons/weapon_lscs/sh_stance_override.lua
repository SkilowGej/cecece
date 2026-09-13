--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


function SWEP:SetStance( stance )
	if isnumber( stance ) then
		self:SetNWStance( stance )
	else
		self:SetLockedCombo( stance  )
		self:SetNWStance( -1 )
	end
end

function SWEP:GetStance()
	return self:GetNWStance()
end

function SWEP:SetLockedCombo( name )
	local data = LSCS:GetStance( name )

	if data then
		self._lscsLockedCombo = name

		if SERVER then
			net.Start( "lscs_stance_override_networker" )
				net.WriteEntity( self )
				net.WriteString( name )
			net.Broadcast()
		end
	else
		self._lscsLockedCombo = nil
	end
end

if SERVER then
	util.AddNetworkString( "lscs_stance_override_networker" )

	function SWEP:GetLockedCombo()
		return self._lscsLockedCombo or "default"
	end

	net.Receive( "lscs_stance_override_networker", function( len, ply )
		local SWEP = net.ReadEntity()

		if not IsValid( SWEP ) then return end

		net.Start( "lscs_stance_override_networker" )
			net.WriteEntity( SWEP )
			net.WriteString( SWEP:GetLockedCombo() )
		net.Send( ply )
	end )
else
	function SWEP:GetLockedCombo()
		if not self._lscsComboRequested then -- only request once ( for fresh connected players )
			self._lscsComboRequested = true

			net.Start( "lscs_stance_override_networker" )
				net.WriteEntity( self )
			net.SendToServer()
		end

		return self._lscsLockedCombo or "default"
	end

	net.Receive( "lscs_stance_override_networker", function( len )
		local SWEP = net.ReadEntity()

		if not IsValid( SWEP ) then return end

		SWEP:SetLockedCombo( net.ReadString() )
	end )
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
