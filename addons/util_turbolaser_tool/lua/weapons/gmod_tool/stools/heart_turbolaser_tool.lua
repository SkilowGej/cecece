--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

TOOL.Category = "SUP • tools"
TOOL.Name = "Turbolaser";
TOOL.Command = nil;
TOOL.ConfigName	= "";
TOOL.AdminOnly = true;

if CLIENT then
	language.Add( "tool.heart_turbolaser_tool.name", "Heart Turbolaser Tool" );
	language.Add( "Tool.heart_turbolaser_tool.desc", "Shoot turbolasers." );
	language.Add( "Tool.heart_turbolaser_tool.left", "Shoot a turbolaser from the sky to where you are aiming.");
	language.Add( "Tool.heart_turbolaser_tool.right", "Shoot a turbolaser from the toolgun.");
	language.Add( "Tool.heart_turbolaser_tool.reload", "Creates a turbolaser spawner at your location.");
end

TOOL.Information = {
	{ name = "left" },
	{ name = "right" },
	{ name = "reload"}
}

// turbolaser options
TOOL.ClientConVar["speed"] = 1000;
TOOL.ClientConVar["damage"] = 1000;
TOOL.ClientConVar["radius"] = 150;
TOOL.ClientConVar["scale"] = 1.0;

TOOL.ClientConVar["r"] = 255;
TOOL.ClientConVar["g"] = 0;
TOOL.ClientConVar["b"] = 0;

// spawner options
TOOL.ClientConVar["shots"] = 3;
TOOL.ClientConVar["delay"] = 0.5;
TOOL.ClientConVar["spread"] = 0;

local defaultCV = TOOL:BuildConVarList();

function TOOL:VerifyValues()
	local speed = self:GetClientNumber("speed");
	local damage = self:GetClientNumber("damage");
	local radius = self:GetClientNumber("radius");
	local scale = self:GetClientNumber("scale");

	local shots = self:GetClientNumber("shots");
	local delay = self:GetClientNumber("delay");
	local spread = self:GetClientNumber("spread");

	local r = self:GetClientNumber("r");
	local g = self:GetClientNumber("g");
	local b = self:GetClientNumber("b");

	if speed <= 0 then return false end
	if damage < 0 then return false end
	if radius < 0 then return false end
	if scale < 0 then return false end

	if shots <= 0 then return false end
	if delay < 0 then return false end
	if spread < 0 then return false end

	if r < 0 || r > 255 then return false end
	if g < 0 || g > 255 then return false end
	if b < 0 || b > 255 then return false end

	return true;
end

// summon turbolaser function
function TOOL:Turbolaser()
	if CLIENT then return end

	if not self:VerifyValues() then return end

	local speed = self:GetClientNumber("speed");
	local damage = self:GetClientNumber("damage");
	local radius = self:GetClientNumber("radius");
	local scale = self:GetClientNumber("scale");

	local r = self:GetClientNumber("r");
	local g = self:GetClientNumber("g");
	local b = self:GetClientNumber("b");

	local laser = ents.Create("heart_turbolaser");
	laser:SetVar("speed", speed);
	laser:SetVar("damage", damage);
	laser:SetVar("radius", radius);

	laser:SetVar("scale", scale);
	laser:SetVar("r", r);
	laser:SetVar("g", g);
	laser:SetVar("b", b);

	return true, laser;
end

// shoot from sky
function TOOL:LeftClick(trace)
	if CLIENT then return end

	local spawned, laser = self:Turbolaser();

	if not spawned then return end

	local ply = self:GetOwner();

	laser:SetOwner(ply);
	laser:SetPos(trace.HitPos + Vector(0,0,5000));
	laser:SetAngles(Angle(90,0,0));

	laser:Spawn();
	laser:Activate();

	undo.Create("Turbolaser");
	undo.AddEntity(laser);
	undo.SetPlayer(ply);
	undo.SetCustomUndoText("Undone Turbolaser");
	undo.Finish();

	return false;
end

// shoot from face
function TOOL:RightClick()
	if CLIENT then return end

	local spawned, laser = self:Turbolaser();

	if not spawned then return end

	local ply = self:GetOwner();

	laser:SetOwner(ply);
	laser:SetPos(ply:GetShootPos());
	laser:SetAngles(ply:GetAngles());

	laser:Spawn();
	laser:Activate();

	undo.Create("Turbolaser");
	undo.AddEntity(laser);
	undo.SetPlayer(ply);
	undo.SetCustomUndoText("Undone Turbolaser");
	undo.Finish();

	return false;
end

// spawner from face
function TOOL:Reload()
	if CLIENT then return end;

	if not self:VerifyValues() then return end

	local ply = self:GetOwner();

	local speed = self:GetClientNumber("speed");
	local damage = self:GetClientNumber("damage");
	local radius = self:GetClientNumber("radius");
	local scale = self:GetClientNumber("scale");

	local shots = self:GetClientNumber("shots");
	local delay = self:GetClientNumber("delay");
	local spread = self:GetClientNumber("spread");

	local r = self:GetClientNumber("r");
	local g = self:GetClientNumber("g");
	local b = self:GetClientNumber("b");

	local spawner = ents.Create("heart_turbolaser_spawner");

	spawner:SetOwner(ply);
	spawner:SetPos(self:GetOwner():GetShootPos());
	spawner:SetAngles(self:GetOwner():GetAngles());

	spawner:SetVar("speed", speed);
	spawner:SetVar("damage", damage);
	spawner:SetVar("radius", radius);

	spawner:SetVar("shots", shots);
	spawner:SetVar("delay", delay);
	spawner:SetVar("spread", spread);

	spawner:SetVar("scale", scale);
	spawner:SetVar("r", r);
	spawner:SetVar("g", g);
	spawner:SetVar("b", b);

	spawner:Spawn();
	spawner:Activate();

	undo.Create("Spawner");
	undo.AddEntity(spawner);
	undo.SetPlayer(ply);
	undo.SetCustomUndoText("Undone Turbolaser Spawner");
	undo.Finish();

	print("undo ready")
end

function TOOL.BuildCPanel(panel)
	panel:SetName("Heart Turbolaser Tool")

	local header = vgui.Create("DImage");
	header:SetImage("materials/heart/turbolaser_header.png");
	header:SetSize(305, 140);
	panel:AddItem(header);

	panel:Help("Version 1.0")

	panel:AddControl( "ComboBox", { MenuButton = 1, Folder = "heart_turbolaser", Options = { [ "#preset.default" ] = defaultCV }, CVars = table.GetKeys( defaultCV ) } );

	panel:ControlHelp("");

	local divider1 = vgui.Create("DImage");
	divider1:SetImage("materials/heart/turbolaser_divider1.png");
	divider1:SetSize(305, 16);
	panel:AddItem(divider1);

	panel:NumSlider("Speed","heart_turbolaser_tool_speed","1","10000","0");
	panel:ControlHelp("Sets the speed of the turbolaser.");

	panel:NumSlider("Damage","heart_turbolaser_tool_damage","0","10000","0");
	panel:ControlHelp("Sets the damage of the turbolaser explosion.");

	panel:NumSlider("Explosion Radius","heart_turbolaser_tool_radius","10","1000","0");
	panel:ControlHelp("Sets the radius of the turbolasers explosion.");

	panel:NumSlider("Scale","heart_turbolaser_tool_scale","0.1","2","2");
	panel:ControlHelp("Sets the scale of the turbolaser model.");

	panel:ControlHelp("");

	local colorMixer = vgui.Create("DColorMixer")
	colorMixer:SetPalette(false)
	colorMixer:SetAlphaBar(false)
	colorMixer:SetWangs(true)
	colorMixer:SetConVarR("heart_turbolaser_tool_r")
	colorMixer:SetConVarG("heart_turbolaser_tool_g")
	colorMixer:SetConVarB("heart_turbolaser_tool_b")
	colorMixer:SetLabel("Turbolaser Color")
	panel:AddItem(colorMixer)

	panel:ControlHelp("Color of the Turbolaser");
	panel:ControlHelp("");

	local divider2 = vgui.Create("DImage");
	divider2:SetImage("materials/heart/turbolaser_divider2.png");
	divider2:SetSize(305, 16);
	panel:AddItem(divider2);

	panel:NumSlider("Number of Shots","heart_turbolaser_tool_shots","1","10000","0");
	panel:ControlHelp("Sets the number of shots for the turbolaser spawner.");

	panel:NumSlider("Delay between Shots","heart_turbolaser_tool_delay","0.1","5","1");
	panel:ControlHelp("Sets the delay between shots for the turbolaser spawner. (In seconds)");

	panel:NumSlider("Spread","heart_turbolaser_tool_spread","0","10","1");
	panel:ControlHelp("Sets the spread of the turbolasers spawned from the turbolaser spawner.");

	panel:ControlHelp("");
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
