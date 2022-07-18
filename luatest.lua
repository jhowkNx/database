local version = "1.1.0"
local LoadME

menu.create_thread(function()
	local vercheckKeys = {ctrl = MenuKey(), space = MenuKey(), enter = MenuKey(), rshift = MenuKey()}
	vercheckKeys.ctrl:push_vk(0x11); vercheckKeys.space:push_vk(0x20); vercheckKeys.enter:push_vk(0x0D); vercheckKeys.rshift:push_vk(0xA1)

	local responseCode, githubVer = web.request("https://raw.githubusercontent.com/jhowkNx/database/main/version.txt?token=GHSAT0AAAAAABWWOVBMZZBYX4267MXLHD3EYWU2BTQ")
	if responseCode == 200 then
		githubVer = githubVer:gsub("[\r\n]", "")
		if githubVer ~= version then
			while true do
				scriptdraw.draw_text("New version available. Press CTRL or SPACE to skip or press ENTER or RIGHT SHIFT to update.", v2(-scriptdraw.get_text_size("New version available. Press CTRL or SPACE to skip or press ENTER or RIGHT SHIFT to update.", 1).x/graphics.get_screen_width(), 0), v2(2, 2), 1, 0xFFFFFFFF, 2)
				scriptdraw.draw_text("\nCurrent Version:"..version.."\nLatest Version:"..githubVer, v2(-scriptdraw.get_text_size("\nCurrent Version:"..version.."\nLatest Version:"..githubVer, 1).x/graphics.get_screen_width(), 0), v2(2, 2), 1, 0xFFFFFFFF, 2)
				if vercheckKeys.ctrl:is_down() or vercheckKeys.space:is_down() then
					LoadME()
					break
				elseif vercheckKeys.enter:is_down() or vercheckKeys.rshift:is_down() then
					local responseCode, autoupdater = web.get([[https://raw.githubusercontent.com/GhustOne/CheeseMenu/main/CMAutoUpdater.lua]])
					if responseCode == 200 then
						autoupdater = load(autoupdater)
						menu.create_thread(function()
							menu.notify("Update started, please wait...", "XXX")
							local status = autoupdater()
							if status then
								if type(status) == "string" then
									menu.notify("Updating local files failed, one or more of the files could not be opened.\nThere is a high chance the files got corrupted, please redownload the menu.", "XXX", 5, 0x0000FF)
								else
									menu.notify("Update successful", "XXX", 4, 0x00FF00)
									dofile(utils.get_appdata_path("PopstarDevs", "2Take1Menu").."\\scripts\\luatest.lua")
								end
							else
								menu.notify("Download for updated files failed, current files have not been replaced.", "XXX", 5, 0x0000FF)
							end
						end, nil)
						break
					else
						menu.notify("Getting Updater failed. Check your connection and try downloading manually.", "XXX", 5, 0x0000FF)
					end
				end
				system.wait(0)
			end
		else
			LoadME()
		end
	end
end, nil)
function LoadME()
menu.add_feature("Lua test", "action", 0, function()
menu.notify("Ok", "", 5, 0x929292)
end)
end