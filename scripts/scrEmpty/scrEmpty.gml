function scrEmpty() {
    clicked = false
    snd_play(sndEmpty)
	
    var _instance = scrPopupCreate(x, y, loc("HUD:NoAmmo", "EMPTY")),
		_type = scr_weapon_get_type(wep)
	
	if (ammo[_type] > 0) {
		var _ammo_name = loc("Ammo:Type", _type, typ_name[_type])
		
		_instance.mytext = loc_fmt_either(
			$"HUD:InsAmmo:{_type}", "HUD:InsAmmo", "NOT ENOUGH %", _ammo_name)
	}
	else if (wep_rads[wep] > 0 && GameCont.rad < wep_rads[wep]) {
        _instance.mytext = loc("HUD:InsRads", "NOT ENOUGH RADS")
    }
	
	drawempty = 30
    clicked = 0
    wkick = -2
}

function scrEmptyB() {
    clicked = false
    snd_play(sndEmpty)
	
    var _instance = scrPopupCreate(x, y, loc("HUD:NoAmmo", "EMPTY")),
		_type = scr_weapon_get_type(bwep)
	
	if (ammo[_type] > 0) {
		var _ammo_name = loc("Ammo:Type", _type)
		
		_instance.mytext = loc_fmt_either(
			$"HUD:InsAmmo:{_type}", "HUD:InsAmmo", "NOT ENOUGH %", _ammo_name)
	}
	else if (wep_rads[bwep] > 0 && GameCont.rad < wep_rads[bwep]) {
        _instance.mytext = loc("HUD:InsRads", "NOT ENOUGH RADS")
    }
	
    clicked = 0
    wkick = -2
}

function scrEmptyRads() {
	scrPopupCreate(x, y, loc("HUD:InsRads", "NOT ENOUGH RADS"))
	snd_play_hit(sndUltraEmpty, 0.2)
    wkick = -2
}