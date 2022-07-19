_G = GLOBAL
rawget = _G.rawget
mods=_G.rawget(_G,"mods") or (function() local m={}_G.rawset (_G,"mods",m) return m end)()
mods.ThaiLanguagePack = {}
t = mods.ThaiLanguagePack
t.SelectedLanguage = "th"
TheSim = _G.TheSim
STRINGS = _G.STRINGS
tostring = _G.tostring
require = _G.require

modimport("scripts/utility.lua")

if GetModConfigData("DISABLE_MOD_WARNING") then -- ข้ามหน้าการแจ้งเตือนมอด
	_G.getmetatable(TheSim).__index.ShouldWarnModsLoaded = function() return false end
end

Config = {}
Config.UI = GetModConfigData("CFG_UI")
Config.CON = GetModConfigData("CFG_CON")
Config.ITEM = GetModConfigData("CFG_ITEM")
Config.CFG_ITEM_TWO = GetModConfigData("CFG_ITEM_TWO")

function ApplyLocalizedFonts()
    local ThaiFontsFileNames = {
        "talkingfont__th.zip",
        "stint-ucr50__th.zip",
        "stint-ucr20__th.zip",
        "opensans50__th.zip",
        "belisaplumilla50__th.zip",
        "belisaplumilla100__th.zip",
        "buttonfont__th.zip"
    }
    if _G.rawget(_G, "TALKINGFONT_WATHGRITHR") then
        table.insert(ThaiFontsFileNames, "talkingfont_wathgrithr__th.zip")
    end
    if _G.rawget(_G, "TALKINGFONT_WORMWOOD") then
        table.insert(ThaiFontsFileNames, "talkingfont_wormwood__th.zip")
    end

    _G.DEFAULTFONT = "opensans"
    _G.DIALOGFONT = "opensans"
    _G.TITLEFONT = "bp100"
    _G.UIFONT = "bp50"
    _G.BUTTONFONT = "buttonfont"
    _G.NUMBERFONT = "stint-ucr"
    _G.TALKINGFONT = "talkingfont"
    if _G.rawget(_G, "TALKINGFONT_WATHGRITHR") then
        _G.TALKINGFONT_WATHGRITHR = "talkingfont_wathgrithr"
    end
    if _G.rawget(_G, "TALKINGFONT_WORMWOOD") then
        _G.TALKINGFONT_WORMWOOD = "talkingfont_wormwood"
    end
    _G.SMALLNUMBERFONT = "stint-small"
    _G.BODYTEXTFONT = "stint-ucr"

    for i, FileName in ipairs(ThaiFontsFileNames) do
        TheSim:UnloadFont("thaifont"..tostring(i))
    end
    TheSim:UnloadPrefabs({"thaifonts_"..modname})

    local ThaiFontsAssets = {}
    for i, FileName in ipairs(ThaiFontsFileNames) do
        table.insert(ThaiFontsAssets, _G.Asset("FONT", MODROOT.."fonts/"..FileName))
    end

    local ThaiFontsPrefab = _G.Prefab("common/thaifonts_"..modname, nil, ThaiFontsAssets)
    _G.RegisterPrefabs(ThaiFontsPrefab)
    TheSim:LoadPrefabs({"thaifonts_"..modname})

    for i, FileName in ipairs(ThaiFontsFileNames) do
        TheSim:LoadFont(MODROOT.."fonts/"..FileName, "thaifont"..tostring(i))
    end

	_G.UIFONT = "thaifont5"
	_G.BUTTONFONT = "thaifont7"
	_G.DEFAULTFONT = "thaifont4"
	_G.DIALOGFONT = "thaifont4"
	_G.TITLEFONT = "thaifont6"
	_G.NUMBERFONT = "thaifont2"
	_G.SMALLNUMBERFONT = "thaifont3"
	_G.BODYTEXTFONT = "thaifont2"
	_G.TALKINGFONT = "thaifont1"
	if _G.rawget(_G, "TALKINGFONT_WATHGRITHR") then
		_G.TALKINGFONT_WATHGRITHR = "thaifont8"
	end
	if _G.rawget(_G, "TALKINGFONT_WORMWOOD") then
		_G.TALKINGFONT_WORMWOOD = "thaifont9"
	end
end
ApplyLocalizedFonts()

Assets = {
    Asset("IMAGE", MODROOT.."images/customisation.tex"),
    Asset("ATLAS", MODROOT.."images/customisation.xml"),
    Asset("IMAGE", MODROOT.."images/customization_porkland.tex"),
    Asset("ATLAS", MODROOT.."images/customization_porkland.xml"),
    Asset("IMAGE", MODROOT.."images/customization_shipwrecked.tex"),
    Asset("ATLAS", MODROOT.."images/customization_shipwrecked.xml"),
    Asset("IMAGE", MODROOT.."images/eyebutton.tex"),
    Asset("ATLAS", MODROOT.."images/eyebutton.xml"),
    Asset("IMAGE", MODROOT.."images/gradient.tex"),
    Asset("ATLAS", MODROOT.."images/gradient.xml"),
    Asset("IMAGE", MODROOT.."images/upgradepanels.tex"),
    Asset("ATLAS", MODROOT.."images/upgradepanels.xml")
}

_G.getmetatable(TheSim).__index.UnregisterAllPrefabs = (function()
	local oldUnregisterAllPrefabs = _G.getmetatable(TheSim).__index.UnregisterAllPrefabs
	return function(self, ...)
		oldUnregisterAllPrefabs(self, ...)
		ApplyLocalizedFonts()
	end
end)()

AddClassPostConstruct("screens/worldgenscreen",function(self) -- แก้ฟ้อนหน้าโหลดโลก
	ApplyLocalizedFonts()
	self.worldgentext:SetFont(_G.TITLEFONT)
	self.flavourtext:SetFont(_G.UIFONT)
end)

AddClassPostConstruct("widgets/spinner",function(self, options, width, height, textinfo, ...) -- แก้ฟ้อนหน้ากำหนดค่า
	if textinfo then
		return
	end
	self.text:SetFont(_G.BUTTONFONT)
end)

--โหลดไฟล์ภาษา
if Config.UI ~= "disable" or Config.CON ~= "disable" or Config.ITEM ~= "disable" then
	LoadPOFile("scripts/languages/thai.po", t.SelectedLanguage)
	_G.LanguageTranslator.languages[t.SelectedLanguage]["STRINGS.UI.MAINSCREEN.UPDATENAME"] = STRINGS.UI.MAINSCREEN.UPDATENAME

	t.PO = _G.LanguageTranslator.languages[t.SelectedLanguage]

	-- ปิดการแปล UI
	if Config.UI == "disable" then
		for i,v in pairs(t.PO) do
			if string.find(i, "STRINGS.UI") then
				t.PO[i]=""
			end
		end
	end

	-- ปิดการแปลบทพูด
	if Config.CON == "disable" then
		for i,v in pairs(t.PO) do
			if string.find(i, "STRINGS.CHARACTERS.GENERIC") then
				t.PO[i]=""
			end
		end
	end

	-- ปิดการแปลชื่อไอเทม
	if Config.ITEM == "disable" then 
		for i,v in pairs(t.PO) do
			if string.find(i, "STRINGS.NAMES") then
				t.PO[i]=""
			end
		end
	elseif Config.CFG_ITEM_TWO == "enable" then  -- ไอเทมสองภาษา
		for i,v in pairs(t.PO) do
			if string.find(i, "STRINGS.NAMES") or string.find(i, "STRINGS.ANTNAMES") or string.find(i, "STRINGS.ANTWARRIORNAMES") or string.find(i, "STRINGS.BALLPHINNAMES") or string.find(i, "STRINGS.BUNNYMANNAMES") or string.find(i, "STRINGS.CHARACTER_NAMES") or string.find(i, "STRINGS.CITYPIGNAMES") or string.find(i, "STRINGS.MANDRAKEMANNAMES") or string.find(i, "STRINGS.MERMNAMES") or string.find(i, "STRINGS.PARROTNAMES") or string.find(i, "STRINGS.PIGNAMES") or string.find(i, "STRINGS.SHIPNAMES") then
				local data = split(i, ".")
				local text
				if #data == 7 then
					text = STRINGS[data[2]][data[3]][data[4]][data[5]][data[6]][data[7]]
					if not text then
						text = STRINGS[data[2]][data[3]][data[4]][data[5]][data[6]][_G.tonumber(data[7])]
					end
				elseif #data == 6 then
					text = STRINGS[data[2]][data[3]][data[4]][data[5]][data[6]]
					if not text then
						text = STRINGS[data[2]][data[3]][data[4]][data[5]][_G.tonumber(data[6])]
					end
				elseif #data == 5 then
					text = STRINGS[data[2]][data[3]][data[4]][data[5]]
					if not text then
						text = STRINGS[data[2]][data[3]][data[4]][_G.tonumber(data[5])]
					end
				elseif #data == 4 then
					text = STRINGS[data[2]][data[3]][data[4]]
					if not text then
						text = STRINGS[data[2]][data[3]][_G.tonumber(data[4])]
					end
				elseif #data == 3 then
					text = STRINGS[data[2]][data[3]]
					if not text then
						text = STRINGS[data[2]][_G.tonumber(data[3])]
					end
				elseif #data == 2 then
					text = STRINGS[data[2]]
					if not text then
						text = STRINGS[_G.tonumber(data[2])]
					end
				end
				t.PO[i]=v..(text and "\n("..text..")" or "")
			end
		end
	end
	
	modimport("scripts/EMPTY.lua")
end

if Config.UI == "enable" then
	modimport("scripts/optionsscreen.lua")
	modimport("scripts/modinfo.lua")
end

local OldStart = _G.Start
function _G.Start() 
	ApplyLocalizedFonts()
	OldStart()
	
	TheSim:QueryServer("https://raw.githubusercontent.com/chaixshot/DS-Thai/main/version.txt", function (result, isSuccessful, resultCode)
		if resultCode == 200 and isSuccessful then
			local json = require("json")
			local data = json.decode(result)
			if modinfo.version ~= data.version then
				local PopupDialogScreen = require "screens/popupdialog"
				_G.TheFrontEnd:PushScreen(PopupDialogScreen("อัพเดท", "ส่วนเสริม \"ภาษาไทย\" มีอัพเดทใหม่\nกรุณาไปที่เมนู \"ส่วนเสริม\" เพื่ออัพเดท",
				{{text="เข้าใจแล้ว!", cb = function() 
					_G.TheFrontEnd:PopScreen() 
				end}}))
			end
		end
	end, "GET")
end

-- แก้ข้อความบังคับอัตโนมัติ เช่น "Moon Shard"
_G.setfenv(1, _G)
TranslateStringTable(STRINGS)