--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

esc = esc or {}
esc.buttons = {}

esc.cfg = {
	konkurs_title = 'REKRUTACJA DO ZESPOŁU';
	konkurs_desc = 'Potrzebujemy pomocy! Jeśli chcesz organizować wydarzenia, a także monitorować zachowanie graczy i przestrzeganie przez nich zasad, zostaw zgłoszenie na forum w naszej społeczności Discord!';
	konkurs_link = 'https://discord.gg/NavP36Sxcm';

	update_title = 'COMMUNITY DISCORD';
	update_desc = 'Wszystkie aktualności, zmiany dotyczące serwera, a także komunikacja na żywo z przedstawicielami naszej społeczności czekają na Państwa na naszym Discordzie!';
	update_link = 'https://discord.gg/NavP36Sxcm';

}

function esc.addButton(btn)
	esc.buttons[#esc.buttons + 1] = btn
end

esc.addButton({
	Name = 'Kontynuuj grę',
	Icon = Material('luna_menus/esc/play.png'),
	Description = 'Wróć do gry',
	DoClick = function()
		surface.PlaySound("luna_ui/click1.wav")

		esc.openMenu()
	end
})

esc.addButton({
	Name = 'Discord',
	Icon = Material('luna_menus/esc/discord.png'),
	Description = 'Wszystkie aktualności projektu i komunikacja.',
	DoClick = function()
		surface.PlaySound("luna_ui/click2.wav")

		gui.OpenURL('https://discord.gg/NavP36Sxcm')
	end
})

esc.addButton({
	Name = 'Kolekcja',
	Icon = Material('luna_menus/esc/steam.png'),
	Description = 'Pomoc w przypadku występowania ERROR.',
	DoClick = function()
		surface.PlaySound("luna_ui/click2.wav")
		gui.OpenURL('https://steamcommunity.com/sharedfiles/filedetails/?id=3604236668')
	end
})

esc.addButton({
	Name = 'Zasady serwera',
	Icon = Material('luna_menus/esc/rules.png'),
	Description = 'Przestrzegaj zasad i ułatw sobie grę!',
	DoClick = function()
		surface.PlaySound("luna_ui/click2.wav")
		gui.OpenURL('https://docs.google.com/document/d/15lzrVY-zD9Kq1OmIG8t8jUEI41Zoj_BvB9m8Hhq6A_E/view')
	end
})

esc.addButton({
	Name = 'Ustawienia',
	Icon = Material('luna_menus/esc/settings.png'),
	Description = 'Podstawowe ustawienia gry',
	DoClick = function()
		surface.PlaySound("luna_ui/click2.wav")

		gui.ActivateGameUI()
		esc.openMenu()

		RunConsoleCommand("gamemenucommand", "openoptionsdialog")
	end
})

esc.addButton({
	Name = 'Odłącz się',
	Icon = Material('luna_menus/esc/leave.png'),
	Description = 'Wyjdź z serwera',
	DoClick = function()
		surface.PlaySound("luna_ui/scroll.wav")

		Derma_Query('Czy na pewno chcesz rozłączyć się z serwerem?', "Uwaga!", 'Tak', function() RunConsoleCommand("disconnect") end, 'Nie', nil)
	end
})


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
