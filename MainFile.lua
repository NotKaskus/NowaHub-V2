while not game:IsLoaded() or not game:GetService("CoreGui") or not game:GetService("Players").LocalPlayer or not game:GetService("Players").LocalPlayer.PlayerGui do wait() end

local queueteleport = syn and syn.queue_on_teleport or queue_on_teleport or fluxus and fluxus.queue_on_teleport or function() end
local requestfunc = syn and syn.request or http and http.request or http_request or fluxus and fluxus.request or request or function(tab)
	if tab.Method == "GET" then
		return {
			Body = game:HttpGet(tab.Url, true),
			Headers = {},
			StatusCode = 200
		}
	else
		return {
			Body = "Trash exploit, buy synapse x bru",
			Headers = {},
			StatusCode = 404
		}
	end
end 

function init()
	if not (requestfunc and queueteleport) then
		print("Vape not supported with your exploit.")
		return
	end

	if getgenv().NowaExecuted then
		error("NowaHub is already injected!")
		return
	else
		getgenv().NowaExecuted = true
	end

	local nowaRepo = 'https://raw.githubusercontent.com/NotKaskus/NowaHub-V2/main/'
	local SupportedGames = {
		["DDay"] = 901793731
	}

	local function GetURL(scripturl)
		local res = game:HttpGet(nowaRepo .. scripturl, true)
		return res
	end

	function SupportedGame(table, gameId)
	for _, value in pairs(table) do
		if value == gameId then
		return true
		end
	end
	return false
	end

	function doshit()
		if SupportedGame(SupportedGames, game.PlaceId) == false then
			loadstring(GetURL('Games/Universal.lua'))()
		else
			loadstring(GetURL('Games/' ..  game.PlaceId .. '.lua'))()
		end
	end
	doshit()
end

init()
