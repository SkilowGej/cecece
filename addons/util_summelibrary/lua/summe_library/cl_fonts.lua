--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

function SummeLibrary:CreateFont(name, size, weight, italic)
    local tbl = {
		font = "Mont Bold",
		size = size + 2,
		weight = weight or 500,
		extended = true,
		italic = italic or false,
	}

    surface.CreateFont(name, tbl)

	return name
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
