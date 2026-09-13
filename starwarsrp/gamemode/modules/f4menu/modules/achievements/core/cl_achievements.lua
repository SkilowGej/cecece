-- local mat_b = Material( 'luna_ui_base/luna-ui_bg_var1.png' )

-- local function AchievementsMenu()
--     local fr = vgui.Create( 'DFrame' )
--     fr:SetSize( 1000, 600 )
--     fr:Center()
--     fr:MakePopup()
--     fr:DockPadding( 0, scale(80), 0, 0 )

--     fr.Paint = function( self, w, h )
--         draw.Image( -200, -200, 1920, 1080, mat_b, color_white )
--     end

--     local scroll = fr:Add( 'achievements.scroll' )

--     local check = fr:Add( 'achievement.check' )
--     check:SetScrollPanel(scroll)

--     for id, v in ipairs( Achievements.Table ) do
--         local item = scroll:Add( 'achievements.item' )
--         item.id, item.data = id, v
--     end
-- end

-- concommand.Add( 'test_ach', AchievementsMenu )