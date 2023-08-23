function scrGamemodePlaybuttons() {
	var _x = view_width / 2,
		_y = view_height / 2 - 48
	
    if !instance_exists(DailyList) && !instance_exists(UnlockScreen) && !UberCont.bossintro && !instance_exists(MenuOptions) {
        if UberCont.daily_run {
			var i = 1 + UberCont.weekly_run,
				name = scrMenuButtonName(sprPlayButtons, i)
			
			if loc_exists(name) {
				draw_set_halign(fa_center)
				draw_set_valign(fa_center)
				
				draw_bigname(_x, _y, loc(name))
				
				draw_set_halign(fa_left)
				draw_set_valign(fa_top)
			}
			else {
	            draw_sprite_ext(sprPlayButtons, i, _x + 1, _y + 1, 1, 1, 0, c_black, 1)
	            draw_sprite_ext(sprPlayButtons, i, _x, _y + 1, 1, 1, 0, c_black, 1)
	            draw_sprite_ext(sprPlayButtons, i, _x, _y, 1, 1, 0, c_white, 1)
	        }
		}
		
        if global.hardmode {
			var name = scrMenuButtonName(sprPlayButtons, 3)
			
			if loc_exists(name) {
				draw_set_halign(fa_center)
				draw_set_valign(fa_center)
				
				draw_bigname(_x, _y, loc(name))
				
				draw_set_halign(fa_left)
				draw_set_valign(fa_top)
			}
			else {
	            draw_sprite_ext(sprPlayButtons, 3, _x + 1, _y + 1, 1, 1, 0, c_black, 1)
	            draw_sprite(sprPlayButtons, 3, _x, _y)
	        }
		}
    }
}