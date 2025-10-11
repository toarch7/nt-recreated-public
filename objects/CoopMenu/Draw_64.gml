if local_wait
	local_wait --

if UberCont.showtutorial {
	draw_align(fa_center, fa_middle)
    draw_text_shadow(view_width / 2, view_height / 2, "YOU HAVEN'T COMPLETED TUTORIAL LEVEL YET")
    draw_align()
	
	exit
}


if !instance_exists(CoopController) {
	if gamepad_button_check_pressed(0, gp_start) {
	    with UberCont
			localcoop = 1
		
	    var _index = 0
		
	    repeat 2 {
	        var _pint = new PlayerInstance(_index),
				_race_id = irandom_range(1, racemax),
				_max_skins = scrRaceGetMaxSkinCount(_race_id)
			
			_pint.race = _race_id
			_pint.bskin = irandom(_max_skins)
			
	        _pint.cwep = scrRaceGetStarterWeapon(_race_id)
			
			_index ++
	    }
		
	    instance_create(0, 0, GameCont)
	    instance_create(0, 0, MenuGen)
		instance_destroy(SpiralCont)
		instance_destroy(CoopMenu)
	}
}


draw_set_color(c_white)

if refresh
	refresh --

if menu == noone {
	with instance_create(x, y, MenuOptions) {
		dispose_on_empty = true
		other.menu = id
	}
	
	scrOptionsMenuChangeCategory(OptionCategory.Coop_Menu, false)
}
else if !instance_exists(menu) {
	var _player_instances = struct_keys(global.__playerinstance_list)
	
	if connected {
		var _dy = view_height / 2,
			_length = array_length(_player_instances)
		
		array_sort(_player_instances, true)
		
		_dy -= _length * 14
		
		for(var i = 0; i < _length; i ++) {
			var _index = _player_instances[i],
				_pinst = global.__playerinstance_list[$ _index]
			
			scr_draw_multiplayer_player_card(_pinst.index, view_width / 2, _dy, 160, fa_center)
			
			_dy += 28
		}
		
		draw_set_halign(fa_left)
	}
	else {
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		
		draw_text_nt(view_width / 2, view_height / 2, loc(text))
		
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
	}
}