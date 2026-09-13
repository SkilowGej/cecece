if SERVER then
	function re.util.Notify(type, target, ...)
		ChatAddText(target, NOTIFY_TYPES[type], '['..os.date(NOTIFY_DATE_FORMAT , os.time())..'] ', color_white, ...)
	end
else
	function re.util.Notify(type, ...)
		chat.AddText(NOTIFY_TYPES[type], '['..os.date(NOTIFY_DATE_FORMAT , os.time())..'] ', color_white, ...)
	end
end

function re.util.NotifyAll(type, ...)
	ChatAddTextAll(NOTIFY_TYPES[type], '['..os.date(NOTIFY_DATE_FORMAT , os.time())..'] ', color_white, ...)
end
