function load_resourcepacks_from(_load_directory) {
	var _resourcepack_dirs = directory_read(_load_directory + "*", fa_directory),
		_resourcepack_dir_count = array_length(_resourcepack_dirs)
	
	if (_resourcepack_dir_count == 0) {
		print(_load_directory, "no resourcepack subdirectories found.")
		exit
	}
	
	print("Loading", _resourcepack_dir_count, "resourcepacks from", _load_directory)
	
	for (var i = _resourcepack_dir_count - 1; i >= 0; --i) {
		var _dirname = _resourcepack_dirs[i],
			_is_local = false
		
		print("Processing resourcepack \"" + _dirname + "\"")
		
		var _pack_directory = _load_directory + _dirname + "/",
			
			_pack_meta_file = _pack_directory + "meta.json",
			_browser_meta_file = _pack_directory + "githubdata.json",
			
			_resourcepack_data = new Resourcepack(_dirname),
			_browser_meta = {}
		
	    if (!file_exists(_pack_directory + ".nomedia")) {
			file_write(_pack_directory + ".nomedia", "")
	    }
		
		try {
			var _struct = json_parse(file_read(_pack_meta_file))
			_resourcepack_data.load_pack_meta_from_struct(_struct)
		}
		catch (e) {
			if (file_exists(_pack_meta_file)) {
				file_rename(_pack_meta_file, _pack_directory + "M_meta.json")
			}
			
			scr_log_push($"[!] {_pack_meta_file} is malformed or doesn't exist. Attempting to create generic template...", c_yellow)
			
			_resourcepack_data.setup_default_fields()
			
			file_write(_pack_meta_file, json_stringify(_resourcepack_data))
		}
		
		if (file_exists(_browser_meta_file)) {
			try {
				_browser_meta = json_parse(file_read(_browser_meta_file))
				_resourcepack_data.load_resourcepackbrowser_data_from_struct(_browser_meta)
			}
			catch (e) {
				scr_log_push($"[!] {_browser_meta_file} failed to parse: " + e.message, c_yellow)
			}
		}
		else {
			_is_local = true
		}
		
		_resourcepack_data.define_sources(_dirname, _pack_directory, !_is_local)
		
		var _is_disabled = file_exists(_pack_directory + "disable.d")
		_resourcepack_data[$ "active"] = (!_is_disabled)
		
		array_push(Resourcepacks, _resourcepack_data)
	}
	
	resourcepack_priority_sort(Resourcepacks)
	
	if (global.safemode) {
		print("Loaded only bare minimum resourcepack information, as the game is running in safe mode")
		exit
	}
	
	var _resourcepack_count = array_length(Resourcepacks)
	for(var i = 0; i < _resourcepack_count; i ++) {
		var _resourcepack_data = Resourcepacks[i],
			_pack_directory = _resourcepack_data.path,
			_is_local = (!_resourcepack_data.external),
			_name = _resourcepack_data.id,
			_load_errors = 0
			
		print("Loading pack \"" + _name + "\"")
		
		if (!global.console_active) {
			global.log_output = []
			global.log_color = []
		}
		
		if (_resourcepack_data.active) {
			_load_errors += load_custom_sprites(
				_resourcepack_data.full_name,
				_pack_directory + "usersprites/")
			
			_load_errors += load_custom_sounds(_pack_directory + "usersounds/")
			_load_errors += load_custom_locales(_pack_directory + "localizations/")
			
			if (file_exists(_pack_directory + "areacolors.json")) {
				_load_errors += load_custom_generic_area_colors(
					_pack_directory + "areacolors.json", global.custom_area_colors, "background")
			}
			
			if (file_exists(_pack_directory + "shadowcolors.json")) {
				_load_errors += load_custom_generic_area_colors(
					_pack_directory + "shadowcolors.json", global.custom_shadow_colors, "shadow")
			}
		}
		
		if ((_is_local || GM_build_type == "run") && _load_errors != 0) {
			var _what_went_wrong = $"Some things went wrong:\n\n{string_join_ext("\n", global.log_output)}\n\n{_load_errors} errors total. Way to go!"
			
			if (is_desktop) {
				if (!instance_exists(Console)) {
					instance_create(0, 0, Console)
				}
				
				global.console_active = true
			}
			else {
				show_message_async(_what_went_wrong)
			}
		}
		
		_resourcepack_data.loaded = true
	}
}