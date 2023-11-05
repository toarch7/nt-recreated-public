if lockstep_stop
	exit

if hp < 0 {
    hp = 0
}

p = index

//SWAP WEPS
if KeyCont.press_swap[index] && bwep != 0 {
    if visible {
        with instance_create(x, y, WepSwap) {
            target = other.id
        }
    }

    if instance_exists(TutCont) && TutCont.pos == 2 && !TutCont.doin {
        TutCont.alarm[0] = 30
        TutCont.doin = 1
    }

    scrSwapWeps()

    if instance_exists(GenCont) or instance_exists(LevCont) or instance_exists(Cinematic) {
        KeyCont.press_swap[index] = 0
    }

    snd_play(wep_swap[wep])
}

if spirit {
    spirit_anim += 0.1

    if spirit_anim >= 6.2
		spirit_anim = 0
}
else if skill_get(27) && spirit_index < 8 {
    spirit_index += 0.4
}

if fainted {
	fainted --
	
	sprite_index = spr_hurt
	image_alpha = 0.5
	
	if hp > 1
		hp = 1
	
	if !fainted {
		if skill_get(mut_strong_spirit)
			scrStrongSpiritRefill()
		
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

if (instance_exists(GenCont)
or (instance_exists(SitDown) && SitDown.sit)
or instance_exists(Cinematic)
or instance_exists(LevCont))
	{ speed = 0; exit}

if !instance_exists(GenCont) && !instance_exists(LevCont) && visible {
    if !roll && canwalk {
        if KeyCont.moving[index] > 0 {
            var spd = maxspeed // * KeyCont.moving[index]

            if speed < spd {
                motion_add(KeyCont.dir_move[index], spd)

                if speed > spd speed = spd
            }

            if instance_exists(TutCont) && TutCont.pos == 0 && !TutCont.doin {
                TutCont.alarm[0] = 90
                TutCont.doin = 1
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
    } else {
        //rolling
        var rollspeed = maxspeed + (1 - skill_get(5) / 2)

        if skill_get(5) {
            angle = direction - 90

            if race == 1 {
                if !snd_is_playing(sndFishTB) snd_loop(sndFishTB)

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
        } else {
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
            snd_play(sndStrongSpiritLose)
            inframes = 30
            spirit = 0
        }
		else if race == 9 && bleed < 150 && visible {
            if bleed = 0 {
                snd_play(sndChickenLoseHead)
                snd_loop(sndChickenHeadlessLoop)

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
				fainted = PRACTICE_FAINTED_TIME
				snd_play(snd_dead)
			}
            else if KeyCont.players > 1 {
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

    //SHOOTING!! AWW YEAH

    if !aimassist_wait or KeyCont.press_fire[index] or KeyCont.release_fire[index] {
        gunangle = KeyCont.dir_fire[index]
    } else aimassist_wait--

    if KeyCont.press_fire[index] or (KeyCont.hold_fire[index] && (wep_auto[wep] or race == 7)) or clicked or (KeyCont.press_spec[index] && (race == 5 or race == 6 or race == 7 or race == 14)) {
        if KeyCont.aimassist[index] && wep_type[wep] != 0 && is_undefined(global.wep_no_assist[$ string(wep)]) {
            var aim_target = noone
            var _raycasted = 1

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

                aim_target = collision_line(x, y, x2, y2, hitme, 0, 1)

                for (var i = 0; i < array_length(l); i++) {
                    instance_activate_object(l[i])
                }
            }

            if !aim_target {
                aim_target = instance_nearest(x, y, enemy)
            }

            if see_object(aim_target, id) && aim_target.object_index != Nothing && aim_target.object_index != Nothing2 {
                var _d = point_direction(x, y, aim_target.x, aim_target.y)

                if aim_target.x > x - 240 && aim_target.y > y - 180 && aim_target.x < x + 240 && aim_target.y < y + 180 {
                    if abs(angle_difference(gunangle, _d)) <= 32 {
                        gunangle = _d
                    }
                }
            }
        }
    }

    if !(race == 2 && KeyCont.hold_spec[index]) && hp >= 0 {
		scrPlayerFiring()
		
        if race == 7 && KeyCont.hold_spec[index] && bcan_shoot {
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
}

//reload stuff
if reload > 0 {
    reload -= 1

    if race == 6 {
        reload -= 0.2

        if ultra == 1 {
            reload -= 0.4
        }
    }

    if skill_get(22) {
        var stress = 1 - hp / max(1, max_hp)

        reload -= stress

        if race == 7 && breload breload -= stress

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

        if wep_type[wep] == 0 snd_play(sndMeleeFlip)

        if wep_type[wep] == 3 snd_play(sndCrossReload)

        if string_copy(wep_name[wep], 0, 6) = "PLASMA" {
            if skill_get(17) {
                snd_play(sndPlasmaReloadUpg)
            } else snd_play(sndPlasmaReload)
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

if race == 7 && breload > 0 {
    breload -= 1

    if breload <= 0 {
        bcan_shoot = 1

        bwepflip = -bwepflip

        if ammo[wep_type[bwep]] < wep_cost[bwep] && wep_type[bwep] != 0 {
            if !show_empty_cooldown {
                scrEmptyB()

                clicked = 0
                show_empty_cooldown = 30
            }
        }

        if wep_type[bwep] == 0 snd_play(sndMeleeFlip)

        if wep_type[bwep] == 3 snd_play(sndCrossReload)

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


if lsthealth < hp {
    drawlowhp = 30
    lsthealth += 1
	
    if lsthealth >= max_hp
		lsthealth = max_hp
}

if sprite_index != spr_hurt && lsthealth > hp {
    if drawlowhp < 30 && hp <= 4
		snd_play(snd_lowh)

    drawlowhp = 30
    lsthealth -= 0.5
}

if can_spirit && !spirit && hp >= max_hp && max_hp > 1
   scrStrongSpiritRefill()

if speed > maxspeed speed = maxspeed

if KeyCont.hold_spec[index] && skill_get(5) && race == 1 {
    roll = 1

    x += round(hspeed / 2)
    y += round(vspeed / 2)
}

if roll {
    speed = 6 + (skill_get(5) * 0.5)
}

if !skill_get(2) {
    if GameCont.area == 5 && !instance_exists(GenCont) && !instance_exists(LevCont) && !instance_exists(FloorMaker) {
        if instance_nearest(x - 16, y - 16, Floor).styleb = 1 {
            friction = 0.1
        } else friction = 0.45
    } else if (GameCont.area = 4 or GameCont.area = 104) && !instance_exists(GenCont) && !instance_exists(LevCont) && !instance_exists(FloorMaker) {
        if instance_nearest(x - 16, y - 16, Floor).styleb = 1 {
            friction = 2
        } else friction = 0.45
    } else if friction != 0.45 {
        friction = 0.45
    }
} else if !(roll && skill_get(5)) friction = 0.45

if last_hp != hp {
    //ON TAKE DAMAGE
    var hp_diff = last_hp - hp

    if hp_diff > 0 {
        try {
            if skill_get(24) {
                with enemy {
                    if x > view_xview && x < view_xview + view_width && y > view_yview && y < view_yview + view_height {
                        target = other.id
                        if instance_exists(target) {
                            with instance_create(x, y, SharpTeeth) {
                                damage = hp_diff * 2
                                target = other.id
                            }
                        }
                    }
                }
            }
        }
		catch (e) {
            print(e.message)
        }

        if race == 12 {
            with instance_create(x, y, PopoExplosion) {
                image_xscale = 0.5
                image_yscale = 0.5
                team = other.team
                snd_play(sndIDPDNadeExplo)
            }

            if ultra == 2 {
                // SUPER BLAST ARMOR

                repeat 3 {
                    with instance_create(x + orandom(2), y + orandom(2), PopoExplosion) {
                        image_xscale = 0.5
                        image_yscale = 0.5
                        team = other.team
                    }
                }
            }
        }
		else if race == 13 {
			UberCont.ctot_uniq[13] += hp_diff
		}
    }

    last_hp = hp
}

if fingers > 0 {
    fingers -= 0.4

    if fingers < 0 {
        fingers = 0
    }
}

if infammo {
    infammo--

    if !infammo {
        with instance_create(x, y, AnimParticle) {
            sprite_index = sprGunWarrantDisappear
            depth = other.depth - 1
            image_speed = 0.4
        }
    }
}

if show_empty_cooldown
	show_empty_cooldown --

//cursed weps
if curse = 1 && random(6) < 1 {
    instance_create(x + lengthdir_x(10, gunangle) + random(6) - 3,
    y + lengthdir_y(10, gunangle) + random(6) - 3, Curse)
}

if inframes inframes--

if skill_get(26) {
    if place_meeting(x + hspeed, y, Wall) or place_meeting(x, y + vspeed, Wall) {
        if hammerhead < 15 hammerhead++
    } else if hammerhead hammerhead--
}

if canshield canshield--

try {
    scrPowers()
} catch (e) {
    print(e.message)
}

if race == 15 && visible {
    if ultra_get(2) && !irandom(2) {
        with instance_create(x, y, ToxicGas)
			scrFrogGasStat()
    }

    speed = maxspeed

    if KeyCont.hold_spec[index] {
        if !froggas {
            if skill_get(5) {
                snd_play(sndFrogStartButt)
                snd_loop(sndFrogLoopButt)
            } else {
                snd_play(sndFrogStart)
                snd_loop(sndFrogLoop)
            }
        }

        if froggas < 30 {
            froggas++
        }

        if ultra_get(2) && !irandom(1) {
            with instance_create(x, y, ToxicGas)
				scrFrogGasStat()
        }

        speed = 0
        sprite_index = spr_idle
    } else if froggas {
        snd_stop(sndFrogLoopButt)
        snd_stop(sndFrogLoop)

        repeat froggas {
            with instance_create(x, y, ToxicGas)
				scrFrogGasStat()
        }

        if froggas >= 25 {
            snd_play(sndFrogGasRelease)

            if skill_get(5) {
                snd_play(sndFrogEndButt)
            } else snd_play(sndFrogEnd)
        }

        froggas = 0
    }
}

if instance_exists(ButtonActive) {
    if race == 11 && !KeyCont.hold_spec[index] {
        horrortime = 0
        horrorbeam = 0
    }
}

if horrornorad {
    horrornorad--
}

if KeyCont.press_horn[index] && race == 6 {
    BackCont.shake += 5

    if GameCont.area != 101 {
        if !UberCont.birthday {
            snd_play(sndVenuz)
        } else snd_play(sndPartyHorn)
    } else snd_play(sndOasisHorn)

    with YungCuz {
        sprite_index = sprCuzHorn
        snd_play(sndCuzHorn)
    }
}

scrFootSteps()