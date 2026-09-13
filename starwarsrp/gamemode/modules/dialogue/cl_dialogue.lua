re.dialogue = re.dialogue or {}

function re.dialogue.CreateMenu(did, npc)
	gradient = vgui.Create("MGradient")
	gradient:SetPos(0,0)
	gradient:SetSize(ScrW(), ScrH())
	gradient:SetAlpha(0)
	gradient:AlphaTo(255, .4)

	gradient.diag = vgui.Create("MDialogue", gradient)
	gradient.diag.npc = npc
	gradient.diag:SetDialogue(did)
end

function re.dialogue.SendOnClick(id, treeid, optionid, npc)
	print(id, treeid, optionid, npc)
	net.Start("re.dialogue.SendOnClick")
		net.WriteEntity(npc)
		net.WriteString(id)
		net.WriteUInt(treeid, 8)
		net.WriteUInt(optionid, 8)
	net.SendToServer()
end

net.Receive("re.dialogue.Open", function()
	re.dialogue.CreateMenu(net.ReadString(), net.ReadEntity())
end)