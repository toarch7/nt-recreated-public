if lockstep_stop
	exit

if hp < 0 {
    hp = 0
}

if scr_weapon_is_melee(wep) {
    if wepangle == 0 {
		wepangle = choose(120, -120)
	}
}
else {
	wepangle = 0
}

//SWAP WEPS
if KeyCont.press_swap[index] && bwep != 0 {
    if visible {
        with instance_create(x, y, WepSwap) {
            target = other.id
        }
    }
	
	with TutCont {
		if pos == 2 && !step_complete {
			step_complete = true
			alarm[0] = 30
		}
    }

    scrSwapWeps()

    if !scrGameIsLockState() KeyCont.press_swap[index] = 0

    snd_play(wep_swap[wep])
}

if spirit {
    spirit_anim += 0.1

    if spirit_anim >= 6.2
		spirit_anim = 0
}
else if skill_get(mut_strong_spirit) && spirit_index < 8 {
    spirit_index += 0.4
}

if fainted {
	fainted -= timescale
	sprite_index = spr_hurt
	image_alpha = 0.5
	
	if hp > 1 {
		hp = 1
	}
	
	if !fainted {
		if skill_get(mut_strong_spirit) {
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
				projectile_hit_self(40)
				
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
		
		mask_index = mskPlayer
		
		if race == 13
			mask_index = mskScrapBoss
		
		image_alpha = 1
		
		inframes = max(30, inframes)
		
		hp = 1
	}
	
	exit
}

if (!visible || scrGameIsLockState()) exit

if !roll && canwalk {
    if KeyCont.moving[index] > 0 {
        var spd = maxspeed // * KeyCont.moving[index]

        if speed < spd {
            motion_add(KeyCont.dir_move[index], spd)

            if speed > spd speed = spd
        }

        if instance_exists(TutCont) && TutCont.pos == 0 && !TutCont.step_complete {
            TutCont.alarm[0] = 90
            TutCont.step_complete = 1
        }
    }

    if place_meeting(x, y, NothingDeath) && instance_exists(SitDown) {
        move_towards_point(SitDown.x, SitDown.y, maxspeed)
    }

    if !speed {
        if sprite_index != spr_hurt
            sprite_index = spr_idle
    } else {
        if sprite_index != spr_hurt
            sprite_index = spr_walk
    }

    if sprite_index = spr_hurt {
        if image_index > 2
            sprite_index = spr_idle
    }
}
else {
    //rolling
    var rollspeed = maxspeed + (1 - skill_get(5) / 2)

    if skill_get(5) {
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
    } else {
        instance_create(x + random(6) - 3, y + random(6), Dust)

        angle += 40 * right

        if abs(angle) >= 540 {
            angle = 0
            roll = 0
        }
    }

    if roll speed = rollspeed

    if !speed {
        if sprite_index != spr_hurt
            sprite_index = spr_idle
    } else {
        if sprite_index != spr_hurt
            sprite_index = spr_walk
    }

    if sprite_index == spr_hurt && image_index > 2 {
        sprite_index = spr_idle
    }
}

if bleed > 0 && hp > 0 && visible {
    snd_stop(sndChickenHeadlessLoop)
    snd_play(sndChickenRegenHead)
    bleed = 0


    if !bskin {
        spr_idle = sprMutant9Idle
        spr_walk = sprMutant9Walk
        spr_hurt = sprMutant9Hurt
        spr_dead = sprMutant9Dead
        spr_gosit = sprMutant9GoSit
        spr_sit = sprMutant9Sit
    }
	else {
        spr_idle = sprMutant9BIdle
        spr_walk = sprMutant9BWalk
        spr_hurt = sprMutant9BHurt
        spr_dead = sprMutant9Dead
        spr_gosit = sprMutant9BGoSit
        spr_sit = sprMutant9BSit
    }

    with Corpse {
        if sprite_index == sprMutant9HeadIdle or sprite_index == sprMutant9BHeadIdle {
            instance_destroy()
        }
    }
}

if hp <= 0 {
    if spirit {
        hp = 1
        snd_play(sndStrongSpiritLost)
        inframes = 30
        spirit = 0
    }
	else if race == 9 && bleed < 150 && visible {
        if bleed = 0 {
            snd_play(sndChickenLoseHead)
            snd_play_loop(sndChickenHeadlessLoop)

            repeat(12) {
                with instance_create(x, y, BloodStreak) {
                    motion_add(random_angle, 2 + random(3))
                    image_angle = direction
                }
            }

            headloses += 2
            if max_hp max_hp -= 2

            repeat 9 + irandom(4) {
                with instance_create(x, y, Feather) {
                    sprite_index = sprChickenFeather
                }
            }

            spr_idle = sprMutant9HeadlessIdle
            spr_hurt = sprMutant9HeadlessHurt
            spr_walk = sprMutant9HeadlessWalk
            spr_gosit = sprMutant9HeadlessGoSit
            spr_sit = sprMutant9HeadlessSit

            with instance_create(x, y, CorpseActive) {
                size = 1
                mask_index = other.mask_index
                motion_add(other.direction, other.speed)
                speed += max(0, - other.hp / 5)
                if other.bskin sprite_index = sprMutant9BHeadIdle
                else sprite_index = sprMutant9HeadIdle
                image_xscale = other.right
                if speed > 16 speed = 16
            }

            sleep(60)
        }

        if random(12) < 1 {
            with instance_create(x, y - 4, BloodStreak) {
                motion_add(45 + random(90), 2 + random(3))
                image_angle = direction
            }
        }

        if visible {
            bleed += 1
        }

        UberCont.ctot_uniq[9] ++
    }
	else if can_die {
		if race == 4 && place_meeting(x, y, ReviveCircle) && !instance_exists(CoopController) {
            hp = 1
            scrTurnIntoSkeleton()
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

            //wep = 0
            //bwep = 0
            curse = 0
            bcurse = 0
            reload = 0
            breload = 0

            with instance_create(x, y, CorpseActive) {
                size = 1

                mask_index = other.mask_index
                motion_add(other.direction, other.speed)
                speed += max(0, - other.hp / 5)
                sprite_index = other.spr_dead
                image_xscale = other.right

                if speed > 16 speed = 16
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
    gunangle = KeyCont.dir_fire[index]
}
else aimassist_wait -= 1

if KeyCont.press_fire[index] || (KeyCont.hold_fire[index] && (wep_auto[wep] || race == 7)) || clicked || (KeyCont.press_spec[index] && (race == 5 || race == 6 || race == 7 || race == 14)) {
    if KeyCont.aimassist[index] && wep_type[wep] != 0 && !scr_weapon_is_disabling_aim_assist(wep) {
        var _aim_target = noone

        with instance_create(x, y, AimAssist) {
            image_xscale = view_width
            image_angle = other.gunangle

            var x2 = x + lengthdir_x(view_width, image_angle)
            var y2 = y + lengthdir_y(view_height, image_angle)

            team = other.team

            var l = []

            with hitme {
                if team == other.team {
                    array_push(l, id)
                    instance_deactivate_object(id)
                }
            }

            _aim_target = collision_line(x, y, x2, y2, hitme, 0, 1)

            for (var i = 0; i < array_length(l); i++) {
                instance_activate_object(l[i])
            }
        }

        if !instance_exists(_aim_target) {
            _aim_target = instance_nearest(x, y, enemy)
        }

        if see_object(_aim_target, id) && _aim_target.object_index != Nothing && _aim_target.object_index != Nothing2 {
            var _d = point_direction(x, y, _aim_target.x, _aim_target.y)

            if _aim_target.x > x - 240 && _aim_target.y > y - 180 && _aim_target.x < x + 240 && _aim_target.y < y + 180 {
                if abs(angle_difference(gunangle, _d)) <= 32 {
                    gunangle = _d
                }
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
			
		if KeyCont.press_spec[index]
			KeyCont.press_fire[index] = true
			
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


if wep != 0 && scr_weapon_is_golden(wep) && irandom(7 + (current_frame % 30)) <= 2 {
    with instance_create(
		random_range(bbox_left, bbox_right),
		random_range(bbox_top, bbox_bottom),
		CaveSparkle
	) {
        depth = other.depth + choose(1, -1)
    }
}

//reload stuff
if reload > 0 {
	var _reload_speed = 1

    if race == 6 {
        _reload_speed += 0.2
		
		var _imagungod = scrUltraCheck(race, UltraSkill.ImaGunGod)
		if _imagungod > 0 {
            _reload_speed += _imagungod * 0.4
        }
    }

    if skill_get(mut_stress) {
        var stress = 1 - hp / max(1, max_hp)

        reload -= stress

        if race == 7 && breload {
			breload -= stress * timescale
		}
		
        if random(2) < stress {
            with instance_create(x, y, Shell) {
                sprite_index = sprSweat
                image_index = irandom(2)
                image_speed = 0
                time = 0
                depth = other.depth - 1
                alarm[0] = 8
                friction = 0.25
                motion_add(other.gunangle + 180 + orandom(45), 2 + random(2))
            }
        }
    }
	
    reload -= _reload_speed * timescale

    if reload <= 0 {
        can_shoot = 1

        if ammo[wep_type[wep]] < wep_cost[wep] && wep_type[wep] != 0 {
            if !show_empty_cooldown {
                scrEmpty()
                show_empty_cooldown = 30
                clicked = 0
            }
        }

        wepflip = -wepflip
		
        if wep_type[bwep] == Ammo.None snd_play(sndMeleeFlip)
        else if wep_type[bwep] == Ammo.Bolts snd_play(sndCrossReload)
		
        if string_starts_with(wep_name[wep], "PLASMA") {
            if skill_get(17) {
                snd_play(sndPlasmaReloadUpg)
            } else snd_play(sndPlasmaReload)
        }
		
		if string_starts_with(wep_name[wep], "LIGHTNING") {
			snd_play(sndLightningReload)
		}

        if string_count("GRENADE", wep_name[wep]) {
            snd_play(sndNadeReload)
        }

        if wep_type[wep] == 2 {
            repeat(wep_cost[wep]) {
                with instance_create(x, y, Shell) {
                    sprite_index = sprShotShell
                    motion_add(other.gunangle + other.right * 100 + random(40) - 20, 2 + random(2))
                }
            }

            wkick = -1

            if wep == 8 {
                wkick = -2
            }

            snd_play(sndShotReload)
        }
    }
}

if race == Race.Steroids && breload > 0 {
    breload -= timescale

    if breload <= 0 {
        bcan_shoot = 1
        bwepflip = -bwepflip
		breload = 0

        if ammo[wep_type[bwep]] < wep_cost[bwep] && wep_type[bwep] != 0 {
            if !show_empty_cooldown {
                scrEmptyB()
                show_empty_cooldown = 30
                clicked = 0
            }
        }
		
        if wep_type[bwep] == Ammo.None snd_play(sndMeleeFlip)
        else if wep_type[bwep] == Ammo.Bolts snd_play(sndCrossReload)
		
        if string_copy(wep_name[bwep], 0, 6) == "PLASMA" {
            if skill_get(17) {
                snd_play(sndPlasmaReloadUpg)
            } else snd_play(sndPlasmaReload)
        }

        if string_count("GRENADE", wep_name[bwep]) {
            snd_play(sndNadeReload)
        }

        if wep_type[bwep] == 2 {
            repeat(wep_cost[bwep]) {
                with instance_create(x, y, Shell) {
                    sprite_index = sprShotShell
                    motion_add(other.gunangle + other.right * 100 + random(40) - 20, 2 + random(2))
                }
            }

            bwkick = -1

            if bwep == 8 {
                bwkick = -2
            }

            snd_play(sndShotReload)
        }
    }
}

if lsthealth != hp {
	var _damage_taken = lsthealth - hp
	
	if lsthealth > hp {
		drawlowhp = 30
	}
	
    if _damage_taken > 0 {
		try {
			scrPlayerProcTakeDamage(_damage_taken)
		}
		catch(e) { print_error(e.message) }
		
        try {
            
        }
		catch (e) {
            print(e.message)
        }

        
    }
	
	lsthealth = approach(lsthealth, hp, timescale)
}

if lsthealth >= max_hp {
	lsthealth = max_hp
}

if sprite_index != spr_hurt && lsthealth > hp {
    if drawlowhp < 30 && hp <= 4
		snd_play(snd_lowh)

    drawlowhp = 30
    lsthealth -= 0.5
}

if can_spirit && !spirit && hp >= max_hp && max_hp > 1 {
	scrStrongSpiritRefill()
}

if speed > maxspeed {
	speed = maxspeed
}

if KeyCont.hold_spec[index] && skill_get(mut_throne_butt) && race == Race.Fish {
    x += round(hspeed * 0.2)
    y += round(vspeed * 0.2)
    roll = 1
}

if roll {
    speed = 6 + (skill_get(5) * 0.5)
}

if !skill_get(mut_extra_feet) && place_meeting(x, y, Floor) {
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
else if !(roll && skill_get(mut_throne_butt)) {
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
		
		snd_play(sndFishWarrantEnd)
    }
}

if inframes > 0 inframes -= timescale
if show_empty_cooldown > 0 show_empty_cooldown -= timescale
if canshield > 0 canshield -= timescale

//cursed weps
if curse && random(6) < 1 {
    instance_create(x + lengthdir_x(10, gunangle) + random(6) - 3,
    y + lengthdir_y(10, gunangle) + random(6) - 3, Curse)
}

if skill_get(mut_hammerhead) {
    if place_meeting(x + hspeed, y, Wall) or place_meeting(x, y + vspeed, Wall) {
        if hammerhead < 15 hammerhead++
    } else if hammerhead hammerhead--
}

try {
    scrPowers()
} catch (e) {
    print(e.message)
}

if race == Race.Frog {
    if ultra_get(2) && !irandom(2) {
        with instance_create(x, y, ToxicGas)
			scrFrogGasStat()
    }

    speed = maxspeed

    if KeyCont.hold_spec[index] {
        if !froggas {
            if skill_get(5) {
                snd_play(sndFrogStartButt)
                snd_play_loop(sndFrogLoopButt)
            } else {
                snd_play(sndFrogStart)
                snd_play_loop(sndFrogLoop)
            }
        }

        if froggas < 30 {
            froggas += timescale
        }

        if ultra_get(2) && !irandom(1) {
            with instance_create(x, y, ToxicGas)
				scrFrogGasStat()
        }

        speed = 0
        sprite_index = spr_idle
    }
	else if froggas {
        snd_stop(sndFrogLoopButt)
        snd_stop(sndFrogLoop)

        repeat froggas {
            with instance_create(x, y, ToxicGas)
				scrFrogGasStat()
        }

        if froggas >= 25 {
            snd_play(sndFrogGasRelease)

            if skill_get(mut_throne_butt) {
                snd_play(sndFrogEndButt)
            }
			else snd_play(sndFrogEnd)
        }

        froggas = 0
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

if KeyCont.press_horn[index] && race == Race.Venuz {
	scr_screenshake(5)
	
    if GameCont.area != area_oasis {
        if !UberCont.birthday {
            snd_play(sndVenuz)
        }
		else snd_play(sndPartyHorn)
    }
	else snd_play(sndOasisHorn)

    with YungCuz {
        sprite_index = sprCuzHorn
        snd_play(sndCuzHorn)
    }
}

scrFootSteps()