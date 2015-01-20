local addon, ns = ...
local cfg = ns.cfg

local bl={2983, 1966, 32406, 114015, 5171, 73651, 5277, 31224,114018,
		84745, 84746, 84747, 13750, 13877, --combat stuff
		51713, 31223,  				-- sub stuff
		32645, 					-- ass stuf
	}

--some local functions
local function cu(s)
	return UnitBuff("player",GetSpellInfo(s))
end
local function Cb(i,s)
	local name,rank,icon=GetSpellInfo(s);
	local f=CreateFrame("Frame")
	f:SetSize(cfg.tracker.iconsize, cfg.tracker.iconsize)
	f.t=f:CreateTexture(nil, cfg.tracker.border)
	f.t:SetAllPoints(true)
	f.t:SetTexture(icon)
	f.f=f:CreateFontString(nil, cfg.tracker.border)
	f.f:SetFont(cfg.tracker.font, cfg.tracker.fontsize, cfg.tracker.fontstyle)
	f.f:SetPoint("BOTTOMRIGHT",0,0)
	return f;
end
local function vb(s,i,row)
	local b1,_,_,b4=cu(s)
	local f=_G["B"..i]
	if b1 then 
		f:Show()
		f:SetPoint(cfg.tracker.anch, 
				   cfg.tracker.x+(cfg.tracker.iconsize+2)*math.ceil((row-1)%cfg.tracker.br),
				   cfg.tracker.y-(cfg.tracker.iconsize)*math.ceil(row/cfg.tracker.br))
		if(b4>1)then
			f.f:SetText(b4)
		end
		row=row+1;
	end
	return row;
end
local function ub()
	for i,s in ipairs(bl)do
		local b,_,_,_,_,_,k=cu(s)
		if b then
			local vt=math.floor(k-GetTime())
			if (vt>=60)then 
				vt=math.ceil(vt/60)_G["B"..i].c:SetText(vt.."m")
			elseif vt >= 0 then 
				_G["B"..i].c:SetText(vt.."s")
			end
		end
	end
end
local function Cc(f)
	f.c=f:CreateFontString(nil,cfg.tracker.border)
	f.c:SetFont(cfg.tracker.font,cfg.tracker.fontsize,cfg.tracker.fontstyle)
	f.c:SetPoint(cfg.tracker.textanch, cfg.tracker.textX, cfg.tracker.textY)
end
local function db()
	for i in ipairs(bl)do
		_G["B"..i]:Hide()
	end
end

-- start tracker
for i,s in ipairs(bl)do _G["B"..i]=Cb(i,s)Cc(_G["B"..i])_G["B"..i]:Hide()end
local function bb()
	db()
	local bw=1;
	for i,s in ipairs(bl)do
		bw=vb(s,i,bw)
	end
end

bk=CreateFrame("Frame")
bk:SetScript("OnEvent",bb)
bk:SetScript("OnUpdate",ub)
bk:RegisterEvent("UNIT_AURA")
