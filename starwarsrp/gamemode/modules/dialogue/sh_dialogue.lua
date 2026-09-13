re.dialogue = re.dialogue or {}
re.dialogue.data = re.dialogue.data or {}

local notUsed = function(id, data)
	chat.AddText(col.red, "Dialogue not implemented!")
	return false
end

function re.dialogue.FindByID(id)
	for k, v in pairs(re.dialogue.data) do
		if (v.id and v.id:lower() == id:lower()) then
			return v, k
		end
	end
	return nil
end

function re.dialogue.Register(dialogue)
	re.dialogue.data[dialogue.id] = dialogue
	_G["DIALOGUE_" .. dialogue.id:upper()] = dialogue.id
end

re.dialogue.Register({
	id = "driver",
	CanUse = function()
		return true
	end,
	tree = {
		{
			speech = "Witam! Nazywam się Mugi i jestem oficerem. Moim zadaniem jest monitorowanie stanu sprzętu, wysyłanie go do naprawy, a także wydawanie sprzętu na pierwsze żądanie autoryzowanym użytkownikom. Czego sobie życzysz?",
			options = {
				{
					text = "Potrzebuję wezwać technika",
					close = true,
					OnClick = function(self, pl, npc)
						if not SERVER then return end

						netstream.Start(pl,"Driver_OpenMenu",nil)
						-- net.Start("Job.OpenMenu")
						-- 	net.WriteString(npc:GetJobName())
						-- net.Send(pl)
					end
				},
				{
					text = "Opowiedz mi więcej o technice i pilotażu.",
					moveto = 2
				},
				{
					text = "Zmieniłem zdanie, do widzenia!",
					close = true,
				}
			}
		},
		{
			speech = "Zasadniczo nasz park technologiczny w bazie „Arkanatura” jest bardzo skromny, co wynika z faktu, że znajdujemy się daleko od głównych szlaków logistycznych WAR. Problemy stwarzają również blokady separatystów, które utrudniają dostawy zaopatrzenia poza głównymi szlakami transportowymi. Możemy zapewnić naprawę, ale nie zawsze będzie ona idealna, ponieważ nie zawsze mamy wszystkie potrzebne części. Do usług.",
			options = {
				-- {
				-- 	text = "Да",
				-- 	close = true,
				-- 	OnClick = function(self, pl)

				-- 	end
				-- },
				{
					text = "Zrozumiałem!",
					moveto = 1
				}
			}
		}
	}
})

re.dialogue.Register({
	id = "skills",
	CanUse = function()
		return true
	end,
	tree = {
		{
			speech = "Witam, mój kod cybernetyczny to M-21, ale możecie nazywać mnie po prostu „Personalizator”. Specjalizuję się w poprawianiu cech osobistych i rozwijaniu umiejętności. Niezależnie od tego, czy chodzi o poprawę kondycji fizycznej, rozwój umiejętności przywódczych czy zwiększenie pewności siebie – zawsze chętnie służę pomocą. Powiedz mi, jakie zmiany Cię interesują, a pomogę Ci wybrać najbardziej odpowiednie opcje.",
			options = {
				{
					text = "Zobaczmy, co masz...",
					close = true,
					OnClick = function(self, pl, npc)
						if not SERVER then return end

						OpenSkillsMenu(pl)
					end
				},
				{
					text = "Za pomocą czego jest to możliwe?",
					moveto = 2
				},
				{
					text = "Zmieniłem zdanie, do widzenia!",
					close = true,
				}
			}
		},
		{
			speech = "Wykorzystuję technologię implantacji, aby poprawić Twoje umiejętności. Jestem w stanie przeprowadzić operację wszczepienia podskórnych mikrochipów, które poprawią Twoją reakcję, szybkość, siłę i inne aspekty. Każdy mikrochip został specjalnie zaprojektowany w celu wzmocnienia konkretnej zdolności.",
			options = {
				{
					text = "Chcę rozwijać swoje umiejętności.",
					close = true,
					OnClick = function(self, pl, npc)
						if not SERVER then return end

						OpenSkillsMenu(pl)
					end
				},
				{
					text = "Zrozumiałem!",
					moveto = 1
				}
			}
		}
	}
})