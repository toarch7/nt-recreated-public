function scrDrawGameModeIndication() {
	var _x = view_width / 2,
		_y = view_height / 2 - 48
	
    if !instance_exists(DailyList) && !instance_exists(UnlockScreen) && !UberCont.bossintro && !instance_exists(MenuOptions) {
        if scrGameIsEventRun() {
			var _subimage = scrGameIsWeeklyRun() ? 2 : 1,
				_name = scrMenuButtonName(sprPlayButtons, _subimage)
			
			if is_string(_name) {
				draw_set_halign(fa_center)
				draw_set_valign(fa_middle)
				
				draw_text_bigname(_x, _y, _name)
				
				draw_set_halign(fa_left)
				draw_set_valign(fa_top)
			}
			else {
	            draw_sprite_ext(sprPlayButtons, _subimage, _x + 1, _y + 1, 1, 1, 0, c_black, 1)
	            draw_sprite_ext(sprPlayButtons, _subimage, _x, _y + 1, 1, 1, 0, c_black, 1)
	            draw_sprite_ext(sprPlayButtons, _subimage, _x, _y, 1, 1, 0, c_white, 1)
	        }
		}
		
        if scrGameIsHardmode() {
			var _name = scrMenuButtonName(sprPlayButtons, 3)
			
			if loc_exists(_name) {
				draw_set_halign(fa_center)
				draw_set_valign(fa_middle)
				
				draw_text_bigname(_x, _y, loc(_name))
				
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