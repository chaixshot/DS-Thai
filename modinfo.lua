names = {
	en = " Thai language",
	th = " ภาษาไทย",
}
name = names[language] or names["en"]
version = "3.0k"
desc = {
	en = [[
		This mod is a Thai translation of the game.
		so that people can read, understand and be happy
		If you see an error, please notify the developer.
		เวอร์ชั่น: ]]..version,
	th = [[
		ส่วนเสริมนี้เป็นการแปลภาษาไทยให้กับเกม
		เพื่อให้คนได้อ่านออกเข้าใจและมีความสุข
		หากพบเห็นข้อผิดพลาดกรุณาแจ้งผู้พัฒนาด้วย
		เวอร์ชั่น: ]]..version,
}
description = desc[language] or desc["en"]
author = "H@mer"
forumthread = ""
api_version = 6
priority = 1
icon = "ModThai.tex"
icon_atlas = "images/ModThai.xml"
dont_starve_compatible = true
reign_of_giants_compatible = true
shipwrecked_compatible = true
hamlet_compatible = true
-- restart_required = true

configuration_options =
{
	{	
		name = "--1--",
		label = "(1)",
		hover = "",
		options =
		{	
			{description = "เกมหลัก!", data = "nope", hover = "หมวดหมู่การตั้งค่าตัวเลือกสำหรับตัวเกม"},
		},
		default = "nope",
	},
	{
        name = "CFG_UI",
		label = "พื้นฐาน",
		hover = "การแปลส่วนพื้นฐาน ยูสเซอร์อินเตอร์เฟส, ข้อความอธิบาย",
        options =
        {
			{description = "ปิด", data = "disable", hover = "ปิดการใช้งานการแปลพื้นฐาน"},
            {description = "เปิด", data = "enable", hover = "เปิดการใช้งานการแปลพื้นฐาน"},
        },
        default = "enable",
    },
	{
        name = "CFG_CON",
		label = "บทพูด",
		hover = "การแปลบทพูดของตัวละคร\n(\"พื้นฐาน\" จะต้องไม่ถูกปิด)",
        options =
        {
			{description = "ปิด", data = "disable", hover = "ปิดการใช้งานการแปลบทพูด"},
            {description = "เปิด", data = "enable", hover = "เปิดการใช้งานการแปลบทพูด"},
        },
        default = "enable",
    },
	{
        name = "CFG_ITEM",
		label = "ไอเทม",
		hover = "การแปลชื่อไอเทม และชื่อสิ่งมีชีวิต\n(\"พื้นฐาน\" จะต้องไม่ถูกปิด)",
        options =
        {
			{description = "ปิด", data = "disable", hover = "ปิดการใช้งานการแปลไอเทม"},
            {description = "เปิด", data = "enable", hover = "เปิดการใช้งานการแปลไอเทม"},
        },
        default = "enable",
    },
	{
        name = "CFG_ITEM_TWO",
		label = "ไอเทมสองภาษา",
		hover = "ชื่อไอเทม สัตว์ สิ่งของ จะแสดงทั้งสองภาษา)",
        options =
        {
			{description = "ปิด", data = "disable", hover = "ปิดการใช้งานไอเทมสองภาษา"},
            {description = "เปิด", data = "enable", hover = "เปิดการใช้งานไอเทมสองภาษา"},
        },
        default = "enable",
    },
    {
        name = "CFG_OTHER_MOD",
		label = "แปลส่วนเสริมอื่น",
		hover = "แปลส่วนเสริมอื่นๆที่สนับสนุนและเปิดการใช้งานอยู่เป็นภาษาไทย",
        options =
        {
			{description = "ปิด", data = "disable", hover = "ปิดการแปลส่วนเสริมอื่น"},
            {description = "เปิด", data = "enable", hover = "เปิดการแปลส่วนเสริมอื่น"},
        },
        default = "enable",
    },
	{	
		name = "--2--",
		label = "(2)",
		hover = "",
		options =
		{	
			{description = "อื่นๆ", data = "nope", hover = "หมวดหมู่นการตั้งค่าตัวเลือกเพิ่มเติม"},
		},
		default = "nope",
	},
	{
		name = "DISABLE_MOD_WARNING",
		label = "ข้ามข้อความเตือนส่วนเสริม",
		hover = "ปิดใช้งานข้อความเตือนส่วนเสริมเมื่อเข้าเกมและข้อความเตือนอื่นๆเมื่อคุณพยายามเล่น Forge",
		options =	{
			{description = "เปิดใช้งาน", data = true, hover = "ข้ามข้อความเตือนส่วนเสริม"},
			{description = "ปิดใช้งาน", data = false, hover = "ไม่ข้ามข้อความเตือนส่วนเสริม"},
		},
		default = true,
	},
}