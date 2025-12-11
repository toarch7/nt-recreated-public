#macro debug_overlay_file "dbg_overlay.ini"

function scr_debug_overlay_load() {
	static load = function(_global_name, _default) {
		variable_global_set(_global_name, is_numeric(_default)
			? ini_read_real("Data", _global_name, _default)
			: ini_read_string("Data", _global_name, _default))
	}
	
	ini_open(debug_overlay_file)
	load("__debug_test_framerate_uncapped", false)
	load("__debug_camera_display_info", false)
	load("__debug_hitboxes", false)
	load("__debug_health", false)
	ini_close()
}

function scr_debug_overlay_save() {
	static write = function(_global_name) {
		assert(variable_global_exists(_global_name))
		
		var _value = variable_global_get(_global_name)
		
		if is_numeric(_value) {
			ini_write_real("Data", _global_name, _value)
		}
		else {
			ini_write_string("Data", _global_name, _value)
		}
	}
	
	ini_open(debug_overlay_file)
	
	ini_close()
}

function scr_create_debug_overlay_views() {
	
	scr_debug_overlay_load()
	
	#region Common
	
	dbg_view("Utils", false)
		
		dbg_section("Toggles")
		dbg_checkbox(ref_create(global, "__debug_camera_display_info"), "Camera & display info")
		dbg_checkbox(ref_create(global, "__debug_hitboxes"), "Object hitboxes")
		dbg_checkbox(ref_create(global, "__debug_health"), "Enemy health")
		
	#endregion
	
	#region Transit
		
		dbg_view("Goto")
		dbg_section("Areas")
		
		static __area_transit_button = function(_area, _subarea) {
			if (scrGameIsPaused()) scrGameUnpause()
			return method({ area: _area, subarea: _subarea }, function() {
				var _area = area,
					_subarea = subarea
				
				with (GameCont) {
					area = _area
					if (_subarea != 0) {
						subarea = _subarea
					}
					else subarea = 0
					is_level_ended = false
					can_advance_stage = false
				}
				
				with (instance_create(10016, 10016, Portal)) {
				    sprite_index = sprPortalDisappear
				    event_perform(ev_other, ev_animation_end)
				}
			})
		}
		
		var _low = area_campfire, _high = area_palace, _secret = false;
		repeat (2) {
			// Normal
			for(var i = _low; i <= _high; ++i) {
				dbg_button(scrAreaGetName(i), __area_transit_button(i, 1), 120)
				
				var _subareas = scrAreaGetMaxSubareas(i)
				for(var j = 0; j < _subareas; ++j) {
					dbg_same_line()
					
					var _area_title = _secret ? (i - 100) : i,
						_subarea_title = (_secret && _subareas <= 1) ? "?" : (j + 1),
						_label = $"{_area_title}-{_subarea_title}"
					
					if (i == area_vault) _label = "???"
					else if (i == area_crib) _label = "$$$"
					
					dbg_button(_label, __area_transit_button(i, j), 60)
				}
			}
			
			_low = area_vault
			_high = area_crib
			_secret = true
		}
	#endregion
	
	#region Tests
		
		static __create_test_option = function(_test_controller) {
			var _name = object_get_name(_test_controller)
			
			dbg_button(string_trim_start(_name, [ "Name" ]),
				method({
					"object": _test_controller
				}, function() {
					instance_destroy(TestCont)
					instance_create(0, 0, object)
				}))
		}
		
		dbg_view("Tests", false)
		
		dbg_checkbox(ref_create(global, "__debug_test_framerate_uncapped"), "Unlimited framerate")
		
		__create_test_option(TestWeapons)
		__create_test_option(TestDamageSources)
		
		dbg_text("")
		
	#endregion
}