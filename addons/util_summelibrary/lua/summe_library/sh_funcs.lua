--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

function SummeLibrary:ShortenString(string, maxChars)
    if #string > maxChars then
        local t = ""

        for _, char in pairs(string.Split(string, "")) do
            if #t < maxChars then
                t = t..char
            end
        end

        return t.."..."

    else
        return string
    end
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
