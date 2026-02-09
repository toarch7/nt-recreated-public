if lockstep_stop
	exit

var _is_local = scr_player_is_local(index)

if (hp < 0) hp = 0

if (lsthealth >= max_hp) lsthealth = max_hp

if scr_weapon_is_melee(wep) {
	if wepangle == 0 {
		wepangle = choose(120, -120)
	}
}
else {
	wepangle = 0
}

if (swapanim != 0) swapanim = approach(swapanim, 0, timescale)

//SWAP WEPS
if KeyCont.press_swap[index] && bwep != 0 {
	if visible {
		with instance_create(x, y, WepSwap) {
			target = other.id
		}
	}
	
	scrSwapWeps()
	swapanim = 1

	if !scrGameIsLockState() KeyCont.press_swap[index] = 0

	snd_play(wep_swap[wep])
}

if spirit {
	spirit_anim += 0.1

	if spirit_anim >= 6.2 {
		spirit_anim = 0
	}
}
else if scr_skill_get(mut_strong_spirit) && spirit_index < 8 {
	spirit_index += 0.4
}

if fainted {
	fainted -= timescale
	sprite_index = spr_hurt
	image_alpha = 0.5
	
	if (hp > 1) hp = 1
	
	if !fainted {
		if scr_skill_get(mut_strong_spirit) {
			scrStrongSpiritRefill()
		}
		
		repeat 24 {
			var ang = random_angle
			
			with instance_create(x, y, Dust) {
				motion_add(ang, random(4) + 6)
			}
		}
		
		with enemy {
			if distance_to_object(other) <= 64 {
				scr_hit_self(40)
				
				motion_add(point_direction(other.x, other.y, x, y), 12)
				
				if speed > 16
					speed = 16
			}
		}
		
		with projectile {
			if team != other.team && distance_to_object(other) <= 96
				instance_destroy(id, 0)
		}
		
		snd_play(snd_hurt)
		snd_play(snd_lowh)
		drawlowhp = 30
		
		image_alpha = 1
		mask_index = mskPlayer
		if (race == Race.BigDog) mask_index = mskScrapBoss
		nexthurt = current_frame + 30
		hp = 1
	}
	
	exit
}

if (!visible || scrGameIsLockState()) exit

if !roll {
	if can_walk && KeyCont.moving[index] > 0 {
		var _maxspeed = maxspeed, // * KeyCont.moving[index]
			_movspeed = 3
		
		if (race == Race.Crystal && KeyCont.hold_spec[index]) {
			with (CrystalShield) {
				if (sprite_index == spr_disappear || creator != other.id) continue
				
				if (scr_ultra_get(Race.Crystal, UltraSkill.Juggernaut)) {
					_maxspeed *= 0.5
					_movspeed *= 0.5
				}
				else if (instance_exists(CrystalShield)) {
					_maxspeed = 0
					_movspeed = 0
				}
			}
		}
		
		if (speed < _maxspeed) {
			if (KeyCont.precisemovement[index]) {
				var _m = _movspeed * KeyCont.moving[index]
				hspeed += ldrx(_m, KeyCont.dir_move[index])
				vspeed += ldry(_m, KeyCont.dir_move[index])
			}
			else {
				hspeed += _movspeed * (KeyCont.hold_east[index] - KeyCont.hold_west[index])
				vspeed += _movspeed * (KeyCont.hold_sout[index] - KeyCont.hold_nort[index])
			}
			
			if (speed > _maxspeed) speed = _maxspeed
		}
		
		with (TutCont) complete_step(TutorialStep.Walking)
	}

	if place_meeting(x, y, NothingDeath) && instance_exists(SitDown) {
		move_towards_point(SitDown.x, SitDown.y, maxspeed)
	}
}
else {
	// rolling
	var _rollspeed = maxspeed + (1 - scr_skill_get(mut_throne_butt) * 0.5)

	if scr_skill_get(mut_throne_butt) {
		angle = direction - 90

		if race == 1 {
			if !snd_is_playing(sndFishTB) snd_play_loop(sndFishTB)

			with instance_create(x, y, FishBoost) {
				motion_add(other.direction + 180 - random_range(-15, 15), 2 - random(1))
			}
		}

		if !KeyCont.hold_spec[index] {
			roll = 0
			angle = 0

			snd_stop(sndFishTB)
		}

		if KeyCont.moving[index] {
			motion_add(KeyCont.dir_move[index], 4)
		}
	}
	else {
		instance_create(x + random(6) - 3, y + random(6), Dust)

		angle += 40 * right

		if abs(angle) >= 540 {
			angle = 0
			roll = 0
		}
	}

	if (roll) speed = _rollspeed
}

if (sprite_exists(spr_cry) && sprite_index == spr_cry) {
	if (animation_end) {
		sprite_index = (speed ? spr_walk : spr_idle)
		image_index = 0
	}
}
else {
	if (!speed) {
		if (sprite_index != spr_hurt) sprite_index = spr_idle
	}
	else {
		if (sprite_index != spr_hurt) sprite_index = spr_walk
	}
	
	if (sprite_index == spr_hurt && image_index > 2) {
		sprite_index = spr_idle
		image_index = 0
	}
}

if bleed > 0 && hp > 0 && max_hp > 0 && visible {
	snd_stop(sndChickenHeadlessLoop)
	snd_play(sndChickenRegenHead)
	bleed = 0
	
	spr_idle = scr_race_get_sprite(race, "Idle", sprMutant9Idle, bskin)
	spr_walk = scr_race_get_sprite(race, "Walk", sprMutant9Walk, bskin)
	spr_hurt = scr_race_get_sprite(race, "Hurt", sprMutant9Hurt, bskin)
	spr_dead = scr_race_get_sprite(race, "Dead", sprMutant9Dead, bskin)
	spr_gosit = scr_race_get_sprite(race, "GoSit", sprMutant9GoSit, bskin)
	spr_sit = scr_race_get_sprite(race, "Sit", sprMutant9Sit, bskin)

	with (ChickenHead) {
		if (index == other.index) instance_destroy()
	}
}

if hp <= 0 {
	if (spirit || (spirit_index > 0 && spirit_index < 2)) {
		hp = 1
		if (spirit) {
			snd_play(sndStrongSpiritLost)
			nexthurt = current_frame + 10
			spirit_index = 0.4
			spirit = false
		}
	}
	else if race == Race.Chicken && bleed < 150 && visible {
		if !bleed {
			snd_play(sndChickenLoseHead)
			snd_play_loop(sndChickenHeadlessLoop)

			repeat(12) {
				with instance_create(x, y, BloodStreak) {
					motion_add(random_angle, 2 + random(3))
					image_angle = direction
				}
			}
			
			if (max_hp > 0) {
				var _n = min(2, max_hp)
				headloses += _n
				max_hp -= _n
			}
			
			var _skin = bskin
			
			repeat (9 + irandom(4)) {
				with instance_create(x, y, Feather) {
					if (_skin != SkinLetter.C) sprite_index = sprChickenFeather
				}
			}
			
			spr_idle = scr_race_get_sprite(race, "HeadlessIdle", sprMutant9HeadlessIdle, _skin)
			spr_hurt = scr_race_get_sprite(race, "HeadlessHurt", sprMutant9HeadlessHurt, _skin)
			spr_walk = scr_race_get_sprite(race, "HeadlessWalk", sprMutant9HeadlessWalk, _skin)
			spr_gosit = scr_race_get_sprite(race, "HeadlessGoSit", sprMutant9HeadlessGoSit, _skin)
			spr_sit = scr_race_get_sprite(race, "HeadlessSit", sprMutant9HeadlessSit, _skin)
			
			with instance_create(x, y, ChickenHead) {
				index = other.index
				mask_index = other.mask_index
				motion_add(other.direction, other.speed + 1)
				/**/ if (_skin == SkinLetter.B) sprite_index = sprMutant9BHeadIdle
				else if (_skin == SkinLetter.C) sprite_index = sprMutant9CHeadIdle
				else sprite_index = sprMutant9HeadIdle
				image_xscale = other.right
				if (speed > 16) speed = 16
			}

			sleep(60)
		}

		if current_frame_active && random(12) < 1 {
			with instance_create(x, y - 4, BloodStreak) {
				motion_add(45 + random(90), 2 + random(3))
				image_angle = direction
			}
		}

		if (_is_local) UberCont.ctot_uniq[Race.Chicken] += timescale
		if (visible) bleed += timescale
	}
	else if can_die && !global.__debug_immortality {
		if race == Race.Melting && place_meeting(x, y, ReviveCircle) && !instance_exists(CoopController) {
			scrTurnIntoSkeleton()
			hp = 1
		}
		else if UberCont.opt_practice {
			mask_index = mskNone
			fainted = CHEAT_PRACTICE_FAINTED_TIME
			snd_play(snd_dead)
		}
		else if player_count > 1 {
			instance_change(Revive, 1)
			image_speed = 0.4
			sprite_index = spr_hurt
			image_alpha = 0.5
			
			curse = 0
			bcurse = 0
			reload = 0
			breload = 0
			
			with instance_create(x, y, CorpseActive) {
				size = 1
				
				mask_index = other.mask_index
				motion_add(other.direction, other.speed)
				speed += max(0, -other.hp / 5)
				sprite_index = other.spr_dead
				image_xscale = other.right
				
				if (speed > 16) speed = 16
			}
		}
		else {
			UberCont.ctot_strk[race] = 0
			instance_destroy()
		}
	}
	else hp = 1
}

if !aimassist_wait || KeyCont.press_fire[index] || KeyCont.release_fire[index] {
	if (can_aim) gunangle = KeyCont.dir_fire[index]
}
else aimassist_wait -= 1

if (KeyCont.aimassist[index] && scr_weapon_get_type(wep) != Ammo.None && !scr_weapon_has_assist_disabled(wep) && can_aim) {
	var _is_specshooting = KeyCont.press_spec[index] && (race == Race.Plant || race == Race.Venuz || Race.Steroids || race == Race.Skeleton),
		_is_shooting = KeyCont.press_fire[index] || clicked || _is_specshooting
	
	if (!instance_exists(aimassist_target)) {
		aimassist_target = noone
	}
	
	if (_is_shooting || KeyCont.hold_fire[index]) {
		var _area_w = game_screen_width * 0.67,
			_area_h = game_screen_height * 0.5,
			_aim_target = aimassist_target,
			_aim_tracer_length = _area_w * 0.5

		if (!instance_exists(_aim_target)) with (instance_create(x, y, AimAssist)) {
			image_angle = other.gunangle
			image_xscale = view_width
			image_yscale *= 5
			
			team = other.team
			
			var _distance_max = infinity
			
			with (hitme) {
				if (place_meeting(x, y, other) && team != other.team) {
					if (object_index == Nothing
						|| object_index == Nothing2
						|| object_index == VenuzCouch
						|| object_index == IceFlower
					) {
						continue
					}
					
					if (collision_line(other.x, other.y, x, y, Wall, true, false) != noone) continue
					
					var _distance = point_distance(x, y, other.x, other.y)
					
					// make it so that props are less likely to be targeted
					if (instance_is(self, prop)) {
						_distance = 64 + _distance * 4
					}
					
					if _distance < _distance_max {
						_distance_max = _distance
						_aim_target = id
					}
				}
			}
		}
		
		if (scrTargetIsVisible(_aim_target)) {
			var _direction = point_direction(x, y, _aim_target.x, _aim_target.y),
				_snap_angle = 35
			
			if (_aim_target.x > (x - _area_w)
				&& _aim_target.y > (y - _area_h)
				&& _aim_target.x < (x + _area_w)
				&& _aim_target.y < (y + _area_h)
			) {
				var _diff = abs(angle_difference(_direction, gunangle))
				
				if (_diff <= _snap_angle) {
					aimassist_target = _aim_target
					
					if (_is_shooting) {
						aimassist_direction = _direction
						gunangle = aimassist_direction
					}
					else {
						aimassist_direction = angle_lerp(
							gunangle, _direction, 1 - _diff / _snap_angle)
					}
				}
				else aimassist_target = noone
			}
		}
	}
}

if !(race == Race.Crystal && KeyCont.hold_spec[index]) && hp >= 0 {
	scrPlayerFiring()
	
	if race == Race.Steroids && KeyCont.hold_spec[index] && bcan_shoot {
		var press = KeyCont.press_fire[index],
			hold = KeyCont.hold_fire[index]
		
		KeyCont.press_fire[index] = false
		
		if KeyCont.press_spec[index] {
			KeyCont.press_fire[index] = true
		}
		
		KeyCont.hold_fire[index] = true
		
		scrSwapWeps()
		
		scrPlayerFiring()
		
		bcan_shoot = can_shoot
		
		scrSwapWeps()
		
		KeyCont.press_fire[index] = press
		KeyCont.hold_fire[index] = hold
	}
}

if !roll {
	if gunangle > 90 && gunangle < 270 {
		right = -1
	}
	else right = 1

	if gunangle > 0 && gunangle < 180 {
		back = 1
	}
	else back = -1
}


if wep != 0 && scr_weapon_is_golden(wep) && irandom(10 + (current_frame % 30)) <= 2 {
	with instance_create(
		random_range(bbox_left, bbox_right),
		random_range(bbox_top, bbox_bottom),
		CaveSparkle
	) {
		x += ldrx(4, other.gunangle)
		y += ldry(4, other.gunangle)
		depth = other.depth + choose(1, -1)
	}
}

#region Weapon reload
if reload > 0 || (breload > 0 && race == Race.Steroids) {
	var _reload_speed = 1

	if race == Race.Venuz {
		_reload_speed += 0.2
		
		var _imagungod = scr_ultra_get(race, UltraSkill.ImaGunGod)
		
		if _imagungod > 0 {
			_reload_speed += _imagungod * 0.4
		}
	}

	if scr_skill_get(mut_stress) {
		var _stress = 1 - hp / max(1, max_hp)
		_reload_speed += _stress
		
		if random(2) < _stress {
			var _direction = gunangle + 180 + orandom(45)
			
			with instance_create(x, y, Shell) {
				sprite_index = sprSweat
				image_index = irandom(2)
				image_speed = 0
				time = 0
				depth = other.depth - 1
				alarm[0] = 8
				friction = 0.25
				motion_add(_direction, 2 + random(2))
			}
		}
	}
	
	if (reload > 0) {
		reload -= _reload_speed * timescale
		
		if (reload <= 0) {
			scrPlayerGunReloadFX(wep)
			
			wepflip *= -1
			can_shoot = true
			reload = 0
		}
	}
	
	if (race == Race.Steroids && breload > 0) {
		breload -= _reload_speed * timescale
		
		if (breload <= 0) {
			scrPlayerGunReloadFX(bwep)
			
			wepflip *= -1
			bcan_shoot = true
			breload = 0
		}
	}
}
#endregion

if lsthealth != hp {
	if (lsthealth > hp && hp <= 4
		&& (!snd_is_playing(snd_lowh) || snd_track_position(snd_lowh) > 0.05)
	) {
		snd_play(snd_lowh)
	}
	
	if (abs(hp - lsthealth) > 20) {
		lsthealth = t_lerp(lsthealth, hp, 0.2)
	}
	else {
		lsthealth = approach(lsthealth, hp, 0.5 * timescale)
	}
}

if sprite_index != spr_hurt && lsthealth > hp {
	if drawlowhp < 30 && hp <= 4 {
		snd_play(snd_lowh)
	}
	
	drawlowhp = 30
}
else if (drawlowhp > 0) drawlowhp -= timescale

if drawempty > 0 {
	if drawempty >= 10 && (drawempty - timescale) < 10 {
		var _t1 = scr_weapon_get_type(wep),
			_t2 = scr_weapon_get_type(bwep),
			_v1 = _t1 ? scrAmmoGetPickupAmount(_t1) : 999,
			_v2 = _t2 ? scrAmmoGetPickupAmount(_t2) : 999
		
		if ((_t1 && ammo[_t1] <= _v1 && ammo[_t1] > (_v1 - scr_weapon_get_cost(wep)))
			|| (race == Race.Steroids && _t2 && ammo[_t2] <= _v2 && ammo[_t2] > (_v2 - scr_weapon_get_cost(bwep)))
		) {
			if (!audio_is_playing(snd_lowa)) snd_play(snd_lowa)
		}
	}
	
	drawempty -= timescale
}

if can_spirit && !spirit && hp >= max_hp && max_hp > 1 {
	scrStrongSpiritRefill()
}

if speed > maxspeed {
	speed = maxspeed
}

if KeyCont.hold_spec[index] && scr_skill_get(mut_throne_butt) && race == Race.Fish {
	x += round(hspeed * 0.2)
	y += round(vspeed * 0.2)
	roll = 1
}

if roll {
	speed = 6 + (scr_skill_get(5) * 0.5)
}

if !scr_skill_get(mut_extra_feet) && place_meeting(x, y, Floor) {
	var _floor = instance_nearest(bbox_center_x, bbox_center_y, Floor)
	
	friction = 0.45
	
	if instance_exists(_floor) {
		var _floor_sprite = _floor.sprite_index
		
		if _floor_sprite == sprFloor4B || _floor_sprite == sprFloor104B {
			friction = 2
		}
		else if _floor_sprite == sprFloor5B {
			friction = 0.1
		}
	}
}
else if !(roll && scr_skill_get(mut_throne_butt)) {
	friction = 0.45
}

if trigger_fingers_shine > 0 {
	trigger_fingers_shine -= timescale * 0.4

	if trigger_fingers_shine < 0 {
		trigger_fingers_shine = 0
	}
}

if infammo {
	infammo --

	if !infammo {
		with instance_create(x, y, AnimParticle) {
			sprite_index = sprGunWarrantDisappear
			depth = other.depth - 1
			image_speed = 0.4
		}
		
		snd_play_hit_big(sndFishWarrantEnd)
	}
}

if show_empty_cooldown > 0 show_empty_cooldown -= timescale
if hammering > 0 hammering -= timescale

//cursed weps
if curse && current_frame_active && random(6) < 1 {
	instance_create(x + lengthdir_x(10, gunangle) + random(6) - 3,
	y + lengthdir_y(10, gunangle) + random(6) - 3, Curse)
}

if (can_spec) scrPowers()

if race == Race.Frog {
	if (current_frame_active && scr_ultra_get(Race.Frog, UltraSkill.Intimacy) && random(1) < 0.5) {
		var _is_me = scr_player_is_local(index)
		
		with (instance_create(x, y, ToxicGas)) {
			if (_is_me) scrFrogGasStat()
		}
	}

	speed = maxspeed

	if KeyCont.hold_spec[index] {
		if !froggas {
			if scr_skill_get(mut_throne_butt) {
				snd_play(sndFrogStartButt)
				snd_play_loop(sndFrogLoopButt)
			}
			else {
				snd_play(sndFrogStart)
				snd_play_loop(sndFrogLoop)
			}
		}

		if froggas < 30 {
			froggas += timescale
		}

		if (current_frame_active && scr_ultra_get(Race.Frog, UltraSkill.Intimacy) && random(1) < 0.5) {
			var _is_me = scr_player_is_local(index)
			
			with (instance_create(x, y, ToxicGas)) {
				if (_is_me) scrFrogGasStat()
			}
		}

		speed = 0
		sprite_index = spr_idle
	}
	else if froggas > 0 {
		var _is_me = scr_player_is_local(index)
		
		repeat (froggas) {
			with (instance_create(x, y, ToxicGas)) {
				if (_is_me) scrFrogGasStat()
			}
		}
		
		if froggas >= 25 {
			snd_play(sndFrogGasRelease)

			if scr_skill_get(mut_throne_butt) {
				snd_play(sndFrogEndButt)
			}
			else snd_play(sndFrogEnd)
		}
		
		snd_stop(sndFrogLoopButt)
		snd_stop(sndFrogLoop)

		froggas = 0
	}
}

if (global.__debug_noreload) {
	if (reload > 0) {
		can_shoot = true
		reload = 0
	}
	
	if (breload > 0) {
		bcan_shoot = true
		breload = 0
	}
}

if (global.__debug_teleportation) {
	if (mouse_check_button_pressed(mb_middle) || scr_keyboard_check_pressed(vk_f1)) {
		x = mouse_x
		y = mouse_y
		xprevious = x
		yprevious = y
		
		repeat (6 + irandom(3)) {
	        with instance_create(x, y, AnimParticle) {
	            sprite_index = sprCrystTrail
	            image_speed = 0.4
	            friction = 0.4
	            depth = -7
				
	            motion_add(random_angle, 3 + random(2))
	        }
	    }
		
		if (place_meeting(x, y, Wall)) {
			with (instance_create(x, y, PortalClear)) {
				image_xscale = 0.25
				image_yscale = 0.25
			}
		}
		
		snd_play(sndCrystalTB)
	}
}

if instance_exists(ButtonActive) {
	if race == Race.Horror && !KeyCont.hold_spec[index] {
		horrortime = 0
		horrorbeam = 0
	}
}

if horrornorad {
	horrornorad -= timescale
}

if KeyCont.press_horn[index] {
	if race == Race.Venuz {
		scr_screenshake(5)
		
		if (!GameCont.underwater) {
			snd_play(UberCont.birthday ? sndPartyHorn : sndVenuz)
		}
		else {
			snd_play(sndOasisHorn)
		}
		
		with YungCuz {
			sprite_index = sprCuzHorn
			snd_play(sndCuzHorn)
		}
	}
	else if race == Race.Cuz {
		snd_play(GameCont.underwater ? sndCuzOasisRinger : sndCuzRinger)
		
		with YungVenuzCouch {
			sprite_index = sprYVBossGamingAirhorn
			if (image_index >= 7) image_index = 3
			snd_play(sndVenuz)
		}
	}
}

scrFootSteps()