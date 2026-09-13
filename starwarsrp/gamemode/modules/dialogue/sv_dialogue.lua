util.AddNetworkString("re.dialogue.Open")
util.AddNetworkString("re.dialogue.SendOnClick")

net.Receive("re.dialogue.SendOnClick", function(len, pl)
	local npc = net.ReadEntity()

	if npc:GetPos():Distance(pl:GetPos()) > 128^2 then return end

	local diaid = net.ReadString()
	local treeid = net.ReadUInt(8)
	local optionid = net.ReadUInt(8)

	local dialogue = re.dialogue.data[diaid] or nil
	if not dialogue then
		return
	end

	local tree = dialogue.tree[treeid]
	if not tree then
		return
	end

	local option = tree.options[optionid]
	if not option then
		return
	end

	option.OnClick(dialogue, pl, npc, treeid, option)
end)