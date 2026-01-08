function scrCampfireMenuCreate(_dead_mode = false) {
	var _x = _dead_mode ? 10016 : 64,
		_y = _dead_mode ? 10016 : 64
	
	#region Create usual suspects
	
	with instance_create(_x, _y, Campfire) {
		with (Menu) char[0] = other.id
		instance_create(x, y - 32, LogMenu)
		
		scrCampfireMenuCreateCharacter(Race.Fish, x, y - 32)
		scrCampfireMenuCreateCharacter(Race.Crystal, x, y + 32)
		scrCampfireMenuCreateCharacter(Race.Eyes, x + 40, y)
		scrCampfireMenuCreateCharacter(Race.Melting, x - 40, y)
	}
	
	#endregion
	
	#region Other characters
	
	var _chicken_instance = noone,
		_bigdog_instance = noone
	
	for(var _race_id = Race.Plant; _race_id < Race.NUM_ALL_RACE_TYPES; ++_race_id) {
		if (_race_id == Race.BigDog && _dead_mode) continue
		
		with scrCampfireMenuCreateCharacter(_race_id) {
			if _race_id == Race.Chicken {
				_chicken_instance = id
			}
			else if _race_id == Race.BigDog {
				_bigdog_instance = id
			}
		}
	}
	
	// Shuffle them around
	var _count = instance_number(CampChar)
	for(var i = 0; i < _count; ++i) with (instance_find(CampChar, i)) {
		if (!randomize_position) continue
		
		var _iteration = 0
		
		do {
			x = xstart
			y = ystart
			
			var _distance = 32 + _iteration * 2 + random(32) + random(64) * random(1)
			
			if (_dead_mode) _distance *= 2
			
			move_contact_solid(random_angle, _distance)
			
			if ((++_iteration) >= 50) {
				if (_dead_mode || _iteration >= 100) break
				instance_create(x, y, PortalClear)
			}
		}
		until (distance_to_object(CampChar) >= 32 && (race != Race.Chicken || (!collision_circle(x, y - 32, 16, CampChar, true, true))))
		
		x = floor(x)
		y = floor(y)
		
		xprevious = y
		yprevious = y
	}
	
	// Give chicken her tv
	with (_chicken_instance) {
		if (_dead_mode) break
		with instance_create(x + orandom(2), y + orandom(4) - 32, TV) {
	        with instance_create(x, y + 16, PortalClear) image_rescale(0.5)
	        with instance_create(x, y, PortalClear) image_rescale(0.5)
	    }
	}
	
	// Big Dog...
	with (_bigdog_instance) {
		sprite_index = sprScrapBossSleep
		spr_menu = sprScrapBossIdle
		spr_to = sprScrapBossIntro
		spr_from = sprScrapBossSleepHurt
		spr_slct = sprScrapBossSleep
		spr_dead = sprScrapBossDead
		spr_shadow = shd96
		
		instance_create(x - 32, y, PortalClear)
		instance_create(x + 32, y, PortalClear)
		instance_create(x, y - 32, PortalClear)
		instance_create(x, y + 32, PortalClear)
	}
	
	#endregion
	
	#region 0-1 post-loop
	
	if (_dead_mode) {
		with (CampChar) {
			with instance_create(x, y, Corpse) {
				sprite_index = other.spr_dead
				image_index = image_number - 1
				image_xscale = choose(-1, 1)
				image_speed = 0
				
				move_contact_solid(random_angle, 64 + irandom(64))
			}
			
			instance_destroy()
		}
		
		with (Campfire) {
			instance_create(x, y, CampfireOff)
			instance_destroy(id, false)
		}
		
		instance_destroy(LogMenu, false)
	}
	
	#endregion
}

/// @function scrCampfireMenuCreateCharacter
/// @param {Enum.Race} race_id
/// @param x=0
/// @param y=0
function scrCampfireMenuCreateCharacter(_race_id, _x = undefined, _y = undefined) {
	if (!scr_race_is_unlocked(_race_id)) return noone
	
	var _randomize_position = true
	
	if is_undefined(_x) || is_undefined(_y) {
		_x = 64
		_y = 64
		
		with Campfire {
			_x = x
			_y = y
		}
	}
	else {
		_randomize_position = false
	}
	
	with (instance_create(_x, _y, CampChar)) {
		with (Menu) char[_race_id] = other.id
		
		race = _race_id
		randomize_position = _randomize_position
		
		// Setup sprites
		var _name = scrRaceGetStringID(_race_id, true),
			_default = scr_race_get_sprite(_race_id, "Idle")
		
		if !sprite_exists(_default) _default = sprDefault
		
		sprite_index = scr_race_get_sprite(_name, "Menu", _default)
		spr_dead = scr_race_get_sprite(_race_id, "Dead", sprDefault)
		
		spr_to = scr_race_get_sprite(_name, "MenuSelect", _default)
		spr_menu = scr_race_get_sprite(_name, "MenuSelected", _default)
		spr_from = scr_race_get_sprite(_name, "MenuDeselect", _default)
		spr_slct = scr_race_get_sprite(_name, "Menu", _default)
		
		return id
	}
	
	return noone
}

function scrMenuPrepareWeeklyLoadout() {
	
	var _weekly_data = UberCont.weekly_data
	assert(is_numeric(_weekly_data) && ds_exists(_weekly_data, ds_type_map))
	
	//
	array_foreach(global.playerinstance_list, function(_inst) {
		if (is_undefined(_inst)) exit
		
		var _weekly_data = UberCont.weekly_data,
			_seed = (_weekly_data[? "seed"] ?? global.seed)
		
		random_set_seed(_seed)
		
		with (_inst) {
			race = _weekly_data[? "char"] ?? Race.Random
		    skin = _weekly_data[? "bskin"] ?? SkinLetter.A
		    cwep = _weekly_data[? "startwep"] ?? -1
		    bwep = _weekly_data[? "bstartwep"] ?? -1
			
			if (race == Race.Random) {
				for(var i = Race.Fish; i < Race.NUM_ALL_RACE_TYPES; ++i) {
					race = (i + (_seed % rng_m)) % Race.NUM_ALL_RACE_TYPES
					if (!scrRaceIsHidden(race)) break
				}
			}
			
			var _max_skins = scrRaceGetMaxSkinCount(race)
			if (skin < 0 || skin >= _max_skins) {
				skin = _max_skins ? irandom(_max_skins - 1) : SkinLetter.A
			}
			
			if (!scr_weapon_is_valid(cwep)) {
				cwep = scrWeeklyWeaponDecide()
				
				if (!scr_weapon_is_valid(bwep) && random(1) < 0.4) {
					bwep = scrWeeklyWeaponDecide()
				}
			}
			else if (!scr_weapon_is_valid(bwep)) {
				bwep = wep_none
			}
			
			start_curse = _weekly_data[? "startcursed"] ?? false
			start_bcurse = _weekly_data[? "bstartcursed"] ?? false
		}
	})
	
	//
	var _crown = _weekly_data[? "crown"] ?? crwn_random
	
	if (_crown == crwn_random) {
		scrCrownSetCurrent(irandom_range(1, crownmax), true)
	}
	else if (scr_crown_is_valid(_crown)) {
		scrCrownSetCurrent(_crown, true)
	}
	
	//
	var _inst = scr_playerinstance_find(global.index)
	
	with CharSelect {
		if race == Race.Random && slot_index == 0 {
			with instance_create(x, y, CharSelect) {
			    race = _inst.race
			    selected = true
			}
		}
		
		instance_destroy()
	}
	
	with (GoButton) {
		if (sprite_index == sprGoButtonSymbolic) instance_destroy()
	}
	
    with (Menu) weekly = true
}

function scrMenuPrepareCustomLoadout() {
	if (!scrGameIsCustomMode()) exit
	
	var _race = scrCustomParam("race", 0),
		_skin = scrCustomParam("bskin", -1),
		_crown = scrCustomParam("crown", 0),
		_wep = scrCustomParam("wep", -1),
		_bwep = scrCustomParam("bwep", -1),
		_pinst = scr_playerinstance_find(global.index)
	
	if (_race != 0 && _race < Race.NUM_ALL_RACE_TYPES) {
		_pinst.race = _race
		
		if (_skin >= 0 && _skin < scrRaceGetMaxSkinCount(_race)) {
			_pinst.skin = _skin
		}
		
		with CharSelect {
			if race == Race.Random && slot_index == 0 {
				with instance_create(x, y, CharSelect) {
				    race = _race
				    selected = true
				}
			}
			
			instance_destroy()
		}
		
		with (GoButton) {
			if (sprite_index == sprGoButtonSymbolic) instance_destroy()
		}
	}
	
	if (scr_crown_is_valid(_crown)) {
		scrCrownSetCurrent(_crown, true)
	}
	
	if (_wep >= 0) {
		if (scrCustomParam("curse")) {
			_pinst.start_curse = true
		}
		_pinst.cwep = _wep
	}
	
	if (_bwep >= 0) {
		if (scrCustomParam("bcurse")) {
			_pinst.start_bcurse = true
		}
		_pinst.bwep = _bwep
	}
	
	with (UberCont) {
		protowep = scrCustomParam("protowep")
		if (!scr_weapon_is_valid(protowep)) {
			protowep = scrCustomParam("protowep_s")
		}
		protocurse = scrCustomParam("protocurse")
	}
}

/// @function scrMenuLoadoutGetPlayerDrawAlignment
/// @param player_index
function scrMenuLoadoutGetPlayerDrawAlignment(_index) {
	switch _index {
		case 0: return [ fa_left, fa_bottom ]
		case 1: return [ fa_right, fa_bottom ]
		case 2: return [ fa_left, fa_top ]
		case 3: return [ fa_right, fa_top ]
	}
	
	return undefined
}

/// @function scrCampfireMenuDrawRacePortrait
/// @param x
/// @param y
/// @param player_index
/// @param race
/// @param skin
/// @param halign
/// @param valign
function scrCampfireMenuDrawRacePortrait(_x, _y, _index, _race, _skin, _halign, _valign) {
	assert(!(_halign == fa_center || _valign == fa_middle))
	
	var _w = gui_w,
		_h = gui_h,
		
		_is_back_layer = _index >= 2,
		_portrait_x = (_halign == fa_right ? 2 : -2) + 18,
		_portrait_y = _h - LETTERBOX_SIZE - (8 * (1 + _is_back_layer)) + 44,
		_portrait_sprite = sprBigPortrait,
		_portrait_subimage = 0,
		
		_charsplat_x = 0,
		_charsplat_y = floor(_h - LETTERBOX_SIZE + 1),
		
		_pinst = scr_playerinstance_find(_index),
		
		_xscale = 1,
		_yscale = 1
	
	if _valign == fa_top {
		_charsplat_y = LETTERBOX_SIZE
		_yscale *= -1
	}
	
	if _halign == fa_right {
		_charsplat_x += _w + 1
		_portrait_x += _w
		_xscale *= -1
	}
	
	#region Portrait
		
		if !is_undefined(_pinst) && !instance_exists(Menu) {
			if _pinst.is_race(Race.Chicken) && _pinst.hp <= 0 {
				_portrait_sprite = sprBigPortraitChickenHeadless
				_portrait_subimage = _pinst.skin
			}
			else if _pinst.is_race(Race.Rebel) && _pinst.skin == 1 && GameCont.area == area_city {
				_portrait_sprite = sprBigPortraitRebelBHooded
			}
		}
		
		if _portrait_sprite == sprBigPortrait {
			_portrait_subimage = scr_race_get_skin_subimage(_race, _skin)
		}
		
		if (_portrait_subimage >= 0) {
			var _color = _is_back_layer ? c_gray : c_white
			
			if instance_exists(Menu) {
				with (Menu) _portrait_x -= portrait_offsets[_index] * _xscale
			}
			else _portrait_y += 20
			
			if scrGameIsPaused() {
				_portrait_x -= UberCont.pause_portrait_anim * _xscale
			}
			
			draw_sprite_ext(_portrait_sprite, _portrait_subimage,
				_x + _portrait_x + (_is_back_layer ? 20 : -18) * _xscale, _y + _portrait_y, _xscale, 1, 0, _color, 1)
		}
		
	#endregion
	
	#region Splat
		
		with Menu {
			draw_sprite_ext(sprCharSplat, splatindex,
				_x + _charsplat_x, _y + _charsplat_y, _xscale, _yscale, 0, c_white, 1)
		}
		
	#endregion
}

/// @function scrCampfireMenuDrawCharText
/// @param x
/// @param y
/// @param player_index
/// @param race
/// @param skin
/// @param halign
/// @param valign
function scrCampfireMenuDrawCharText(_x, _y, _index, _race, _skin, _halign = fa_left, _valign = fa_bottom) {
	assert(!(_halign == fa_center || _valign == fa_middle))
	
	var _w = gui_w,
		_h = gui_h,
		
		_bigname_x = 0, _bigname_y = LETTERBOX_SIZE + 32 * (_valign == fa_bottom && _race != Race.Random),
		
		_xscale = 1,
		_yscale = 1
	
	if _valign == fa_top {
		_yscale *= -1
	}
	else if _valign == fa_bottom {
		_bigname_y = _h - _bigname_y
	}
	
	if _halign == fa_right {
		_bigname_x += _w
		_xscale *= -1
	}
	
	draw_align(_halign, _valign)
	
	#region Name
		
		var _race_name = scrRaceGetName(_race)
		
		if (loc("Races", _race, "Name", _race_name) == _race_name && player_count > 1) {
			var _drawx = _x + _bigname_x,
				_drawy = _y + _bigname_y - sprite_get_height(sprBigName)
			
			if textappear[_index] != 2 {
				draw_sprite_ext(sprBigName, _race, _drawx + 1, _y + _drawy + 0, 1, 1, 0, c_black, 1)
				draw_sprite_ext(sprBigName, _race, _drawx + 1, _y + _drawy + 1, 1, 1, 0, c_black, 1)
				draw_sprite_ext(sprBigName, _race, _drawx + 1, _y + _drawy + 2, 1, 1, 0, c_black, 1)
				draw_sprite_ext(sprBigName, _race, _drawx + 0, _y + _drawy + 2, 1, 1, 0, c_black, 1)
			}
			
			draw_sprite_ext(sprBigName, _race, _drawx, _drawy, 1, 1, 0, c_white, 1)
		}
		else {
			draw_text_bigname(_x + _bigname_x, _y + _bigname_y, loc("Races", _race, "Name", _race_name), c_white, 1, 1)
		}
		
	#endregion
	
	#region Skills
		
		var _appear = textappear[_index]
		
		if _race != Race.Random && _appear != 2 {
			var _passive_text = loc("Races", _race, "Passive", scrRaceGetPassiveSkillDescription(_race)),
				_active_text = loc("Races", _race, "Active", scrRaceGetActiveSkillDescription(_race)),
				_skills_text, _skills_y = _bigname_y;
			
			_skills_text = $"{_passive_text}\n{_active_text}"
			
			if _valign == fa_bottom {
				_skills_y += (font_get_string_height(_skills_text) div 2) + _appear + 8
				draw_set_valign(fa_middle)
			}
			else if _valign == fa_top {
				_skills_y += sprite_get_height(sprBigName)
			}
			
			var _offset = font_get_height_diff()
			draw_text_nt(_x + _bigname_x + (8 * _xscale), _y + _skills_y - _offset, _skills_text)
		}
	
	#endregion
	
	draw_align()
}

/// @function scrMenuDrawPlayersOrdered
/// @param x
/// @param y
/// @param {Asset.GMScript} function
function scrMenuDrawPlayersOrdered(_x, _y, _function) {
	var _do_letterbox = (_function == scrCampfireMenuDrawRacePortrait && !scrGameIsPaused())
	
	if player_count > 1 {
		var _player_numbers = [ 2, 3, 0, 1 ],
			_player_slot_count = array_length(_player_numbers)
		
		for(var _player_index = 0; _player_index < _player_slot_count; ++_player_index) {
			var _player_number = _player_numbers[_player_index],
				_pinst = scr_playerinstance_find(_player_index)
			
			if _do_letterbox && _player_number == 0 {
				scrDrawLetterbox()
			}
			
			if _player_number == global.index || is_undefined(_pinst) continue
			
			var _alignment = scrMenuLoadoutGetPlayerDrawAlignment(_player_number)
			
			script_execute(_function, _x, _y, _player_number,
				_pinst.race, _pinst.skin, _alignment[0], _alignment[1])
		}
	}
	else if _do_letterbox {
		scrDrawLetterbox()
	}
	
	// local player always goes upfornt
	var _pinst = scr_playerinstance_find(global.index),
		_alignment = scrMenuLoadoutGetPlayerDrawAlignment(0)
	
	script_execute(_function, _x, _y, 0,
		_pinst.race, _pinst.skin, _alignment[0], _alignment[1])
}

/// @function scrCampfireMenuSelectionChange
/// @param player_index
/// @param {Enum.Race} race_change
function scrCampfireMenuSelectionChange(_player_index, _race) {
	with Menu {
		var _pinst = scr_playerinstance_find(_player_index)
		
		portrait_offsets[_player_index] = 180
		textappear[_player_index] = 2
		
		if _pinst.is_local() && _pinst.race != _race {
			if (scrCustomParam("bskin", -1) == -1) {
				_pinst.skin = scr_loadout_race_get_skin(_race)
			}
			
			if (scrCustomParam("wep", -1) == -1) {
				if scrGameIsDailyRun() {
					_pinst.cwep = scrRaceGetStarterWeapon(_race)
			    }
				else if !scrGameIsWeeklyRun() {
					_pinst.cwep = scr_loadout_race_get_start_weapon(_race)
			    }
			}
			
			if is_touch(_player_index) {
				with (GoButton) alarm[0] = 30
			}
			
			if !scrGameIsEventRun() && scrCustomParam("crown", 0) <= 0 && global.is_server {
				var _start_crown = scr_loadout_race_get_start_crown(_race)
				
				if scr_loadout_race_is_crown_unlocked(_race, _start_crown) {
					scrCrownSetCurrent(_start_crown, true)
				}
			}
			
			if !scr_loadout_is_available_for_race(_race) {
				loadout_open = false
			}
			
			_pinst.race = _race
		}
	}
}

/// @function scrMenuDrawLoadout
/// @param playerinstance
function scrMenuDrawLoadout(_pinst) {
	static __update_tooltip_display = function(_tooltip, _tooltip_x, _tooltip_y) {
		with (Menu) {
			if (is_string(_tooltip)) {
				if (tooltip != _tooltip) {
					tooltip = _tooltip
					tooltip_pop = 1
				}
				else if (tooltip_pop) {
					tooltip_pop --
				}
				
				scrDrawTooltip(_tooltip_x, _tooltip_y, _tooltip, tooltip_pop, true)
			}
			else if (!is_undefined(tooltip)) {
				tooltip = undefined
				tooltip_pop = 0
			}
		}
	}
	
	var _w = gui_w,
		_h = gui_h,
		
		_mx = device_mouse_x_to_gui(0),
		_my = device_mouse_y_to_gui(0),
		_press = mouse_ui_clicked(),
		
		_race = _pinst.get_race(),
		_skin_current = _pinst.get_skin(),
		
		_is_touch = is_touch(),
		
		_crown_count = crownmax + 1,
		_crown_current = scrCrownGetCurrent(),
		_crown_unlocked_total = scr_loadout_race_get_unlocked_crowns_count(_race),
		_crowntop = LETTERBOX_SIZE * 2,
		_crownbottom = _h - _crowntop,
		_crownsize = sprite_get_height(sprLoadoutCrown) - 4,
		_crownstep = _crownsize,
		_crownspace_height = _crownbottom - _crowntop,
		_crowns_per_column = max(1, _crownspace_height div _crownsize),
		_crowns_per_row = _crown_count div _crowns_per_column,
		_crownright = _w + 12,
		_crownleft = _crownright - _crowns_per_row * _crownsize,
		
		_weapon_count = 2,
		_weaponsize = 44,
		_weapons_x = (_crownright + _crownleft) div 2 - (_weaponsize * 0.5) * _weapon_count + 18,
		_weapons_y = _crownbottom + _crownsize div 2 - 14,
		_is_custom_weapon = (scrCustomParam("wep", -1) >= 0 || scrCustomParam("bwep", -1) >= 0),
		
		_skin_count = scrRaceGetMaxSkinCount(_race),
		_skinsize = sprite_get_width(sprLoadoutSkin) - 4,
		_skins_x = _crownleft - _crownsize div 2 - 22,
		_skins_y = (_h div 2) - (_skinsize * 0.5) * _skin_count - 2,
		
		_splat_x = _w + 2,
		_splat_y = _h - LETTERBOX_SIZE + 2,
		_splat_width = _skins_x,
		_splat_open_width = sprite_get_width(sprLoadoutSplat),
		_splat_open_height = sprite_get_height(sprLoadoutSplat),
		_splat_pointed = point_in_rectangle(_mx, _my,
			_splat_x - _splat_open_width div (loadout_open ? 4 : 2),
			_splat_y - _splat_open_height div 2,
			_splat_x, _splat_y),
		
		_fullview = (loadout_frame >= 2),
		_tooltip = undefined,
		_tooltip_x = 0,
		_tooltip_y = 0,
		
		_primary_weapon = _pinst.cwep,
		_secondary_weapon = _pinst.bwep
	
	if _race == Race.Steroids && !scr_weapon_is_valid(_secondary_weapon) {
		_secondary_weapon = wep_revolver
	}
	
	if loadout_frame == 0 {
		draw_sprite_ext(sprLoadoutSplat, splatindex, _splat_x, _splat_y, 1, 1.05, 0, c_white, 1)
	}
	
	#region Loadout arrow
	
	if _race != Race.Random {
		if scr_loadout_is_available_for_race(_race) && !scrGameIsEventRun() {
			if scr_keyboard_check_pressed(vk_space) || (_press && _splat_pointed) {
				snd_play(loadout_open ? sndClickBack : sndMenuLoadout)
				loadout_open ^= 1
				_press = false
			}
			
			if _splat_pointed {
				if !loadout_arrow_pointed {
					loadout_arrow_pointed = true
					snd_play(sndHover)
				}
			}
			else loadout_arrow_pointed = false
			
			if loadout_frame > 0 {
				var _xscale = max(1, (_w - _skins_x) / (sprite_get_width(sprLoadoutOpen) - _crownsize * 2)),
					_yscale = (_splat_y - LETTERBOX_SIZE) / sprite_get_height(sprLoadoutOpen) + 0.05
				
				draw_sprite_ext(sprLoadoutOpen, loadout_frame,
					_splat_x - 2, _splat_y, _xscale, _yscale, 0, c_white, 1)
			}
			
			draw_sprite_ext(sprLoadoutArrow, loadout_open,
				_splat_x - 16, _splat_y - _splat_pointed - 16, 1, 1, 0, _splat_pointed ? c_white : c_uigray, 1)
		}
		else {
			loadout_open = false
			if _fullview {
				_fullview = false
				loadout_frame = 0
			}
		}
		
		//
		var _tooltip_always_visible = !is_keyboard(_pinst.index)
		
		if !_fullview && ((_is_custom_weapon || scrGameIsWeeklyRun()) && (_tooltip_always_visible || _splat_pointed)) {
			if scrCustomParam("crown", 0) > 0 {
				_tooltip = loc("Crowns", _crown_current, "Name", scr_crown_get_name(_crown_current)) + "\n"
					+ "@s" + loc("Crowns", _crown_current, "Text", scr_crown_get_text(_crown_current)) + "@w"
			}
			else _tooltip = ""
			
			if (scr_weapon_is_valid(_primary_weapon)) {
				if (_tooltip != "") {
					_tooltip += "\n"
				}
				_tooltip += "\n" + loc("Weapons", _primary_weapon, "Name", scr_weapon_get_name(_primary_weapon))
			}
			if (scr_weapon_is_valid(_secondary_weapon)) {
				if (_tooltip != "") {
					_tooltip += "\n"
				}
				_tooltip += "\n" + loc("Weapons", _secondary_weapon, "Name", scr_weapon_get_name(_secondary_weapon))
			}
			
			_tooltip_x = _splat_x - 55
			_tooltip_y = _splat_y - 50
			
			if (_tooltip_always_visible) _tooltip_y -= 15
		}
	}
	
	#endregion
	
	#region Current loadout
	
	if !_fullview && _race != Race.Random {
		var _loadout_x = _splat_x - 60,
			_loadout_y = _splat_y - 15,
		
		if !scrGameIsWeeklyRun() && !scr_loadout_is_available_for_race(_race) {
			_splat_pointed = false
		}
		
		if _crown_current != crwn_none {
			var _crown_x = _loadout_x - _splat_pointed,
				_crown_y = _loadout_y - _splat_pointed - 25
			
			draw_sprite(sprLoadoutCrown, _crown_current, _crown_x, _crown_y)
			
			if (_crown_current == crwn_haste) scrDrawClock(_crown_x - 2, _crown_y - 1)
		}
		
		if _primary_weapon >= 0 && _secondary_weapon >= 0 {
			scrLoadoutDrawWeapon(_secondary_weapon,
				_loadout_x - _splat_pointed + 16, _loadout_y + _splat_pointed, c_silver)
			
			scrLoadoutDrawWeapon(_primary_weapon,
				_loadout_x - _splat_pointed - 8, _loadout_y + _splat_pointed, c_white)
		}
		else if _primary_weapon >= 0 {
			scrLoadoutDrawWeapon(_primary_weapon,
				_loadout_x - _splat_pointed, _loadout_y + _splat_pointed, c_white)
		}
		else if _secondary_weapon >= 0 {
			scrLoadoutDrawWeapon(_secondary_weapon,
				_loadout_x - _splat_pointed, _loadout_y + _splat_pointed, c_white)
		}
	}
	
	#endregion
	
	if (!_fullview) {
		__update_tooltip_display(_tooltip, _tooltip_x, _tooltip_y)
		exit
	}
	
	var _openaddy = (loadout_frame >= 2 && loadout_frame < 3) ? (loadout_open ? 1 : -1) : 0
	
	#region Crowns
		
		var _any = false,
			_crown_x = _crownleft + 12,
			_crown_y = _crowntop + _openaddy - 24
		
		_crown_x = _crownright - _crownsize * 3
		
		for(var _crown_id = 0; _crown_id < _crown_count; ++_crown_id) {
			if _crown_id == crwn_random && !_crown_unlocked_total {
				_crown_x += _crownsize
				continue
			}
			
			var _is_pointed = point_in_circle(_mx, _my, _crown_x, _crown_y, _crownsize * 0.5),
				
				_unlocked = scr_loadout_race_is_crown_unlocked(_race, _crown_id),
				
				_is_suspected_selection = _unlocked && (_is_pointed || _crown_current == _crown_id),
				
				_selection_tint = _is_suspected_selection ? c_white : c_uigray
			
			draw_sprite_ext(_unlocked ? sprLoadoutCrown : sprLockedLoadoutCrown, _crown_id,
				_crown_x, _crown_y - _is_suspected_selection, 1, 1, 0, _selection_tint, 1)
			
			if _unlocked && _crown_id == crwn_haste {
				scrDrawClock(_crown_x - 2, _crown_y - _is_suspected_selection - 1, _selection_tint)
			}
			
			if _is_pointed {
				_any = true
				
				if _unlocked {
					//
					_tooltip = loc("Crowns", _crown_id, "Name", scr_crown_get_name(_crown_id))
					+ "\n@s" + loc("Crowns", _crown_id, "Text", scr_crown_get_text(_crown_id))
					
					_tooltip_x = _crown_x
					_tooltip_y = _crown_y - 16
					
					//
					if _press && _crown_current != _crown_id {
						scrCrownSetCurrent(_crown_id, true)
						scr_loadout_race_set_start_crown(_race, _crown_id)
						snd_play(sndMenuCrown, 0.95 + random(0.1))
					}
					
					if loadout_crown_pointed != _crown_id {
						loadout_crown_pointed = _crown_id
						snd_play(sndHover)
					}
				}
				else {
					if (!_is_touch) {
						_tooltip = loc("Loadout:CrownLocked", "LOCKED")
						_tooltip_x = _crown_x
						_tooltip_y = _crown_y - 16
					}
					
					if _press {
						if (_is_touch) with (Menu) {
							unlock_hint = loc("Loadout:CrownLocked", "LOCKED")
							unlock_hint_pop = 2
							alarm[11] = 90
						}
						
						snd_play(sndNoSelect, 0.95 + random(0.1))
					}
				}
			}
			
			_crown_x += _crownsize
			
			if _crown_x >= _crownright || _crown_id == crwn_none {
				_crown_x = _crownleft
				_crown_y += _crownstep
			}
		}
		
	#endregion
	
	#region Skins
		
		if _skin_count > 1 {
			var _any = false
			
			for(var _skin_id = 0; _skin_id < _skin_count; ++_skin_id) {
				var _is_pointed = point_in_circle(_mx, _my, _skins_x, _skins_y, 10),
					_unlocked = scr_race_is_skin_unlocked(_race, _skin_id),
					_letter = scr_race_get_skin_letter(_skin_id, true)
				
				if _is_pointed {
					if _unlocked {
						if !loadout_skin_pointed {
							loadout_skin_pointed = true
							snd_play(sndHover)
						}
						
						_tooltip = loc("Loadout:Skin" + _letter, _letter + " SKIN")
						_tooltip_x = _skins_x
						_tooltip_y = _skins_y - 16
						
						if _press {
							if scr_loadout_race_get_skin(_race) != _skin_id {
								scr_loadout_race_set_skin(_race, _skin_id)
								portrait_offsets[_pinst.get_index()] = 180
								_pinst.skin = _skin_id
								
								if _skin_id == SkinLetter.C {
									snd_play(sndMenuCSkin, random_range(0.95, 1.05))
								}
								else if _skin_id == SkinLetter.B {
									snd_play(sndMenuBSkin, 1 + (_skin_id - 1) * random_range(0.05, 0.1))
								}
								else snd_play(sndMenuASkin, 0.95 + random(0.1))
							}
							_press = false
						}
					}
					else {
						var _suffix = "SkinUnlock"
						
						var _string = loc("Races", _race,
								(_skin_id > SkinLetter.B ? (_letter + _suffix) : _suffix),
								scrRaceGetSkinUnlockDescription(_race, _skin_id))
						
						if (!_is_touch) {
							_tooltip = _string
							_tooltip_x = _skins_x
							_tooltip_y = _skins_y - 16
						}
						
						if (_press) {
							if (_is_touch) with (Menu) {
								unlock_hint = _string
								unlock_hint_pop = 2
								alarm[11] = 90
							}
						
							snd_play(sndNoSelect, 0.95 + random(0.1))
						}
					}
					
					_any = true
				}
				
				var _subimage = scr_race_get_skin_subimage(_race, _skin_id),
					_is_selection = _unlocked && (_skin_current == _skin_id || _is_pointed)
				
				draw_sprite_ext(_unlocked ? sprLoadoutSkin : sprLoadoutSkinLocked, _subimage,
					_skins_x, _skins_y + _openaddy - _is_selection, 1, 1, 0, _is_selection ? c_white : c_uigray, 1)
				
				_skins_y += _skinsize
			}
			
			if !_any {
				loadout_skin_pointed = false
			}
		}
		
	#endregion
	
	#region Weapons
		
		if _weapon_count >= 1 && !_is_custom_weapon {
			var _default_weapon = scrRaceGetStarterWeapon(_race),
				_unlocked_cwep = scr_loadout_race_get_stored_weapon(_race),
				_current_weapon = scr_loadout_race_get_start_weapon(_race),
				_slot_weapons = [ _default_weapon, _unlocked_cwep ],
				_slot_count = array_length(_slot_weapons),
				_any = false
			
			for(var _slot_index = 0; _slot_index < _slot_count; ++_slot_index) {
				var _weapon = _slot_weapons[_slot_index]
				
				if _slot_index > 0 && _weapon == _default_weapon {
					continue
				}
				
				var _is_chosen = (_current_weapon == _weapon),
					_is_pointed = point_in_circle(_mx, _my, _weapons_x, _weapons_y, 10),
					_color = _is_chosen ? c_white : (_is_pointed ? c_uilight : c_uigray),
					_offset = max(_is_pointed, _is_chosen * 2) - _openaddy
				
				scrLoadoutDrawWeapon(_weapon, _weapons_x, _weapons_y - _offset, _color)
				
				if _is_pointed {
					_tooltip = loc("Weapons", _weapon, "Name", scr_weapon_get_name(_weapon))
					_tooltip_x = _weapons_x
					_tooltip_y = _weapons_y - 16
					
					if !loadout_weapon_pointed {
						loadout_weapon_pointed = true
						snd_play(sndHover)
					}
					
					_any = true
					
					if _press && !_is_chosen {
						scr_loadout_race_set_start_weapon(_race, _weapon)
						snd_play(scr_weapon_is_golden(_weapon) ? sndMenuGoldwep : wep_swap[_weapon])
						_press = false
					}
				}
				
				_weapons_x += _weaponsize
			}
			
			if !_any {
				loadout_weapon_pointed = false
			}
		}
		
	#endregion
	
	__update_tooltip_display(_tooltip, _tooltip_x, _tooltip_y)
}

/// @function scrLoadoutDrawWeapon
/// @param {Real} weapon_id
/// @param x
/// @param y
/// @param tint_color
function scrLoadoutDrawWeapon(_weapon_id, _x, _y, _tint) {
	var _sprite = scr_weapon_get_loadout_sprite(_weapon_id)
	
	// make sure that the weapon has a dedicated loadout art
	if is_numeric(_sprite) && sprite_exists(_sprite) {
		draw_sprite_ext(_sprite, 0, _x, _y, 1, 1, 0, _tint, 1)
		exit
	}
	
	// if not, use the regular weapon sprite instead
	var _weapon_sprite = scr_weapon_get_sprite(_weapon_id)
	if sprite_exists(_weapon_sprite) {
		var _xorig = sprite_get_xoffset(_weapon_sprite),
			_yorig = sprite_get_yoffset(_weapon_sprite),
			_width = sprite_get_width(_weapon_sprite),
			_height = sprite_get_height(_weapon_sprite)
		sprite_set_offset(_weapon_sprite, _width div 2, _height div 2)
		draw_sprite_ext(_weapon_sprite, 0, _x, _y, 2, 2, 30, _tint, 1)
		sprite_set_offset(_weapon_sprite, _xorig, _yorig)
	}
}
