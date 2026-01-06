global.playerinstance_list = array_create(INPUT_MAX_PLAYERS, undefined)

globalvar my_player, player_count;
my_player = undefined
player_count = 0

function PlayerInstance(_index = 0) constructor {
    index = _index
	race = Race.Random
	skin = 0
	name = "player" + string(_index)
	cprefs = (0 << 1)
    color = -1
	uid = "N/A"
	hp = 8
	
	static reset_session_data = function() {
		if self.is_local() {
			self.update_cprefs()
			name = scrSavedataGetUsername()
			color = global.player_color
		}
		
		self.reset_loadout()
		latency = -1
	}
	
	static reset_loadout = function() {
	    skin = 0
	    race = Race.Random
		randchar = false
	    cwep = wep_revolver
		bwep = wep_none
		start_curse = false
		start_bcurse = false
	}
	
    static write = function(buff) {
        buffer_write(buff, buffer_u8, _index)
		
        buffer_write(buff, buffer_u8, race)
        buffer_write(buff, buffer_u8, skin)
        buffer_write(buff, buffer_u16, cwep)
		
        buffer_write(buff, buffer_u32, color)
        buffer_write(buff, buffer_u32, cprefs)
		
        buffer_write(buff, buffer_string, name)
		
        return buff
    }
	
    static read = function(buff) {
        race = buffer_read(buff, buffer_u8)
        skin = buffer_read(buff, buffer_u8)
        cwep = buffer_read(buff, buffer_u16)
		
        color = buffer_read(buff, buffer_u32)
        cprefs = buffer_read(buff, buffer_u32)
		
        name = buffer_read(buff, buffer_string)
    }
	
	static read_from_struct = function(_struct) {
		struct_foreach(_struct, function(_vname, _value) {
			if variable_struct_exists(self, _vname) {
				variable_struct_set(self, _vname, _value)
			}
		})
	}
	
	static is_local = function() {
		return (self == my_player)
	}
	
	static update_cprefs = function() {
		var _cprefs = int64(0)
		
		with UberCont {
			var _cpref_list = cpref_list,
				_cpref_count = array_length(_cpref_list)
			
			for(var i = 0; i < _cpref_count; i ++) {
				if variable_instance_get(self, "cpref_" + _cpref_list[i]) {
					_cprefs |= (1 << (i + 1))
				}
			}
		}
		
		if cprefs == _cprefs exit
		KeyCont.activeforever[index] = false
		cprefs = _cprefs
	}
	
	static get_name = function() {
		return name
	}
	
	static get_index = function() {
		return index
	}
	
	static get_race = function() {
		return race
	}
	
	static is_race = function(_race) {
		return (race == _race)
	}
	
	static get_skin = function() {
		return skin
	}
	
	static toString = function() {
		return $"{self.is_local() ? "LocalPlayer" : "RemotePlayer"} \{ index : {index} , uid : \"{uid}\" , race : {race} , skin : {skin} \}"
	}
	
	self.reset_session_data()
}

function scr_playerinstance_create(_index) {
	assert(is_undefined(global.playerinstance_list[_index]))
	
	var _playerinstance = new PlayerInstance(_index)
	global.playerinstance_list[_index] = _playerinstance
	
	scr_playerinstances_recollect()
	
	return _playerinstance
}

function scr_playerinstance_destroy(_index, _remove_player_object = false) {
    global.playerinstance_list[_index] = undefined
	
	if _remove_player_object {
		with Player {
			if index != _index continue
			instance_destroy(id, false)
		}
	}
	
	scr_playerinstances_recollect()
	
    show_debug_message("PlayerInstace" + string(_index) + " was removed. Current list state: " + string(global.playerinstance_list))
}

function scr_playerinstance_find(_index = global.index) {
	if _index >= 0 && _index < array_length(global.playerinstance_list)
		return global.playerinstance_list[_index]
	
	return undefined
}

function scr_playerinstance_add(_index, _playerinstance) {
	global.playerinstance_list[_index] = _playerinstance
	scr_playerinstances_recollect()
	
	return _playerinstance
}

function scr_playerinstance_reset(_index = global.index) {
	with scr_playerinstance_find(_index) {
		self.reset_session_data()
		return self
	}
	
	return undefined
}

function scr_playerinstances_recollect() {
	var _list = global.playerinstance_list,
		_count = array_length(_list),
		_slot_index = 0
	
	for(var i = 0; i < _count; ++i) {
		var _pinst = _list[i]
		
		if is_undefined(_pinst) continue
		
		if _slot_index != i {
			_list[_slot_index] = _pinst
			_list[i] = undefined
		}
		
		_slot_index ++
	}
	
	player_count = _slot_index
}

function scr_playerinstances_get_all() {
	var _result = array_create(player_count, undefined)
	array_copy(_result, 0, global.playerinstance_list, 0, player_count)
	return _result
}

function scr_playerinstances_reset_all() {
	global.playerinstance_list = array_create(INPUT_MAX_PLAYERS, undefined)
	
	global.index = 0
	
	if is_struct(my_player) {
		my_player.index = global.index
		my_player.reset_session_data()
		scr_playerinstance_add(global.index, my_player)
	}
	else {
		my_player = scr_playerinstance_create(global.index)
	}
	
	scr_playerinstances_recollect()
}

function scr_player_is_local(_index) {
	return global.playerinstance_list[_index].is_local()
}

function scr_playerinstances_load_from_list(_pinstlist) {
	var _count = array_length(_pinstlist)
	
	scr_playerinstances_recollect()
	
	for(var _player_index = 0; _player_index < _count; _player_index ++) {
		var _pinst_data = _pinstlist[_player_index],
			_pinst = scr_playerinstance_create(_pinst_data.index)
		
		_pinst.read_from_struct(_pinst_data)
	}
}

function scrCreatePlayers(_my_index = global.index) {
    var _player_instances = global.playerinstance_list

    for (var _player_index = 0; _player_index < player_count; _player_index ++) {
        var _pinst = _player_instances[_player_index]
		
        if (is_undefined(_pinst)) continue

        if _pinst.race == Race.Random || _pinst.randchar {
			var _randrace;
			do {
                _randrace = irandom_range(Race.Fish, Race.NUM_ALL_RACE_TYPES - 1)

                if _randrace == Race.BigDog {
                    _randrace = -1
                }
            }
			until (_randrace > 0 && scr_race_is_unlocked(_randrace))
			
			_pinst.race = _randrace
			_pinst.skin = scr_loadout_race_get_skin(_randrace)
			
            if !instance_exists(CoopController) {
				if !scrGameIsEventRun() {
                    _pinst.cwep = scr_loadout_race_get_start_weapon(_pinst.race)
                }
				else if !UberCont.weekly_run {
                    _pinst.cwep = scrRaceGetStarterWeapon(_pinst.race)
                }
            }

            if !scrGameIsEventRun() {
				var _start_crown = scr_loadout_race_get_start_crown(_pinst.race)
				scrCrownSetCurrent(_start_crown, true)
            }
			
			_pinst.randchar = true
		}
		
		if !(instance_exists(CoopController) || UberCont.weekly_run) {
	        if _pinst.race == Race.Skeleton && !scr_race_is_unlocked(_pinst.race) {
	            _pinst.race = Race.Melting
				_pinst.skin = scr_loadout_race_get_skin(Race.Melting)
	        }
		}

        if _pinst[$ "cwep"] == wep_golden_frog_pistol {
            _pinst.race = Race.Frog
			_pinst.skin = scr_loadout_race_get_skin(Race.Frog)
        }
		
		KeyCont.activeforever[_pinst.index] = false

        with scrPlayerCreate(_pinst.index, _pinst.race, _pinst.skin) {
            is_me = (index == _my_index)

            if is_me {
				if !scrGameIsDailyRun() {
					UberCont.ctot_days[race] ++
				}
				else if UberCont.hardmode {
                    UberCont.ctot_hard[race] ++
                }

                UberCont.ctot_runs[race] ++
            }

            if (scr_weapon_is_valid(_pinst.cwep)) wep = _pinst.cwep
            if (scr_weapon_is_valid(_pinst.bwep)) bwep = _pinst.bwep
			
			if (scr_weapon_is_valid(wep)) {
				var _type = scr_weapon_get_type(wep)
				
				scrPlayerGiveAmmo(id, _type, scrAmmoGetPickupAmount(_type) * 3)
				
				if _pinst.start_curse {
					curse = true
				}
			}
            
			if (scr_weapon_is_valid(bwep)) {
				var _type = scr_weapon_get_type(bwep)
				scrPlayerGiveAmmo(id, _type, scrAmmoGetPickupAmount(_type) * 3)
				
				if _pinst.start_bcurse {
					bcurse = true
				}
				
				if (!scr_weapon_is_valid(wep)) {
					wep = bwep
					curse = bcurse
					bwep = wep_none
					bcurse = false
				}
			}
        }
    }
}

function scr_draw_multiplayer_player_card(_index, _x, _y, _width = 160, _halign = fa_left) {
	var _inst = scr_playerinstance_find(_index)
	if _inst == undefined exit
	
	var _height = 24
	
	if _halign == fa_center {
		_x -= _width / 2
	}
	
	draw_sprite_stretched_ext(sprAchievementSplash, 0, _x, _y, _width, _height, c_black, 0.5)
	
	var _image = scr_race_get_skin_subimage(_inst.race, _inst.skin)
	draw_sprite_ext(sprMapIcon, _image, _x + 14, _y + 10, 1, 1, 0, c_white, 1)
	
	_y += 4
	
	draw_set_valign(fa_middle)
	draw_set_font(fntSmall)
	
	draw_set_color(c_uigray)
	draw_text_nt(_x + 32, _y, "Player " + string(_inst.index + 1))
	
	var _latency_string = _inst.is_local() ? string(round(_inst.latency)) + "ms." : "(You)"
	
	draw_set_halign(fa_right)
	draw_text_nt(_x + _width - 12, _y + _height div 2 - 4, _latency_string)
	
	draw_set_halign(fa_left)
	draw_set_color(_inst.color)
	draw_text_nt(_x + 32, _y + _height div 2 - 4, _inst.name)
	
	draw_set_valign(fa_top)
	draw_reset_font()
}

function scr_player_pref(_pinst, _name) {
	var _list = UberCont.cpref_list,
		_index = array_indexof(_list, _name)
	
	// todo: uncrutch
	if _index == -1 || (_name == "rogue" && instance_exists(CoopController)) {
		return false
	}
	
	return (_pinst.cprefs & (1 << (_index + 1))) != 0
}
