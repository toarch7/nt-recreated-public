/// @description Draw & selection

if (setup) {
	event_user(1)
	setup = false
}

var	_start_x = floor(gui_w / 13.5),
	_start_y = LETTERBOX_SIZE + 20,
	_half = LETTERBOX_SIZE div 2,
	_drawx = _start_x,
	_drawy = -scroll + _start_y,
	_width = gui_w - _drawx - 30,
	_height = gui_h,
	_xstep = 40,
	_ystep = 18,
	_mx = gui_x,
	_my = gui_y,
	_ypos = 0,
	_any = false

var _group_count = array_length(groups)

if (tooltip_pop != 0) {
	tooltip_pop = approach(tooltip_pop, 0, timescale)
}

var _current_weapon_key = get_weapon_key(),
	_current_curse_key = get_curse_key(),
	
	_current_weapon = scrCustomParam(_current_weapon_key),
	_current_curse = scrCustomParam(_current_curse_key)

for(var i = 0; i < _group_count; ++i) {
	var _weapons = groups[i],
		_weapon_count = array_length(_weapons)
	
	_drawx = _start_x
	
	var _dx = gui_w div 2,
		_dy = _drawy + _ypos - 12
	
	draw_sprite(sprCustomModeWeaponSplat, 0, _dx, _dy)
	draw_text_nt(_dx, _dy + 6, group_names[i])
	
	for(var j = 0; j < _weapon_count; ++j) {
		var _weapon = _weapons[j],
			_sprite = scr_weapon_get_sprite(_weapon),
			_dx = _drawx,
			_dy = _drawy + _ypos
		
		_drawx += _xstep
		
		if (_dy >= _half && _dy < (_height - LETTERBOX_SIZE)) {
			var _pointed, _name, _color;
			
			if (_weapon == wep_none) {
				_name = loc("CustomMode.Weapon", "None", "NONE")
				_sprite = sprCustomModeWeaponNo
			}
			else if (_weapon == -1) {
				_name = loc("CustomMode.Weapon", "Default", "DEFAULT")
				_sprite = sprCustomModeWeaponDefault
			}
			else {
				_name = loc("Weapons", _weapon, "Name", scr_weapon_get_name(_weapon))
			}
			
			if (_my >= 0 && _my <= (_height - LETTERBOX_SIZE - 4) && !dragging
				&& point_in_rectangle(_mx, _my, _dx, _dy, _dx + _xstep - 1, _dy + _ystep - 1)
			) {
				_pointed = true
				
				if (hovered_weapon != _weapon) {
					hovered_weapon = _weapon
					tooltip_pop = 1
				}
				
				if (mouse_ui_clicked()) {
					if (_current_weapon == _weapon) {
						if (scr_weapon_is_valid(_weapon)) {
							_current_curse ^= 1
							audio_stop_sound(sndCursedChest)
							audio_stop_sound(sndCursedReminder)
							snd_play(_current_curse ? sndCursedChest : sndCursedReminder)
							scrCustomParamChange(_current_curse_key, _current_curse)
						}
					}
					else {
						scrCustomParamChange(_current_curse_key, false)
						scrCustomParamChange(_current_weapon_key, _weapon)
						snd_play(scr_weapon_is_valid(_weapon) ? wep_swap[_weapon] : sndClick)
						if (scr_weapon_is_golden(_weapon)) snd_play(sndGoldPickup)
					}
				}
				
				scrDrawTooltip(_dx + _xstep * 0.5, _dy, _name, tooltip_pop, true)
				
				_any = true
			}
			else _pointed = false
			
			var _this_weapon = (_current_weapon == _weapon)
			_color = (_this_weapon || _pointed) ? c_white : c_silver
			
			if (sprite_exists(_sprite)) {
				var _ox = sprite_get_xoffset(_sprite),
					_oy = sprite_get_yoffset(_sprite),
					_wx = _dx + _xstep * 0.5 - sprite_get_width(_sprite) * 0.5,
					_wy = _dy + _ystep * 0.5 - sprite_get_height(_sprite) * 0.5 - _pointed
				
				sprite_set_offset(_sprite, 0, 0)
				
				if (_this_weapon) {
					var _outline = _current_curse ? c_curse : c_white
					draw_sprite_ext(_sprite, 1, _wx + 1, _wy + 0, 1, 1, 0, _outline, 1)
					draw_sprite_ext(_sprite, 1, _wx + 0, _wy + 1, 1, 1, 0, _outline, 1)
					draw_sprite_ext(_sprite, 1, _wx - 1, _wy - 0, 1, 1, 0, _outline, 1)
					draw_sprite_ext(_sprite, 1, _wx - 0, _wy - 1, 1, 1, 0, _outline, 1)
				}
				
				draw_sprite_ext(_sprite, 0, _wx, _wy, 1, 1, 0, _color, 1)
				
				if (_this_weapon) {
					draw_sprite(sprCustomModeWeaponYes, 0, _dx + _xstep - 4, _dy + _ystep - 4)
				}
				
				sprite_set_offset(_sprite, _ox, _oy)
			}	
			else {
				draw_sprite(sprDefault, 0, _dx, _dy)
			}
		}
		
		if ((_drawx + _xstep) >= _width) {
			_drawx = _start_x
			_ypos += _ystep
		}
	}
	
	_ypos += 40
}

if (!_any) hovered_weapon = -1

free_touch = _any

draw_set_color(c_white)

height = _ypos