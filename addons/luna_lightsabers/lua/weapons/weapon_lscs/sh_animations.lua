--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher


function SWEP:SetGestureTime( time )
	self:SetNWGestureTime( time )
	self.f_NextGesture = time
end

function SWEP:GetGestureTime()
	if SERVER then
		return self:GetNWGestureTime()
	else
		local ply = self:GetOwner()
		if IsValid( ply ) and ply == LocalPlayer() then
			return (self.f_NextGesture or 0)
		else
			return self:GetNWGestureTime()
		end
	end
end

function SWEP:PlayAnimation( anim, start )
	if not start then
		start = 0
	end

	local ply = self:GetOwner()

	if not IsValid( ply ) then return end

	if game.SinglePlayer() then

		ply:AddVCDSequenceToGestureSlot( GESTURE_SLOT_ATTACK_AND_RELOAD, ply:LookupSequence( anim ), start, true )

		return
	end

	ply.s_vcd_anim = anim

	if SERVER then
		net.Start( "lscs_animations" )
			net.WriteEntity( ply )
			net.WriteBool( true )
			net.WriteString( anim )
			net.WriteString( tostring(start) )
		net.Broadcast()
	end

	ply:AddVCDSequenceToGestureSlot( GESTURE_SLOT_ATTACK_AND_RELOAD, ply:LookupSequence( anim ), start, true )
end

function SWEP:StopAnimation()
	local ply = self:GetOwner()

	if not IsValid( ply ) then return end

	ply.s_vcd_anim = nil

	self:SetGestureTime( CurTime() )

	ply:AnimResetGestureSlot( GESTURE_SLOT_ATTACK_AND_RELOAD )
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
