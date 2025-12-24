/// @function scrFire
/// @param weapon
/// @param consume_ammo=true
function scrFire(_wep, _consume_ammo = true) {
	var _weapon_type = scr_weapon_get_type(_wep)
	
	reload = scr_weapon_get_load(_wep)
	can_shoot = 0
    
    var oldviewx2 = BackCont.viewx2,
		oldviewy2 = BackCont.viewy2,
		oldshake = BackCont.shake
	
	var _gunangle = gunangle,
		_long_arms = scr_skill_get(mut_long_arms),
		_laser_brain = scr_skill_get(mut_laser_brain),
		_is_golden = scr_weapon_is_golden(_wep),
		_is_melee = scr_weapon_is_melee(_wep),
		_accuracy = accuracy
	
	// Steroids TB
    if race == Race.Steroids && scr_skill_get(mut_throne_butt) && _weapon_type != Ammo.None {
		var _cost = scr_weapon_get_cost(_wep),
			_amount = scrAmmoGetPickupAmount(_wep)
		
		if (random(_amount) < _cost) && ((random(2) < 1 || !bcan_shoot) && random(3) < 2) {
			scrPlayerGiveAmmo(id, _weapon_type, ceil(_amount * 0.5), true)
		}
    }
	
	// Laser brain lightning FX
    if scr_weapon_get_type(_wep) == Ammo.Energy && scr_skill_get(mut_laser_brain) {
		var _count = scr_weapon_get_cost(_wep)
		
        repeat _count {
            with instance_create(x, y, LaserBrain) {
                image_speed = 0.4 - random(0.1)
                image_angle = random_angle
                depth = other.depth - 1
                creator = other.id
            }
        }
    }
	
	// Consume ammo
    if !infammo && _consume_ammo {
        ammo[_weapon_type] -= scr_weapon_get_cost(_wep)
		
		var _wep_rads = scr_weapon_get_rads(_wep)
        if _wep_rads && GameCont.rad >= _wep_rads {
            GameCont.rad -= _wep_rads
		}
    }

    if (_weapon_type == Ammo.None) {
	    if (GameCont.area == area_oasis) snd_play_gun(sndOasisMelee)
	}
	else {
		if (!specfiring && race == Race.Steroids) drawempty = 30
	}
	
	if (!_is_melee) {
		if (scr_weapon_get_type(_wep) != Ammo.None && wep != wep_jackhammer) {
			GameCont.hasfiredshots = true
		}
	}
	else wepangle *= -1
	
	switch (_wep) {
		case wep_revolver:
		case wep_rusty_revolver:
		case wep_golden_revolver:
			snd_play_gun(_is_golden ? sndGoldPistol : sndPistol)
			scrBulletShotShellFX(Shell)
			with scr_projectile_create(x, y, Bullet1, _gunangle, 16) {
				scr_projectile_spread(4)
			}
			scr_weapon_post(_gunangle, 6, 5, 4)
			break
		case wep_triple_machinegun:
			snd_play_gun(sndTripleMachinegun)
			for(var i = -1; i <= 1; ++i) {
				scrBulletShotShellFX(Shell, 35)
				with scr_projectile_create(x, y, Bullet1, _gunangle, 16) {
					scr_projectile_shift(i * 15)
					scr_projectile_spread(3)
				}
			}
			scr_weapon_post(_gunangle, 6, 0, 4)
			break
		case wep_wrench:
		case wep_golden_wrench:
			snd_play_gun(_is_golden ? sndGoldWrench : sndWrench)
			instance_create(x, y, Dust)
			with scr_projectile_create(x, y, Slash, _gunangle, 2) {
				damage = 8
				scr_projectile_long_arms(_long_arms)
				if (_is_golden) repeat(2) {
					instance_create(
						bbox_center_x + orandom(8),
						bbox_center_y + orandom(8), CaveSparkle)
				}
			}
			scr_weapon_post(_gunangle, 12, 1, -4, -6)
			break
		case wep_machinegun:
		case wep_golden_machinegun:
			snd_play_gun(_is_golden ? sndGoldMachinegun : sndMachinegun)
			scrBulletShotShellFX(Shell)
			with scr_projectile_create(x, y, Bullet1, _gunangle, 16) {
				scr_projectile_spread(6)
			}
			scr_weapon_post(_gunangle, 6, 3, 4)
			break
		case wep_shotgun:
		case wep_golden_shotgun:
		case wep_double_shotgun:
		case wep_auto_shotgun:
		case wep_sawed_off_shotgun:
			var _pellets = 7, _spread = 20
			
			if _wep == wep_double_shotgun {
				snd_play(sndDoubleShotgun)
				scr_weapon_post(_gunangle, 15, 8, 8, 2)
				_pellets = 14
				_spread = 30
			}
			else if _wep == wep_sawed_off_shotgun {
				snd_play(sndSawedOffShotgun)
				scr_weapon_post(_gunangle, 18, 10, 9, 2)
				_pellets = 20
				_spread = 45
			}
			else {
				if (_wep == wep_auto_shotgun) {
					_spread = 15
					_pellets --
				}
				snd_play(_is_golden ? sndGoldShotgun : sndShotgun)
				scr_weapon_post(_gunangle, 12, 1, 4)
			}
			
			repeat (_pellets + _is_golden) {
				with scr_projectile_create(x, y, Bullet2, _gunangle, random_range(12, 18)) {
					scr_projectile_spread(_spread)
				}
			}
			
			break
		case wep_crossbow:
		case wep_golden_crossbow:
		case wep_auto_crossbow:
			snd_play_gun(_is_golden ? sndGoldCrossbow : sndCrossbow)
			scr_weapon_post(_gunangle, 12, 0, 4, 0)
			with scr_projectile_create(x, y, Bolt, _gunangle, 24) {
				if (_wep == wep_auto_crossbow) scr_projectile_spread(5)
				if (_is_golden) sprite_index = sprBoltGold
			}
			break
		case wep_grenade_launcher:
		case wep_golden_grenade_launcher:
			snd_play_gun(_is_golden ? sndGoldGrenade : sndGrenade)
			scr_weapon_post(_gunangle, 10, 2, 5)
			with scr_projectile_create(x, y, Grenade, _gunangle, 10) {
				scr_projectile_spread(3)
				if (_is_golden) sprite_index = sprGoldGrenade
			}
			break
		case wep_minigun:
			snd_play_gun(sndMinigun)
			scrBulletShotShellFX(Shell, 40)
			scr_weapon_post(_gunangle, 7, 4, 4, 0.6)
			with scr_projectile_create(x, y, Bullet1, _gunangle, 16) {
				scr_projectile_spread(13)
			}
			break
		case wep_super_crossbow:
			snd_play_gun(sndSuperCrossbow)
			scr_weapon_post(_gunangle, 60, 14, 8, 1)
			for(var i = -2; i <= 2; ++i) {
				with scr_projectile_create(x, y, Bolt, _gunangle, 24) {
					scr_projectile_shift(5 * i)
				}
			}
			break
		case wep_shovel:
			snd_play_gun(sndShovel, 0.2)
			instance_create(x, y, Dust)
			scr_weapon_post(_gunangle, 24, 1, -4, -6)
			for(var i = -1; i <= 1; ++i) {
				with scr_projectile_create(x, y, Slash, _gunangle, 3) {
					damage = 16
					scr_projectile_shift(i * 60)
					scr_projectile_long_arms(_long_arms)
					sprite_index = sprHeavySlash
				}
			}
			break
		case wep_bazooka:
		case wep_golden_bazooka:
		case wep_gatling_bazooka:
			snd_play_gun(_is_golden ? sndGoldRocket : sndRocket)
			scr_weapon_post(_gunangle, 30, 4, 10)
			with scr_projectile_create(x, y, Rocket, _gunangle, 2) {
				scr_projectile_spread(_wep == wep_gatling_bazooka ? 12 : 3)
				if (_is_golden) sprite_index = sprGoldRocket
			}
			break
		case wep_sticky_launcher:
			snd_play(sndGrenade)
			scr_weapon_post(_gunangle, 10, 0, 2)
			with scr_projectile_create(x, y, Grenade, _gunangle, 11) {
				scr_projectile_spread(3)
				sprite_index = sprStickyGrenade
				sticky = true
			}
			break
		case wep_smg:
			snd_play_gun(sndPistol)
			scrBulletShotShellFX(Shell, 30)
			scr_weapon_post(_gunangle, 6, 3, 2)
			with scr_projectile_create(x, y, Bullet1, _gunangle, 16) {
				scr_projectile_spread(16)
			}
			break
		case wep_assault_rifle:
		case wep_golden_assault_rifle:
			with scr_damage_create(x, y, Burst) {
				golden = _is_golden
	            event_perform(ev_alarm, 0)
	        }
			break
		case wep_disc_gun:
		case wep_golden_disc_gun:
			snd_play_gun(sndDiscgun)
			scr_weapon_post(_gunangle, 10, 6, 4)
			with scr_projectile_create(x, y, Disc, _gunangle, 5) {
				if (_wep == wep_golden_disc_gun) {
					sprite_index = sprGoldDisc
					speed ++
				}
				scr_projectile_spread(5)
				hitid = HitId.Disc
			}
			break
		case wep_laser_pistol:
		case wep_golden_laser_pistol:
		case wep_laser_rifle:
		case wep_laser_minigun:
			snd_play_gun(_is_golden
					? (_laser_brain ? sndGoldLaserUpg : sndGoldLaser)
					: (_laser_brain ? sndLaserUpg : sndLaser))
			
			if _wep == wep_laser_minigun {
				scr_weapon_post(_gunangle, 5, 2, 8, 0.6)
			}
			else {
				scr_weapon_post(_gunangle, 3, 2, (_wep == wep_laser_rifle ? 5 : 2))
			}
			with scr_projectile_create(x, y, Laser, _gunangle) {
				if _wep == wep_laser_rifle scr_projectile_spread(3)
				else if _wep == wep_laser_minigun scr_projectile_spread(12)
				else scr_projectile_spread(1)
				event_perform(ev_alarm, 0)
			}
			break
		case wep_slugger:
		case wep_golden_slugger:
		case wep_gatling_slugger:
			var _gatling_slugger = (_wep == wep_gatling_slugger)
			snd_play_gun(_is_golden ? sndGoldSlugger : sndSlugger)
			scr_weapon_post(_gunangle, 14, 10, _gatling_slugger ? 10 : 8)
			with scr_projectile_create(x, y, Slug, _gunangle, _gatling_slugger ? 18 : 16) {
				scr_projectile_spread(_gatling_slugger ? 6 : 5)
			}
			break
		case wep_assault_slugger:
			with scr_damage_create(x, y, SlugBurst) {
				event_perform(ev_alarm, 0)
			}
			break
		case wep_energy_sword:
			snd_play_gun(_laser_brain ? sndEnergySwordUpg : sndEnergySword)
			scr_weapon_post(_gunangle, 24, 1, -4, -7)
			instance_create(x, y, Dust)
			with scr_projectile_create(x, y, EnergySlash, _gunangle) {
				scr_projectile_long_arms(_long_arms)
			}
			break
		case wep_super_slugger:
			snd_play_gun_big(sndSuperSlugger)
			scr_weapon_post(_gunangle, 10, 15, 8, 3)
			for(var i = -2; i <= 2; ++i) {
				with scr_projectile_create(x, y, Slug, _gunangle, 18) {
					scr_projectile_shift(i * 10)
					scr_projectile_spread(4)
				}
			}
			break
		case wep_hyper_rifle:
			snd_play_gun(sndHyperRifle)
			with scr_damage_create(x, y, HyperBurst) {
	            event_perform(ev_alarm, 0)
	        }
			break
		case wep_screwdriver:
		case wep_golden_screwdriver:
			snd_play_gun(_is_golden ? sndGoldScrewdriver : sndScrewdriver)
			scr_weapon_post(_gunangle, 12, 1, -8, -4)
			instance_create(x, y, Dust)
			with scr_projectile_create(x, y, Shank, _gunangle, 3) {
				scr_projectile_spread(5)
				scr_projectile_long_arms(_long_arms)
			}
			break
		case wep_blood_launcher:
			snd_play_gun(sndBloodLauncher)
			scr_weapon_post(_gunangle, 5, 3, 4)
			with scr_projectile_create(x, y, BloodGrenade, _gunangle, 10) {
				scr_projectile_spread(6)
			}
			break
		case wep_splinter_gun:
			snd_play_gun(sndSplinterGun, 0.2)
			scr_weapon_post(_gunangle, 15, 3, 3)
			repeat (3) {
				with scr_projectile_create(x, y, Splinter, _gunangle, random_range(20, 24)) {
					scr_projectile_spread(10)
				}
			}
			repeat (2) {
				with scr_projectile_create(x, y, Splinter, _gunangle, random_range(20, 24)) {
					scr_projectile_spread(5)
				}
			}
		break
		case wep_golden_splinter_gun:
			snd_play_gun(sndGoldSplinterGun, 0.2)
			scr_weapon_post(_gunangle, 15, 3, 3)
			repeat (3) {
				with scr_projectile_create(x, y, Splinter, _gunangle, random_range(20, 24)) {
					scr_projectile_spread(10)
				}
				with scr_projectile_create(x, y, Splinter, _gunangle, random_range(20, 24)) {
					scr_projectile_spread(5)
				}
			}
			break
		case wep_toxic_bow:
			snd_play_gun(sndCrossbow)
			scr_weapon_post(_gunangle, 40, 5, 4)
			scr_projectile_create(x, y, ToxicBolt, _gunangle, 22)
			break
		case wep_sentry_gun:
			snd_play_gun(sndGrenade)
			scr_weapon_post(_gunangle, 5, 0, -10)
			with instance_create(x, y, SentryGun) {
				team = other.team
				creator = other.id
				motion_add(_gunangle, 6)
				image_angle = direction
			}
			break
		case wep_wave_gun:
			snd_play_gun(sndWaveGun)
			with scr_damage_create(x, y, WaveBurst) {
				event_perform(ev_alarm, 0)
			}
			break
		case wep_plasma_gun:
		case wep_golden_plasma_gun:
			snd_play_gun(_is_golden
				? (_laser_brain ? sndGoldPlasmaUpg : sndGoldPlasma)
				: (_laser_brain ? sndPlasmaUpg : sndPlasma))
			scr_weapon_post(_gunangle, 3, 3, 5, 3)
			with scr_projectile_create(x, y, PlasmaBall, _gunangle, 2 + _is_golden) {
				scr_projectile_spread(4)
			}
			break
		case wep_plasma_cannon:
			snd_play_gun(_laser_brain ? sndPlasmaBigUpg : sndPlasmaBig)
			scr_weapon_post(_gunangle, 8, 8, 10, 6)
			with scr_projectile_create(x, y, PlasmaBig, _gunangle, 2) {
				scr_projectile_spread(2)
			}
			break
		case wep_energy_hammer:
			snd_play_gun(_laser_brain ? sndEnergyHammer : sndEnergyHammerUpg)
			scr_weapon_post(_gunangle, 32, 2, -3, -7)
			instance_create(x, y, Dust)
			with scr_projectile_create(x, y, EnergyHammerSlash, _gunangle, 2) {
				scr_projectile_long_arms(_long_arms)
			}
			break
		case wep_jackhammer:
			with scr_damage_create(x, y, SawBurst) {
				event_perform(ev_alarm, 0)
			}
			break
		case wep_flak_cannon:
			snd_play_gun(sndFlakCannon)
			scr_weapon_post(_gunangle, 32, 4, 7)
			with scr_projectile_create(x, y, FlakBullet, _gunangle, random_range(11, 13)) {
				scr_projectile_spread(6)
			}
			break
		case wep_chicken_sword:
			snd_play_gun(sndChickenSword)
			instance_create(x, y, Dust)
			scr_weapon_post(_gunangle, 8, 1, -6, -4)
			with scr_projectile_create(x, y, Slash, _gunangle) {
				scr_projectile_long_arms(_long_arms)
				damage = 6
			}
			break
		case wep_nuke_launcher:
		case wep_golden_nuke_launcher:
			snd_play_gun(sndNukeFire)
			scr_weapon_post(_gunangle, 40, 8, 10)
			with scr_projectile_create(x, y, Nuke, _gunangle, 2) {
				if (_wep == wep_golden_nuke_launcher) sprite_index = sprGoldNuke
				scr_projectile_spread(2)
				index = other.index
			}
			break
		case wep_ion_cannon:
			snd_play_gun(_laser_brain ? sndLaserUpg : sndLaser)
			scr_damage_create(x, y, IonBurst)
			break
		case wep_quadruple_machinegun:
			snd_play_gun(sndQuadMachinegun)
			scr_weapon_post(_gunangle, 10, 6, 8)
			for(var i = -2; i <= 2; ++i) {
				if (i == 0) continue
				scrBulletShotShellFX(Shell, 35)
				
				with scr_projectile_create(x, y, Bullet1, _gunangle, 16) {
					scr_projectile_shift(floor(i * (4.5 + abs(i * 2))))
					scr_projectile_spread(3)
				}
			}
			break
		case wep_flamethrower:
			if !instance_exists(FlameSound) instance_create(x, y, FlameSound)
			with scr_damage_create(x, y, FlameBurst) event_perform(ev_alarm, 0)
			break
		case wep_dragon:
			if !instance_exists(DragonSound) instance_create(x, y, DragonSound)
			with scr_damage_create(x, y, DragonBurst) event_perform(ev_alarm, 0)
			break
		case wep_flare_gun:
			snd_play_gun(sndFlare)
			scr_weapon_post(_gunangle, 10, 5, 5)
			with scr_projectile_create(x, y, Flare, _gunangle, 9) {
				scr_projectile_spread(7)
			}
			break
		case wep_energy_screwdriver:
			snd_play_gun(_laser_brain ? sndEnergyScrewdriverUpg : sndEnergyScrewdriver)
			instance_create(x, y, Dust)
			scr_weapon_post(_gunangle, 12, 2, -8, -5)
			with scr_projectile_create(x, y, EnergyShank, _gunangle, 3) {
				scr_projectile_long_arms(_long_arms)
			}
			break
		case wep_hyper_launcher:
			snd_play_gun(sndHyperLauncher)
			scr_weapon_post(_gunangle, 20, 4, 8)
			with scr_projectile_create(x, y, HyperGrenade, _gunangle) {
				scr_projectile_spread(2)
			}
			break
		case wep_laser_cannon:
			snd_play_gun(sndLaserCannonCharge)
			with scr_damage_create(x, y, LaserCannon) {
				if (_laser_brain) ammo += 2
				image_angle = _gunangle
				direction = _gunangle
			}
			break
		case wep_lightning_pistol:
			snd_play_gun(_laser_brain ? sndLightningPistolUpg : sndLightningPistol)
			scr_weapon_post(_gunangle, 3, 5, 4)
			scrLightningCreate(x, y, _gunangle + orandom(15) * _accuracy, 14)
			break
		case wep_lightning_rifle:
			snd_play_gun(_laser_brain ? sndLightningRifleUpg : sndLightningRifle)
			scr_weapon_post(_gunangle, 6, 8, 8)
			scrLightningCreate(x, y, _gunangle + orandom(15) * _accuracy, 30)
			break
		case wep_lightning_shotgun:
			snd_play_gun(_laser_brain ? sndLightningShotgunUpg : sndLightningShotgun)
			scr_weapon_post(_gunangle, 4, 10, 5)
			repeat (8) scrLightningCreate(x, y, _gunangle, irandom_range(9, 12))
			break
		case wep_super_flak_cannon:
			snd_play_gun(sndSuperFlakCannon)
			with scr_projectile_create(x, y, SuperFlakBullet, _gunangle, random_range(10, 11)) {
				scr_projectile_spread(4)
			}
			scr_weapon_post(_gunangle, 48, 8, 9)
			break
		case wep_splinter_pistol:
			snd_play_gun(sndSplinterPistol)
			repeat (4) with scr_projectile_create(x, y, Splinter, _gunangle, random_range(16, 24)) {
				scr_projectile_spread(4)
			}
			scr_weapon_post(_gunangle, 10, 2, 3)
			break
		case wep_super_splinter_gun:
			snd_play_gun(sndSuperSplinterGun)
			with scr_damage_create(x, y, SplinterBurst) {
				event_perform(ev_alarm, 0)
			}
			break
		case wep_lightning_smg:
			snd_play_gun(_laser_brain ? sndLightningPistolUpg : sndLightningPistol)
			scrLightningCreate(x, y, _gunangle + orandom(30) * _accuracy, 14)
			scr_weapon_post(_gunangle, 4, 5, 5)
			break
		case wep_smart_gun:
			snd_play_gun(sndSmartgun)
			var _target = noone
			if instance_exists(enemy) {
				_target = instance_nearest(x, y, enemy)
				if (instance_exists(_target)) {
					_gunangle = point_direction(x, y, _target.x, _target.y)
					if (instance_is(self, Player)) gunangle = _gunangle
				}
			}
			scrBulletShotShellFX(Shell, 35)
			with scr_projectile_create(x, y, Bullet1, _gunangle, 16) {
				scr_projectile_spread(5)
			}
			scr_weapon_post(_gunangle, 0, 5, 5)
			break
		case wep_heavy_crossbow:
		case wep_heavy_auto_crossbow:
			snd_play_gun(sndHeavyCrossbow)
			scr_weapon_post(_gunangle, 50, 5, 6, 0)
			with scr_projectile_create(x, y, HeavyBolt, _gunangle, 16) {
				if (_wep == wep_heavy_auto_crossbow) scr_projectile_spread(6)
			}
			break
		case wep_blood_hammer:
			snd_play_gun(sndBloodHammer)
			scr_weapon_post(_gunangle, 12, 1, -4, -6)
			with scr_projectile_create(x, y, BloodSlash, _gunangle, 2) {
				scr_projectile_long_arms(_long_arms)
				damage = 14
			}
			break
		case wep_lightning_cannon:
			snd_play_gun(_laser_brain ? sndLightningCannonUpg : sndLightningCannon)
			with scr_projectile_create(x, y, LightningBall, _gunangle, 3) {
				scr_projectile_spread(5)
			}
			scr_weapon_post(_gunangle, 6, 9, 6, 6)
			break
		case wep_pop_gun:
			snd_play_gun(sndPopgun)
			scrBulletShotShellFX(Shell)
	        scr_weapon_post(_gunangle, 4, 2, 2)
	        with scr_projectile_create(x, y, Bullet2, _gunangle, 16) {
	            scr_projectile_spread(4)
	        }
			break
		case wep_plasma_rifle:
			snd_play_gun(_laser_brain ? sndPlasmaRifleUpg : sndPlasmaRifle)
	        with scr_projectile_create(x, y, PlasmaBall, _gunangle, 2) {
	            scr_projectile_spread(3)
	        }
			scr_weapon_post(_gunangle, 3, 3, 5, 3)
			break
		case wep_pop_rifle:
			with scr_damage_create(x, y, PopBurst) {
				event_perform(ev_alarm, 0)
			}
			break
		case wep_toxic_launcher:
			snd_play_gun(sndToxicLauncher)
			scr_weapon_post(_gunangle, 10, 2, 4)
			with scr_projectile_create(x, y, ToxicGrenade, _gunangle, 9) {
				scr_projectile_spread(3)
			}
			break
		case wep_flame_cannon:
			snd_play_gun_big(sndFlameCannon, 0.2)
	        with scr_projectile_create(x, y, FlameBall, _gunangle, 3) {
				scr_projectile_spread(5)
	        }
			scr_weapon_post(_gunangle, 10, 2, 5)
			break
		case wep_lightning_hammer:
			snd_play_gun(sndLightningHammer, 0.2)
	        instance_create(x, y, Dust)
	        with scr_projectile_create(x, y, LightningSlash, _gunangle, 2) {
	            scr_projectile_long_arms(_long_arms)
	        }
			scr_weapon_post(_gunangle, 24, 1, -4, -7)
			break
		case wep_flame_shotgun:
		case wep_auto_flame_shotgun:
			snd_play(sndFireShotgun)
			scr_weapon_post(_gunangle, 12, 6, 5)
			repeat (6) {
				with scr_projectile_create(x, y, FlameShell, _gunangle, random_range(12, 18)) {
					scr_projectile_spread(_wep == wep_auto_flame_shotgun ? 10 : 15)
				}
			}
			break
		case wep_double_flame_shotgun:
			snd_play_gun(sndDoubleFireShotgun)
			for(var i = -1; i <= 1; ++i) {
				if (i == 0) continue
				repeat (7) with scr_projectile_create(x, y, FlameShell, _gunangle, random_range(12, 18)) {
					scr_projectile_shift(i * 15)
					scr_projectile_spread(15)
				}
			}
			scr_weapon_post(_gunangle, 22, 12, 9)
			break
		case wep_cluster_launcher:
			snd_play_gun(sndClusterLauncher)
	        with scr_projectile_create(x, y, ClusterNade, _gunangle, 8) {
				scr_projectile_spread(8)
	        }
			scr_weapon_post(_gunangle, 10, 2, 5)
			break
		case wep_grenade_shotgun:
		case wep_auto_grenade_shotgun:
			snd_play_gun(sndGrenadeShotgun)
			var _num = (_wep == wep_auto_grenade_shotgun ? 3 : 4) + scrCrownCheck(crwn_death)
	        repeat (_num) {
	            with scr_projectile_create(x, y, SmallGrenade, _gunangle, random_range(10, 15)) {
	                scr_projectile_spread(17)
	            }
			}
			scr_weapon_post(_gunangle, 10, 2, 8)
			break
		case wep_grenade_rifle:
			with scr_damage_create(x, y, NadeBurst) {
				ammo = 3 + scrCrownCheck(crwn_death)
				event_perform(ev_alarm, 0)
			}
			break
		case wep_rogue_rifle:
			scr_damage_create(x, y, IDPDBurst)
			break
		case wep_party_gun:
			snd_play_gun_big(sndConfettiGun, 0.2)
	        with scr_projectile_create(x, y, ConfettiBall, _gunangle, 8) {
				scr_projectile_spread(8)
	        }
			scr_weapon_post(_gunangle, 3, 3, 2)
			break
		case wep_double_minigun:
			snd_play_gun_big(sndDoubleMinigun)
			scr_weapon_post(_gunangle, 12, 6, 7, 0.7)
			for(var i = -1; i <= 1; ++i) {
				if (i == 0) continue
				with scrBulletShotShellFX(Shell, 40) speed ++
				with scr_projectile_create(x, y, Bullet1, _gunangle, 16) {
					scr_projectile_shift(i * 7)
					scr_projectile_spread(12)
				}
			}
			break
		case wep_ultra_revolver:
			snd_play_gun_big(sndUltraPistol)
			scrBulletShotShellFX(Shell)
			with scr_projectile_create(x, y, UltraBullet, _gunangle, 24) {
				scr_projectile_spread(3)
			}
			scr_weapon_post(_gunangle, 12, 6, 4)
			break
		case wep_ultra_laser_pistol:
			snd_play_gun_big(_laser_brain ? sndUltraLaserUpg : sndUltraLaser)
			for(var i = -2; i <= 2; ++i) {
				with scr_projectile_create(x, y, Laser, _gunangle) {
					scr_projectile_shift(i * 8)
					scr_projectile_spread(1)
				}
			}
			scr_weapon_post(_gunangle, 12, 10, 7)
			break
		case wep_sledgehammer:
			snd_play_gun(sndHammer)
			instance_create(x, y, Dust)
			scr_weapon_post(_gunangle, 12, 1, -4, -6)
			with scr_projectile_create(x, y, Slash, _gunangle, 2) {
				damage = 24
				sprite_index = sprHeavySlash
				scr_projectile_long_arms(_long_arms)
			}
			break
		case wep_heavy_revolver:
		case wep_heavy_machinegun:
			if (_wep == wep_heavy_machinegun) snd_play_gun(sndHeavyRevolver)
			else snd_play_gun(sndHeavyRevolver)
			scrBulletShotShellFX(HeavyShell)
			with scr_projectile_create(x, y, HeavyBullet, _gunangle, 16) {
				scr_projectile_spread(_wep == wep_heavy_machinegun ? 3 : 1)
			}
			scr_weapon_post(_gunangle, 7, 5, 6)
			break
		case wep_heavy_slugger:
			snd_play_gun(sndHeavySlugger)
			with scr_projectile_create(x, y, HeavySlug, _gunangle, 13) {
				scr_projectile_spread(4)
			}
			scr_weapon_post(_gunangle, 34, 14, 10)
			break
		case wep_ultra_shovel:
			snd_play_gun_big(sndUltraShovel)
			instance_create(x, y, Dust)
			for(var i = -1; i <= 1; ++i) {
				with scr_projectile_create(x, y, UltraSlash, _gunangle, 3) {
					damage = 30
					scr_projectile_long_arms(_long_arms)
					scr_projectile_shift(60 * i)
				}
			}
			scr_weapon_post(_gunangle, 28, 1, -6, -8)
			break
		case wep_ultra_shotgun:
			snd_play_gun_big(sndUltraShotgun)
			repeat (9) with scr_projectile_create(x, y, UltraShell, _gunangle, random_range(12, 18)) {
				scr_projectile_spread(22)
			}
			scr_weapon_post(_gunangle, 44, 5, 7)
			break
		case wep_ultra_crossbow:
			snd_play_gun_big(sndUltraCrossbow)
			scr_projectile_create(x, y, UltraBolt, _gunangle, 20)
			scr_weapon_post(_gunangle, 44, 5, 8)
			break
		case wep_ultra_grenade_launcher:
			snd_play_gun_big(sndUltraGrenade)
			with scr_projectile_create(x, y, UltraGrenade, _gunangle, 10) {
				scr_projectile_spread(5)
			}
			scr_weapon_post(_gunangle, 12, 3, 8)
			break
		case wep_plasma_minigun:
			snd_play_gun(_laser_brain ? sndPlasmaMinigunUpg : sndPlasmaMinigun)
			with scr_projectile_create(x, y, PlasmaBall, _gunangle, 1) {
				scr_projectile_spread(10)
			}
			scr_weapon_post(_gunangle, 5, 3, 8, 2)
			break
		case wep_devastator:
			snd_play_gun(_laser_brain ? sndDevastatorUpg : sndDevastator)
			with scr_projectile_create(x, y, Devastator, _gunangle, 16) {
				scr_projectile_spread(3)
			}
			scr_weapon_post(_gunangle, 30, 10, 8, 5)
			break
		case wep_super_disc_gun:
			snd_play_gun(sndSuperDiscGun)
			for(var i = -2; i <= 2; ++i) {
				with scr_projectile_create(x, y, Disc, _gunangle + i * 7, 5) {
					scr_projectile_spread(2)
					hitid = HitId.Disc
				}
			}
			scr_weapon_post(_gunangle, 16, 6, 6)
			break
		case wep_heavy_assault_rifle:
			with scr_damage_create(x, y, HeavyBurst) {
				event_perform(ev_alarm, 0)
			}
			break
		case wep_blood_cannon:
			snd_play_gun(sndBloodCannon)
			with scr_projectile_create(x, y, BloodBall, _gunangle, 5) {
				scr_projectile_spread(5)
				if (!place_free(x, y)) move_outside_solid(direction, speed)
			}
			scr_weapon_post(_gunangle, 9, 6, 6)
			break
		case wep_dog_spin_attack:
			snd_play_gun(sndBigDogSpin)
			with instance_create(x, y, DogSpinAttack) {
	            team = other.team
	            creator = other.id
	            ammo = 15
	        }
			break
		case wep_incinerator:
			snd_play_gun(sndIncinerator)
			for(var i = -1; i <= 1; ++i) {
				scrBulletShotShellFX(Shell, 35)
				with scr_projectile_create(x, y, FlameShell, _gunangle, 16) {
					scr_projectile_shift(18 * i)
					scr_projectile_spread(5)
				}
			}
			scr_weapon_post(_gunangle, 9, 4, 7)
			break
		case wep_super_plasma_cannon:
			snd_play_gun(_laser_brain ? sndPlasmaHugeUpg : sndPlasmaHuge)
			with scr_projectile_create(x, y, PlasmaHuge, _gunangle, 1.5) {
				scr_projectile_spread(1)
			}
			scr_weapon_post(_gunangle, 40, 15, 10, 16)
			break
		case wep_seeker_pistol:
			snd_play_gun(sndSeekerPistol)
			scr_weapon_post(_gunangle, 12, 2, 4)
			repeat (2) {
				with scr_projectile_create(x, y, Seeker, _gunangle, 8) {
					scr_projectile_spread(30)
				}
			}
			break
		case wep_seeker_shotgun:
			snd_play_gun(sndSeekerShotgun)
			scr_weapon_post(_gunangle, 16, 6, 8)
			repeat (6) {
				with scr_projectile_create(x, y, Seeker, _gunangle, 8) {
					scr_projectile_spread(70)
				}
			}
			break
		case wep_eraser:
			snd_play_gun(sndEraser)
			repeat (17) {
	            with scr_projectile_create(x, y, Bullet2, _gunangle, random_range(10, 18)) {
	                scr_projectile_spread(1)
	            }
	        }
			scr_weapon_post(_gunangle, 18, 8, 8, 2)
			break
		case wep_guitar:
		case wep_electric_guitar:
			snd_play_gun(_wep == wep_electric_guitar ? sndElectricGuitar : sndGuitar)
	        instance_create(x, y, Dust)
	        with scr_projectile_create(x, y, Slash, _gunangle, 2) {
	            damage = 26
				scr_projectile_long_arms(_long_arms)
	            sprite_index = sprHeavySlash
				if (_wep == wep_electric_guitar) {
					electricguitar = true
				}
				else guitar = true
	        }
			scr_weapon_post(_gunangle, 12, 1, -4, -6)
			break
		case wep_bouncer_smg:
			snd_play_gun(sndBouncerSmg)
			scrBulletShotShellFX(Shell, 30)
			with scr_projectile_create(x, y, BouncerBullet, _gunangle, 6) {
				scr_projectile_spread(20)
			}
			scr_weapon_post(_gunangle, 5, 2, 2)
			break
		case wep_bouncer_shotgun:
			snd_play_gun(sndBouncerShotgun)
			for(var i = -3; i <= 3; ++i) {
				with scr_projectile_create(x, y, BouncerBullet, _gunangle, 6) {
					sprite_index = sprBouncerShell
					scr_projectile_shift(i * 10)
					scr_projectile_spread(3)
				}
			}
			scr_weapon_post(_gunangle, 7, 7, 5)
			break
		case wep_hyper_slugger:
			snd_play_gun(sndHyperSlugger)
			with scr_projectile_create(x, y, HyperSlug, _gunangle, 12) {
				scr_projectile_spread(2)
			}
			scr_weapon_post(_gunangle, 16, 11, 10)
			break
		case wep_super_bazooka:
			snd_play_gun(sndSuperBazooka)
			for(var i = -2; i <= 2; ++i) {
				scr_projectile_create(x, y, Rocket, _gunangle + i * 6, 2)
			}
			scr_weapon_post(_gunangle, 60, 20, 12, 1)
			break
		case wep_frog_pistol:
		case wep_golden_frog_pistol:
			snd_play_gun(_is_golden ? sndGoldFrogPistol : sndFrogPistol)
			repeat (3) with scr_projectile_create(x, y, EnemyBullet2, _gunangle, random_range(10, 14)) {
				scr_projectile_spread(6)
				hitid = HitId.None
			}
			scr_weapon_post(_gunangle, 4, 4, 2)
			break
		case wep_black_sword:
			var _mega = (instance_is(self, Player) && (hp <= 0 || max_hp <= 0))
			snd_play_gun(_mega ? sndBlackSwordMega : sndBlackSword)
			instance_create(x, y, Dust)
			with scr_projectile_create(x, y, Slash, _gunangle, 2) {
				damage = _mega ? 80 : 12
				scr_projectile_long_arms(_long_arms)
				if _mega {
					sprite_index = sprMegaSlash
					mask_index = mskMegaSlash
				}
			}
			sleep(8)
			scr_weapon_post(_gunangle, 9, 1, -7, -8)
			break
		case wep_heavy_grenade_launcher:
			snd_play_gun(sndHeavyNader)
			with scr_projectile_create(x, y, HeavyGrenade, _gunangle, random_range(10, 11)) {
				scr_projectile_spread(4)
			}
			scr_weapon_post(_gunangle, 12, 2, 8)
			break
		case wep_gun_gun:
			snd_play_gun(sndGunGun)
			var _drop_wep = scrDecideWep(10)
			with scrWeaponPickupCreate(x, y, _drop_wep) {
				motion_add_m(_gunangle, 16)
				instance_create(x + hspeed, y + vspeed, GunGun)
				mask_index = mskPlasma
				friction = 0
				team = other.team
				creator = other.id
			}
			scr_weapon_post(_gunangle, 30, 8, 6)
			break
		default: print("Unkown weapon:", _wep)
	}
	
	return true
}