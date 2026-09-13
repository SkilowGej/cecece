--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

PS.Config = {}

-- Edit below

PS.Config.CommunityName = "Piwnica Granie"

PS.Config.DataProvider = 'pdata'

PS.Config.Branch = 'https://raw.github.com/adamdburton/pointshop/master/' -- Master is most stable, used for version checking.
PS.Config.CheckVersion = false -- Do you want to be notified when a new version of Pointshop is avaliable?

PS.Config.ShopKey = KEY_F2 -- Any Uppercase key or blank to disable
PS.Config.ShopCommand = 'ps' -- Console command to open the shop, set to blank to disable
PS.Config.ShopChatCommand = 'ps' -- Chat command to open the shop, set to blank to disable

PS.Config.NotifyOnJoin = false -- Should players be notified about opening the shop when they spawn?

PS.Config.PointsOverTime = false -- Should players be given points over time?
PS.Config.PointsOverTimeDelay = 20 -- If so, how many minutes apart?
PS.Config.PointsOverTimeAmount = 300 -- And if so, how many points to give after the time?

PS.Config.AdminCanAccessAdminTab = false -- Can Admins access the Admin tab?
PS.Config.SuperAdminCanAccessAdminTab = true -- Can SuperAdmins access the Admin tab?

PS.Config.CanPlayersGivePoints = true -- Can players give points away to other players?
PS.Config.DisplayPreviewInMenu = true -- Can players see the preview of their items in the menu?

PS.Config.PointsName = 'KR' -- What are the points called?
PS.Config.SortItemsBy = 'Name' -- How are items sorted? Set to 'Price' to sort by price.

-- Edit below if you know what you're doing

PS.Config.CalculateBuyPrice = function(ply, item)
	-- You can do different calculations here to return how much an item should cost to buy.
	-- There are a few examples below, uncomment them to use them.

	-- Everything half price for admins:
	-- if ply:IsAdmin() then return math.Round(item.Price * 0.5) end

	-- 25% off for the 'donators' group
	-- if ply:IsUserGroup('donators') then return math.Round(item.Price * 0.75) end

	return item.Price
end

PS.Config.CalculateSellPrice = function(ply, item)
	return math.Round(item.Price * 0.25) -- 25% or 3/4 (rounded) of the original item price
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
