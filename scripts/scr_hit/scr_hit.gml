/// @function scr_hit
/// @param instance
/// @param amount
/// @param {Enum.HitId|Array} hitid=HitId.None
function scr_hit(_instance, _amount, _hitid = HitId.None) {
	with _instance {
		if instance_is(self, Player) {
			if (scrPlayerProcTakeDamage(_amount)) return false
			if (is_array(_hitid) || (_hitid >= 0 && _hitid != HitId.Player)) {
				if (scr_player_is_local(index)) GameCont.deathcause = _hitid
			}
			drawlowhp = 30
		}
		
		if _amount > 0 {
			hp -= _amount
			nexthurt = current_frame + 5
		}
		
		sprite_index = spr_hurt
		image_index = 0
		
		snd_play_hit(snd_hurt, 0.2)
		
		if (global.__debug_health) {
			if (is_array(_hitid) || _hitid >= 0) {
				print(real(id), object_get_name(object_index), $"{hp}/{max_hp}", "was hit by", _amount, "from", scrDeathCauseGetName(_hitid), $"({object_get_name(other.object_index)})")
			}
			else {
				print(real(id), object_get_name(object_index), $"{hp}/{max_hp}", "was hit by", _amount, "from", _hitid, $"({object_get_name(other.object_index)})")
			}
		}
		
		return true
	}
	
	return false
}

/// @function scr_hit_self
/// @param amount
/// @param {Enum.HitId|Array} hitid=HitId.None
function scr_hit_self(_amount, _hitid = HitId.None) {
	gml_pragma("forceinline")
	return scr_hit(id, _amount, _hitid)
}

/// @function scr_projectile_hit
/// @param instance
/// @param amount
/// @param knockback_amount=0
/// @param knockback_direction=direction
function scr_projectile_hit(_instance, _amount, _kb_amount = 0, _kb_direction = undefined) {
	if _amount > 0 && scr_hit(_instance, _amount, hitid) {
		if _kb_amount != 0 {
			if is_undefined(_kb_direction) {
				_kb_direction = direction
			}
			
			with (_instance) motion_add(_kb_direction, _kb_amount)
		}
		
		return true
	}
	
	return false
}

/// @function scr_projectile_generic_hit
/// @param destroy=true
/// @param check_inframes=true
function scr_projectile_generic_hit(_destroy = true, _inframes = true) {
	if scr_can_hit(other.id, _inframes) && scr_projectile_hit(other.id, damage, knockback_speed) {
		if (_destroy) instance_destroy()
		return true
	}
	
	return false
}

/// @function scr_projectile_generic_bullet_hit
/// @param recycle_gland_yield=1
function scr_projectile_generic_bullet_hit(_gland = 1) {
	if scr_can_hit(other.id, false) && scr_projectile_hit(other.id, damage, knockback_speed) {
		if (instance_is(creator, Player) && scr_skill_get(mut_recycle_gland) && random(1) < 0.6) {
			with (creator) {
				scrPlayerGiveAmmo(id, Ammo.Bullets, _gland)
			}
			
			snd_play_hit(sndRecGlandProc)
			instance_create(x, y, RecycleGland)
		}
		
		instance_destroy()
		return true
	}
	
	return false
}

/// @function scr_projectile_generic_shell_hit
/// @param pointblank_bonus=1
function scr_projectile_generic_shell_hit(_bonus_amount = 1) {
	if scr_can_hit(other.id, false) {
		var _amount = damage + (bonus * _bonus_amount)
		
		if scr_projectile_hit(other.id, _amount, knockback_speed) {
			instance_destroy()
			return true
		}
	}
	
	return false
}

function scr_projectile_generic_plasma_hit() {
	if scr_can_hit(other.id, false) {
		var _amount = floor(damage * (image_xscale + image_yscale) * 0.5)
		
		if scr_projectile_hit(other.id, _amount, knockback_speed) {
			instance_create(x, y, Smoke)
			snd_play(sndPlasmaHit)
			scr_screenshake(6)
			image_xscale -= 0.1
			image_yscale -= 0.1
			x -= hspeed
			y -= vspeed
			return true
		}
	}
	
	return false
}

/// @function scr_projectile_generic_grenade_hit
/// @param can_overkill_pierce=false
function scr_projectile_generic_grenade_hit(_pierce = false) {
	if scr_can_hit(other.id, false) {
		var _hp = other.hp
		if scr_projectile_hit(other.id, damage, knockback_speed) {
			if !_pierce || _hp > damage {
				instance_destroy()
			}
			
			return true
		}
	}
	
	return false
}

function scr_projectile_generic_flame_hit() {
	if scr_can_hit(other.id, true) {
		var _amount = damage
		
		if instance_is(other, Player) && scr_skill_get(mut_boiling_veins) {
			with other {
				if (hp - _amount) < veinsthreshold {
					_amount -= veinsthreshold - (hp - _amount)
				}
			}
		}
		
		return scr_hit(other.id, _amount, hitid)
	}
	
	return false
}

function scr_explosion_generic_hit() {
	if scr_can_hit(other.id, false) {
		var _amount = damage
		
		if instance_is(other, Player) && scr_skill_get(mut_boiling_veins) {
			with other {
				if (hp - _amount) < veinsthreshold {
					_amount -= veinsthreshold - (hp - _amount)
				}
			}
		}
		
		with (other) if (speed < 16) {
			motion_add(point_direction(other.x, other.y, x, y), 6)
			if (speed > 16) speed = 16
		}
		
		return scr_hit(other.id, _amount, hitid)
	}
	
	return false
}

function scr_projectile_generic_laser_hit() {
	if scr_can_hit(other.id, false) && scr_projectile_hit(other.id, damage, knockback_speed) {
		with other {
			instance_create(bbox_center_x, bbox_center_y, Smoke)
		}
		
		return true
	}
	
	return false
}

/// @function scr_projectile_generic_bolt_hit
/// @param can_overkill_pierce=true
function scr_projectile_generic_bolt_hit(_pierce=true) {
	if speed == 0 && !check_wall_hit_damage {
		return false
	}
	
	if scr_can_hit(other.id, false) {
		var _hp_last = other.hp
		
		if (!scr_projectile_hit(other.id, damage, knockback_speed)) return false
		
		if !_pierce || _hp_last >= (damage * 0.5) {
			var _target = other.id
			
			with instance_create(x, y, BoltStick) {
				sprite_index = other.sprite_index
				image_index = sprite_get_number(sprite_index) - 1
				image_angle = other.image_angle
	            target = _target
			}
			
			var _direction = direction,
				_speed = knockback_speed * 0.8
			
			with (other) motion_add_m(_direction, _speed, 16)
			
			instance_destroy()
		}
		else motion_add_m(direction, knockback_speed)
		
		return true
	}
	
	return false
}
