#macro resourcepack_format_version_major 1
#macro resourcepack_format_version_minor 0

#macro resourcepack_texturegen_prefix "__PACK_TEXTUREGEN_"

function load_resourcepacks() {
	globalvar Resourcepacks;
    Resourcepacks = []
	
	#region Cleanup
	
	if (variable_global_exists("custom_texture_groups")) {
		array_foreach(global.custom_texture_groups, function(_group_name) {
			if (texturegroup_exists(_group_name)) {
				texturegroup_delete(_group_name)
			}
		})
	}
	
	#endregion
	
	//
    global.replaced_base_sprites = []
    global.custom_sprite_markings = {}
	
	//
	global.custom_texturepage_bucket = []
	global.custom_texturepage_replacement_frames = {}
	global.temporary_custom_sprites = []
    global.custom_texture_groups = []
	
	//
    global.custom_sounds = {}
    global.custom_area_colors = {}
    global.custom_shadow_colors = {}
	global.custom_sprite_registry = {}
	
	//
	print("Default sprite culling is", gpu_get_sprite_cull() ? "ON" : "OFF")
    
	//
	directory_create(game_directory + "resourcepacks")
	
	var _time = get_timer()
	try {
		// this loads sorts of resources into the global variables from above
		load_resourcepacks_from(game_directory + "resourcepacks/")
		
		// texturepage generation
		var _compactor = new CustomTexturePageCompactor(),
			_texture_rects = global.custom_texturepage_bucket
		
		#region Finish up frame replacements
		
		// frame replacements are essentially just resonstructions of base sprites, where we poke
		// original frames out and replaced them with custom sprites (frames).
		// this whole process has to be done in bulk so that we don't do this from
		// scratch for every individual frame replacement
		var _frame_replacement_indices = global.custom_texturepage_replacement_frames,
			_frame_replacement_keys = struct_keys(_frame_replacement_indices)
		
		for (var i = array_length(_frame_replacement_keys) - 1; i >= 0; --i) {
			var _key = _frame_replacement_keys[i],
				_original_sprite = asset_get_index(_key),
				_number = sprite_get_number(_original_sprite),
				_width = sprite_get_width(_original_sprite),
				_height = sprite_get_height(_original_sprite),
				_sprite_frames = _frame_replacement_indices[$ _key]
			
			for(var _subimage = array_length(_sprite_frames) - 1; _subimage >= 0; --_subimage) {
				var _replacement_sprite = _sprite_frames[_subimage]
				
				array_push(_texture_rects, new CustomTexturePageRect(
					_key, _subimage, _number, _width, _height, _replacement_sprite))
			}
		}
		
		#endregion
		
		_compactor.populate_textures(_texture_rects)
		
		file_write($"texture_rects.json", json_stringify(_texture_rects, true))
		
		var _custom_texturegroup_name = "custom_textures",
			
			_texture_pages = _compactor.process_texture_pages(),
			
			// texturegroups are prefixed, because we don't want the engine to manage sprite replacements itself
			// (and yes gamemaker overrides existing sprites with new sprites that share names, but these will have different indicees (bad))
			_texturegroup_info = _compactor.write_texturegroup_info_and_textures(_texture_pages, resourcepack_texturegen_prefix)
		
		if (GM_build_type == "run") {
			file_write("resourcepack-texturegroup.json", json_stringify(_texturegroup_info, true))
		}
		
		texturegroup_add(
			_custom_texturegroup_name,
			_texturegroup_info.textures,
			{
				sprites: _texturegroup_info.sprite_data
			})
		
		array_push(global.custom_texture_groups, _custom_texturegroup_name)
		
		array_foreach(
			texturegroup_get_sprites(_custom_texturegroup_name),
			
			function(_custom_sprite) {
				static __trim_pfx = [ resourcepack_texturegen_prefix ]
				
				var _custom_sprite_name = sprite_get_name(_custom_sprite),
					_original_sprite_name = string_trim_start(_custom_sprite_name, __trim_pfx),
					_original_sprite = asset_get_index(_original_sprite_name),
					
					_xoffset = sprite_get_xoffset(_original_sprite),
					_yoffset = sprite_get_yoffset(_original_sprite)
				
				sprite_set_offset(_custom_sprite, _xoffset, _yoffset)
				sprite_assign(_original_sprite, _custom_sprite)
				
				//
				array_push(global.replaced_base_sprites, _original_sprite_name)
			})
		
	}
	catch(e) {
		print_exception("Something got caught on fire while loading resourcepacks", e)
	}
	
	sprite_flush_multi(global.temporary_custom_sprites)
	
	array_foreach(global.temporary_custom_sprites, function(_sprite) {
		if (sprite_exists(_sprite)) sprite_delete(_sprite)
	})
	
	print("load_resourcepacks() time ellapsed:", (get_timer() - _time) / 100_000, "ms.")
	
	//
	var _resourcepacks = Resourcepacks,
		_active_resourcepack_list = []
	
	for(var i = array_length(_resourcepacks) - 1; i >= 0; --i) {
		var _resourcepack_data = _resourcepacks[i]
		
		if (_resourcepack_data.active) {
			array_push(_active_resourcepack_list, _resourcepack_data.full_name)
		}
	}
	
	if (array_length(_active_resourcepack_list) != 0) {
		file_write(".active_resourcepacks",
			string_join_ext("\n", _active_resourcepack_list))
	}
	else if (file_exists(".active_resourcepacks")) {
		file_delete(".active_resourcepacks")
	}
}
