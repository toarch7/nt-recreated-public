#macro debug_overlay_file "dbg_overlay.ini"

global.__debug_transit_loop = -1
global.__debug_autoplayer_race = Race.Random

function scr_debug_overlay_load() {
	static load = function(_global_name, _default) {
		variable_global_set(_global_name, is_numeric(_default)
			? ini_read_real("Data", _global_name, _default)
			: ini_read_string("Data", _global_name, _default))
	}
	
	ini_open(debug_overlay_file)
	load("__debug_test_framerate_uncapped", false)
	load("__debug_camera_display_info", false)
	load("__debug_menu_options", false)
	load("__debug_hitboxes", false)
	load("__debug_health", false)
	load("__debug_immortality", false)
	load("__debug_noreload", false)
	load("__debug_infammo", false)
	load("__debug_teleportation", false)
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
	write("__debug_test_framerate_uncapped")
	write("__debug_camera_display_info")
	write("__debug_menu_options")
	write("__debug_hitboxes")
	write("__debug_health")
	write("__debug_immortality")
	write("__debug_noreload")
	write("__debug_infammo")
	write("__debug_teleportation")
	ini_close()
}

function scr_debug_cheats_enabled() {
	gml_pragma("forceinline")
	return global.__debug_menu_options || global.__debug_hitboxes
		|| global.__debug_health || global.__debug_immortality || global.__debug_teleportation
		|| global.__debug_noreload || global.__debug_infammo || global.cheats
}

function scr_create_debug_overlay_views() {
	
	scr_debug_overlay_load()
	
	#region Common
	
	dbg_view("Utils", false)
		
		dbg_section("Toggles")
		dbg_checkbox(ref_create(global, "__debug_camera_display_info"), "Camera & display info")
		dbg_checkbox(ref_create(global, "__debug_menu_options"), "Show all settings")
		dbg_checkbox(ref_create(global, "__debug_hitboxes"), "Object hitboxes")
		dbg_checkbox(ref_create(global, "__debug_health"), "Enemy health")
		dbg_checkbox(ref_create(global, "__debug_immortality"), "Player immortality")
		dbg_checkbox(ref_create(global, "__debug_noreload"), "Disable reload")
		dbg_checkbox(ref_create(global, "__debug_infammo"), "Infinite ammo")
		dbg_checkbox(ref_create(global, "__debug_teleportation"), "MMB Teleportation")
		
		dbg_section("Technical")
		dbg_button("Reload languges", function() {
			with (UberCont) {
				scrLanguagesLoad()
				scrLanguageSet(opt_language)
			}
		})
		
		dbg_button("Dump all sprites", function() {
			var _dir = game_directory + "exportsprites"
            if (!directory_exists(_dir)) directory_create(_dir)

            _dir += "/"
			
			print("Exporting sprites to", _dir, "...")
			
			call_after(1, method({dir: _dir}, function() {
				array_foreach(asset_get_ids(asset_sprite), function(_sprite) {
	                sprite_strip_save(_sprite, $"{dir}/{sprite_get_name(_sprite)}.png")
	            })
			
	            print("Export finished.")
			}))
		})
		
	#endregion
	
	#region Transit
		
		static __area_transit_button = function(_area, _subarea) {
			return method({ area: _area, subarea: _subarea }, function() {
				if (!instance_exists(GameCont)) {
					print("Unable to teleport - You're not in the game!")
					exit
				}
				
				if (scrGameIsPaused()) scrGameUnpause()
				
				var _area = area,
					_subarea = subarea
				
				with (GameCont) {
					area = _area
					subarea = _subarea
					is_level_ended = false
					can_advance_stage = false
					
					if (global.__debug_transit_loop != -1) {
						loops = global.__debug_transit_loop
					}
					
					hard = scrAreaGetDifficulty(_area, _subarea, loops)
					
					print("Teleporting to", scrAreaGetMapName(_area, _subarea, loops, scrGameIsHardmode(), false), "diff", hard)
					
					waypnt[waypoints] = area
					waysub[waypoints] = subarea
					waylps[waypoints] = loops
					waypoints ++
				}
				
				with (instance_create(10016, 10016, Portal)) {
				    sprite_index = sprPortalDisappear
				    event_perform(ev_other, ev_animation_end)
				}
			})
		}
		
		dbg_view("Goto", false)
		dbg_section("Area", true)
		
		dbg_slider_int(ref_create(global, "__debug_transit_loop"), -1, 10, "Loop")
		
		var _default_max_subareas = 3,
			_area_list = range(area_campfire, area_palace)
		
		array_push(_area_list, area_hq)
		
		var _area_count = array_length(_area_list)
		
		for(var i = 0; i < _area_count; ++i) {
			var _area = _area_list[i],
				_secret_area = (_area % 100) + 100
			
			dbg_button(scrAreaGetName(_area), __area_transit_button(_area, 1), 120)
			
			var _subareas = scrAreaGetMaxSubareas(_area),
				_secret_subareas = scrAreaGetMaxSubareas(_secret_area),
				_missing_subareas = max(0, _default_max_subareas - _subareas),
				_has_secret = true
			
			if (_secret_subareas > 1 || _area == _secret_area) _has_secret = false
			
			for(var _subarea = 1; _subarea <= _subareas; ++_subarea) {
				dbg_same_line()
				dbg_button(
					scrAreaGetMapName(_area, _subarea, 0),
					__area_transit_button(_area, _subarea),
					(65 + _missing_subareas * 20.33) * max(1, _missing_subareas))
			}
			
			if (_has_secret) {
				dbg_same_line()
				dbg_text("")
				dbg_same_line()
				dbg_button(scrAreaGetName(_secret_area),
					__area_transit_button(_area + 100, 1), 110)
			}
		}
		
	#endregion
	
	#region Mutations
	
		dbg_view("Mutations", false)
		dbg_section("Skills", true)
		
		for(var i = 1; i <= maxskill; ++i) {
			dbg_button($"{i}. {string_lower_camel(scr_skill_get_name(i), true)}", method({ skill: i }, function() {
				if !scr_skill_get(skill) {
					scr_skill_set(skill, true)
				}
				else {
					scr_skill_set(skill, false)
				}
			}))
			
			if ((i % 3) != 0) dbg_same_line()
		}
		dbg_text("")
		
		for(var i = Race.CoopUltra; i < Race.NUM_ALL_RACE_TYPES; ++i) {
			var _open = (scrPlayerCountRace(i, true) != 0)
			dbg_section($"{i}. Ultras - {i == 0 ? "Co-op" : string_lower_camel(scrRaceGetName(i), true)}", _open)
			for(var j = 1; j <= (2 + (i == Race.Horror)); ++j) {
				var _name = string_lower_camel(scrRaceGetUltraSkillName(i, j), true)
				dbg_button(_name, method({ race: i, ultra: j }, function() {
					if !scr_ultra_get(race, ultra) {
						scr_ultra_set(race, ultra, true)
					}
					else {
						scr_ultra_set(race, ultra, false)
					}
				}))
				dbg_same_line()
			}
			dbg_text("")
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
		
		dbg_button("Stop all", function() {
			instance_destroy(TestCont)
		})
		
		dbg_checkbox(ref_create(global, "__debug_test_framerate_uncapped"), "Unlimited framerate")
		
		__create_test_option(TestWeapons)
		__create_test_option(TestDamageSources)
		
		//
		__create_test_option(TestAutoPlayer)
		
		var _list = []
		for(var i = Race.Random; i < Race.NUM_ALL_RACE_TYPES; ++i) {
			array_push(_list, $"{scrRaceGetStringID(i, true)}:{i}")
		}
		dbg_drop_down(ref_create(global, "__debug_autoplayer_race"), string_join_ext(",", _list), "Auto Player Race")
		
		dbg_text("")
		
	#endregion
}