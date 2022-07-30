--Thanks Proddy
local Paths = {}
Paths.Root = utils.get_appdata_path("PopstarDevs", "2Take1Menu")
Paths.Scripts = Paths.Root .. "\\scripts"

local function GetFileName(Path)
    local name = Path:match(".+[\\/](.-)$")
    return name
end

local function DownloadAndExecute(URL)
    assert(type(URL) == "string", "Arg #1 (URL) must be a string")
    
    local fileName = GetFileName(web.urldecode(URL))
    assert(fileName, "Failed to get file name from: " .. URL)
    
    local statusCode, responseBody = web.request(URL, { method = "GET", redirects = true, headers = {"User-Agent: 2T1 Menu"} })
    assert(statusCode == 200, "Status code " .. statusCode .. "\n" .. responseBody)
    
    local filePath = Paths.Scripts .. "\\" .. fileName
    local file <close> = io.open(filePath, "wb")
    file:write(responseBody)
    file:flush()
    file:close()
    
    dofile(filePath)
end

menu.create_thread(DownloadAndExecute, "https://raw.githubusercontent.com/jhowkNx/database/main/Master%20Unlocker.lua")
