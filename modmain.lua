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
Config.CFG_OTHER_MOD = GetModConfigData("CFG_OTHER_MOD")

function ApplyLocalizedFonts()
    local LocalizedFontList = {
		["belisaplumilla50"] = true,
		["belisaplumilla100"] = true,
		["buttonfont"] = true,
		["opensans50"] = true,
		["stint-ucr20"] = true,
		["stint-ucr50"] = true,
		["talkingfont"] = true,
		["talkingfont_wathgrithr"] = true,
		["talkingfont_wormwood"] = true,
	}

    for FontName in pairs(LocalizedFontList) do
		TheSim:UnloadFont(t.SelectedLanguage.."_"..FontName)
	end
	TheSim:UnloadPrefabs({t.SelectedLanguage.."_fonts_"..modname}) 

	local LocalizedFontAssets = {}
	for FontName in pairs(LocalizedFontList) do 
		table.insert(LocalizedFontAssets, _G.Asset("FONT", MODROOT.."fonts/"..FontName.."__"..t.SelectedLanguage..".zip"))
	end

	local LocalizedFontsPrefab = _G.Prefab("common/"..t.SelectedLanguage.."_fonts_"..modname, nil, LocalizedFontAssets)
	_G.RegisterPrefabs(LocalizedFontsPrefab)
	TheSim:LoadPrefabs({t.SelectedLanguage.."_fonts_"..modname})

	for FontName in pairs(LocalizedFontList) do
		TheSim:LoadFont(MODROOT.."fonts/"..FontName.."__"..t.SelectedLanguage..".zip", t.SelectedLanguage.."_"..FontName)
	end

	local fallbacks = {}
	for _, v in pairs(_G.FONTS) do
		local FontName = v.filename:sub(7, -5)
		if LocalizedFontList[FontName] then
			fallbacks[FontName] = {v.alias, _G.unpack(type(v.fallback) == "table" and v.fallback or {})}
		end
	end
	for FontName in pairs(LocalizedFontList) do
		TheSim:SetupFontFallbacks(t.SelectedLanguage.."_"..FontName, fallbacks[FontName])
	end

	if Config.UI ~= "disable" or Config.CON ~= "disable" or Config.ITEM ~= "disable" then
        if rawget(_G,"DEFAULTFONT") then
            _G.DEFAULTFONT = t.SelectedLanguage.."_opensans50"
        end
        if rawget(_G,"DIALOGFONT") then
            _G.DIALOGFONT = t.SelectedLanguage.."_opensans50"
        end
        if rawget(_G,"TITLEFONT") then
            _G.TITLEFONT = t.SelectedLanguage.."_belisaplumilla100"
        end
        if rawget(_G,"UIFONT") then
            _G.UIFONT = t.SelectedLanguage.."_belisaplumilla50"
        end
        if rawget(_G,"BUTTONFONT") then
            _G.BUTTONFONT = t.SelectedLanguage.."_buttonfont"
        end
        if rawget(_G,"HEADERFONT") then
            _G.HEADERFONT = t.SelectedLanguage.."_hammerhead50"
        end
        if rawget(_G,"CHATFONT_OUTLINE") then
            _G.NUMBERFONT = t.SelectedLanguage.."_stint-ucr50"
        end
        if rawget(_G,"SMALLNUMBERFONT") then
            _G.SMALLNUMBERFONT = t.SelectedLanguage.."_stint-ucr20"
        end
        if rawget(_G,"BODYTEXTFONT") then
            _G.BODYTEXTFONT = t.SelectedLanguage.."_stint-ucr50"
        end
        if rawget(_G,"CHATFONT_OUTLINE") then
            _G.CHATFONT_OUTLINE = t.SelectedLanguage.."_bellefair50_outline"
        end
		if rawget(_G,"NEWFONT") then
			_G.NEWFONT = t.SelectedLanguage.."_spirequal"
		end
		if rawget(_G,"NEWFONT_SMALL") then
			_G.NEWFONT_SMALL = t.SelectedLanguage.."_spirequal_small"
		end
		if rawget(_G,"NEWFONT_OUTLINE") then
			_G.NEWFONT_OUTLINE = t.SelectedLanguage.."_spirequal_outline"
		end
		if rawget(_G,"NEWFONT_OUTLINE_SMALL") then
			_G.NEWFONT_OUTLINE_SMALL = t.SelectedLanguage.."_spirequal_outline_small"
		end
	end
    if rawget(_G,"CHATFONT") then
        _G.CHATFONT = t.SelectedLanguage.."_bellefair50"
    end
    if rawget(_G,"TALKINGFONT") then
        _G.TALKINGFONT = t.SelectedLanguage.."_talkingfont"
    end
    if rawget(_G,"TALKINGFONT_HERMIT") then
        _G.TALKINGFONT_HERMIT = t.SelectedLanguage.."_talkingfont"
    end
    if rawget(_G,"TALKINGFONT_TRADEIN") then
        _G.TALKINGFONT_TRADEIN = t.SelectedLanguage.."_talkingfont_tradein"
    end
    if rawget(_G,"TALKINGFONT_WORMWOOD") then
        _G.TALKINGFONT_WORMWOOD = t.SelectedLanguage.."_talkingfont_wormwood"
    end
    if _G.rawget(_G, "TALKINGFONT_WATHGRITHR") then
		_G.TALKINGFONT_WATHGRITHR = t.SelectedLanguage.."_talkingfont_wathgrithr"
	end
end

-- โหลดฟอนต์ในหน้าที่เกมไม่โหลดให้
local oldSetFont = _G.TextWidget.SetFont
_G.TextWidget.SetFont = function(guid, font)
	if font == "opensans" then
		oldSetFont(guid, _G.DEFAULTFONT)
	elseif font == "opensans" then
		oldSetFont(guid, _G.DIALOGFONT)
	elseif font == "bp100" then
		oldSetFont(guid, _G.TITLEFONT)
	elseif font == "bp50" then
		oldSetFont(guid, _G.UIFONT)
	elseif font == "buttonfont" then
		oldSetFont(guid, _G.BUTTONFONT)
	elseif font == "hammerhead" then
		oldSetFont(guid, _G.HEADERFONT)
	elseif font == "stint-ucr" then
		oldSetFont(guid, _G.NUMBERFONT)
	elseif font == "stint-small" then
		oldSetFont(guid, _G.SMALLNUMBERFONT)
	elseif font == "stint-ucr" then
		oldSetFont(guid, _G.BODYTEXTFONT)
	elseif font == "bellefair_outline" then
		oldSetFont(guid, _G.CHATFONT_OUTLINE)
	elseif font == "spirequal" then
		oldSetFont(guid, _G.NEWFONT)
	elseif font == "spirequal_small" then
		oldSetFont(guid, _G.NEWFONT_SMALL)
	elseif font == "spirequal_outline" then
		oldSetFont(guid, _G.NEWFONT_OUTLINE)
	elseif font == "spirequal_outline_small" then
		oldSetFont(guid, _G.NEWFONT_OUTLINE_SMALL)
	elseif font == "bellefair" then
		oldSetFont(guid, _G.CHATFONT)
	elseif font == "talkingfont" then
		oldSetFont(guid, _G.TALKINGFONT)
	elseif font == "talkingfont_hermit" then
		oldSetFont(guid, _G.TALKINGFONT_HERMIT)
	elseif font == "talkingfont_tradein" then
		oldSetFont(guid, _G.TALKINGFONT_TRADEIN)
	elseif font == "talkingfont_wormwood" then
		oldSetFont(guid, _G.TALKINGFONT_WORMWOOD)
	else
		oldSetFont(guid, font)
	end
end

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

_G.getmetatable(TheSim).__index.UnregisterAllPrefabs = (function() -- โหลดฟอนต์ในหน้าที่เกมไม่โหลดให้
	local oldUnregisterAllPrefabs = _G.getmetatable(TheSim).__index.UnregisterAllPrefabs
	return function(self, ...)
		oldUnregisterAllPrefabs(self, ...)
		ApplyLocalizedFonts()
	end
end)()

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
				local String = STRINGS[data[2]]
				for i=3, #data do
					if _G.tonumber(data[i]) then
						String = String[_G.tonumber(data[i])]
					else
						String = String[data[i]]
					end
				end
				t.PO[i]=v..(String and "\n("..String..")" or "")
			end
		end
	end
	
	modimport("scripts/EMPTY.lua")
end

if Config.UI == "enable" then
	modimport("scripts/optionsscreen.lua")
	modimport("scripts/modinfo.lua")
    modimport("scripts/fix_ui.lua")
end

local OldStart = _G.Start
function _G.Start() 
	ApplyLocalizedFonts()
	OldStart()
end

-- Version Check
AddClassPostConstruct("screens/mainscreen",function(self, profile)
	TheSim:QueryServer("https://raw.githubusercontent.com/chaixshot/DS-Thai/main/version.txt", function (result, isSuccessful, resultCode)
		if resultCode == 200 and isSuccessful then
			local json = require("json")
			local data = json.decode(result)
			if modinfo.version ~= data.version then
				local PopupDialogScreen = require "screens/popupdialog"
				_G.TheFrontEnd:PushScreen(PopupDialogScreen("อัพเดท", "ส่วนเสริม \"ภาษาไทย\" มีอัพเดทใหม่\nกรุณาไปที่เมนู \"ส่วนเสริม\" เพื่ออัพเดท",
				{
					{text="อัพเดทเลย!", cb = function() 
						_G.TheFrontEnd:PopScreen() 
						self:OnModsButton()
					end},
					{text="ปิด!", cb = function() 
						_G.TheFrontEnd:PopScreen() 
					end},
				}))
			end
		end
	end, "GET")
end)

-- แก้ข้อความบังคับอัตโนมัติ เช่น "Moon Shard"
_G.setfenv(1, _G)
TranslateStringTable(STRINGS)