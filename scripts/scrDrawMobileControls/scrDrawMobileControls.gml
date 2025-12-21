function scrDrawMobileControls(_player = noone, _scale_option = UberCont.opt_controls_scale) {
	if (UberCont.quit_pause || UberCont.want_pause) exit
	
    var _width = 1,
		_controls_alpha_inside = 37 / 255,
		_hid_sticks = UberCont.opt_hiddensticks,
		_simplified = UberCont.opt_simplify,
		_autoaim = UberCont.opt_aimbot,
		_index = global.index

    _scale_option = min(1 + _scale_option, 1.5)
	
    var _scale_multiplier = (0.5 + _scale_option) / 2,
		_stick_radius_treshold = (_simplified ? 0.65 : 0.5)

    draw_set_color(c_white)
	
	#region Movement

    with JoystickMove {
        var _direction = KeyCont.dir_move[_index],
			_distance = rad * KeyCont.moving[_index],
			_stick_x = round(x + lengthdir_x(_distance * _stick_radius_treshold, _direction)),
			_stick_y = round(y + lengthdir_y(_distance * _stick_radius_treshold, _direction)),
			_alpha = image_alpha

        if _simplified {
			draw_set_color(c_black)
			draw_set_alpha(_alpha * _controls_alpha_inside)
			draw_circle(x - 1, y - 1, rad * _scale_multiplier, false)
			
			draw_set_color(c_white)
			draw_set_alpha(_alpha)
			draw_circle_width(x, y, rad * _scale_multiplier, _width)
			
            if (_distance) draw_set_color(c_ltgray)
            draw_circle(_stick_x - 1, _stick_y - 1, rad * _scale_multiplier * 0.33, 0)
			
            draw_set_color(c_white)
			draw_set_alpha(1)
        }
		else {
			draw_sprite_ext(sprMobileControlJoystick, 0,
				round(x), round(y), _scale_option, _scale_option, 0, c_white, _alpha)
            
			draw_sprite_ext(sprMobileControlJoystick, 1,
				_stick_x, _stick_y, _scale_option, _scale_option, 0, c_white, _alpha)
        }
    }
	
	#endregion
	
	#region Attack & Weapon sticks
	
    with JoystickAttack {
        var _direction = KeyCont.dir_fire[_index],
			_distance = self.dis,
		
        var _stick_x = round(x + lengthdir_x(_distance * _stick_radius_treshold, _direction)),
			_stick_y = round(y + lengthdir_y(_distance * _stick_radius_treshold, _direction)),
			_alpha = image_alpha,
			_angle = 0
		
		var _is_wepstick = instance_is(self, WepstickAttack), _wepstick_scale = 0.8
		
		if _autoaim {
			_stick_x = x
			_stick_y = y
			_angle = 45
		}
		
        if _simplified {
			draw_set_color(c_black)
			draw_set_alpha(_alpha * _controls_alpha_inside)
			draw_circle(x - 1, y - 1, rad * _scale_multiplier, false)
			
			draw_set_color(c_white)
			draw_set_alpha(_alpha)
			
            if (_distance) draw_set_color(c_ltgray)
			
			var _stick_radius = rad * _scale_multiplier
			
			// hollow circle with lines on both axis
			// when using fully automatic aim
			if _angle > 0 {
				_stick_radius *= 0.9
				draw_circle_width(_stick_x, _stick_y, _stick_radius, _width)
				draw_circle_width(_stick_x, _stick_y, _stick_radius * 0.7, _width)
				
				_stick_x --
				_stick_y --
				
				draw_line_width(_stick_x, _stick_y - _stick_radius - 4, _stick_x, _stick_y + _stick_radius + 4, _width)
				draw_line_width(_stick_x - _stick_radius - 4, _stick_y, _stick_x + _stick_radius + 4, _stick_y, _width)
			}
            else {
				draw_circle_width(x, y, _stick_radius, _width)
				draw_circle(_stick_x - 1, _stick_y - 1, _stick_radius * 0.33, 0)
			}
			
            draw_set_color(c_white)
			draw_set_alpha(1)
        }
		else {
            var _color = 0x0dfd98,
				_crosshair = UberCont.opt_crosshair,
				_splitfire = UberCont.opt_splitfire
			
			if (!_splitfire && UberCont.opt_cursorcol != c_white) _color = UberCont.opt_cursorcol
			
			var _scale = _scale_option
			
			if (_is_wepstick) _scale *= _wepstick_scale
			
			draw_sprite_ext(sprMobileControlJoystick, 0, x, y,
				_scale, _scale, _angle, c_white, _alpha)
			
			draw_sprite_ext(sprCrosshairBig, _crosshair, _stick_x, _stick_y,
				_scale * 0.5, _scale * 0.5, (_crosshair < 7 ? _angle : 0), _color, _alpha)
			
			if ((_splitfire && !_is_wepstick) || (index != -1 && !(_is_wepstick || _autoaim )
				&& (!_splitfire && (_distance / rad) < ATTACK_BUTTON_DEADZONE))
			) {
				draw_sprite_ext(sprMobileControlJoystick, 2, x, y,
					_scale, _scale, _angle, c_gray, _alpha)
			}
		}
		
		if _is_wepstick {
			var _color = active ? make_color_hsv(65, 242, 252) : c_gray,
				_scale = _scale_option * wepstick_scale
			
			if (index != -1 && (_distance / rad) < ATTACK_BUTTON_DEADZONE) {
				_color = merge_color(_color, c_gray, 0.5)
			}
			
			if (!_simplified) draw_sprite_ext(sprMobileControlJoystick, 2,
				x, y, _scale, _scale, _angle, _color, _alpha)
			
			var _sprite = instance_exists(_player) ? wep_spr
				: (scr_weapon_get_sprite(primary ? wep_revolver : wep_wrench)) // default sprites
			
			if sprite_exists(_sprite) {
				var _color = active ? c_white : c_gray,
					_scale = (_scale_option + 0.5) * 0.67
				
				draw_sprite_ext(_sprite, 0,
					lerp(x, _stick_x, 0.37) + 8,
					lerp(y, _stick_y, 0.37) + 12,
					_scale, _scale, 60, _color, _alpha)
			}
		}
    }
	
	#endregion
	
	#region Ability

    var _crystal_tb = instance_exists(_player) && _player.race == Race.Crystal && scr_skill_get(mut_throne_butt)

    with ButtonActive {
        if _crystal_tb {
			draw_sprite_ext(sprSkillIconHUD, 5,
				x, y, _scale_option, _scale_option, 0, c_white, 0.5)
			
			continue
		}
		
        var _volumecontrol = self[$ "volume_control_command"],
            _color = c_white, _alpha = min(1, rogue_hide / 60),
			_forever = KeyCont.activeforever[_index]
			
		if _forever {
			_color = c_lime
		}
		else {
			if _volumecontrol == -1 {
				_color = c_yellow
			}
	        else if _volumecontrol == 2 {
				_color = c_ultra
			}
			
			if index != -1 {
				_color = merge_color(_color, c_gray, 0.5)
			}
		}
		
        draw_sprite_ext(sprMobileControlAbility, 0, x, y,
			_scale_option * 0.75, _scale_option * 0.75, 0, _color, _alpha)
		
        if instance_exists(_player) && _player.race == Race.Rogue && _player.pref("rogue") {
            draw_set_halign(fa_center)
            draw_set_valign(fa_middle)
			
			draw_set_alpha(_alpha * 1.25)
            draw_text_shadow(x, y, loc("SCREEN#SWIPE"))
			
			draw_set_alpha(1)
            
			draw_set_halign(fa_left)
            draw_set_valign(fa_top)
        }
    }
	
	#endregion
	
	#region Pickup/Interact button

    with ButtonAct {
        if (!instance_exists(_player)) {
			alpha = 1
		}
		else if (alpha <= 0) continue
		
        var _volumecontrol = self[$ "volume_control_command"],
            _color = (_volumecontrol == 1 ? c_lime : (_volumecontrol == -1 ? c_yellow : (_volumecontrol == 2 ? c_gray : c_white)))
		
		draw_set_color(c_black)
		var _a = power(min(alpha, 1), 2)
		draw_set_alpha(_a * _controls_alpha_inside)
		draw_circle(x - 1, y - 1, rad * _scale_multiplier, false)
		
        if _simplified {
            draw_set_alpha(alpha)
            draw_set_color(_color)
			
            draw_circle_width(x, y, rad * _scale_multiplier, _width)
        }
		else {
            draw_sprite_ext(sprMobileControlCorners, 0, x, y, _scale_option, _scale_option, 0, _color, alpha)
        }
		
        draw_set_color(c_white)
		draw_set_alpha(1)
    }
	
	scrDrawInteractionHUD(_player)
	
	#endregion
	
	#region Attack button (separate)
	
	with ButtonAttack {
        var _scale = _scale_option / 2,
			_color = UberCont.opt_cursorcol
		
		if _simplified {
            draw_set_color(c_white)
            draw_set_alpha(1)
			
            draw_circle_width(x, y, rad / 2 * _scale_multiplier, _width)
			
            draw_set_alpha(1)
            draw_set_color(c_white)
			
			_color = c_white
        }
		else {
            draw_sprite_ext(sprMobileControlCorners, 0, x, y, _scale_option, _scale_option, 0, c_white, 1)
        }
		
	    if _color == c_white
	        _color = make_color_rgb(125, 253, 13)
		
        draw_sprite_ext(sprCrosshairBig, UberCont.opt_crosshair, x, y + _scale, _scale, _scale, 0, c_black, 1)
        draw_sprite_ext(sprCrosshairBig, UberCont.opt_crosshair, x, y, _scale, _scale, 0, _color, 1)
    }
	
	#endregion
	
	#region Swap button
	
    with ButtonSwap {
        var _volumecontrol = self[$ "volume_control_command"],
            _color = (_volumecontrol == 1 ? c_lime
				: (_volumecontrol == -1 ? c_yellow : (_volumecontrol == 2 ? c_gray : c_white))),
			
			_weapon_scale = _scale_option + 0.5,
			_weapon_swap_tilt = 45 - rot,
			
			_wep, _bwep, _reload, _breload, _curse, _bcurse, _extra_weps, _extra_count;
		
		if instance_exists(_player) {
			_wep = _player.wep
			_bwep = _player.bwep
			_reload = _player.reload
			_breload = _player.breload
			_curse = _player.curse
			_bcurse = _player.bcurse
			_extra_weps = _player.extra_weps
			_extra_count = array_length(_extra_weps)
		}
		else {
			// example weapons
			_wep = wep_revolver
			_bwep = wep_wrench
			_reload = 4
			_breload = 0
			_curse = false
			_bcurse = false
			_extra_weps = undefined
			_extra_count = 0
		}
		
		draw_set_color(c_black)
		draw_set_alpha(_controls_alpha_inside)
		
		draw_circle(x - 1, y - 1, rad * _scale_multiplier, false)
		
		draw_set_color(_color)
        draw_set_alpha(0.7)
		
        if !_simplified {
			var _current_weapon = _wep,
				_current_reload = _reload,
				_weapon_index = 0,
				_extra_index = 0
			
			draw_set_color(c_white)
			draw_set_color(_curse ? #ab83d4 : c_white)
			
			repeat (2 + _extra_count) {
				if (scr_weapon_is_valid(_current_weapon)) {
					var _reload_width = _width * power(0.8, _weapon_index + 1) * 3,
						_reload_progress = max(0, _current_reload) / max(1, scr_weapon_get_load(_current_weapon)),
						_reload_radius = rad * _scale_multiplier - ((_reload_width + 0.5) * _weapon_index)
					
					draw_circle_part(x, y, _reload_radius, _reload_width, 1 - _reload_progress)
				}
				
				//
				if (_weapon_index >= 1) {
					if (_extra_index >= _extra_count) break
					_current_weapon = _player.extra_weps[_extra_index]
					_current_reload = _player.extra_weps_reload[_extra_index]
					var _value = 175 - _extra_index * 25
					if (_player.extra_weps_curse[_extra_index]) {
						draw_set_color(make_color_hsv(191, 96, _value))
					}
					else {
						draw_set_color(make_color_hsv(0, 0, _value))
					}
					_extra_index ++
				}
				else {
					_current_weapon = _bwep
					_current_reload = _breload
					draw_set_color(_bcurse ? #8f6db0 : c_ltgray)
					draw_set_alpha(0.5)
				}
				
				_weapon_index ++
	        }
			
			draw_set_alpha(1)
			draw_set_color(c_white)
		}
		else {
			draw_circle_width(x, y, rad * _scale_multiplier, _width)
		}
		
        draw_set_color(c_white)
        draw_set_alpha(1)
		
		var _weapons_x = x,
			_weapons_y = y + 10
		
		if (instance_exists(_player)) _weapons_y += _player.swapanim
		
		//
		if _extra_count > 0 {
			for(var i = 0; i < _extra_count; ++i) {
				var _sprite = scr_weapon_get_sprite(_extra_weps[i])
				
				if (sprite_exists(_sprite)) {
					var _xoff = round(sprite_get_width(_sprite) / 2) - sprite_get_xoffset(_sprite),
						_yoff = round(sprite_get_height(_sprite) / 2) - sprite_get_yoffset(_sprite)
					
					draw_sprite_ext(_sprite, 0, _weapons_x - _xoff, _weapons_y - _yoff,
						_weapon_scale, _weapon_scale, _weapon_swap_tilt + 30 * (i + 2), merge_color(c_gray, c_dkgray, i / _extra_count), 1)
				}
			}
		}
		
		//
        if scr_weapon_is_valid(_bwep) {
			var _sprite = scr_weapon_get_sprite(_bwep)
			
			if (sprite_exists(_sprite)) {
				var _xoff = round(sprite_get_width(_sprite) * 0.5) - sprite_get_xoffset(_sprite),
					_yoff = round(sprite_get_height(_sprite) * 0.5) - sprite_get_yoffset(_sprite)
				
				draw_sprite_ext(_sprite, 0, _weapons_x - _xoff, _weapons_y - _yoff,
					_weapon_scale, _weapon_scale, _weapon_swap_tilt + 30, c_gray, 1)
	        }
		}
		
		//
        if scr_weapon_is_valid(_wep) {
			var _sprite = scr_weapon_get_sprite(_wep)
			
			if (sprite_exists(_sprite)) {
				var _xoff = round(sprite_get_width(_sprite) * 0.5) - sprite_get_xoffset(_sprite),
					_yoff = round(sprite_get_height(_sprite) * 0.5) - sprite_get_yoffset(_sprite)
				
				draw_sprite_ext(_sprite, 0, _weapons_x - _xoff, _weapons_y - _yoff,
					_weapon_scale, _weapon_scale, _weapon_swap_tilt, c_white, 1)
	        }
		}
    }
	
	#endregion
	
	//
	
	#region Volume control help
	
    if UberCont.opt_volumecontrol {
        var _language = save_get_value("etc", "language", "null"),
			_sprite = sprMobileVolumeControl

        if (_language == "ru" || _language == "ua") {
            _sprite = sprMobileVolumeControlRU
        }
		
        with MobileUI {
            if (is_undefined(self[$ "volume_control_command"]) || object_index == ButtonAct) continue
            var _offset = rad / 2 + 4
			
            if object_index == ButtonSwap && instance_exists(_player) && !_player.bwep {
                draw_sprite_ext(_sprite, 0, x + _offset, y + _offset, 1, 1, 0, c_white, 0.33)
            }
			else {
				draw_sprite(_sprite, (object_index == ButtonActive), x + _offset, y + _offset)
			}
		}
    }
	
	#endregion
	
	#region Editing mode visuals
	
    if instance_exists(MenuOptions) && MenuOptions.editing_mode {
        with MobileUI {
            if index != -1 {
                smoothrad = lerp(smoothrad, 1, 0.1)
            }
			else {
				smoothrad = lerp(smoothrad, 0, 0.2)
			}
			
            if (smoothrad > 0) draw_circle_width(x, y, get_touch_radius(rad), smoothrad)
        }
    }
	
	#endregion
	
	
}