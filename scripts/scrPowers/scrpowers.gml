function scrPowers() {
    //FISH
    if KeyCont.press_spec[index] && race == 1 && visible && canwalk {
        if speed < friction {
            direction = KeyCont.dir_fire[index]
        }

        speed = 4

        if is_me {
            UberCont.ctot_uniq[1]++
        }

        if !skill_get(5) {
            if angle == 0 snd_play(sndRoll)
        }
		else snd_play(sndFishRollUpg)

        roll = 1
    }

    //CRYSTAL
    if race == 2 && KeyCont.press_spec[index] {
        var a = 0

        with CrystalShield {
            if creator == other.id a = 1
        }

        if !a {
            with instance_create(x, y, CrystalShield) {
                creator = other.id
            }
        }
    }


    //EYES
    if race == 3 {
		#region Mmmmmmwwwwhhhawwwmmmmhhhhaawwww
        if KeyCont.hold_spec[index] {
            if skill_get(5) {
                if !snd_is_playing(sndEyesLoopUpg)
					snd_play(sndEyesLoopUpg)
            }
			else if !snd_is_playing(sndEyesLoop)
				snd_play(sndEyesLoop)
        }
		else {
            if skill_get(5) {
                if snd_is_playing(sndEyesLoopUpg)
					snd_stop(sndEyesLoopUpg)
            }
			else if snd_is_playing(sndEyesLoop)
				snd_stop(sndEyesLoop)
		}
		#endregion
		
		if KeyCont.hold_spec[index] {
			// telekinesis
			var bx1 = x - 213,
				by1 = y - 120,
				bx2 = x + 213,
				by2 = y + 120
			
			if ultra == 1 {
			    with projectile {
			        if self[$ "creator"] == other.id {
			            x = lerp(x, other.x + lengthdir_x(16, direction), 0.8)
			            y = lerp(y, other.y + lengthdir_y(16, direction), 0.8)
						
						if speed < 16
							speed += friction
			        }
			    }
			}
			
			UberCont.ctot_uniq[3] ++
			
			var strength = 1 + skill_get(5), dir, lx, ly
		
			#macro M_EYES_TELEKINESIS { if !(x > bx1 && y > by1 && x < bx2 && y < by2) continue dir = point_direction(x, y, other.x, other.y) lx = lengthdir_x(strength, dir) ly = lengthdir_y(strength, dir) if !place_meeting(x + lx, y, Wall) x += lx if !place_meeting(x, y + ly, Wall) y += ly }
		
			with enemy M_EYES_TELEKINESIS;
			with chestprop M_EYES_TELEKINESIS;
			with AmmoPickup M_EYES_TELEKINESIS;
			with HPPickup M_EYES_TELEKINESIS;
			with WepPickup M_EYES_TELEKINESIS;
			with RadChest M_EYES_TELEKINESIS;
			with Rad M_EYES_TELEKINESIS;
		
			with projectile {
				if team != other.team {
					if !(x > bx1 && y > by1 && x < bx2 && y < by2)
						continue
				
					dir = point_direction(x, y, other.x, other.y)
				
					lx = -lengthdir_x(strength, dir)
					ly = -lengthdir_y(strength, dir)
				
					if !place_meeting(x + lx, y, Wall)
						x += lx
				
					if !place_meeting(x, y + ly, Wall)
						y += ly
				}
			}
		}
		else if ultra == 2 {
		    with enemy {
		        if distance_to_object(other) <= 72 && speed < 16 {
		            motion_add(point_direction(other.x, other.y, x, y), 0.4)
		        }
		    }
		}
    }

    //MELTING
    if KeyCont.press_spec[index] && race == 4 && (instance_number(enemy) > 0 or instance_exists(Portal)) {
		var bx1 = x - 213,
			by1 = y - 120,
			bx2 = x + 213,
			by2 = y + 120

        with Corpse {
            if image_speed <= 0 && x > bx1 && x < bx2 && y > by1 && y < by2
                scrMeltingCorpseExplosion()
        }

        if ultra == 1 {
            with enemy {
                if hp < 6 && x > bx1 && x < bx2 && y > by1 && y < by2
                    scrMeltingCorpseExplosion()
            }
        }
    }

    //PLANT
    if KeyCont.press_spec[index] && race == 5 && !instance_exists(TangleSeed) {
        with Tangle
			instance_destroy()

        with TangleSeed
			instance_destroy()

        with instance_create(x, y, TangleSeed) {
            motion_add(other.gunangle, 12)
            image_angle = direction
            team = other.team
        }
    }

    //YUNG VENUZ
    if race == 6 && can_shoot && KeyCont.press_spec[index] {
        if !scrYVCanPop(wep)
			return snd_play(sndMutant6Melee)
		
		var shots = 2,
			boost = skill_get(mut_throne_butt)
		
		if boost
			shots += 2
		
        if scrCheckCanShoot(wep, shots) {
			if ultra_get(2) {
				repeat 1 + boost
					scrFire(wep, false)
				
                can_shoot = true
				
				repeat 3 {
					with instance_create(x, y, Feather) {
						motion_set(other.gunangle + other.right * 100 + random(50) - 35, 2 + random(2))
						
						sprite_index = sprMoney
					}
				}
            }
			
			repeat shots {
				can_shoot = true
				scrFire(wep)
			}
			
			snd_play(boost ? sndPopPopUpg : sndPopPop)
			
			reload *= (2 + boost)
			
			weapon_post(gunangle, 8, 1, 0)
			motion_add(gunangle + 180, 4)
			
			//if yvmobilepopping
			//	clicked = 0
			
			if speed > 5
				speed = 5
		}
		else {
			if !scrCheckRads(wep) {
				scrEmptyRads()
			}
			else scrEmpty()
		}
    }

    //ROBOT
    if race == 8 && KeyCont.press_spec[index] {
        if bwep {
            if string_copy(wep_name[wep], 0, 4) == "GOLD" {
                repeat 4 {
                    if random(max_hp) > hp {
                        instance_create(x, y, HPPickup)
                    } else instance_create(x, y, AmmoPickup)
                }
            }

            if string_copy(wep_name[wep], 0, 5) == "HYPER" && !UberCont.cskingot[8] {
                UberCont.cskingot[8] = 1
                show_unlock_popup(race_name[race] + " B-SKIN UNLOCKED#FOR EATING HYPER WEAPON")
                with instance_create(0, 0, UnlockScreen) {
                    race = 8;
                    skin = 1
                }
                scrAchievement(17)
            }

            if ultra == 2 && random(1) <= .4 {
                if random(max_hp) > hp and random(3) < 2 {
                    if crown_current != crwn_love {
                        instance_create(x, y, HealthChest)
                    }
					else instance_create(x, y, AmmoChest)
                }
				else if crown_current != crwn_love {
                    instance_create(x, y, choose(WeaponChest, AmmoChest))
                }
				else instance_create(x, y, AmmoChest)
            }

            with instance_create(x, y, RobotEat) {
				image_xscale = other.right
				creator = other.id
			}

            if random(max_hp) > hp {
                instance_create(x, y, HPPickup)
            }
			else instance_create(x, y, AmmoPickup)

            if curse {
                curse = 0
                hp -= 7
				
                repeat 10 {
					instance_create(x + random(16) - 8, y + random(16) - 8, Curse)
				}
				
				snd_play_hit_big(snd_hurt)
			}

            scrSwapWeps()
            bwep = 0

            if skill_get(5) {
                snd_play(sndRobotEatUpg)
                instance_create(x, y, AmmoPickup)
            }
			else snd_play(sndRobotEat)

            breload = 0
            instance_create(x, y, Smoke)

            UberCont.ctot_uniq[8]++
        }
    }



    //CHICKEN
    if race == 9 && KeyCont.press_spec[index] && wep {
        if !curse {
            snd_play(sndChickenThrow)

            with instance_create(x, y, WepPickup) {
                wep = other.wep
                name = wep_name[wep]
                type = wep_type[wep]
                sprite_index = wep_sprt[wep]
                curse = 0
                motion_add(other.gunangle, 16)
                team = other.team
                ammo = 0
                image_angle = direction

                if other.ultra == 2 {
                    alarm[1] = 90
                }

                creator = other.id
                mask_index = mskPlasma
            }

            reload = 0

            wep = 0
            scrSwapWeps()
        } else snd_play(sndCursedReminder)
    }

    //REBEL
    if race == 10 && KeyCont.press_spec[index] && hp > (1 + instance_exists(Ally)) {
        canrebel = 1

        if skill_get(5) {
            snd_play(sndSpawnSuperAlly)
        }

        with Ally {
            instance_create(x, y, HealFX)
            alarm[2] = 120
            hp = max_hp
            creator = other.id
        }

        sprite_index = spr_hurt
        image_index = 0

        hp -= 2 - (!instance_exists(Ally) && !ultra_get(2))

        repeat 1 + ultra_get(2) {
            with instance_create(x, y, Ally) {
                creator = other.id
            }
        }

        snd_play_hit(snd_hurt, .2)
        instance_create(x, y, Dust)
    }

    //RAD DOG
    if race == 11 {
        var cost = ceil(horrortime) + 1

        if KeyCont.press_spec[index] {
            if GameCont.rad < cost {
                snd_play(sndHorrorEmpty)
            } else snd_play(sndHorrorBeam)
        }


        if KeyCont.hold_spec[index] && GameCont.rad >= cost {
            horrortime += 0.03
            horrornorad = 40

            repeat round(horrortime + 1) {
                with instance_create(x, y, HorrorBullet) {
                    motion_add(other.gunangle, 12)
                    image_angle = direction

                    if other.bskin {
                        sprite_index = sprHorrorBullet2
                    }

                    var dir = random_angle
                    x += lengthdir_x(irandom(2 + other.horrortime), dir)
                    y += lengthdir_y(irandom(2 + other.horrortime), dir)

                    team = other.team
                }
            }

            if skill_get(5) && GameCont.tottimer % 30 == 0 && horrortime > 0.3 {
                var num = 1

                hp = min(hp + num, max_hp)

                dir = instance_create(x, y, PopupText)
                dir.mytext = "+" + string(num) + " HP"

                if hp >= max_hp {
                    dir.mytext = "MAX HP"
                }

                with instance_create(x, y, AnimParticle) {
                    sprite_index = sprHorrorTB
                    image_speed = 0.4

                    creator = other.id
                }
            }

            GameCont.rad -= cost

            if GameCont.rad < cost {
                snd_play(sndHorrorEmpty)

                if is_me {
                    if snd_is_playing(sndHorrorLoop) snd_stop(sndHorrorLoop)
                    if snd_is_playing(sndHorrorLoopTB) snd_stop(sndHorrorLoopTB)
                }
            }

            if is_me {
                if skill_get(5) {
                    if !snd_is_playing(sndHorrorLoopTB) snd_loop(sndHorrorLoopTB)
                } else if !snd_is_playing(sndHorrorLoop) snd_loop(sndHorrorLoop)
            }
        } else {
            horrortime = 0

            if is_me {
                if snd_is_playing(sndHorrorLoop) snd_stop(sndHorrorLoop)
                if snd_is_playing(sndHorrorLoopTB) snd_stop(sndHorrorLoopTB)
            }
        }
    }
	
    // Rogue
    if race == 12 && KeyCont.press_spec[index] && (!is_mobile(index) or player_pref(playerinstance, "rogue")) {
        var px = mouse_x,
            py = mouse_y

        if is_gamepad(index) or is_mobile(index) {
            px = x + lengthdir_x(64, KeyCont.dir_fire[index])
            py = y + lengthdir_y(64, KeyCont.dir_fire[index])
        }

        if rogue_ammo {
            with instance_create(px, py, PortalStrike) {
                creator = other.id
				event_perform(ev_step, 0)
			}

            rogue_ammo --
        }
		else if !snd_is_playing(sndPortalStrikeEmpty) {
            snd_play(sndPortalStrikeEmpty)
        }
    }

    // Big Dog
    if race == 13 && KeyCont.press_spec[index] && ammo[4] >= 3 {
        repeat 3 {
            with instance_create(x, y, BigDogMissile) {
                team = other.team
                creator = other.id
                motion_add(random_angle, 2)
                move_contact_solid(direction, 14)
            }
        }

        ammo[4] -= 3
        snd_play(sndBigDogMissile)
    }

    // Skeleton
    if race == 14 && KeyCont.press_spec[index] && can_shoot && !reload {
        if wep_cost[wep] {
            scrFire(wep, false)

            can_shoot = 0
            reload = wep_load[wep]

            if ultra_get(2) {
                reload = max(reload / 5, 1)
            }
			
			with instance_create(x, y, BulletHit) {
				sprite_index = sprBloodGamble
				image_angle = other.gunangle
				image_speed = 0.4
				
				depth = other.depth - 1
			}
			
			if wep_cost[wep] > 0
				skeletongamble ++
			
            if random(typ_ammo[wep_type[wep]] + (skill_get(5) * 12)) < wep_cost[wep] {
				projectile_hit_self(1)
				
				skeletongamble = 0
				
                repeat 3 {
                    with instance_create(x, y, BloodStreak) {
                        motion_add(random_angle, 2)
                        image_angle = direction
                    }
                }
            }
			
			if skeletongamble > UberCont.ctot_uniq[14]
				UberCont.ctot_uniq[14] = skeletongamble

            snd_play(sndBloodGamble)
        }
    }

    if instance_exists(TutCont) && TutCont.pos == 3 && !TutCont.doin && KeyCont.press_spec[index] {
        TutCont.alarm[0] = 30
        TutCont.doin = 1
    }
}

function scrMeltingCorpseExplosion() {
    with instance_create(x, y, BloodStreak) {
        motion_add(point_direction(other.x, other.y, x, y), 8)
        image_angle = direction
    }
    
    instance_create(x, y, MeltSplat)
    
    if skill_get(5) {
        ang = random_angle
		
		for(var i = 0; i <= 360; i += 120) {
			instance_create(x + lengthdir_x(24, ang + i), y + lengthdir_y(24, ang + i), MeatExplosion)
		}
    }
    
	if size >= 2 {
		var ang = random_angle
		
		for(var i = 0; i <= 360; i += 120) {
			instance_create(x + lengthdir_x(24, ang + i), y + lengthdir_y(24, ang + i), MeatExplosion)
		}
	}
	else instance_create(x, y, MeatExplosion)
	
    UberCont.ctot_uniq[4] ++
	
	snd_play(sndExplosion)
    
    if skill_get(5) {
		snd_play(sndCorpseExploUpg)
	}
	else snd_play(sndCorpseExplo)
    
    instance_destroy()
}