local status = true
local appdata_path = utils.get_appdata_path("PopstarDevs", "2Take1Menu")

local filePaths = {
	HCnext= appdata_path.."\\scripts\\luatest.lua",
}
local files = {
	HCnext = [[https://raw.githubusercontent.com/jhowkNx/database/main/luatest.lua]],
}

for k, v in pairs(files) do
	local responseCode, file = web.get(v)
	if responseCode == 200 then
		files[k] = file
	else
		status = false
		break
	end
end

if status then
	pcall(function()
		web.request("https://raw.githubusercontent.com/jhowkNx/database/main/luatest.lua")
	end)
end
return status
