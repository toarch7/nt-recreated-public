#macro max_custom_mode_slots 9
#macro custom_mode_version 1
#macro custom_player_damage_adj 10

function CustomModeOptions(_slot_name) constructor {
	name = string(_slot_name)
	hardmode = false
	seed = 0
	seed_enable = false
	
	unlock_chars = false
	unlock_crowns = false
	
	area = 1
	subarea = 1
	loops = 0
	area_size = 3
	area_size_alt = 1
	
	wep = -1
	bwep = -1
	curse = 0
	bcurse = 0
	protowep = -1
	protocurse = 0
	protowep_s = wep_rusty_revolver
	
	rad = 0
	radmax = 100
	level = 0
	maxlevel = 10
	crown = 0
	endpoints = -1
	
	race = 0
	bskin = -1
	
	skill_choices = 4
	skill_mult_base = 1
	skill_mult_pairs = []
	skill_start = []
	skillpoints = -1
	
	damage_to_player = 0
	
	weapon_tier_base = -2
	weapon_tier_pairs = []
	
	self[$ "game_speed"] = 100
	enemy_health = 100
	boss_health = 100
	pickup_time = 100
}

function scrCustomModeLoadPresets() {
	var _filepath = game_directory + "custom-mode.json"
	if (!file_exists(_filepath)) {
		scrCustomModeSavePresets(true)
	}
	
	try {
		var _contents = file_read(_filepath),
			
			_data = json_parse(_contents)
		
		with (UberCont) {
			custom_mode_disclaimer = _data.accepted_disclaimer
			custom_mode_slot_index = _data.index
			
			custom_mode_slots = array_map(_data.array, function(_slot, _index) {
				if (!is_struct(_slot)) {
					return new CustomModeOptions(string(_index + 1))
				}
				return _slot
			})
		}
	}
	catch(e) {
		print_exception("Faield to load cutom mode presets.", e)
		scrCustomModeSavePresets(true)
		exit
	}
}

/// @function scrCustomModeSavePresets
/// @param reset_all=false
function scrCustomModeSavePresets(_reset_all = false) {
	var _struct, _data;
	
	if (_reset_all) {
		_struct = {
			"accepted_disclaimer": false,
			"index": 0,
			"version": custom_mode_version,
			"array": array_create(max_custom_mode_slots, undefined)
		}
		_data = _struct.array
		
		for(var i = 0; i < max_custom_mode_slots; ++i) {
			_data[i] = new CustomModeOptions(string(i + 1))
		}
	}
	else {
		_struct = {
			"accepted_disclaimer": UberCont.custom_mode_disclaimer,
			"index": UberCont.custom_mode_slot_index,
			"version": custom_mode_version,
			"array": UberCont.custom_mode_slots
		}
	}
	
	var _filepath = game_directory + "custom-mode.json"
	file_write(_filepath, json_stringify(_struct, true))
}

/// @function scrCustomParam
/// @param key
/// @param default=undefined
function scrCustomParam(_key, _default=undefined) {
	if (scrGameIsCustomMode()) {
		assert(variable_struct_exists(UberCont.custom_options, _key),
			  "{0} is not a valid custom mode parameter", _key)
		
		return variable_struct_get(UberCont.custom_options, _key)
	}
	
	return _default
}

function scrCustomParamChange(_key, _value) {
	variable_struct_set(UberCont.custom_options, _key, _value)
}

function scrGameCustomModeReset() {
	with (UberCont) {
		custom = false
		custom_options = undefined
	}
}

function scrCustomModeCountMutations() {
	return array_length(UberCont.custom_options.skill_start)
}

function scrCustomModePickupTimeMult() {
	if (scrGameIsCustomMode()) {
		return scrCustomParam("pickup_time") / 100
	}
	return 1
}