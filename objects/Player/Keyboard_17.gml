if (is_keyboard_used_debug_overlay() || global.console_active || UberCont.public) exit

if scr_keyboard_check_pressed(ord("H")) {
    hp = 10000
    max_hp = hp
	lsthealth = hp
}

if scr_keyboard_check_pressed(ord("R")) game_restart()

//CHEATS
var _weapon_change = (mouse_wheel_down() - mouse_wheel_up())
	
if (_weapon_change == 0) {
	_weapon_change = scr_keyboard_check_pressed(ord("X")) - scr_keyboard_check_pressed(ord("Z"))
}
	
if (_weapon_change != 0) {
	wep -= _weapon_change
	
	if !scr_weapon_is_valid(wep) {
		if (wep <= 0) wep = maxwep - 1
		else wep = wep_revolver
	}
		
	var _type = scr_weapon_get_type(wep)
		
	if (_type) ammo[_type] = scrAmmoGetTypeCapacity(_type)
	with (instance_create(x, y, WepSwap)) target = other.id
	with (PopupText) if (self[$ "__from_debug"]) instance_destroy()
	with (scrPopupCreate(x, y, scr_weapon_get_name(wep) + "!")) {
		self[$ "__from_debug"] = true
	}
	snd_play(wep_swap[wep])
}

if scr_keyboard_check_pressed(ord("V")) {
    with (instance_create(x, y, Portal)) {
        sprite_index = sprPortalDisappear
        event_perform(ev_other, ev_animation_end)
    }
}

if scr_keyboard_check_pressed(ord("C")) {
    instance_create(mouse_x, mouse_y, Bandit)
}

if scr_keyboard_check_pressed(ord("P")) {
    instance_create(mouse_x, mouse_y, SnowTank)
}

if scr_keyboard_check_held(ord("B")) {
    if scr_keyboard_check_held(vk_shift) repeat 10 instance_create(x, y, BigRad)
    else instance_create(x, y, BigRad)
}

if scr_keyboard_check_pressed(ord("K")) {
    with enemy
    hp = 0
}
