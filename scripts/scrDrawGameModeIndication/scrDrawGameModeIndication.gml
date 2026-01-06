function scrDrawGameModeIndication() {
	var _x = view_width / 2,
		_y = view_height / 2 - 45
	
    if (instance_exists(DailyList) || instance_exists(UnlockScreen)
		|| UberCont.bossintro || instance_exists(MenuOptions)
	) {
		exit
	}
	
	var _subimage = -1, _name = undefined
	
    if scrGameIsEventRun() {
		_subimage = scrGameIsWeeklyRun() ? 2 : 1
	}
	else if scrGameIsCustomMode() {
		_subimage = 4
	}
    else if scrGameIsHardmode() {
		_subimage = 3
	}
	
	if (_subimage == -1) exit
	
	_name = scrMenuButtonName(sprPlayButtons, _subimage)
	
	if (is_string(_name)) {
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