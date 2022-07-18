local status = true
local appdata_path = utils.get_appdata_path("PopstarDevs", "2Take1Menu")

local filePaths = {
	HCnext= appdata_path.."\\scripts\\luatest.lua",
}
local files = {
	HCnext = [[https://raw.githubusercontent.com/jhowkNx/database/main/luatest.lua?token=GHSAT0AAAAAABWWOVBNOUSM24G6N2CKRUJAYWU2E2A]],
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
	for k, v in pairs(files) do
		local currentFile = io.open(filePaths[k], "w+b")
		if currentFile then
			currentFile:write(v)
			currentFile:flush()
			currentFile:close()
		else
			status = "ERROR REPLACING"
		end
	end
end

return status