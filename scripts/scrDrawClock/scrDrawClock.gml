function scrDrawClock(_x, _y, _blend = c_white) {
	var _tz = date_get_timezone()
	
	if (_tz == timezone_utc) date_set_timezone(timezone_local)
	
	var _hour = current_hour,
		_minute = current_minute,
		_hour_angle = (_hour / 12 * -360) + 90,
		_minute_angle = (_minute / 60 * -360) + 90,
		_surface = -1,
		_dx = _x,
		_dy = _y
	
	if (UberCont.opt_scaling > 1) {
		_surface = surface_create(32, 32)
		
		surface_set_target(_surface)
		draw_clear_alpha(c_black, 0)
		
		_dx = 16
		_dy = 16
	}
	
	draw_sprite_ext(sprClockParts, 0, _dx, _dy, 1, 1, _minute_angle, _blend, 1)
	draw_sprite_ext(sprClockParts, 0, _dx, _dy, 1, 1, _hour_angle, _blend, 1)
	draw_sprite_ext(sprClockParts, 1, _dx, _dy, 1, 1, 0, _blend, 1)
	
	if (_surface != -1) {
		surface_reset_target()
		
		if (surface_exists(_surface)) {
			draw_surface(_surface, _x - _dx, _y - _dy)
			surface_free(_surface)
		}
	}
	
	date_set_timezone(_tz)
}