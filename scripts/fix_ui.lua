_G.StringUITable = {}

local function TranslateStringTable(text, data)
    for a,b in pairs(data) do
        if type(b) == "table" then
            TranslateStringTable(text.."."..a, b)
        else
            _G.StringUITable[data[a]] = t.PO[text.."."..a]
        end
    end
end

if Config.UI ~= "disable" then -- แปล UI ทั้งหมด
	TranslateStringTable("STRINGS.UI", STRINGS.UI)

	-- แปลหน้าสร้างโลก > ป่า > รูปแบบวัน
	_G.StringUITable["ยาวนาน ตอนเช้า"] = "ช่วงเช้ายาวนาน"
	_G.StringUITable["ยาวนาน ตอนพลบค่ำ"] = "ช่วงเย็นยาวนาน"
	_G.StringUITable["ยาวนาน ตอนกลางคืน"] = "กลางคืนยาวนาน"
	_G.StringUITable["ไม่มี ตอนเช้า"] = "ไม่มีช่วงเช้า"
	_G.StringUITable["ไม่มี ตอนพลบค่ำ"] = "ไม่มีช่วงเย็น"
	_G.StringUITable["ไม่มี ตอนกลางคืน"] = "ไม่มีกลางคืน"
	_G.StringUITable["แค่ ตอนเช้า"] = "ช่วงเช้าเท่านั้น"
	_G.StringUITable["แค่ ตอนพลบค่ำ"] = "ช่วงเย็นเท่านั้น"
	_G.StringUITable["แค่ ตอนกลางคืน"] = "กลางคืนเท่านั้น"
    
    -- โฆณาหน้าแรก
	_G.StringUITable["More Info!"] = "ข้อมูล!"

	local oldSetString = _G.TextWidget.SetString
	_G.TextWidget.SetString = function(guid, str)
		if type(str)=="string" then
			str = _G.StringUITable[str] or str
		end
		oldSetString(guid, str)
	end
end

if Config.CFG_OTHER_MOD ~= "disable" then -- แปลภาษามอดที่เปิดใช้งานอยู่
	local mod_enable = {}
	if _G.KnownModIndex and _G.KnownModIndex.savedata and _G.KnownModIndex.savedata.known_mods then
		for folder, mod in pairs(_G.KnownModIndex.savedata.known_mods) do
			local name = mod.modinfo.name
			if name then
				mod_enable[name] = true
			end
		end
	end
	
	local mod_main_do = {}
	mod_main_do["Minimap HUD Customizable"] = 842790123
	mod_main_do["Geometric Placement"] = 356043883
	mod_main_do["Item Info"] = 1800299402
	
	for k,v in pairs(mod_main_do) do
		if mod_enable[k] then
			modimport("scripts/mods/"..tostring(v)..".lua")
		end
	end
end
