bots = {
-- ======================== Edit Here  =======================
-- ======================   ======================
    
	GetBot("Bot1"),	
	GetBot("Bot2"),	
	GetBot("Bot3"),	

    }
-- ======================== Edit Here  =======================
-- ======================   ======================
bg = 56 -- ID bg  ====================
left = 47 -- Number of plates left =========================
right = 48 -- Number of plates on the right =====================DB==
interval = 50 -- Fast Bot ===============================
-- ======================== Edit Here  =======================
-- ======================   ======================
RunThread(function()
  if bots[1] == nil then
    return
  end
  local function amount(id)
    if bots[1]:GetInventory():GetItem(id) then
      return bots[1]:GetInventory():GetItem(id).amount
    else
      return 0
    end
  end
  local function hook(c,v,n,d)
  if v[0]:find("OnTalkBubble") and v[1]:find("!gems") then
    c:Say(amount(112))
   if v[0]:find("OnDialogRequest") and v[1]:find("end_dialog|grinder") then
      c:SendPacket(2,("action|dialog_return\ndialog_name|grinder\ntilex|%d|\ntiley|%d|\nitemID|%d|\ncount|%d"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)"),v[1]:match("itemID|(%d+)"),v[1]:match("count||(%d+)")))
    end
    if v[0]:find("OnDialogRequest") and v[1]:find("end_dialog|vending") then
      if  v[1]:find("end_dialog|vending|Close||") then
        c:SendPacket(2,("action|dialog_return\ndialog_name|vending\ntilex|%d|\ntiley|%d|\nstockitem|4562"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)")))
      end
      if  v[1]:find("end_dialog|vending|Close|Update|") then
        c:SendPacket(2,("action|dialog_return\ndialog_name|vending\ntilex|%d|\ntiley|%d|\nbuttonClicked|addstock\n\nsetprice|%d\nchk_peritem|%d\nchk_perlock|%d"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)"),v[1]:match("setprice|Price|(%d+)"),v[1]:match("chk_peritem|World Locks per Item|(%d+)"),v[1]:match("chk_perlock|Items per World Lock|(%d+)")))
      end
    end
  end
  bots[1]:AddCallback(VARIANTLIST,"hook",hook)
  tile = {}
  for _,t in pairs(bots[1]:GetWorld():GetTiles()) do
    if t.bg == bg then
      tile[#tile+1] = {x = t.pos_x,
                            y = t.pos_y
                            }
    end
  end
  while true do
    if amount(880) >= 150 and amount(881) >= 100 then
      for _,t in pairs(bots[1]:GetWorld():GetTiles()) do
        if t.fg == 4582 then
          bots[1]:FindPath(t.pos_x,t.pos_y-1)
		  Sleep(interval)
          bots[1]:PlaceTile(t.pos_x,t.pos_y,880)
          Sleep(1000)
        end
      end
      for _,t in pairs(bots[1]:GetWorld():GetTiles()) do
        if t.fg == 2978 then
          bots[1]:FindPath(t.pos_x,t.pos_y)
		  Sleep(interval)
          bots[1]:WrenchTile(t.pos_x,t.pos_y)
          Sleep(1000)
        end
      end
    end
    bots[1]:FindPath(tile[1].x,tile[1].y)
	Sleep(interval)
    while amount(880) > 0 do
      bots[1]:PlaceTile(tile[1].x-1,tile[1].y,880)
      Sleep(200)
      bots[1]:PlaceTile(tile[1].x+1,tile[1].y,880)
      Sleep(200)
      bots[1]:HitTile(tile[1].x-1,tile[1].y)
      Sleep(200)
      bots[1]:HitTile(tile[1].x+1,tile[1].y)
      Sleep(200)
      bots[1]:HitTile(tile[1].x-1,tile[1].y)
      Sleep(200)
      bots[1]:HitTile(tile[1].x+1,tile[1].y)
      Sleep(200)
    end
    for i = -2, -(left+1), -1 do
      bots[1]:FindPath(tile[1].x+i,tile[1].y)
	  Sleep(interval)
      bots[1]:HitTile(tile[1].x+i,tile[1].y)
      Sleep(200)
    end
    for i = -(left+1), -2 do
      bots[1]:FindPath(tile[1].x+i,tile[1].y)
	  Sleep(interval)
      bots[1]:PlaceTile(tile[1].x+i,tile[1].y,881)
      Sleep(200)
    end
    if amount(880) >= 150 and amount(881) >= 100 then
      for _,t in pairs(bots[1]:GetWorld():GetTiles()) do
        if t.fg == 4582 then
          bots[1]:FindPath(t.pos_x,t.pos_y-1)
		  Sleep(interval)
          bots[1]:PlaceTile(t.pos_x,t.pos_y,880)
          Sleep(1000)
        end
      end
      for _,t in pairs(bots[1]:GetWorld():GetTiles()) do
        if t.fg == 2978 then
          bots[1]:FindPath(t.pos_x,t.pos_y)
		  Sleep(interval)
          bots[1]:WrenchTile(t.pos_x,t.pos_y)
          Sleep(1000)
        end
      end
    end
    bots[1]:FindPath(tile[1].x,tile[1].y)
	Sleep(interval)
    while amount(880) > 0 do
      bots[1]:PlaceTile(tile[1].x-1,tile[1].y,880)
      Sleep(200)
      bots[1]:PlaceTile(tile[1].x+1,tile[1].y,880)
      Sleep(200)
      bots[1]:HitTile(tile[1].x-1,tile[1].y)
      Sleep(200)
      bots[1]:HitTile(tile[1].x+1,tile[1].y)
      Sleep(200)
      bots[1]:HitTile(tile[1].x-1,tile[1].y)
      Sleep(200)
      bots[1]:HitTile(tile[1].x+1,tile[1].y)
      Sleep(200)
    end
    for i = 2, right+1 do
      bots[1]:FindPath(tile[1].x+i,tile[1].y)
	  Sleep(interval)
      bots[1]:HitTile(tile[1].x+i,tile[1].y)
      Sleep(200)
    end
    for i = right+1, 2, -1 do
      bots[1]:FindPath(tile[1].x+i,tile[1].y)
	  Sleep(interval)
      bots[1]:PlaceTile(tile[1].x+i,tile[1].y,881)
      Sleep(200)
    end
  end
end)
RunThread(function()
  if bots[2] == nil then
    return
  end
  local function amount(id)
    if bots[2]:GetInventory():GetItem(id) then
      return bots[2]:GetInventory():GetItem(id).amount
    else
      return 0
    end
  end
  local function hook(c,v,n,d)
   if v[0]:find("OnDialogRequest") and v[1]:find("end_dialog|grinder") then
      c:SendPacket(2,("action|dialog_return\ndialog_name|grinder\ntilex|%d|\ntiley|%d|\nitemID|%d|\ncount|%d"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)"),v[1]:match("itemID|(%d+)"),v[1]:match("count||(%d+)")))
    end
    if v[0]:find("OnDialogRequest") and v[1]:find("end_dialog|vending") then
      if  v[1]:find("end_dialog|vending|Close||") then
        c:SendPacket(2,("action|dialog_return\ndialog_name|vending\ntilex|%d|\ntiley|%d|\nstockitem|4562"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)")))
      end
      if  v[1]:find("end_dialog|vending|Close|Update|") then
        c:SendPacket(2,("action|dialog_return\ndialog_name|vending\ntilex|%d|\ntiley|%d|\nbuttonClicked|addstock\n\nsetprice|%d\nchk_peritem|%d\nchk_perlock|%d"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)"),v[1]:match("setprice|Price|(%d+)"),v[1]:match("chk_peritem|World Locks per Item|(%d+)"),v[1]:match("chk_perlock|Items per World Lock|(%d+)")))
      end
    end
  end
  bots[2]:AddCallback(VARIANTLIST,"hook",hook)
  tile = {}
  for _,t in pairs(bots[2]:GetWorld():GetTiles()) do
    if t.bg == bg then
      tile[#tile+1] = {x = t.pos_x,
                            y = t.pos_y
                            }
    end
  end
  while true do
    if amount(880) >= 150 and amount(881) >= 100 then
      for _,t in pairs(bots[2]:GetWorld():GetTiles()) do
        if t.fg == 4582 then
          bots[2]:FindPath(t.pos_x,t.pos_y-1)
		  Sleep(interval)
          bots[2]:PlaceTile(t.pos_x,t.pos_y,880)
          Sleep(1000)
        end
      end
      for _,t in pairs(bots[2]:GetWorld():GetTiles()) do
        if t.fg == 2978 then
          bots[2]:FindPath(t.pos_x,t.pos_y)
		  Sleep(interval)
          bots[2]:WrenchTile(t.pos_x,t.pos_y)
          Sleep(1000)
        end
      end
    end
    bots[2]:FindPath(tile[2].x,tile[2].y)
	Sleep(interval)
    while amount(880) > 0 do
      bots[2]:PlaceTile(tile[2].x-1,tile[2].y,880)
      Sleep(200)
      bots[2]:PlaceTile(tile[2].x+1,tile[2].y,880)
      Sleep(200)
      bots[2]:HitTile(tile[2].x-1,tile[2].y)
      Sleep(200)
      bots[2]:HitTile(tile[2].x+1,tile[2].y)
      Sleep(200)
      bots[2]:HitTile(tile[2].x-1,tile[2].y)
      Sleep(200)
      bots[2]:HitTile(tile[2].x+1,tile[2].y)
      Sleep(200)
    end
    for i = -2, -(left+1), -1 do
      bots[2]:FindPath(tile[2].x+i,tile[2].y)
	  Sleep(interval)
      bots[2]:HitTile(tile[2].x+i,tile[2].y)
      Sleep(200)
    end
    for i = -(left+1), -2 do
      bots[2]:FindPath(tile[2].x+i,tile[2].y)
	  Sleep(interval)
      bots[2]:PlaceTile(tile[2].x+i,tile[2].y,881)
      Sleep(200)
    end
    if amount(880) >= 150 and amount(881) >= 100 then
      for _,t in pairs(bots[2]:GetWorld():GetTiles()) do
        if t.fg == 4582 then
          bots[2]:FindPath(t.pos_x,t.pos_y-1)
		  Sleep(interval)
          bots[2]:PlaceTile(t.pos_x,t.pos_y,880)
          Sleep(1000)
        end
      end
      for _,t in pairs(bots[2]:GetWorld():GetTiles()) do
        if t.fg == 2978 then
          bots[2]:FindPath(t.pos_x,t.pos_y)
		  Sleep(interval)
          bots[2]:WrenchTile(t.pos_x,t.pos_y)
          Sleep(1000)
        end
      end
    end
    bots[2]:FindPath(tile[2].x,tile[2].y)
	Sleep(interval)
    while amount(880) > 0 do
      bots[2]:PlaceTile(tile[2].x-1,tile[2].y,880)
      Sleep(200)
      bots[2]:PlaceTile(tile[2].x+1,tile[2].y,880)
      Sleep(200)
      bots[2]:HitTile(tile[2].x-1,tile[2].y)
      Sleep(200)
      bots[2]:HitTile(tile[2].x+1,tile[2].y)
      Sleep(200)
      bots[2]:HitTile(tile[2].x-1,tile[2].y)
      Sleep(200)
      bots[2]:HitTile(tile[2].x+1,tile[2].y)
      Sleep(200)
    end
    for i = 2, right+1 do
      bots[2]:FindPath(tile[2].x+i,tile[2].y)
	  Sleep(interval)
      bots[2]:HitTile(tile[2].x+i,tile[2].y)
      Sleep(200)
    end
    for i = right+1, 2, -1 do
      bots[2]:FindPath(tile[2].x+i,tile[2].y)
	  Sleep(interval)
      bots[2]:PlaceTile(tile[2].x+i,tile[2].y,881)
      Sleep(200)
    end
  end
end)
RunThread(function()
  if bots[3] == nil then
    return
  end
  local function amount(id)
    if bots[3]:GetInventory():GetItem(id) then
      return bots[3]:GetInventory():GetItem(id).amount
    else
      return 0
    end
  end
  local function hook(c,v,n,d)
   if v[0]:find("OnDialogRequest") and v[1]:find("end_dialog|grinder") then
      c:SendPacket(2,("action|dialog_return\ndialog_name|grinder\ntilex|%d|\ntiley|%d|\nitemID|%d|\ncount|%d"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)"),v[1]:match("itemID|(%d+)"),v[1]:match("count||(%d+)")))
    end
    if v[0]:find("OnDialogRequest") and v[1]:find("end_dialog|vending") then
      if  v[1]:find("end_dialog|vending|Close||") then
        c:SendPacket(2,("action|dialog_return\ndialog_name|vending\ntilex|%d|\ntiley|%d|\nstockitem|4562"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)")))
      end
      if  v[1]:find("end_dialog|vending|Close|Update|") then
        c:SendPacket(2,("action|dialog_return\ndialog_name|vending\ntilex|%d|\ntiley|%d|\nbuttonClicked|addstock\n\nsetprice|%d\nchk_peritem|%d\nchk_perlock|%d"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)"),v[1]:match("setprice|Price|(%d+)"),v[1]:match("chk_peritem|World Locks per Item|(%d+)"),v[1]:match("chk_perlock|Items per World Lock|(%d+)")))
      end
    end
  end
  bots[3]:AddCallback(VARIANTLIST,"hook",hook)
  tile = {}
  for _,t in pairs(bots[3]:GetWorld():GetTiles()) do
    if t.bg == bg then
      tile[#tile+1] = {x = t.pos_x,
                            y = t.pos_y
                            }
    end
  end
  while true do
    if amount(880) >= 150 and amount(881) >= 100 then
      for _,t in pairs(bots[3]:GetWorld():GetTiles()) do
        if t.fg == 4582 then
          bots[3]:FindPath(t.pos_x,t.pos_y-1)
		  Sleep(interval)
          bots[3]:PlaceTile(t.pos_x,t.pos_y,880)
          Sleep(1000)
        end
      end
      for _,t in pairs(bots[3]:GetWorld():GetTiles()) do
        if t.fg == 2978 then
          bots[3]:FindPath(t.pos_x,t.pos_y)
		  Sleep(interval)
          bots[3]:WrenchTile(t.pos_x,t.pos_y)
          Sleep(1000)
        end
      end
    end
    bots[3]:FindPath(tile[3].x,tile[3].y)
    while amount(880) > 0 do
      bots[3]:PlaceTile(tile[3].x-1,tile[3].y,880)
      Sleep(200)
      bots[3]:PlaceTile(tile[3].x+1,tile[3].y,880)
      Sleep(200)
      bots[3]:HitTile(tile[3].x-1,tile[3].y)
      Sleep(200)
      bots[3]:HitTile(tile[3].x+1,tile[3].y)
      Sleep(200)
      bots[3]:HitTile(tile[3].x-1,tile[3].y)
      Sleep(200)
      bots[3]:HitTile(tile[3].x+1,tile[3].y)
      Sleep(200)
    end
    for i = -2, -(left+1), -1 do
      bots[3]:FindPath(tile[3].x+i,tile[3].y)
	  Sleep(interval)
      bots[3]:HitTile(tile[3].x+i,tile[3].y)
      Sleep(200)
    end
    for i = -(left+1), -2 do
      bots[3]:FindPath(tile[3].x+i,tile[3].y)
	  Sleep(interval)
      bots[3]:PlaceTile(tile[3].x+i,tile[3].y,881)
      Sleep(200)
    end
    if amount(880) >= 150 and amount(881) >= 100 then
      for _,t in pairs(bots[3]:GetWorld():GetTiles()) do
        if t.fg == 4582 then
          bots[3]:FindPath(t.pos_x,t.pos_y-1)
		  Sleep(interval)
          bots[3]:PlaceTile(t.pos_x,t.pos_y,880)
          Sleep(1000)
        end
      end
      for _,t in pairs(bots[3]:GetWorld():GetTiles()) do
        if t.fg == 2978 then
          bots[3]:FindPath(t.pos_x,t.pos_y)
		  Sleep(interval)
          bots[3]:WrenchTile(t.pos_x,t.pos_y)
          Sleep(1000)
        end
      end
    end
    bots[3]:FindPath(tile[3].x,tile[3].y)
	Sleep(interval)
    while amount(880) > 0 do
      bots[3]:PlaceTile(tile[3].x-1,tile[3].y,880)
      Sleep(200)
      bots[3]:PlaceTile(tile[3].x+1,tile[3].y,880)
      Sleep(200)
      bots[3]:HitTile(tile[3].x-1,tile[3].y)
      Sleep(200)
      bots[3]:HitTile(tile[3].x+1,tile[3].y)
      Sleep(200)
      bots[3]:HitTile(tile[3].x-1,tile[3].y)
      Sleep(200)
      bots[3]:HitTile(tile[3].x+1,tile[3].y)
      Sleep(200)
    end
    for i = 2, right+1 do
      bots[3]:FindPath(tile[3].x+i,tile[3].y)
	  Sleep(interval)
      bots[3]:HitTile(tile[3].x+i,tile[3].y)
      Sleep(200)
    end
    for i = right+1, 2, -1 do
      bots[3]:FindPath(tile[3].x+i,tile[3].y)
	  Sleep(interval)
      bots[3]:PlaceTile(tile[3].x+i,tile[3].y,881)
      Sleep(200)
    end
  end
end)
RunThread(function()
  if bots[4] == nil then
    return
  end
  local function amount(id)
    if bots[4]:GetInventory():GetItem(id) then
      return bots[4]:GetInventory():GetItem(id).amount
    else
      return 0
    end
  end
  local function hook(c,v,n,d)
   if v[0]:find("OnDialogRequest") and v[1]:find("end_dialog|grinder") then
      c:SendPacket(2,("action|dialog_return\ndialog_name|grinder\ntilex|%d|\ntiley|%d|\nitemID|%d|\ncount|%d"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)"),v[1]:match("itemID|(%d+)"),v[1]:match("count||(%d+)")))
    end
    if v[0]:find("OnDialogRequest") and v[1]:find("end_dialog|vending") then
      if  v[1]:find("end_dialog|vending|Close||") then
        c:SendPacket(2,("action|dialog_return\ndialog_name|vending\ntilex|%d|\ntiley|%d|\nstockitem|4562"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)")))
      end
      if  v[1]:find("end_dialog|vending|Close|Update|") then
        c:SendPacket(2,("action|dialog_return\ndialog_name|vending\ntilex|%d|\ntiley|%d|\nbuttonClicked|addstock\n\nsetprice|%d\nchk_peritem|%d\nchk_perlock|%d"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)"),v[1]:match("setprice|Price|(%d+)"),v[1]:match("chk_peritem|World Locks per Item|(%d+)"),v[1]:match("chk_perlock|Items per World Lock|(%d+)")))
      end
    end
  end
  bots[4]:AddCallback(VARIANTLIST,"hook",hook)
  tile = {}
  for _,t in pairs(bots[4]:GetWorld():GetTiles()) do
    if t.bg == bg then
      tile[#tile+1] = {x = t.pos_x,
                            y = t.pos_y
                            }
    end
  end
  while true do
    if amount(880) >= 150 and amount(881) >= 100 then
      for _,t in pairs(bots[4]:GetWorld():GetTiles()) do
        if t.fg == 4582 then
          bots[4]:FindPath(t.pos_x,t.pos_y-1)
		  Sleep(interval)
          bots[4]:PlaceTile(t.pos_x,t.pos_y,880)
          Sleep(1000)
        end
      end
      for _,t in pairs(bots[4]:GetWorld():GetTiles()) do
        if t.fg == 2978 then
          bots[4]:FindPath(t.pos_x,t.pos_y)
		  Sleep(interval)
          bots[4]:WrenchTile(t.pos_x,t.pos_y)
          Sleep(1000)
        end
      end
    end
    bots[4]:FindPath(tile[4].x,tile[4].y)
	Sleep(interval)
    while amount(880) > 0 do
      bots[4]:PlaceTile(tile[4].x-1,tile[4].y,880)
      Sleep(200)
      bots[4]:PlaceTile(tile[4].x+1,tile[4].y,880)
      Sleep(200)
      bots[4]:HitTile(tile[4].x-1,tile[4].y)
      Sleep(200)
      bots[4]:HitTile(tile[4].x+1,tile[4].y)
      Sleep(200)
      bots[4]:HitTile(tile[4].x-1,tile[4].y)
      Sleep(200)
      bots[4]:HitTile(tile[4].x+1,tile[4].y)
      Sleep(200)
    end
    for i = -2, -(left+1), -1 do
      bots[4]:FindPath(tile[4].x+i,tile[4].y)
	  Sleep(interval)
      bots[4]:HitTile(tile[4].x+i,tile[4].y)
      Sleep(200)
    end
    for i = -(left+1), -2 do
      bots[4]:FindPath(tile[4].x+i,tile[4].y)
	  Sleep(interval)
      bots[4]:PlaceTile(tile[4].x+i,tile[4].y,881)
      Sleep(200)
    end
    if amount(880) >= 150 and amount(881) >= 100 then
      for _,t in pairs(bots[4]:GetWorld():GetTiles()) do
        if t.fg == 4582 then
          bots[4]:FindPath(t.pos_x,t.pos_y-1)
		  Sleep(interval)
          bots[4]:PlaceTile(t.pos_x,t.pos_y,880)
          Sleep(1000)
        end
      end
      for _,t in pairs(bots[4]:GetWorld():GetTiles()) do
        if t.fg == 2978 then
          bots[4]:FindPath(t.pos_x,t.pos_y)
		  Sleep(interval)
          bots[4]:WrenchTile(t.pos_x,t.pos_y)
          Sleep(1000)
        end
      end
    end
    bots[4]:FindPath(tile[4].x,tile[4].y)
	Sleep(interval)
    while amount(880) > 0 do
      bots[4]:PlaceTile(tile[4].x-1,tile[4].y,880)
      Sleep(200)
      bots[4]:PlaceTile(tile[4].x+1,tile[4].y,880)
      Sleep(200)
      bots[4]:HitTile(tile[4].x-1,tile[4].y)
      Sleep(200)
      bots[4]:HitTile(tile[4].x+1,tile[4].y)
      Sleep(200)
      bots[4]:HitTile(tile[4].x-1,tile[4].y)
      Sleep(200)
      bots[4]:HitTile(tile[4].x+1,tile[4].y)
      Sleep(200)
    end
    for i = 2, right+1 do
      bots[4]:FindPath(tile[4].x+i,tile[4].y)
	  Sleep(interval)
      bots[4]:HitTile(tile[4].x+i,tile[4].y)
      Sleep(200)
    end
    for i = right+1, 2, -1 do
      bots[4]:FindPath(tile[4].x+i,tile[4].y)
	  Sleep(interval)
      bots[4]:PlaceTile(tile[4].x+i,tile[4].y,881)
      Sleep(200)
    end
  end
end)
RunThread(function()
  if bots[5] == nil then
    return
  end
  local function amount(id)
    if bots[5]:GetInventory():GetItem(id) then
      return bots[5]:GetInventory():GetItem(id).amount
    else
      return 0
    end
  end
  local function hook(c,v,n,d)
   if v[0]:find("OnDialogRequest") and v[1]:find("end_dialog|grinder") then
      c:SendPacket(2,("action|dialog_return\ndialog_name|grinder\ntilex|%d|\ntiley|%d|\nitemID|%d|\ncount|%d"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)"),v[1]:match("itemID|(%d+)"),v[1]:match("count||(%d+)")))
    end
    if v[0]:find("OnDialogRequest") and v[1]:find("end_dialog|vending") then
      if  v[1]:find("end_dialog|vending|Close||") then
        c:SendPacket(2,("action|dialog_return\ndialog_name|vending\ntilex|%d|\ntiley|%d|\nstockitem|4562"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)")))
      end
      if  v[1]:find("end_dialog|vending|Close|Update|") then
        c:SendPacket(2,("action|dialog_return\ndialog_name|vending\ntilex|%d|\ntiley|%d|\nbuttonClicked|addstock\n\nsetprice|%d\nchk_peritem|%d\nchk_perlock|%d"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)"),v[1]:match("setprice|Price|(%d+)"),v[1]:match("chk_peritem|World Locks per Item|(%d+)"),v[1]:match("chk_perlock|Items per World Lock|(%d+)")))
      end
    end
  end
  bots[5]:AddCallback(VARIANTLIST,"hook",hook)
  tile = {}
  for _,t in pairs(bots[5]:GetWorld():GetTiles()) do
    if t.bg == bg then
      tile[#tile+1] = {x = t.pos_x,
                            y = t.pos_y
                            }
    end
  end
  while true do
    if amount(880) >= 150 and amount(881) >= 100 then
      for _,t in pairs(bots[5]:GetWorld():GetTiles()) do
        if t.fg == 4582 then
          bots[5]:FindPath(t.pos_x,t.pos_y-1)
		  Sleep(interval)
          bots[5]:PlaceTile(t.pos_x,t.pos_y,880)
          Sleep(1000)
        end
      end
      for _,t in pairs(bots[5]:GetWorld():GetTiles()) do
        if t.fg == 2978 then
          bots[5]:FindPath(t.pos_x,t.pos_y)
		  Sleep(interval)
          bots[5]:WrenchTile(t.pos_x,t.pos_y)
          Sleep(1000)
        end
      end
    end
    bots[5]:FindPath(tile[5].x,tile[5].y)
	Sleep(interval)
    while amount(880) > 0 do
      bots[5]:PlaceTile(tile[5].x-1,tile[5].y,880)
      Sleep(200)
      bots[5]:PlaceTile(tile[5].x+1,tile[5].y,880)
      Sleep(200)
      bots[5]:HitTile(tile[5].x-1,tile[5].y)
      Sleep(200)
      bots[5]:HitTile(tile[5].x+1,tile[5].y)
      Sleep(200)
      bots[5]:HitTile(tile[5].x-1,tile[5].y)
      Sleep(200)
      bots[5]:HitTile(tile[5].x+1,tile[5].y)
      Sleep(200)
    end
    for i = -2, -(left+1), -1 do
      bots[5]:FindPath(tile[5].x+i,tile[5].y)
	  Sleep(interval)
      bots[5]:HitTile(tile[5].x+i,tile[5].y)
      Sleep(200)
    end
    for i = -(left+1), -2 do
      bots[5]:FindPath(tile[5].x+i,tile[5].y)
	  Sleep(interval)
      bots[5]:PlaceTile(tile[5].x+i,tile[5].y,881)
      Sleep(200)
    end
    if amount(880) >= 150 and amount(881) >= 100 then
      for _,t in pairs(bots[5]:GetWorld():GetTiles()) do
        if t.fg == 4582 then
          bots[5]:FindPath(t.pos_x,t.pos_y-1)
		  Sleep(interval)
          bots[5]:PlaceTile(t.pos_x,t.pos_y,880)
          Sleep(1000)
        end
      end
      for _,t in pairs(bots[5]:GetWorld():GetTiles()) do
        if t.fg == 2978 then
          bots[5]:FindPath(t.pos_x,t.pos_y)
		  Sleep(interval)
          bots[5]:WrenchTile(t.pos_x,t.pos_y)
          Sleep(1000)
        end
      end
    end
    bots[5]:FindPath(tile[5].x,tile[5].y)
	Sleep(interval)
    while amount(880) > 0 do
      bots[5]:PlaceTile(tile[5].x-1,tile[5].y,880)
      Sleep(200)
      bots[5]:PlaceTile(tile[5].x+1,tile[5].y,880)
      Sleep(200)
      bots[5]:HitTile(tile[5].x-1,tile[5].y)
      Sleep(200)
      bots[5]:HitTile(tile[5].x+1,tile[5].y)
      Sleep(200)
      bots[5]:HitTile(tile[5].x-1,tile[5].y)
      Sleep(200)
      bots[5]:HitTile(tile[5].x+1,tile[5].y)
      Sleep(200)
    end
    for i = 2, right+1 do
      bots[5]:FindPath(tile[5].x+i,tile[5].y)
	  Sleep(interval)
      bots[5]:HitTile(tile[5].x+i,tile[5].y)
      Sleep(200)
    end
    for i = right+1, 2, -1 do
      bots[5]:FindPath(tile[5].x+i,tile[5].y)
	  Sleep(interval)
      bots[5]:PlaceTile(tile[5].x+i,tile[5].y,881)
      Sleep(200)
    end
  end
end)
RunThread(function()
  if bots[6] == nil then
    return
  end
  local function amount(id)
    if bots[6]:GetInventory():GetItem(id) then
      return bots[6]:GetInventory():GetItem(id).amount
    else
      return 0
    end
  end
  local function hook(c,v,n,d)
   if v[0]:find("OnDialogRequest") and v[1]:find("end_dialog|grinder") then
      c:SendPacket(2,("action|dialog_return\ndialog_name|grinder\ntilex|%d|\ntiley|%d|\nitemID|%d|\ncount|%d"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)"),v[1]:match("itemID|(%d+)"),v[1]:match("count||(%d+)")))
    end
    if v[0]:find("OnDialogRequest") and v[1]:find("end_dialog|vending") then
      if  v[1]:find("end_dialog|vending|Close||") then
        c:SendPacket(2,("action|dialog_return\ndialog_name|vending\ntilex|%d|\ntiley|%d|\nstockitem|4562"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)")))
      end
      if  v[1]:find("end_dialog|vending|Close|Update|") then
        c:SendPacket(2,("action|dialog_return\ndialog_name|vending\ntilex|%d|\ntiley|%d|\nbuttonClicked|addstock\n\nsetprice|%d\nchk_peritem|%d\nchk_perlock|%d"):format(v[1]:match("tilex|(%d+)"),v[1]:match("tiley|(%d+)"),v[1]:match("setprice|Price|(%d+)"),v[1]:match("chk_peritem|World Locks per Item|(%d+)"),v[1]:match("chk_perlock|Items per World Lock|(%d+)")))
      end
    end
  end
  bots[6]:AddCallback(VARIANTLIST,"hook",hook)
  tile = {}
  for _,t in pairs(bots[6]:GetWorld():GetTiles()) do
    if t.bg == bg then
      tile[#tile+1] = {x = t.pos_x,
                            y = t.pos_y
                            }
    end
  end
  while true do
    if amount(880) >= 150 and amount(881) >= 100 then
      for _,t in pairs(bots[6]:GetWorld():GetTiles()) do
        if t.fg == 4582 then
          bots[6]:FindPath(t.pos_x,t.pos_y-1)
		  Sleep(interval)
          bots[6]:PlaceTile(t.pos_x,t.pos_y,880)
          Sleep(1000)
        end
      end
      for _,t in pairs(bots[6]:GetWorld():GetTiles()) do
        if t.fg == 2978 then
          bots[6]:FindPath(t.pos_x,t.pos_y)
		  Sleep(interval)
          bots[6]:WrenchTile(t.pos_x,t.pos_y)
          Sleep(1000)
        end
      end
    end
    bots[6]:FindPath(tile[6].x,tile[6].y)
	Sleep(interval)
    while amount(880) > 0 do
      bots[6]:PlaceTile(tile[6].x-1,tile[6].y,880)
      Sleep(200)
      bots[6]:PlaceTile(tile[6].x+1,tile[6].y,880)
      Sleep(200)
      bots[6]:HitTile(tile[6].x-1,tile[6].y)
      Sleep(200)
      bots[6]:HitTile(tile[6].x+1,tile[6].y)
      Sleep(200)
      bots[6]:HitTile(tile[6].x-1,tile[6].y)
      Sleep(200)
      bots[6]:HitTile(tile[6].x+1,tile[6].y)
      Sleep(200)
    end
    for i = -2, -(left+1), -1 do
      bots[6]:FindPath(tile[6].x+i,tile[6].y)
	  Sleep(interval)
      bots[6]:HitTile(tile[6].x+i,tile[6].y)
      Sleep(200)
    end
    for i = -(left+1), -2 do
      bots[6]:FindPath(tile[6].x+i,tile[6].y)
	  Sleep(interval)
      bots[6]:PlaceTile(tile[6].x+i,tile[6].y,881)
      Sleep(200)
    end
    if amount(880) >= 150 and amount(881) >= 100 then
      for _,t in pairs(bots[6]:GetWorld():GetTiles()) do
        if t.fg == 4582 then
          bots[6]:FindPath(t.pos_x,t.pos_y-1)
		  Sleep(interval)
          bots[6]:PlaceTile(t.pos_x,t.pos_y,880)
          Sleep(1000)
        end
      end
      for _,t in pairs(bots[6]:GetWorld():GetTiles()) do
        if t.fg == 2978 then
          bots[6]:FindPath(t.pos_x,t.pos_y)
		  Sleep(interval)
          bots[6]:WrenchTile(t.pos_x,t.pos_y)
          Sleep(1000)
        end
      end
    end
    bots[6]:FindPath(tile[6].x,tile[6].y)
	Sleep(interval)
    while amount(880) > 0 do
      bots[6]:PlaceTile(tile[6].x-1,tile[6].y,880)
      Sleep(200)
      bots[6]:PlaceTile(tile[6].x+1,tile[6].y,880)
      Sleep(200)
      bots[6]:HitTile(tile[6].x-1,tile[6].y)
      Sleep(200)
      bots[6]:HitTile(tile[6].x+1,tile[6].y)
      Sleep(200)
      bots[6]:HitTile(tile[6].x-1,tile[6].y)
      Sleep(200)
      bots[6]:HitTile(tile[6].x+1,tile[6].y)
      Sleep(200)
    end
    for i = 2, right+1 do
      bots[6]:FindPath(tile[6].x+i,tile[6].y)
	  Sleep(interval)
      bots[6]:HitTile(tile[6].x+i,tile[6].y)
      Sleep(200)
    end
    for i = right+1, 2, -1 do
      bots[6]:FindPath(tile[6].x+i,tile[6].y)
	  Sleep(interval)
      bots[6]:PlaceTile(tile[6].x+i,tile[6].y,881)
      Sleep(200)
    end
  end
end)
