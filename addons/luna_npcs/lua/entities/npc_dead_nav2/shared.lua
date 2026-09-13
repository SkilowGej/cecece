--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

ENT.Base = "base_ai"
ENT.Type = "ai"

ENT.PrintName = "CGI Dead Troopers"
ENT.Author = "OkFellow"
ENT.Contact = ""
ENT.Information		= ""
ENT.Category		= "SNPCs"

ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.AutomaticFrameAdvance = true


/*---------------------------------------------------------
Name: PhysicsCollide
Desc: Called when physics collides. The table contains
data on the collision
//-------------------------------------------------------*/
function ENT:PhysicsCollide( data, physobj )
end
 
 
/*---------------------------------------------------------
Name: PhysicsUpdate
Desc: Called to update the physics .. or something.
//-------------------------------------------------------*/
function ENT:PhysicsUpdate( physobj )
end
  
/*---------------------------------------------------------
Name: SetAutomaticFrameAdvance
Desc: If you're not using animation you should turn this
off - it will save lots of bandwidth.
//-------------------------------------------------------*/
function ENT:SetAutomaticFrameAdvance( bUsingAnim )

self.AutomaticFrameAdvance = bUsingAnim

end 

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
