#macro savegame_file "savegame.dat"

enum SavegamePart {
	SessionData,
	GlobalVars,
	PlayerData
}

function scrSavegameSave() {
	var _buffer = buffer_create(0xffff, buffer_grow, 1), _step_name;
	
	try {
		scrSavegameSession(_buffer, false)
		scrSavegameGlobals(_buffer, false)
		scrSavegamePlayers(_buffer, false)
	}
	catch(e) {
		return print_exception($"Failed to write game save.", e)
	}
	
	if (buffer_exists(_buffer)) buffer_save(_buffer, savegame_file)
}

function scrSavegameLoad(_only_first_part = false) {
	var _buffer = buffer_load(savegame_file)
	
	if (_only_first_part) {
		while (buffer_tell(_buffer) < buffer_get_size(_buffer)) {
			var _part_index = buffer_read(_buffer, buffer_u8)
			if (_part_index == SavegamePart.SessionData) {
				buffer_seek(_buffer, buffer_seek_relative, -1)
				return scrSavegameSession(_buffer, true)
			}
		}
		exit
	}
	
	try {
		scrSavegameSession(_buffer, true)
		scrSavegameGlobals(_buffer, true)
		scrSavegamePlayers(_buffer, true)
		
		return true
	}
	finally {
		if (buffer_exists(_buffer)) buffer_delete(_buffer)
	}
	
	return false
}

function scrSavegameSession(_buffer, _is_load) {
    var _part_index = SavegamePart.SessionData, _session_info;
	
	if (_is_load) {
		assert(buffer_read(_buffer, buffer_u8) == _part_index, "Invalid session part index")
		_session_info = json_parse(buffer_read(_buffer, buffer_string))
		
		array_foreach(_session_info.players, function(_player_data) {
			if (!is_struct(_player_data)) exit
			
			var _pinst = scr_playerinstance_find(_player_data.index)
			
			if (is_undefined(_pinst)) {
				_pinst = new PlayerInstance()
				scr_playerinstance_add(_player_data.index, _pinst)
			}
			
			_pinst.read_from_struct(_player_data)
		})
		
		with (GameCont) {
			array_foreach(_session_info.session_data, function(_entry) {
				var _vname = _entry.name,
					_value = _entry.value
				
				if (_vname == "skills") {
					return ds_list_read(skills, _value)
				}
				
				variable_struct_set(self, _vname, _value)
			})
		}
		
		global.recontinued_times = _session_info.recontinued_times
		
		with (UberCont) {
			daily_run = _session_info.daily_run
			weekly_run = _session_info.weekly_run
			custom = _session_info.custom
			custom_options = _session_info.custom_options
			hardmode = _session_info.hardmode
			
			if (is_string(_session_info.weekly_data)) {
				if (!ds_exists(weekly_data, ds_type_map)) {
					weekly_data = ds_map_create()
				}
				
				ds_map_read(weekly_data, _session_info.weekly_data)
			}
		}
		
		GameCont.persistentweps = _session_info.persistentweps
		
		array_foreach(_session_info.unlockscreens, function(_struct) {
			scrUnlockScreenCreate(_struct.race, _struct.bskin)
		})
	}
	else {
		_session_info = {
			players: scr_playerinstances_get_all(),
			
			// GameCont data
			session_data: [],
			
	        hardmode: UberCont.hardmode,
			recontinued_times: global.recontinued_times,
			
	        daily_run: UberCont.daily_run,
	        weekly_run: UberCont.weekly_run,
			weekly_data: undefined,
			
			custom: UberCont.custom,
			custom_options: UberCont.custom_options,
			
			persistentweps: [],
			unlockscreens: [],
			
	        ammo: undefined,
	        hp: undefined,
	        spirit: undefined,
			max_hp: undefined,
			headloses: undefined
	    }
		
		with (UberCont) if (is_numeric(weekly_data) && ds_exists(weekly_data, ds_type_map)) {
			_session_info.weekly_data = ds_map_write(weekly_data)
		}
		
		with (GameCont) {
			var _keys = variable_struct_get_names(id),
				_count = array_length(_keys)
			
			for(var i = 0; i < _count; ++i) {
				var _vname = _keys[i],
					_value = self[$ _vname]
				
				if (_vname == "skills") _value = ds_list_write(_value)
				
				array_push(_session_info.session_data, {
					name: _vname, value: _value
				})
			}
		}

	    with Player {
	        _session_info.ammo = ammo
	        _session_info.hp = hp
	        _session_info.spirit = spirit
			_session_info.max_hp = max_hp
			_session_info.headloses = headloses
			
			with WepPickup if (persistent) {
				array_push(_session_info.persistentweps, {
					wep: wep, curse: curse, ammo: ammo
				})
		    }
			
			with UnlockScreen {
				array_insert(_session_info.unlockscreens, 0, {
					race: race, bskin: bskin
				})
			}
	    }
		
		buffer_write(_buffer, buffer_u8, _part_index)
	    buffer_write(_buffer, buffer_string, json_stringify(_session_info))
	}
}

function scrSavegameGlobals(_buffer, _is_load) {
	var _part_index = SavegamePart.GlobalVars, _globals;
	
	if (_is_load) {
		assert(buffer_read(_buffer, buffer_u8) == _part_index, "Invalid global variable part index")
		_globals = json_parse(buffer_read(_buffer, buffer_string))
		
		struct_foreach(_globals, function(_vname, _value) {
			variable_global_set(_vname, _value)
		})
	}
	else {
		_globals = {}
		
	    var _global_keys = [
			"rng_state", "index", "seed", "is_server", "custom_seed",
			"current_frame", "party_gun_special_drop", "crownpick",
			"recontinued_times",
		]
		
		with (_globals) array_foreach(_global_keys, function(_vname) {
			assert(variable_global_exists(_vname), $"Global variable \"{_vname}\" doesn't exist")
			self[$ _vname] = variable_global_get(_vname)
		})
		
		buffer_write(_buffer, buffer_u8, _part_index)
	    buffer_write(_buffer, buffer_string, json_stringify(_globals))
	}
}

function scrSavegamePlayers(_buffer, _is_load) {
	var _part_index = SavegamePart.PlayerData
	
	if (_is_load) {
		assert(buffer_read(_buffer, buffer_u8) == _part_index, "Invalid player data part index")
		var _player_data = json_parse(buffer_read(_buffer, buffer_string)),
			_count = array_length(_player_data)
		
		for(var i = 0; i < _count; ++i) {
			var _player_info = _player_data[i],
				_object_index = asset_get_index(_player_info.object_index_name)
			
			variable_struct_remove(_player_info, "object_index_name")
			
			with (instance_create(0, 0, _object_index)) {
				struct_foreach(_player_info, function(_vname, _value) {
					self[$ _vname] = _value
				})
			}
		}
	}
	else {
		var _player_data = [],
			_object = Player
		
		repeat (2) {
			var _n = instance_number(_object)
			
			for(var i = 0; i < _n; ++i) with (instance_find(Player, i)) {
				var _player_info = {
					object_index_name: object_get_name(object_index)
				}
				
				var _keys = variable_struct_get_names(id)
				for(var j = array_length(_keys) - 1; j >= 0; --j) {
					var _key = _keys[j],
						_value = self[$ _key]
					
					_player_info[$ _key] = _value
				}
				
				array_push(_player_data, _player_info)
			}
			
			_object = Revive
		}
		
		buffer_write(_buffer, buffer_u8, _part_index)
		buffer_write(_buffer, buffer_string, json_stringify(_player_data))
	}
}