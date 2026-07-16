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
    global.custom_sprites = []
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
	directory_create(game_directory + "resourcepacks")
    
	var _time = get_timer()
	try {
		load_resourcepacks_from(game_directory + "resourcepacks/")
		
		//
		var _compactor = new CustomTexturePageCompactor(),
			_texture_rects = global.custom_texturepage_bucket
		
		#region Finish up frame replacements
		var _frame_replacement_indices = global.custom_texturepage_replacement_frames,
			_frame_replacement_keys = struct_keys(_frame_replacement_indices)
		
		for (var _subimage = array_length(_frame_replacement_keys) - 1; _subimage >= 0; --_subimage) {
			var _key = _frame_replacement_keys[_subimage],
				_replacement_sprite = _frame_replacement_indices[$ _key],
				_original_sprite = asset_get_index(_key)
			
			array_push(_texture_rects, new CustomTexturePageRect(_key, _subimage,
				sprite_get_number(_original_sprite), sprite_get_width(_original_sprite), sprite_get_height(_original_sprite), _replacement_sprite))
		}
		#endregion
		
		_compactor.populate_textures(_texture_rects)
		
		var _custom_texturegroup_name = "custom_textures",
			
			_texture_pages = _compactor.process_texture_pages(),
			
			_texturegroup_info = _compactor.write_texturegroup_info_and_textures(_texture_pages, "texture")
		
		file_write("resourcepack-texturegroup.json", json_stringify(_texturegroup_info, true))
		
		texturegroup_add(
			_custom_texturegroup_name,
			_texturegroup_info.textures,
			{
				sprites: _texturegroup_info.sprite_data
			})
		
		print(texturegroup_get_sprites(_custom_texturegroup_name))
		
		gpu_set_sprite_cull(false)
		
		array_push(global.custom_texture_groups, _custom_texturegroup_name)
	}
	catch(e) {
		print_exception("Something got caught on fire while loading resourcepacks", e)
	}
	
	sprite_flush_multi(global.temporary_custom_sprites)
	
	array_foreach(global.temporary_custom_sprites, function(_sprite) {
		if (sprite_exists(_sprite)) sprite_delete(_sprite)
	})
	
	print("load_resourcepacks() time ellapsed:", (get_timer() - _time) / 100_000, "ms.")
}
