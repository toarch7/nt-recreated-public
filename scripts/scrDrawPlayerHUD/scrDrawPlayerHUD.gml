function scrDrawPlayerHUD(_player = noone) {
	if !((UberCont.opt_hud || instance_exists(MakeGame)) && (is_struct(_player) || instance_exists(_player))) exit
	
	var _ammo = _player.ammo,
		_race = _player.race,
		_wep = _player.wep,
		_bwep = _player.bwep,
		_hp = max(0, _player.hp),
		_max_hp = _player.max_hp,
		_wave = _player.wave
	
	draw_align(fa_center, fa_top)

	var _sprite;
	
	#region Healthbar
		draw_set_color(c_white)
		draw_sprite(sprHealthBar, 2, 20, 4)
		
		var _health_string = loc_fmt("HUD:Health", "%1/%2", _hp, _max_hp)
		
		if _player.fainted {
			var _color = merge_color(c_black, c_red, 0.5 + sin(current_time / 250) * 0.3)
			draw_sprite_ext(sprBleedHUD, 2, 22, 7, 84 - max(0, 84 * (1 - _player.fainted / CHEAT_PRACTICE_FAINTED_TIME)), 1, 0, _color, 1)
			draw_text_nt(23 + 44, 7, loc("HUD:Fainted", "FAINTED"))
		}
		else if _player.bleed {
			draw_sprite_ext(sprBleedHUD, 2, 22, 7, 84 - max(0, 84 * (_player.bleed / 150)), 1, 0, c_gray, 1)
			draw_text_shadow(23 + 44, 7, _health_string)
		}
		else {
			var _healthbar_color = UberCont.opt_healthcol,
				_healthbar_bg = max(0, 84 * (_player.lsthealth / _max_hp)),
				_healthbar_fg = max(0, 84 * (_hp / _max_hp))
			
			if (_healthbar_color != c_white) {
				var _bg_hue = color_get_hue(_healthbar_color) - 5
				
				if (_bg_hue < 0) _bg_hue = 255 + _bg_hue
				
				var _bg_color = make_color_hsv(_bg_hue,
						color_get_saturation(_healthbar_color),
						color_get_value(_healthbar_color) * 0.5)
				
				draw_sprite_ext(sprHealthFill, 0, 22, 7, _healthbar_bg, 1, 0, _bg_color, 1)
				draw_sprite_ext(sprHealthFill, 0, 22, 7, _healthbar_fg, 1, 0, _healthbar_color, 1)
			}
			else {
				draw_sprite_ext(sprHealthFill, 2, 22, 7, _healthbar_bg, 1, 0, _healthbar_color, 1)
				draw_sprite_ext(sprHealthFill, 1, 22, 7, _healthbar_fg, 1, 0, _healthbar_color, 1)
			}
			
			if _race == Race.Rogue {
				var _cskin = (_player.bskin == SkinLetter.C),
					_ammo_progress = min(1, _player.rogue_ammo / _player.rogue_ammo_max),
					_sprite = scr_ultra_get(Race.Rogue, UltraSkill.SuperPortalStrike)
						? (_cskin ? sprRogueAmmoHUDCTB : sprRogueAmmoHUDTB)
						: (_cskin ? sprRogueAmmoHUDC : sprRogueAmmoHUD),
					_subimage_max = sprite_get_number(_sprite) - 1,
					_subimage = _player.rogue_ammo ? max(1, floor(_subimage_max * _ammo_progress)) : 0
				
				draw_sprite(_sprite, _subimage, 110, 4)
			}
			else if _race == Race.Cuz && !cuz_fun {
				var _ammo_progress = min(1, _player.cuz_ammo / _player.cuz_ammo_max),
					_sprite = scr_ultra_get(Race.Cuz, UltraSkill.Emotional) ? sprCuzAmmoHUDU : sprCuzAmmoHUD,
					_subimage_max = sprite_get_number(_sprite) - 1,
					_subimage = _player.cuz_ammo ? max(1, floor(_subimage_max * _ammo_progress)) : 0
				
				draw_sprite(_sprite, _subimage, 110, 4)
			}
			
			if !is_struct(_player) {
				var _hurt = _player.mask_index != mskNone && _player.nexthurt > current_frame && !scrGameIsLockState()
				
				if (_hurt) draw_sprite_ext(sprHealthFill, 0, 22, 7, max(0, 84 * (_hp / _max_hp)), 1, 0, c_white, 1)
				
				if (!_hurt || sin(wave) > 0) || scrGameIsGenerationScreen() {
					draw_text_shadow(23 + 44, 7, _health_string)
				}
			}
			else {
				draw_text_shadow(23 + 44, 7, _health_string)
			}
		}
	#endregion
	
	#region Weapons
		var _hud_weapon = _wep,
			_hud_weapon_index = 0,
			_extra_weps = _player.extra_weps,
			_extra_count = array_length(_extra_weps),
			_is_steroids = (_race == Race.Steroids),
			_curse = false,
			_dx = 24,
			_dy = 16
		
		repeat (2 + _extra_count) {
			if (_hud_weapon) {
				var _extra_index = _hud_weapon_index - 2,
					_is_extra = _extra_index >= 0,
					_type = scr_weapon_get_type(_hud_weapon),
					_sprite = scr_weapon_get_sprite(_hud_weapon),
					_is_golden = scr_weapon_is_golden(_hud_weapon),
					_is_cursed = (_is_extra ? _player.extra_weps_curse[_extra_index] : (_hud_weapon_index ? _player.bcurse : _player.curse)),
					_reload = (_is_extra ? _player.extra_weps_reload[_extra_index] : (_hud_weapon_index ? _player.breload : _player.reload)),
					_is_ultra = scr_weapon_get_rads(_hud_weapon) != 0,
					_broke_batch = (_is_ultra || _is_cursed || _is_golden),
					_weapon_width = (((!_extra_count || _hud_weapon_index == 0) && _type == Ammo.None) ? 32 : 16),
					_is_active_weapon = (_hud_weapon_index == 0 || _is_steroids)
				
				// Gun
				/**/ if (_is_golden) gpu_set_fog(true, c_gold, 0, 0)
				else if (_is_cursed) gpu_set_fog(true, c_curse, 0, 0)
				else if (_is_ultra) gpu_set_fog(true, c_ultra, 0, 0)
				
				var _anim = instance_exists(_player) ? _player.swapanim : 0,
					_xoffset = sprite_get_xoffset(_sprite),
					_yoffset = sprite_get_yoffset(_sprite),
				
				if (_is_active_weapon || _broke_batch || (instance_exists(TopCont) && TopCont.darkness) || UberCont.letterbox_frame >= 2) {
					var _outline_color = _is_active_weapon ? c_white : #404040
					draw_sprite_part_ext(_sprite, 1, _xoffset, _yoffset + _anim - 8, _weapon_width, 14 + _anim, _dx + 1, _dy + 0, 1, 1, _outline_color, 1)
					draw_sprite_part_ext(_sprite, 1, _xoffset, _yoffset + _anim - 8, _weapon_width, 14 + _anim, _dx - 1, _dy - 0, 1, 1, _outline_color, 1)
					draw_sprite_part_ext(_sprite, 1, _xoffset, _yoffset + _anim - 8, _weapon_width, 14 + _anim, _dx + 0, _dy + 1, 1, 1, _outline_color, 1)
					draw_sprite_part_ext(_sprite, 1, _xoffset, _yoffset + _anim - 8, _weapon_width, 14 + _anim, _dx - 0, _dy - 1, 1, 1, _outline_color, 1)
				}
				
				if (_broke_batch) gpu_set_fog(0, 0, 0, 0)
				
				var _reload_progress = clamp(_reload / scr_weapon_get_load(_hud_weapon), 0, 1)
				draw_sprite_part_ext(_sprite, 1, _xoffset, _yoffset + _anim - 8, _weapon_width, 14 + _anim, _dx, _dy, 1, 1, c_black, 1)
				if (_reload_progress != 0) draw_sprite_part_ext(_sprite, 1, _xoffset, _yoffset - 8, _weapon_width * _reload_progress, 14, _dx, _dy, 1, 1, c_white, 0.2)
				
				// Ammo
				if (_extra_count == 0 || _hud_weapon_index == 0) {
					if _type != Ammo.None {
						draw_set_halign(fa_left)
						var _is_active_ammo = (_is_active_weapon || _type == scr_weapon_get_type(_wep))
					
						draw_set_color(_is_active_ammo ? c_white : c_silver)
					
						if (_player.ammo[_type] <= 0) {
							draw_set_color(c_uidark)
						}
						else if (_player.ammo[_type] <= scrAmmoGetPickupAmount(_type)) {
							draw_set_color(_is_active_ammo ? c_red : c_gray)
						}
						
						draw_text_shadow(_dx + 18, _dy + 5, string(_player.ammo[_type]))
						draw_set_halign(fa_center)
						draw_set_color(c_white)
					}
					
					_dx += 44
				}
				// smaller gap for extra weps and bwep if carrying extra guns
				else _dx += 20
			}
			
			_hud_weapon_index ++
			/**/ if (_hud_weapon_index == 1) _hud_weapon = _player.bwep
			else if (_extra_count > (_hud_weapon_index - 2)) _hud_weapon = _extra_weps[_hud_weapon_index - 2]
			else break
			
			if (!scr_weapon_is_valid(_hud_weapon)) break
		}
	#endregion
	
	#region Experience bar
		if (GameCont.skillpoints > 0 || GameCont.ultrapoints) draw_sprite(sprExpBarLevel, 0, 4, 4)
		
		draw_sprite(sprExpBar, (GameCont.rad / GameCont.max_rad) * 16, 4, 4)
		
		if GameCont.level < 10 {
			draw_text_shadow(11, 16 - floor(string_height("A") * 0.5), GameCont.level)
		}
		else {
			draw_sprite(sprUltraLevel, 0, 11, 16)
		}
	#endregion
	
	#region Ammo Icons & Daily indicator
		var _frames = sprite_get_number(sprBulletIcon) - 1,
			_t1 = scr_weapon_get_type(_wep),
			_t2 = scr_weapon_get_type(_bwep)
		
		for(var _ammo_type = Ammo.Bullets; _ammo_type < Ammo.NUM_AMMO_TYPES; ++_ammo_type) {
			var _background_index = 0,
				_type_capacity = scrAmmoGetTypeCapacity(_ammo_type),
				_percentage = clamp(_ammo[_ammo_type] / _type_capacity, 0, 1),
				_icon_index = ceil(_percentage * _frames),
				_dx = 2 + (_ammo_type - 1) * 10,
				_dy = 32
			
			if (_t1 == _ammo_type || (_is_steroids && _t2 == _ammo_type)) {
				_background_index = 2
			}
			else if (_t2 == _ammo_type) _background_index = 1
			
			if (_ammo_type >= Ammo.Bolts) _dx -= 2
			
			scrDrawTypeAmmo(_ammo_type, _background_index, _frames - _icon_index, _dx, _dy)
		}
		
		if scrGameIsEventRun() {
			draw_sprite(scrGameIsWeeklyRun() ? sprWeeklyIcon : sprDailyIcon, 0, 56, 33)
		}
		
		if UberCont.continued_run {
			draw_sprite(sprContinuedRunIcon, 0, 56 + (scrGameIsEventRun() * 12), 33)
		}
	#endregion
	
	#region Low Health/Ammo
		if instance_exists(_player) {
			var _check_weapon = _wep,
				_type = scr_weapon_get_type(_check_weapon),
				_rads = scr_weapon_get_rads(_check_weapon)
			
			repeat ((_is_steroids && scr_weapon_get_type(_bwep) != _type) ? 2 : 1) {
				var _pickup_amount = scrAmmoGetPickupAmount(_type)
				
				if _player.drawempty > 0 && _type && (_ammo[_type] <= _pickup_amount || GameCont.rad < _rads) && sin(wave) > 0 {
					var _txt = loc_fmt_either($"HUD:LowAmmo:{_type}", "HUD:LowAmmo",
							"LOW %", loc("Ammo:Type", _type, typ_name[wep_type[_check_weapon]]))
					
					if _ammo[_type] < scr_weapon_get_cost(_check_weapon) {
						if _ammo[_type] > 0 {
							var _type_name = loc("Ammo:Type", _type, typ_name[_type])
							_txt = loc_fmt_either($"HUD:InsAmmo:{_type}", "HUD:InsAmmo", "NOT ENOUGH %", _type_name)
						}
						else _txt = loc("HUD:NoAmmo", "EMPTY")
					}
					else if GameCont.rad < _rads {
						_txt = loc("HUD:InsRads", "NOT ENOUGH RADS")
					}
					
					draw_set_color(c_red)
					draw_set_halign(fa_left)
					
					var _icon_count = scrGameIsEventRun() + scrGameIsContinuedRun()
					
					draw_text_shadow(55 + _icon_count * 12, 35, loc(string(_txt)))
					
					draw_set_color(c_white)
					draw_set_halign(fa_center)
				}
				
				_check_weapon = _bwep
				_type = scr_weapon_get_type(_check_weapon)
				_rads = scr_weapon_get_rads(_check_weapon)
			}

			if _hp <= 4 && _hp != _max_hp && sin(wave) > 0 && _player.drawlowhp > 0 {
				var _txt = loc("HUD:LowHealth", "LOW HP")

				draw_set_color(c_red)
				draw_set_halign(fa_left)
				draw_text_shadow(110, 7, string(_txt))
				draw_set_halign(fa_center)
			}
		}
	#endregion
	
	draw_set_color(c_white)
	
	// Interaction
	if (!scrGameIsPaused()) scrDrawInteractionHUD(_player)
}

function scrDrawTypeAmmo(_type, _background_index, _icon_index, _x, _y) {
	var _icon_sprite, _background_sprite;
	
	switch _type {
		case Ammo.Bullets:
			_icon_sprite = sprBulletIcon
			_background_sprite = sprBulletIconBG
			break
		case Ammo.Shells:
			_icon_sprite = sprShotIcon
			_background_sprite = sprShotIconBG
			break
		case Ammo.Bolts:
			_icon_sprite = sprBoltIcon
			_background_sprite = sprBoltIconBG
			break
		case Ammo.Explosives:
			_icon_sprite = sprExploIcon
			_background_sprite = sprExploIconBG
			break
		case Ammo.Energy:
			_icon_sprite = sprEnergyIcon
			_background_sprite = sprEnergyIconBG
			break
		default:
			_icon_sprite = -1
			_background_sprite = -1
			break
	}
	
	if (_background_sprite != -1) draw_sprite(_background_sprite, _background_index, _x, _y)
	if (_icon_sprite != -1) draw_sprite(_icon_sprite, _icon_index, _x, _y)
}

function scrDrawInteractionHUD(_player) {
	with (_player) array_foreach([ WepPickup, CarVenusFixed, IceFlower, Van ], function(_object_index) {
		var _player = id
		
		with (instance_nearest(_player.x, _player.y, _object_index)) if (visible && place_meeting(x, y, _player)) {
			if ((instance_is(self, Van) && (!can_hq || drawspr != sprVanDeactivate))
				|| (instance_is(self, WepPickup) && autopick)
			) {
				continue
			}
			
			var _x = floor(x - view_xview),
				_y = floor(y - view_yview),
				_name = name
			
			var _text_offset = draw_pickup_button(_x, _y)
			
			if instance_is(self, WepPickup) {
				var _type_capacity = scrAmmoGetTypeCapacity(type),
					_frames = sprite_get_number(sprBulletIcon) - 1,
					_percentage = _player.ammo[type] / _type_capacity,
					_icon_index = ceil(_frames * _percentage)
				
				draw_text_shadow(_x, _y - 31, loc("Weapons", wep, "Name", _name))
				
				if (type == Ammo.None) _text_offset = 0
				
				scrDrawTypeAmmo(type, 2, _frames - _icon_index, _x + _text_offset, _y - 21)
			}
			else {
				var _object_name = object_get_name(object_index)
				if (object_is_ancestor(object_index, Car)) _object_name = "Car"
				draw_text_shadow(_x, _y - 31, loc("HUD", $"Prompt{_object_name}", _name))
			}
			
			if is_touch(_player.index) {
				if instance_is(self, WepPickup) _name = loc("R:HUD:PickUpAction", "PICK UP")
				
				with ButtonAct {
					draw_text_shadow(x, y + ((y < 40) ? 36 : -36), _name)
					
					var _sprite = other.sprite_index,
						_xoffset = sprite_get_xoffset(_sprite),
						_yoffset = sprite_get_yoffset(_sprite),
						_width = sprite_get_width(_sprite),
						_height = sprite_get_height(_sprite)
					
					sprite_set_offset(_sprite, _width div 2, _height div 2)
					draw_sprite_ext(_sprite, other.image_index, x, y,
						other.image_xscale * 1.6, other.image_yscale * 1.6, other.image_angle, other.image_blend, other.image_alpha)
					sprite_set_offset(_sprite, _xoffset, _yoffset)
					
					alpha = approach(alpha, 1.1, 0.4)
					active = true
				}
			}
		}
	})
}