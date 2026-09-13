hook.Add("ShowHelp", "ThirdpersonOpen", function(pPlayer)
    re.cmd.callback(pPlayer, "reg", {"thirdperson"})
end)

function GM:ShowHelp()
	
end