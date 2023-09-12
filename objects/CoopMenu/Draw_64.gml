if local_wait
	local_wait --

if UberCont.showtutorial {
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
	
    draw_text_shadow(view_width / 2, view_height / 2, "YOU HAVEN'T COMPLETED TUTORIAL LEVEL YET")
    
	draw_set_halign(fa_top)
    draw_set_valign(fa_left)
    
	exit
}


if !instance_exists(CoopController) {
	if gamepad_button_check_pressed(0, gp_start) {
	    with UberCont
			localcoop = 1
		
	    var ind = 0
		
	    repeat 2 {
	        var inst = new PlayerInstance(ind)
			
			inst.race = irandom(11) + 1
			inst.bskin = !irandom(2)
			
	        inst.cwep = UberCont.race_swep[inst.race]
			
			ind ++
	    }
		
	    with SpiralCont
			instance_destroy()
		
	    instance_create(0, 0, GameCont)
	    instance_create(0, 0, MenuGen)
		
	    with CoopMenu
	        instance_destroy()
	}
}


draw_set_color(c_white)

if refresh
	refresh --

if menu == noone {
	menu = instance_create(x, y, MenuOptions)
	
	menu.dispose_on_empty = true
	menu.category_set(OptionCategory.Coop_Menu, false)
}
else if !instance_exists(menu) {
	var players = struct_keys(playerinstances)
	
	if connected {
		var dy = view_height / 2,
			len = array_length(players)
		
		array_sort(players, true)
		
		dy -= len * 14
		
		for(var i = 0; i < len; i ++) {
			var ind = players[i],
				player = playerinstances[$ ind]
			
			draw_playerinstance(player.index, view_width / 2, dy, 160, fa_center)
			
			dy += 28
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