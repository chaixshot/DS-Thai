-- การแปลข้อความที่ว่างเปล่า
for i,v in pairs(t.PO) do
	if v=="<ว่างเปล่า>" then t.PO[i]="" end
end