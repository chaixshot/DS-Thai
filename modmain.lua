_G = GLOBAL
rawget = _G.rawget
mods=_G.rawget(_G,"mods") or (function() local m={}_G.rawset (_G,"mods",m) return m end)()
mods.ThaiLanguagePack = {}
t = mods.ThaiLanguagePack
t.SelectedLanguage = "th"
TheSim = _G.TheSim
STRINGS = _G.STRINGS
IsDST = _G.MOD_API_VERSION == 10
tostring = _G.tostring
tonumber = _G.tonumber
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

	-- ไอเทมสองภาษาใน STRING.CHARACTERS, STRING.SKILLTREE, STRING.SKIN_DESCRIPTIONS, STRINGS.RECIPE_DESC
    if Config.CON == "enable" then
        local ItemNameTH = {}
        for k,v in pairs(STRINGS.NAMES) do
            local nameTH = tostring(t.PO["STRINGS.NAMES."..k])
            local nameEN = v
            ItemNameTH[nameTH] = nameEN
        end
        local function ItemTwoConversation(text, data)
            for k,v in pairs(data) do
                if type(v) == "table" then
                    ItemTwoConversation(text.."."..k, v)
                else
                    local data = split(text.."."..k, ".")
                    local ConversationTH = tostring(t.PO[text.."."..k])
                    local ConversationEN = STRINGS[data[2]]
                    for i=3, #data do
                        if tonumber(data[i]) then
                            ConversationEN = ConversationEN[tonumber(data[i])]
                        else
                            ConversationEN = ConversationEN[data[i]]
                        end
                    end
                    ConversationEN = tostring(ConversationEN)
                    
                    local BlackList = {
                        ["Nothing"] = true,
                        ["X"] = true,
                        ["Health"] = true,
                        ["Sanity"] = true,
                        ["Fire"] = true,
                        ["Plant"] = true,
                    }
                    
                    for thainame, engname in pairs(ItemNameTH) do
                        if not BlackList[engname] then
                            if string.find(ConversationEN, engname) then -- Fast check
                                if string.find(ConversationEN, "%f[%a]"..engname.."%f[%A]") then -- Slow check
                                    local newcon = string.gsub(ConversationTH, "%f[%a]"..engname.."%f[%A]", thainame)
                                    if Config.ITEM == "disable" then -- ปิดแปลชื่อไอเทมในบทสนทนา
                                        newcon = string.gsub(newcon, thainame, " "..engname.." ")
                                    else
                                        newcon = string.gsub(newcon, thainame, thainame.."("..engname..")")
                                    end
                                    ConversationTH = string.gsub(newcon, "  ", " ")
                                    t.PO[text.."."..k] = ConversationTH
                                end
                            end
                        end
                    end
                end
            end
        end
        ItemTwoConversation("STRINGS.CHARACTERS", STRINGS.CHARACTERS)
        ItemTwoConversation("STRINGS.RECIPE_DESC", STRINGS.RECIPE_DESC)
        if IsDST then
            ItemTwoConversation("STRINGS.SKILLTREE", STRINGS.SKILLTREE)
            ItemTwoConversation("STRINGS.SKIN_DESCRIPTIONS", STRINGS.SKIN_DESCRIPTIONS)
        end
    end
    
    -- ไอเทมสองภาษาในชื่อไอเทมเลย
    if Config.ITEM == "enable" and Config.CFG_ITEM_TWO == "enable" then
        local function ItemTwoName(text, data)
            for k,v in pairs(data) do
                if type(v) == "table" then
                    ItemTwoName(text.."."..k, v)
                else
                    local data = split(text.."."..k, ".")
                    local ItemTH = tostring(t.PO[text.."."..k])
                    local ItemEN = STRINGS[data[2]]
                    for i=3, #data do
                        if tonumber(data[i]) then
                            ItemEN = ItemEN[tonumber(data[i])]
                        else
                            ItemEN = ItemEN[data[i]]
                        end
                    end
                    t.PO[text.."."..k]=ItemTH..(ItemEN and "\n("..ItemEN..")" or "")
                end
            end
        end
        ItemTwoName("STRINGS.NAMES", STRINGS.NAMES)
        ItemTwoName("STRINGS.BUNNYMANNAMES", STRINGS.BUNNYMANNAMES)
        ItemTwoName("STRINGS.CHARACTER_NAMES", STRINGS.CHARACTER_NAMES)
        ItemTwoName("STRINGS.MERMNAMES", STRINGS.MERMNAMES)
        ItemTwoName("STRINGS.PIGNAMES", STRINGS.PIGNAMES)
        if IsDST then
            ItemTwoName("STRINGS.BEEFALONAMING", STRINGS.BEEFALONAMING)
            ItemTwoName("STRINGS.CROWNAMES", STRINGS.CROWNAMES)
            ItemTwoName("STRINGS.KITCOON_NAMING", STRINGS.KITCOON_NAMING)
            ItemTwoName("STRINGS.SWAMPIGNAMES", STRINGS.SWAMPIGNAMES)
        else
            ItemTwoName("STRINGS.CITYPIGNAMES", STRINGS.CITYPIGNAMES)
            ItemTwoName("STRINGS.ANTNAMES", STRINGS.ANTNAMES)
            ItemTwoName("STRINGS.ANTWARRIORNAMES", STRINGS.ANTWARRIORNAMES)
            ItemTwoName("STRINGS.BALLPHINNAMES", STRINGS.BALLPHINNAMES)
            ItemTwoName("STRINGS.MANDRAKEMANNAMES", STRINGS.MANDRAKEMANNAMES)
            ItemTwoName("STRINGS.PARROTNAMES", STRINGS.PARROTNAMES)
            ItemTwoName("STRINGS.SHIPNAMES", STRINGS.SHIPNAMES)
        end
	end
    
    for i,v in pairs(t.PO) do
        -- ปิดการแปล UI
        if Config.UI == "disable" then
            if string.find(i, "STRINGS.UI") then
                t.PO[i]=""
            end
        end
        
        -- ปิดการแปลบทพูด
        if Config.CON == "disable" then
            if string.find(i, "STRINGS.CHARACTERS.GENERIC") then
                t.PO[i]=""
            end
        end
        
        -- ปิดการแปลชื่อไอเทม
        if Config.ITEM == "disable" then 
			if string.find(i, "STRINGS.NAMES") then
				t.PO[i]=""
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