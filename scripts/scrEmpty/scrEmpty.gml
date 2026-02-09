function scrEmpty() {
    var _type = scr_weapon_get_type(wep)
	if (_type == Ammo.None) exit
	
    var _instance = scrPopupCreate(x, y, loc("HUD:NoAmmo", "EMPTY")),
	
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
    snd_play(sndEmpty)
}

function scrEmptyB() {
    var _type = scr_weapon_get_type(bwep)
	if (_type == Ammo.None) exit
	
    var _instance = scrPopupCreate(x, y, loc("HUD:NoAmmo", "EMPTY"))
	
	if (ammo[_type] > 0) {
		var _ammo_name = loc("Ammo:Type", _type)
		
		_instance.mytext = loc_fmt_either(
			$"HUD:InsAmmo:{_type}", "HUD:InsAmmo", "NOT ENOUGH %", _ammo_name)
	}
	else if (wep_rads[bwep] > 0 && GameCont.rad < wep_rads[bwep]) {
        _instance.mytext = loc("HUD:InsRads", "NOT ENOUGH RADS")
    }
	
	bwkick = -2
	snd_play(sndEmpty)
}

function scrEmptyRads() {
	scrPopupCreate(x, y, loc("HUD:InsRads", "NOT ENOUGH RADS"))
	snd_play_hit(sndUltraEmpty, 0.2)
    wkick = -2
}