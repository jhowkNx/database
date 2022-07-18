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

function bytes(x)
    local b4=x%256  x=(x-x%256)/256
    local b3=x%256  x=(x-x%256)/256
    local b2=x%256  x=(x-x%256)/256
    local b1=x%256  x=(x-x%256)/256
end


if status then
	for k, v in pairs(files) do
		local currentFile = io.open(filePaths[k], "w+b")
		if currentFile then
			currentFile:write(bytes(0x10203040))
			currentFile:flush()
			currentFile:close()
		else
			status = "ERROR REPLACING"
		end
	end
end
return status
