
event_inherited()

primary = false

active = false

function scrWepstickUpdateSprite(plr) {
	var _wep = active ? plr.wep : plr.bwep
	
	if _wep
		wep_spr = wep_sprt[_wep]
	
}

rad *= 0.8