local addon, ns = ...
local cfg = ns.cfg

local dl={
	408,
	703,
	1833,
	84617,
	--1943, --rapture
	--91023, --find weak
	--16511, -- hemo
}


--some local functions
local function cu(s)
	return UnitDebuff("target",GetSpellInfo(s))
end
local function Cb(i,s)
	local name,rank,icon=GetSpellInfo(s);
	local f=CreateFrame("Frame")
	f:SetSize(cfg.dbtracker.iconsize, cfg.dbtracker.iconsize)
	f.t=f:CreateTexture(nil, cfg.dbtracker.border)
	f.t:SetAllPoints(true)
	f.t:SetTexture(icon)
	f.f=f:CreateFontString(nil, cfg.dbtracker.border)
	f.f:SetFont(cfg.dbtracker.font, cfg.dbtracker.fontsize, cfg.dbtracker.fontstyle)
	f.f:SetPoint("BOTTOMRIGHT",0,0)
	return f;
end
local function vb(s,i,row)
	local b1,_,_,b4=cu(s)
	local f=_G["B"..i]
	if b1 then 
		f:Show()
		f:SetPoint(cfg.dbtracker.anch, 
				   cfg.dbtracker.x+(cfg.dbtracker.iconsize+2)*math.ceil((row-1)%cfg.dbtracker.br),
				   cfg.dbtracker.y-(cfg.dbtracker.iconsize)*math.ceil(row/cfg.dbtracker.br))
		if(b4>1)then
			f.f:SetText(b4)
		end
		row=row+1;
	end
	return row;
end
local function ub()
	for i,s in ipairs(dl)do
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
	f.c=f:CreateFontString(nil,cfg.dbtracker.border)
	f.c:SetFont(cfg.dbtracker.font,cfg.dbtracker.fontsize,cfg.dbtracker.fontstyle)
	f.c:SetPoint(cfg.dbtracker.textanch, cfg.dbtracker.textX, cfg.dbtracker.textY)
end
local function db()
	for i in ipairs(dl)do
		_G["B"..i]:Hide()
	end
end

-- start dbtracker
for i,s in ipairs( dl)do _G["B"..i]=Cb(i,s)Cc(_G["B"..i])_G["B"..i]:Hide()end
local function bb()
	db()
	local bw=1;
	for i,s in ipairs( dl)do
		bw=vb(s,i,bw)
	end
end

dk=CreateFrame("Frame")
dk:SetScript("OnEvent",bb)
dk:SetScript("OnUpdate",ub)
dk:RegisterEvent("UNIT_AURA")
