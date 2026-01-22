// gives cuz a different ability. just for giggles
#macro cuz_fun false

function scrPowers() {
	var _index = index,
		_is_local = scr_player_is_local(_index),
		_press = KeyCont.press_spec[_index],
		_hold = KeyCont.hold_spec[_index],
		_release = KeyCont.release_spec[_index],
		_tb = scr_skill_get(mut_throne_butt)
	
	switch (race) {
		case Race.Fish:
			if _press && visible && can_walk {
				if (_is_local) UberCont.ctot_uniq[race] ++
				
				if (speed < 1) direction = gunangle
				
				if !_tb {
					if (angle == 0) snd_play(sndRoll)
				}
				else snd_play(sndFishRollUpg)
				
				speed = maxspeed
				roll = true
			}
			break
		case Race.Crystal:
			if _press && visible {
				var _any = false
				
				with (CrystalShield) if (creator == other.id) {
					_any = true
				}
				
				if (!_any) with instance_create(x, y, CrystalShield) {
					creator = other.id
				}
			}
			break
		case Race.Eyes:
			var _px = x, _py = y
			
			if _hold {
				var _sound = (_tb ? sndEyesLoopUpg : sndEyesLoop)
				
				if !(audio_is_playing(eyesloop) || snd_is_playing(_sound)) {
					eyesloop = snd_play_loop(_sound)
				}
				
				if (_is_local) UberCont.ctot_uniq[race] ++
				
				if scr_ultra_get(race, UltraSkill.ProjectileStyle) {
					with projectile {
						if creator == other.id {
							x = lerp(x, _px + lengthdir_x(8, direction), 0.8)
							y = lerp(y, _py + lengthdir_y(8, direction), 0.8)
							if (speed < 16 && friction > 0) speed += friction
						}
					}
				}
				
				scrEyesTelekinesis()
			}
			else {
				if audio_is_playing(eyesloop) eyesloop = snd_stop(eyesloop)
				
				if scr_ultra_get(Race.Eyes, UltraSkill.MonsterStyle) {
					with enemy {
						if point_distance(x, y, _px, _py) <= 72 && speed < 16 {
							motion_add(point_direction(other.x, other.y, x, y), 0.4)
						}
					}
				}
			}
			break
		case Race.Melting:
			if _press && (instance_number(enemy) > 0 || instance_exists(Portal)) {
				var _w = game_screen_width div 2,
					_h = game_screen_height div 2,
					
					_px = x,
					_py = y,
					
					_left = _px - _w,
					_top = _py - _h,
					
					_right = _px + _w,
					_bottom = _py + _h
				
				with (Corpse) {
					if image_speed == 0 && x > _left && y > _top && x < _right && y < _bottom {
						scrMeltingCorpseExplosion(_is_local, _tb)
					}
				}
				
				if scr_ultra_get(Race.Melting, UltraSkill.BrainCapacity) {
					with (enemy) {
						if hp <= 5 && x > _left && y > _top && x < _right && y < _bottom {
							scrMeltingCorpseExplosion(_is_local, _tb)
						}
					}
				}
			}
			break
		case Race.Plant:
			if _press {
				var _any = false
				
				with (TangleSeed) if (creator == other.id) {
					_any = true
					break
				}
				
				if !_any {
					scr_projectile_create(x, y, TangleSeed, gunangle, 12)
					snd_play(_tb ? sndPlantFireTB : sndPlantFire)
					instance_destroy(Tangle)
				}
			}
			break
		case Race.Venuz:
			if _press && can_shoot {
				if !scrYVCanPopPop(wep) {
					return snd_play(sndMutant6No)
					break
				}
				
				var _count = 2 + (_tb * 2)
				
				if !scrCheckCanShoot(wep, _count) {
					if !scrCheckRads(wep) {
						scrEmptyRads()
					}
					else scrEmpty()
					
					break
				}
				
				specfiring = true
				
				if scr_ultra_get(Race.Venuz, UltraSkill.Back2Bizniz) {
					repeat (1 + _tb) scrFire(wep, false)
						
					var _angle = gunangle + right * 100
					repeat (3) {
						with instance_create(x, y, Feather) {
							sprite_index = sprMoney
							direction = _angle + orandom(25)
							speed = 2 + random(2)
						}
					}
				}
				
				motion_add_m(gunangle + 180, 8)
				snd_play(_tb ? sndPopPopUpg : sndPopPop)
				repeat (_count) scrFire(wep, true)
				
				specfiring = false
				reload *= (2 + _tb)
			}
			break
		case Race.Robot:
			if _press && scr_weapon_is_valid(wep) && scr_weapon_is_valid(bwep) {
				with instance_create(x, y, RobotEat) {
					if (_tb) sprite_index = sprRobotEatTB
					image_xscale = other.right
					creator = other.id
				}
				
				if (_is_local) {
					if (scr_weapon_is_hyper(wep)) scrRaceUnlockSkin(Race.Robot, SkinLetter.B)
					if (wep == wep_rusty_revolver) scrRaceUnlockSkin(Race.Robot, SkinLetter.C)
					UberCont.ctot_uniq[race] ++
				}
				
				scrRobotEat(wep)
				
				if (curse) {
					scr_hit_self(7, HitId.CurseEat)
					curse = false
					
					repeat (10) {
						instance_create(x + orandom(8), y + orandom(8), Curse)
					}
				}
				
				if (scr_weapon_get_rads(wep)) {
					scrRadDrop(x, y, 15, false, false)
				}
				
				wep = wep_none
				scrSwapWeps()
				breload = 0
				
				snd_play(_tb ? sndRobotEatUpg : sndRobotEat)
				
				instance_create(x, y, Smoke)
			}
			break
		case Race.Chicken:
			if _press && scr_weapon_is_valid(wep) {
				if (curse) {
					snd_play(sndCursedReminder)
					break
				}
				
				with scrWeaponPickupCreate(x, y, wep) {
					motion_set(other.gunangle + orandom(2), 16)
					if scr_ultra_get(Race.Chicken, UltraSkill.Determination) {
						alarm[1] = 60
					}
					team = other.team
					creator = other.id
					image_angle = direction
					mask_index = mskPlasma
					friction = 0
				}
				
				reload = 0
				wep = wep_none
				scrSwapWeps()
				
				snd_play(sndChickenThrow)
			}
			break
		case Race.Rebel:
			if _press {
				var _cost = 1
				
				if scr_ultra_get(Race.Rebel, UltraSkill.Riot) {
					_cost = 2
				}
				else with (Ally) if (creator == other.id) {
					_cost = 2
					break
				}
				
				if (hp <= _cost) break
				
				if (_tb) snd_play(sndSpawnSuperAlly)
				
				scr_hit_self(_cost)
				instance_create(x, y, Dust)
				
				with (Ally) {
					instance_create(x, y, HealFX)
					alarm[2] = 120
					hp = max_hp
				}
				
				repeat (1 + scr_ultra_get(Race.Rebel, UltraSkill.Riot)) {
					with instance_create(x, y, Ally) {
						creator = other.id
						team = other.team
					}
				}
			}
			break
		case Race.Horror:
			var _cost = floor(horrortime + 1)
			
			if _press {
				if GameCont.rad < _cost {
					snd_play(sndHorrorEmpty)
				}
				else {
					snd_play(sndHorrorBeam)
				}
			}
			
			if _hold && GameCont.rad >= _cost {
				var _bskin = bskin
				horrortime += 0.03
				horrornorad = 40
				
				if (_is_local) UberCont.ctot_uniq[Race.Horror] ++
				
				var _sound = _tb ? sndHorrorLoopTB : sndHorrorLoop
				if !(audio_is_playing(horrorloop) || snd_is_playing(_sound)) {
					horrorloop = snd_play_loop(_sound)
				}
				
				with GameCont {
					rad -= _cost
					
					if rad <= 0 {
						snd_play(sndHorrorEmpty)
						rad = 0
					}
				}
				
				var _time = horrortime
				repeat round(_time + 1) {
					with scr_projectile_create(x, y, HorrorBullet, gunangle, 12) {
						if _bskin != SkinLetter.A {
							if _bskin == SkinLetter.B {
								sprite_index = sprHorrorBBullet
								spr_fade = sprHorrorHitB
							}
							else if _bskin == SkinLetter.C {
								sprite_index = sprHorrorCBullet
								spr_fade = sprHorrorBulletHitC
							}
						}
						
						var _dir = random_angle
						x += lengthdir_x(irandom(2 + _time), _dir)
						y += lengthdir_y(irandom(2 + _time), _dir)
					}
				}
				
				if (_tb && floor(_time / 0.03) % 30 < timescale) {
					with instance_create(x, y, AnimParticle) {
						sprite_index = sprHorrorTB
						creator = other.id
						image_speed = 0.4
					}
					
					scrPlayerHeal(id, 1, true)
				}
			}
			else {
				if audio_is_playing(horrorloop) snd_stop(horrorloop)
				horrortime = 0
			}
			break
		case Race.Rogue:
			if _press && (!is_touch(_index) || scr_player_pref(scr_playerinstance_find(_index), "rogue")) {
				if !rogue_ammo {
					snd_play(sndPortalStrikeEmpty)
					break
				}
				
				var _px = mouse_x,
					_py = mouse_y
				
				if is_gamepad(_index) || is_touch(_index) {
					_px = x + ldrx(64, KeyCont.dir_fire[_index])
					_py = y + ldry(64, KeyCont.dir_fire[_index])
				}
				
				with instance_create(_px, _py, PortalStrike) {
					creator = other.id
					event_perform(ev_step, 0)
				}
				
				rogue_ammo --
			}
			break
		case Race.BigDog:
			if _press && ammo[Ammo.Explosives] >= 3 {
				repeat 3 {
					with instance_create(x, y, BigDogMissile) {
						creator = other.id
						team = other.team
						
						motion_add(random_angle, 2)
						move_contact_solid(direction, 14)
					}
				}

				ammo[Ammo.Explosives] -= 3
				snd_play(sndBigDogMissile)
			}
			break
		case Race.Skeleton:
			if _press && can_shoot && reload <= 0 {
				if (scr_weapon_get_cost(wep) <= 0) break
				
				scrFire(wep, false)
				reload = scr_weapon_get_load(wep)
				can_shoot = false
				
				if scr_ultra_get(Race.Skeleton, UltraSkill.Damnation) {
					reload = max(1, reload * 0.2)
				}
				
				with instance_create(x, y, BulletHit) {
					sprite_index = sprBloodGamble
					image_angle = other.gunangle
					depth = other.depth - 1
					image_speed = 0.4
				}
				
				skeletongamble ++
				
				var _type = scr_weapon_get_type(wep),
					_amount = scrAmmoGetPickupAmount(_type)
				
				if (random(_amount) < scr_weapon_get_cost(wep)) && (!_tb || random(3) < 2) && scr_hit_self(1, HitId.BloodGamble) {
					skeletongamble = 0
					
					repeat (3) {
						with instance_create(x, y, BloodStreak) {
							motion_add(random_angle, 2)
							image_angle = direction
						}
					}
				}
				
				if _is_local && skeletongamble > UberCont.ctot_uniq[race] {
					UberCont.ctot_uniq[race] = skeletongamble
				}
			}
			break
		case Race.Cuz:
			if _press {
				if (cuz_fun) { scrCuzThrowAllAbility(); break }
				
				if (GameCont.underwater) break
				
				if (cuz_ammo == 0) {
					snd_play(sndCuzCryAttackNoAmmo)
					break
				}
				
				var _ultra = scr_ultra_get(Race.Cuz, UltraSkill.Emotional)
				snd_play(_ultra ? sndCuzCryAttackUltraB : sndCuzCryAttack)
				
				var _angle = 0,
					_count = 20 * (1 + _ultra),
					_step = 360 / _count
				
				repeat _count {
					scr_projectile_create(x, y, CuzTear, _angle, 6)
					_angle += _step
				}
				
				if (_is_local) UberCont.ctot_uniq[race] += _count
				
				if (sprite_exists(spr_cry)) {
					sprite_index = spr_cry
					image_index = 0
				}
				
				cuz_ammo --
			}
			break
	}
	
	with (TutCont) {
		if (_press) complete_step(TutorialStep.Power)
	}
}

function scrMeltingCorpseExplosion(_is_local, _tb) {
	with instance_create(x, y, BloodStreak) {
		motion_add(point_direction(other.x, other.y, x, y), 8)
		image_angle = direction
	}
	
	instance_create(x, y, MeltSplat)
	
	if _tb {
		var _ang = random_angle
		
		repeat 3 {
			instance_create(x + ldrx(24, _ang), y + ldry(24, _ang), MeatExplosion)
			_ang += 120
		}
		
		snd_play(sndCorpseExploUpg)
	}
	else snd_play(sndCorpseExplo)
	
	if size >= 2 {
		var _ang = random_angle
		
		repeat 3 {
			instance_create(x + ldrx(24, _ang), y + ldry(24, _ang), MeatExplosion)
			_ang += 120
		}
	}
	else {
		instance_create(x, y, MeatExplosion)
	}
	
	if (instance_is(other, Player) && scr_player_is_local(other.index)) {
		UberCont.ctot_uniq[Race.Melting] ++
	}
	
	snd_play(sndExplosion)
	
	instance_destroy()
}

function scrCuzThrowAllAbility() {
	if (!scr_weapon_is_valid(bwep)) {
		snd_play(sndMutant6No, 1.1)
		exit
	}
	
	var _weps = extra_weps,
		_weps_curse = extra_weps_curse,
		_weps_reload = extra_weps_reload,
		_weps_wkick = extra_weps_wkick,
		_weps_wepflip = extra_weps_wepflip,
		_weps_wepangle = extra_weps_wepangle,
		_weps_can_shoot = extra_weps_can_shoot,
		_tb = scr_skill_get(mut_throne_butt),
		_shots = 0
	
	repeat (2) {
		if (scr_weapon_is_valid(wep)) {
			scrExtraWepStoreCurrent()
			wep = wep_none
		}
		scrSwapWeps(false)
	}
	
	scrExtraWepsReset()
	
	var _px = x, _py = y, _angle = gunangle
	
	for(var i = 0; i < array_length(_weps); ++i) {
		var _wep = _weps[i]
		
		wep = _wep
		if (scrCheckCanShoot(_wep)) {
			if (_weps_can_shoot[i]) {
				var _n = random(2 + i),
					_a = _angle + orandom(3)
								
				x = _px + ldrx(_n, _a)
				y = _py + ldry(_n, _a)
				
				gunangle = point_direction(_px, _py, x, y)
				
				scrFire(_wep, true)
				_weps_reload[i] = reload
				_weps_can_shoot[i] = can_shoot
				_shots ++
			}
		}
		else {
			scrEmpty()
		}
		
		wep = wep_none
		if (_weps_curse[i]) continue
		
		with (scrWeaponPickupCreate(x, y, _wep)) {
			team = other.team
			creator = other.id
			mask_index = mskPlasma
			motion_add(random_angle, 2)
			motion_add(other.gunangle, 4)
			speed = random_range(6, 8)
			autopick = true
			
			if (_tb) slowreturn = true
		}
		
		array_delete(_weps, i, 1)
		array_delete(_weps_curse, i, 1)
		array_delete(_weps_reload, i, 1)
		array_delete(_weps_wkick, i, 1)
		array_delete(_weps_wepflip, i, 1)
		array_delete(_weps_wepangle, i, 1)
		array_delete(_weps_can_shoot, i, 1)
		
		i--
	}
	
	x = _px
	y = _py
	
	extra_weps = _weps
	extra_weps_curse = _weps_curse
	extra_weps_reload = _weps_reload
	extra_weps_wkick = _weps_wkick
	extra_weps_wepflip = _weps_wepflip
	extra_weps_wepangle = _weps_wepangle
	extra_weps_can_shoot = _weps_can_shoot
	
	var _count = min(2, array_length(_weps))
	
	repeat (_count) {
		scrExtraWepRestoreFirst()
		
		if (_count > 1) {
			scrSwapWeps(false)
		}
	}
	
	if (_shots > 1) snd_play_hit_big(sndCuzOpen)
}

function scrRobotEat(_wep, _auto_collect = false) {
	static __spawn_pickup = function(_object, _auto_collect) {
		var _instance = instance_create(x, y, _object)
		
		if (_auto_collect) with (instance_nearest(x, y, Player)) {
			with (_instance) event_perform(ev_collision, Player)
		}
		
		return _instance
	}
	
	var _tb = scr_skill_get(mut_throne_butt),
		_life_crown = scrCrownCheck(crwn_life)
	
	if (scr_weapon_is_golden(_wep)) repeat (4 + _tb) {
		var _health = (!_life_crown && random(max_hp) > hp)
		__spawn_pickup(_health ? HPPickup : AmmoPickup, _auto_collect)
	}
	
	if scr_ultra_get(Race.Robot, UltraSkill.Regurgitate) && random(1) <= 0.43 {
		if scrCrownCheck(crwn_love) {
			__spawn_pickup(AmmoChest, _auto_collect)
		}
		else if random(max_hp) > hp && random(3) < 2 {
			__spawn_pickup(HealthChest, _auto_collect)
		}
		else {
			__spawn_pickup(choose(WeaponChest, AmmoChest, AmmoChest), _auto_collect)
		}
	}
	
	repeat (1 + _tb) {
		if random(max_hp) > hp && !_life_crown {
			__spawn_pickup(HPPickup, _auto_collect)
		}
		else {
			__spawn_pickup(AmmoPickup, _auto_collect)
		}
	}
}