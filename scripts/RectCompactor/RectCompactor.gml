#macro compactor_texturepage_width 2048
#macro compactor_texturepage_height 2048

function CustomTexturePageRect(_name, _image, _max_images, _width, _height, _sprite) constructor {
	assert(is_numeric(_sprite) && _sprite >= 0, _name)
	
	name = _name
	image_index = _image
	image_number = _max_images
	
	width = _width
	height = _height
	
	sprite = _sprite
	
	weight = _width * _height * _height
	
	x = 0
	y = 0
	
	// frame background color for debugging purposes
	image_blend = c_white
	
	is_sorted = false
	sort_index = -1
	
	static to_frame_entry = function(_texturepage_index) {
		return {
			"x": x,
			"y": y,
			"w": width,
			"h": height,
			"tp": _texturepage_index
		}
	}
}

function CustomTexturePageCompactor() constructor {
	rectangles = undefined
	
	static populate_textures = function(_texture_rects) {
		var _count = array_length(_texture_rects)
		
		rectangles = array_create(_count)
		
		array_copy(rectangles, 0, _texture_rects, 0, _count)
	}
	
	static count_rects = function() {
		return array_length(rectangles)
	}
	
	static find_tiniest_fit = function(_min_width, _from_index = 0) {
		var _rectangles = rectangles,
			_count = array_length(_rectangles),
			
			_result_index = -1,
			_max_width = 0
		
		for(var i = _from_index; i < _count; ++i) {
			var _rectangle = _rectangles[i]
			
			if (!_rectangle.is_sorted
				&& _rectangle.width < _min_width
				&& _rectangle.width > _max_width
			) {
				_max_width = _rectangle.width
				_result_index = i
			}
		}
		
		if (_result_index >= 0) {
			var _result = _rectangles[_result_index]
			array_delete(_rectangles, _result_index, 1)
			array_insert(_rectangles, _from_index, _result)
			return _result
		}
		
		return undefined
	}
	
	static process_texture_pages = function () {
		var _rectangles = rectangles,
			_rectangle_count = array_length(_rectangles),
			_texture_pages = [];
		
		_rectangles = rectangles
		_rectangle_count = count_rects()
		
		array_sort(_rectangles, function(a, b) {
			var _d = b.weight - a.weight
			if (_d == 0) _d = (b.image_number - a.image_number)
			if (_d == 0) _d = (a.name > b.name) ? -1 : 1
			return sign(_d)
		})
		
		var _px = 0,
			_py = 0,
			
			_grid_width = compactor_texturepage_width,
			_grid_height = compactor_texturepage_height,
			
			_max_rect_height = 0,
			
			_rectangle_index = 0,
			_skipped_index_start = -1,
			
			_sprite_data = {}
		
		while (_rectangle_index < _rectangle_count) {
			var _rectangle = _rectangles[_rectangle_index]
			
			if (_rectangle.is_sorted) {
				_rectangle_index ++
				continue
			}
			
			var _sprite_name = _rectangle.name,
				
				_width = _rectangle.width,
				_height = _rectangle.height,
				
				_is_present = variable_struct_exists(_sprite_data, _sprite_name),
				
				_all_good = true,
				_cannot_fit_whole = false,
				_new_page_requested = false
			
			// skip if we can't fit this sprite vertically
			if ((_py + _rectangle.height) >= _grid_height) {
				_new_page_requested = true
				_cannot_fit_whole = true
				_all_good = false
			}
			
			if (_all_good) {
				_rectangle.x = _px
				_rectangle.y = _py
				
				_rectangle.sort_index = _rectangle_index
				_rectangle.is_sorted = true
				
				_max_rect_height = max(_height, _max_rect_height)
				
				if ((_px + _width) >= _grid_width) {
					var _leftover = _width - ((_px + _width) - _grid_width)
					
					for (;;) {
						// TODO: implement height check
						var _fit = find_tiniest_fit(_leftover, _rectangle_index + 1)
						//print("fitting", _leftover)
						if (_fit == undefined) break
						
						_fit.is_sorted = true
						_fit.image_blend = c_gray
						_fit.sort_index = ++ _rectangle_index
						_fit.x = _rectangle.x
						_fit.y = _py
						
						_leftover -= _fit.width
						if (_leftover <= 0) break
						_px = _fit.x + _fit.width
					}
					
					if ((_py + _max_rect_height + _height) > _grid_height) {
						_new_page_requested = true
						_cannot_fit_whole = true
						_all_good = false
					}
					else {
						_px = 0
						_py += _max_rect_height
						
						_max_rect_height = _height
						
						if (_py < _grid_height) {
							_rectangle.x = _px
							_rectangle.y = _py
						}
						else {
							// TODO: resolve such cases
							show_error("fucky wucky", true)
							_rectangle.is_sorted = false
						}
					}
				}
				
				_px += _width
			}
			
			if (_new_page_requested) {
				_sprite_data = {}
				
				array_push(_texture_pages, _sprite_data)
				
				if (_skipped_index_start >= 0) {
					_rectangle_index = _skipped_index_start
					_skipped_index_start = -1
				}
				
				_px = 0
				_py = 0
			}
			else if (_all_good) {
				if (_is_present) {
					array_push(_sprite_data[$ _sprite_name], _rectangle)
				}
				else {
					_sprite_data[$ _sprite_name] = [ _rectangle ]
				}
				_rectangle_index ++
			}
		}
		
		if (variable_struct_get_names(_sprite_data) != 0 && !array_contains(_texture_pages, _sprite_data)) {
			array_push(_texture_pages, _sprite_data)
		}
		
		file_write("texture_pages.json", json_stringify(_texture_pages, true))
		
		return _texture_pages
	}
	
	static write_texturegroup_info_and_textures = function(_texture_pages, _sprite_prefix = undefined) {
		var _grid_width = compactor_texturepage_width,
			_grid_height = compactor_texturepage_height,
			
			_surface = surface_create(_grid_width, _grid_height),
			
			_texture_page_count = array_length(_texture_pages),
			
			_texturegroup_textures = [],
			_texturegroup_sprite_data = {}
		
		#macro debug_render_custom_texturepage_backgrounds false
		#macro debug_texture_text_scale 1
		
		for(var _texturepage_index = 0; _texturepage_index < _texture_page_count; ++_texturepage_index) {
			surface_set_target(_surface)
			draw_clear_alpha(c_black, 0)
			
			var _texturepage_sprites = _texture_pages[_texturepage_index],
				_keys = variable_struct_get_names(_texturepage_sprites)
			
			for(var i = array_length(_keys) - 1; i >= 0; --i) {
				var _key = _keys[i],
					
					_sprite_name = (is_string(_sprite_prefix) ? ($"{_sprite_prefix}{_key}") : _key),
					
					_frames = _texturepage_sprites[$ _key],
					
					_frame_count = array_length(_frames),
					
					_sprite_frames;
				
				if (variable_struct_exists(_texturegroup_sprite_data, _sprite_name)) {
					_sprite_frames = _texturegroup_sprite_data[$ _sprite_name].frames
				}
				else {
					_sprite_frames = array_create(_frame_count, undefined)
				}
				
				for(var j = _frame_count - 1; j >= 0; --j) {
					var _frame = _frames[j], _sprite = _frame.sprite;
					
					if (debug_render_custom_texturepage_backgrounds) {
						draw_set_color(_frame.image_blend)
						draw_rectangle(_frame.x, _frame.y, _frame.x + _frame.width, _frame.y + _frame.height, !_frame.is_sorted)
						
						draw_set_color(c_black)
						draw_text_transformed(_frame.x + 4, _frame.y + 3, _sprite_name, debug_texture_text_scale, debug_texture_text_scale, 0)
						draw_text_transformed(_frame.x + 4, _frame.y + 4, _sprite_name, debug_texture_text_scale, debug_texture_text_scale, 0)
						
						draw_set_color(c_white)
						draw_text_transformed(_frame.x + 3, _frame.y + 3, _sprite_name, debug_texture_text_scale, debug_texture_text_scale, 0)
					}
					
					draw_sprite(_sprite, _frame.image_index,
								
								_frame.x + sprite_get_xoffset(_sprite),
								_frame.y + sprite_get_yoffset(_sprite))
					
					_sprite_frames[_frame.image_index] = _frame.to_frame_entry(_texturepage_index)
				}
				
				// this seems to be caused by sprites being spread between several texturepages
				// so we should just wait for the first texture entry to insert itself
				if (!is_undefined(_sprite_frames[0])) {
					variable_struct_set(_texturegroup_sprite_data, _sprite_name,
						{
							"width": _sprite_frames[0].w,
							"height": _sprite_frames[0].h,
							"frames": _sprite_frames
						})
				}
			}
			
			surface_reset_target()
			
			var _texture_name = $"texturepage_{_texturepage_index}.png"
			array_push(_texturegroup_textures, _texture_name)
			surface_save(_surface, _texture_name)
		}
		
		surface_free(_surface)
		
		return {
			textures: _texturegroup_textures,
			sprite_data: _texturegroup_sprite_data
		}
	}
}
