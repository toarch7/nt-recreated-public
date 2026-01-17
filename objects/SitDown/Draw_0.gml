if (!sit) exit

with (player) {
	var _weps = scrPlayerGetWeapons(id),
		_count = array_length(_weps)
	
	for(var i = 0; i < _count; ++i) {
		var _sprite = scr_weapon_get_sprite(_weps[i])
		
		if sprite_exists(_sprite) {
			var _color = merge_color(c_white, c_dkgray, i / 6)
			draw_sprite_ext(_sprite, 0, x, y, 1, 1, 90 + i * 15, _color, 1)
		}
	}
	
	depth = other.depth - 1
}

if sprite_exists(sprite_index) draw_self()