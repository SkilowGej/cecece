local cfg = GameMenu.cfg
local LOOK_AT, CAMPOS, ANGLE_DEFAULT = Vector(5, 0, 57), Vector(110, 50, 70), Angle(0, 0, 0)
local direct_light, ambient_light = Color(220, 190, 100), Color(10, 15, 50)
local PANEL = {}
function PANEL:Init()
    local p, parent = LocalPlayer(), self:GetParent()
    self:SetSize(parent:GetWide() * .4, parent:GetTall() * .9)
    self:SetPos(parent:GetWide() - self:GetWide(), parent:GetTall() - self:GetTall())
    self:SetLookAt(LOOK_AT)
    self:SetCamPos(CAMPOS)
    self:SetFOV(scale(15))
    local model = p:GetModel()
    self:SetModel(model or 'models/sup/vrpm/eng/eng.mdl')
    self:SetAmbientLight(ambient_light)
    self:SetDirectionalLight(BOX_TOP, direct_light)
    self.Angles = ANGLE_DEFAULT
end

function PANEL:DragMousePress()
    self.PressX, self.PressY = gui.MousePos()
    self.Pressed = true
end

function PANEL:DragMouseRelease()
    self.Pressed = false
end

function PANEL:LayoutEntity(ent)
    if self.Pressed then
        local mx, my = gui.MousePos()
        self.Angles = self.Angles - Angle(0, (self.PressX or mx) - mx, 0)
        self.PressX, self.PressY = gui.MousePos()
    end

    ent:SetAngles(self.Angles)
end

vgui.Register('gm.modelpanel', PANEL, 'DModelPanel')