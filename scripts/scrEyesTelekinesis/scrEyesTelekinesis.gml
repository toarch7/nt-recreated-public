function scrEyesTelekinesis() {
	var _w = game_screen_width div 2,
		_h = game_screen_height div 2,
		
		_px = x,
		_py = y,
		
		_left = _px - _w,
		_top = _py - _h,
		
		_right = _px + _w,
		_bottom = _py + _h
	
	var _strength = 1 + scr_skill_get(mut_throne_butt)
	
	#macro mcr_eyes_telekenesis \
		if (x > _left && y > _top && x < _right && y < _bottom) { \
			var _dir = point_direction(x, y, _px, _py), \
				_lx = lengthdir_x(_strength, _dir), \
				_ly = lengthdir_y(_strength, _dir) \
			if (!place_meeting(x + _lx, y, Wall)) x += _lx \
			if (!place_meeting(x, y + _ly, Wall)) y += _ly \
		}
	
	// push away
	with projectile {
		var _dir = point_direction(_px, _py, x, y),
			_lx = lengthdir_x(_strength, _dir),
			_ly = lengthdir_y(_strength, _dir)
		if (!place_meeting(x + _lx, y, Wall)) x += _lx
		if (!place_meeting(x, y + _ly, Wall)) y += _ly
	}
	
	// attract
	with enemy mcr_eyes_telekenesis;
	with chestprop mcr_eyes_telekenesis;
	with AmmoPickup mcr_eyes_telekenesis;
	with HPPickup mcr_eyes_telekenesis;
	with WepPickup mcr_eyes_telekenesis;
	with RadChest mcr_eyes_telekenesis;
	with Rad mcr_eyes_telekenesis;
}