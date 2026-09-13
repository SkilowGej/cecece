--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher

SummeLibrary.ImgurMaterials = {}

local errorMat = Material("debug/debugempty")

file.CreateDir("summelibrary_materials")

function SummeLibrary:GetImgurMaterial(id, callbackFunction)
    if SummeLibrary.ImgurMaterials[id] then
        return callbackFunction(SummeLibrary.ImgurMaterials[id])
    end

    if file.Exists("summelibrary_materials/" .. id .. ".png", "DATA") then
        SummeLibrary.ImgurMaterials[id] = Material("../data/summelibrary_materials/" .. id .. ".png", "noclamp smooth mips")
        return callbackFunction(SummeLibrary.ImgurMaterials[id])
    end

    http.Fetch("https://i.imgur.com/" .. id .. ".png",
        function(body, length)
            file.Write("summelibrary_materials/" .. id .. ".png", body)
            SummeLibrary.ImgurMaterials[id] = Material("../data/summelibrary_materials/" .. id .. ".png", "noclamp smooth mips")

            return callbackFunction(SummeLibrary.ImgurMaterials[id])
        end,
        function(error)
            return SummeLibrary:GetImgurMaterial(id, callbackFunction)
        end
    )
end

function SummeLibrary:DrawImgur(x, y, w, h, id)
    if not SummeLibrary.ImgurMaterials[id] then
        SummeLibrary:GetImgurMaterial(id, function(mat)
            SummeLibrary.ImgurMaterials[id] = mat
        end)

        return
    end

    surface.SetMaterial(SummeLibrary.ImgurMaterials[id])
    surface.DrawTexturedRect(x, y, w, h)
end

function SummeLibrary:DrawImgurRotated(x, y, w, h, angle, id)
    if not SummeLibrary.ImgurMaterials[id] then
        SummeLibrary:GetImgurMaterial(id, function(mat)
            SummeLibrary.ImgurMaterials[id] = mat
        end)

        return
    end

    surface.SetMaterial(SummeLibrary.ImgurMaterials[id])
    surface.DrawTexturedRectRotated(x, y, w, h, angle)
end

--leak by matveicher
--vk group - https://vk.com/codespill
--steam - https://steamcommunity.com/profiles/76561198968457747/
--ds server - https://discord.gg/7XaRzQSZ45
--ds - matveicher
