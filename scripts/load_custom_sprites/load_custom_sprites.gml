function load_custom_sprites(_namespace, _load_directory) {
	static _header_buffer = buffer_create(32, buffer_fixed, 1)
	
	var _load_errors = 0,
		
		_sprite_files = directory_read(_load_directory + "*.png", fa_directory),
		_sprite_file_count = array_length(_sprite_files),
		
		_sprite_replacement_markings = global.custom_sprite_markings,
		_frame_replacement_indices = global.custom_texturepage_replacement_frames,
		
		_compactor = new CustomTexturePageCompactor(),
		_texture_rects = global.custom_texturepage_bucket,
		_temporary_sprites = global.temporary_custom_sprites
	
	scr_log_push($"[{_namespace}] {_sprite_file_count} images to process", c_gray)
	
	for(var _file_index = _sprite_file_count - 1; _file_index >= 0; --_file_index) {
		var _handled = false,
			_file_name = _sprite_files[_file_index],
			_sprite_name = string_replace(_file_name, ".png", ""),
			_sprite_path = _load_directory + _file_name,
			_sprite_location = $"{_namespace}/usersprites/{_file_name}",
			_original_sprite = asset_get_index(_sprite_name),
			_is_strip_replacement = false,
			_strip_replacement_frames = -1,
			_is_frame_replacement = false,
			_frame_replacement_index = -1,
			_png_width, _png_height;
		
		buffer_load_partial(_header_buffer, _sprite_path, 0, 31, 0)
		buffer_seek(_header_buffer, buffer_seek_start, 0)
		
		if (!(buffer_read(_header_buffer, buffer_u8) == 0x89
			&& buffer_read(_header_buffer, buffer_u8) == 0x50
			&& buffer_read(_header_buffer, buffer_u8) == 0x4E
			&& buffer_read(_header_buffer, buffer_u8) == 0x47)
		) {
			scr_log_push($"[!!!] {_sprite_location} is not a valid PNG image", c_red)
			_load_errors ++
			continue
		}
	
		_png_width = buffer_peek_u32be(_header_buffer, 16)
		_png_height = buffer_peek_u32be(_header_buffer, 20)
		
		if (_png_width > 0x2000 || _png_height >= 0x2000) {
			scr_log_push($"[!!!] \"{_sprite_name}\" PNG format is invalid (width and height are too big {_png_width}/{_png_height}), or the provided image is just too big", c_red)
			_load_errors ++
			continue
		}
		
		if (!sprite_exists(_original_sprite) && string_pos("_", _sprite_name) != 0) {
			var _strip_suffix_pos = string_pos("_strip", _sprite_name)
			
			if (_strip_suffix_pos != 0) {
				if (_strip_suffix_pos == 1) {
					scr_log_push($"[!!!] \"{_sprite_name}\" is not a valid sprite name")
					_load_errors ++
					continue
				}
				
				var _frame_number_slice = string_digits(string_copy(
						_sprite_name, _strip_suffix_pos, string_length(_sprite_name)))
				
				_strip_replacement_frames = scrRealExt(_frame_number_slice)
				
				if (!is_numeric(_strip_replacement_frames) || _strip_replacement_frames <= 0) {
					scr_log_push($"[!!!] {_frame_number_slice} is not a valid number of frames (in {_sprite_location})")
					_load_errors ++
					continue
				}
				
				_original_sprite = asset_get_index(string_copy(_sprite_name, 1, _strip_suffix_pos - 1))
				if (sprite_exists(_original_sprite)) _sprite_name = sprite_get_name(_original_sprite)
				_is_strip_replacement = true
			}
			else {
				var _frame_suffix_pos = string_pos("_frame", _sprite_name)
				
				if (_frame_suffix_pos != 0) {
					if (_frame_suffix_pos == 1) {
						scr_log_push($"[!!!] \"{_sprite_name}\" is not a valid sprite name")
						_load_errors ++
						continue
					}
					
					var _frame_number_slice = string_digits(string_copy(
							_sprite_name, _frame_suffix_pos, string_length(_sprite_name)))
					
					_frame_replacement_index = scrRealExt(_frame_number_slice)
					
					if (!is_numeric(_frame_replacement_index) || _frame_replacement_index < 0) {
						scr_log_push($"[!!!] {_frame_number_slice} is not a valid frame number (in {_sprite_location})")
						_load_errors ++
						continue
					}
					
					_original_sprite = asset_get_index(string_copy(_sprite_name, 1, _frame_suffix_pos - 1))
					
					if (sprite_exists(_original_sprite)) {
						_sprite_name = sprite_get_name(_original_sprite)
						
						if (_frame_replacement_index >= sprite_get_number(_original_sprite)) {
							scr_log_push($"[!!!] cannot replace frame {_frame_replacement_index} of \"{_sprite_location}\": the index number exceeds max frames ({sprite_get_number(_original_sprite)})")
							_load_errors ++
							continue
						}
						else if (variable_struct_exists(_frame_replacement_indices, _sprite_name)
							&& _frame_replacement_indices[$ _sprite_name][_frame_replacement_index] != _original_sprite
						) {
							scr_log_push($"[!] frame {_frame_number_slice} of {_sprite_name} is already replaced in another resourcepack. Skipped", c_ltgray)
							continue
						}
					}
					
					_is_frame_replacement = true
				}
			}
		}
		
		if (!sprite_exists(_original_sprite)) {
			scr_log_push($"[!!!] \"{_sprite_name}\" is not a known sprite name", c_red)
			_load_errors ++
			continue
		}
		
		if (!_is_frame_replacement && variable_struct_exists(global.custom_sprite_registry, _sprite_name)) {
			var _replaced_by_whom = global.custom_sprite_registry[$ _sprite_name].full_name
			scr_log_push($"\"{_sprite_name}\" was alreday replaced in {_replaced_by_whom}", c_ltgray)
			continue
		}
		
		var _replacement_frames, _sprite_frames = sprite_get_number(_original_sprite);
		
		/**/ if (_is_frame_replacement) _replacement_frames = 1
		else if (_is_strip_replacement) _replacement_frames = _strip_replacement_frames
		else _replacement_frames = _sprite_frames
		
		if (_replacement_frames > 1 && frac(_png_width / _replacement_frames) != 0) {
			scr_log_push($"[!!!] cannot replace \"{_sprite_location}\" - the width ({_png_width}) canot be split into {_replacement_frames} equal frames", c_red)
			_load_errors ++
			continue
		}
		
		if (!_is_frame_replacement && _sprite_frames != _replacement_frames) {
			scr_log_push($"[!!!] cannot replace {_sprite_location} - the number of frames doesn't match (expected: {_sprite_frames}, replacement: {_replacement_frames})", c_red)
			_load_errors ++
			continue
		}
		
		var _replacement_sprite = sprite_add(_sprite_path, _replacement_frames, 0, 0, 0, 0)
		
		if (!sprite_exists(_replacement_sprite)) {
			scr_log_push($"[!!!] failed to load sprite for {_sprite_location}")
			_load_errors ++
			continue
		}
		else {
			array_push(_temporary_sprites, _replacement_sprite)
		}
		
		if (!variable_struct_exists(_sprite_replacement_markings, _sprite_name)) {
			sprite_strip_save(_original_sprite, "replacedsprites/" + sprite_get_name(_original_sprite) + ".png")
		}
		
		var _replacement_sprite_width = sprite_get_width(_replacement_sprite),
			_replacement_sprite_height = sprite_get_height(_replacement_sprite)
		
		if (_is_frame_replacement) {
			var _sprite_frame_array;
			
			if (!variable_struct_exists(_frame_replacement_indices, _sprite_name)) {
				_sprite_frame_array = array_create(_sprite_frames)
				
				for(var i = _sprite_frames - 1; i >= 0; --i) {
					_sprite_frame_array[i] = _original_sprite
				}
				
				_frame_replacement_indices[$ _sprite_name] = _sprite_frame_array
			}
			else {
				_sprite_frame_array = _frame_replacement_indices[$ _sprite_name]
			}
			
			_sprite_frame_array[_frame_replacement_index] = _replacement_sprite
		}
		else {
			for(var _subimage = _replacement_frames - 1; _subimage >= 0; --_subimage) {
				array_push(_texture_rects, new CustomTexturePageRect(_sprite_name, _subimage,
					_replacement_frames, _replacement_sprite_width, _replacement_sprite_height, _replacement_sprite))
			}
		}
	}
	
	return _load_errors
}