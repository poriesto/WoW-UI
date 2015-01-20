function BuffInfo(aura)
	return UnitBuff("player", GetSpellInfo(aura));
end
function DebuffInfo(debuff)
	return UnitDebuff("target", GetSpellInfo(debuff);
end

function Create(i, s, cfg)
	local name,rank,icon=GetSpellInfo(s);
	local f=CreateFrame("Frame");
	
end
