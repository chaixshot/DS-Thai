-- แปลหน้าการตั้งค่า ENABLED และ DISABLED
AddClassPostConstruct("screens/optionsscreen", function(self) 
	for _,v in pairs(self) do
		if type(v)=="table" and v.name=="SPINNER" then
			local shouldbeupdated=false
			for _,opt in ipairs(v.options) do
				if opt.text=="Enabled" then
					opt.text=STRINGS.UI.OPTIONS.ENABLED
					shouldbeupdated=true
				elseif opt.text=="Disabled" then
					opt.text=STRINGS.UI.OPTIONS.DISABLED
					shouldbeupdated=true
				end
			end
			if v.selectedIndex and v.selectedIndex>0 and v.selectedIndex<=#v.options then v:UpdateText(v.options[v.selectedIndex].text) end
		end
	end
end)