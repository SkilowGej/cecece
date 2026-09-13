--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

function MEDIAPLAYER:GetSnapshot()
	local queue = table.Copy( self:GetMediaQueue() )
	local media = self:GetMedia()

	return {
		media = media,
		currentTime = media and media:CurrentTime(),
		queue = queue,
		queueRepeat = self:GetQueueRepeat(),
		queueShuffle = self:GetQueueShuffle(),
		queueLocked = self:GetQueueLocked()
	}
end

function MEDIAPLAYER:RestoreSnapshot( snapshot )
	self._Queue = {}

	self:SetQueueRepeat( snapshot.queueRepeat )
	self:SetQueueShuffle( snapshot.queueShuffle )
	self:SetQueueLocked( snapshot.queueLocked )

	if snapshot.media then
		-- restore currently playing media from where it left off
		local mediaSnapshot = snapshot.media
		local media = MediaPlayer.GetMediaForUrl( mediaSnapshot.url )
		if media then
			table.Merge( media, mediaSnapshot )
			media:StartTime( RealTime() - snapshot.currentTime )
			self:SetMedia( media )
		end
	else
		self:SetMedia( nil )
	end

	if snapshot.queue then
		-- restore queue
		for _, mediaSnapshot in ipairs( snapshot.queue ) do
			local media = MediaPlayer.GetMediaForUrl( mediaSnapshot.url )
			if media then
				table.Merge( media, mediaSnapshot )
				self:AddMedia( media )
			end
		end

		self:QueueUpdated()
	end
end


--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
