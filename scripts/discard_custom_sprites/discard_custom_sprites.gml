function discard_custom_sprites(_restore_original_sprites) {
	if (_restore_original_sprites) {
		array_foreach(global.replaced_base_sprites, function(_sprite_name) {
			var _sprite_index = asset_get_index(_sprite_name),
				_path = $"replacedsprites/{_sprite_name}.png"
			
			sprite_replace(
				_sprite_index, _path,
				
				sprite_get_number(_sprite_index),
				
				false, false,
				
				sprite_get_xoffset(_sprite_index),
				sprite_get_yoffset(_sprite_index))
		})
	}
	
	global.replaced_base_sprites = []
	
}