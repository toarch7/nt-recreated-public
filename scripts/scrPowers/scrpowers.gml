function scrPowers() {
    if instance_exists(TutorialCont) && TutorialCont.pos == 3 && !TutorialCont.doin {
        TutorialCont.alarm[0] = 30
        TutorialCont.doin = 1
    }

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
        } else snd_play(sndFishRollUpg)

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
        if KeyCont.hold_spec[index] {
            if skill_get(5) {
                if !snd_is_playing(sndEyesLoopUpg) snd_play(sndEyesLoopUpg)
            } else if !snd_is_playing(sndEyesLoop) snd_play(sndEyesLoop)
        } else {
            if skill_get(5) {
                if snd_is_playing(sndEyesLoopUpg) snd_stop(sndEyesLoopUpg)
            } else if snd_is_playing(sndEyesLoop) snd_stop(sndEyesLoop)
        }

        if KeyCont.hold_spec[index] && race == 3 {
            var bx1 = x - 213
            var by1 = y - 120
            var bx2 = x + 213
            var by2 = y + 120

            UberCont.ctot_uniq[3]++

            var strength = 1 + skill_get(5),
                dir, lx, ly

                with enemy {
                    if x > bx1 && y > by1 && x < bx2 && y < by2 {
                        dir = point_direction(x, y, other.x, other.y)
                        lx = lengthdir_x(strength, dir)
                        ly = lengthdir_y(strength, dir)

                        if !place_meeting(x + lx, y, Wall) x += lx
                        if !place_meeting(x, y + ly, Wall) y += ly
                    }
                }

            with Rad {
                if x > bx1 && y > by1 && x < bx2 && y < by2 {
                    dir = point_direction(x, y, other.x, other.y)
                    lx = lengthdir_x(strength, dir)
                    ly = lengthdir_y(strength, dir)

                    if !place_meeting(x + lx, y, Wall) x += lx
                    if !place_meeting(x, y + ly, Wall) y += ly
                }
            }

            with WepPickup {
                if x > bx1 && y > by1 && x < bx2 && y < by2 {
                    dir = point_direction(x, y, other.x, other.y)
                    lx = lengthdir_x(strength, dir)
                    ly = lengthdir_y(strength, dir)

                    if !place_meeting(x + lx, y, Wall) x += lx
                    if !place_meeting(x, y + ly, Wall) y += ly
                }
            }

            with BigRad {
                if x > bx1 && y > by1 && x < bx2 && y < by2 {
                    dir = point_direction(x, y, other.x, other.y)
                    lx = lengthdir_x(strength, dir)
                    ly = lengthdir_y(strength, dir)

                    if !place_meeting(x + lx, y, Wall) x += lx
                    if !place_meeting(x, y + ly, Wall) y += ly
                }
            }

            with HPPickup {
                if x > bx1 && y > by1 && x < bx2 && y < by2 {
                    dir = point_direction(x, y, other.x, other.y)
                    lx = lengthdir_x(strength, dir)
                    ly = lengthdir_y(strength, dir)

                    if !place_meeting(x + lx, y, Wall) x += lx
                    if !place_meeting(x, y + ly, Wall) y += ly
                }
            }

            with AmmoPickup {
                if x > bx1 && y > by1 && x < bx2 && y < by2 {
                    dir = point_direction(x, y, other.x, other.y)
                    lx = lengthdir_x(strength, dir)
                    ly = lengthdir_y(strength, dir)

                    if !place_meeting(x + lx, y, Wall) x += lx
                    if !place_meeting(x, y + ly, Wall) y += ly
                }
            }

            with RadChest {
                if x > bx1 && y > by1 && x < bx2 && y < by2 {
                    dir = point_direction(x, y, other.x, other.y)
                    lx = lengthdir_x(strength, dir)
                    ly = lengthdir_y(strength, dir)

                    if !place_meeting(x + lx, y, Wall) x += lx
                    if !place_meeting(x, y + ly, Wall) y += ly
                }
            }

            with RadChestBig {
                if x > bx1 && y > by1 && x < bx2 && y < by2 {
                    dir = point_direction(x, y, other.x, other.y)
                    lx = lengthdir_x(strength, dir)
                    ly = lengthdir_y(strength, dir)

                    if !place_meeting(x + lx, y, Wall) x += lx
                    if !place_meeting(x, y + ly, Wall) y += ly
                }
            }

            with BigRad {
                if x > bx1 && y > by1 && x < bx2 && y < by2 {
                    dir = point_direction(x, y, other.x, other.y)
                    lx = lengthdir_x(strength, dir)
                    ly = lengthdir_y(strength, dir)

                    if !place_meeting(x + lx, y, Wall) x += lx
                    if !place_meeting(x, y + ly, Wall) y += ly
                }
            }

            with chestprop {
                if x > bx1 && y > by1 && x < bx2 && y < by2 {
                    dir = point_direction(x, y, other.x, other.y)
                    lx = lengthdir_x(strength, dir)
                    ly = lengthdir_y(strength, dir)

                    if !place_meeting(x + lx, y, Wall) x += lx
                    if !place_meeting(x, y + ly, Wall) y += ly
                }
            }

            with projectile
            if team != other.team {
                if x > bx1 && y > by1 && x < bx2 && y < by2 {
                    dir = point_direction(other.x, other.y, x, y)
                    x += lengthdir_x(strength, dir)
                    y += lengthdir_y(strength, dir)
                }
            }
        }
    }

    //MELTING
    if KeyCont.press_spec[index] && race == 4 {
        var bx1 = x - 213
        var by1 = y - 120
        var bx2 = x + 213
        var by2 = y + 120

        with Corpse {
            if image_speed <= 0 && (instance_number(enemy) > 0 or instance_exists(Portal)) && x > bx1 && x < bx2 && y > by1 && y < by2 {
                snd_play(sndExplosion)

                if skill_get(5) snd_play(sndCorpseExploUpg)
                else snd_play(sndCorpseExplo)

                instance_destroy()
                with instance_create(x, y, BloodStreak) {
                    motion_add(point_direction(other.x, other.y, x, y), 8)
                    image_angle = direction
                }

                instance_create(x, y, MeltSplat)

                if skill_get(5) {
                    ang = random(360)
                    instance_create(x + lengthdir_x(24, ang), y + lengthdir_y(24, ang), MeatExplosion)
                    instance_create(x + lengthdir_x(24, ang + 120), y + lengthdir_y(24, ang + 120), MeatExplosion)
                    instance_create(x + lengthdir_x(24, ang + 240), y + lengthdir_y(24, ang + 240), MeatExplosion)
                }

                if size >= 2 {
                    var ang = random(360)

                    repeat 3 {
                        instance_create(x + lengthdir_x(24, ang), y + lengthdir_y(24, ang), MeatExplosion)
                        ang += 120
                    }
                } else instance_create(x, y, MeatExplosion)

                UberCont.ctot_uniq[4]++
            }
        }

        if ultra == 1 {
            with enemy {
                if hp <= 5 && instance_number(enemy) > 1 && x > bx1 && x < bx2 && y > by1 && y < by2 {
                    snd_play(sndExplosion)

                    if skill_get(5) snd_play(sndCorpseExploUpg)
                    else snd_play(sndCorpseExplo)

                    instance_destroy()
                    with instance_create(x, y, BloodStreak) {
                        motion_add(point_direction(other.x, other.y, x, y), 8)
                        image_angle = direction
                    }

                    instance_create(x, y, Scorchmark)

                    if skill_get(5) {
                        ang = random(360)
                        instance_create(x + lengthdir_x(24, ang), y + lengthdir_y(24, ang), MeatExplosion)
                        instance_create(x + lengthdir_x(24, ang + 120), y + lengthdir_y(24, ang + 120), MeatExplosion)
                        instance_create(x + lengthdir_x(24, ang + 240), y + lengthdir_y(24, ang + 240), MeatExplosion)
                    }

                    UberCont.ctot_uniq[4]++instance_create(x, y, MeatExplosion)
                }
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
    var yvmobilepopping = race == 6 && scrYVCanPop(wep) && KeyCont.activeforever[index] && KeyCont.press_fire[index]
    if race == 6 && can_shoot && (((UberCont.opt_keyboard or UberCont.opt_gamepad) && KeyCont.press_spec[index]) or yvmobilepopping) {
        if scrYVCanPop(wep) {
            if ammo[wep_type[wep]] < wep_cost[wep] * (2 + skill_get(5) * 2) && wep_type[wep] != 0 && GameCont.rad >= wep_rads[wep] {
                scrEmpty()
            }

            if ammo[wep_type[wep]] >= wep_cost[wep] * (2 + skill_get(5) * 2) && GameCont.rad >= wep_rads[wep] {
                if ultra_get(2) {
                    scrFire(wep, 1)

                    can_shoot = 1
                    ammo[wep_type[wep]] += wep_cost[wep]
                }

                repeat 2 + skill_get(5) * 2 {
                    scrFire(wep, 1)

                    can_shoot = 1
                }

                if speed > 5 speed = 5

                can_shoot = 0

                if skill_get(5) = 1 snd_play(sndPopPopUpg)
                else snd_play(sndPopPop)

                reload *= 2 + skill_get(5) * 1.4
                motion_add(gunangle + 180, 4)
                BackCont.viewx2 += lengthdir_x(8, gunangle)
                BackCont.viewy2 += lengthdir_y(8, gunangle)
                BackCont.shake += 1

                if yvmobilepopping clicked = 0
            }
        } else snd_play(sndMutant6Melee)
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
                if random(Player.max_hp) > Player.hp and random(3) < 2 {
                    if GameCont.crown != 9 {
                        instance_create(x, y, HealthChest)
                    } else instance_create(x, y, AmmoChest)
                } else if GameCont.crown != 9 {
                    instance_create(x, y, choose(WeaponChest, AmmoChest))
                } else instance_create(x, y, AmmoChest)
            }

            with instance_create(x, y, RobotEat)
            image_xscale = Player.right

            if random(max_hp) > hp {
                instance_create(x, y, HPPickup)
            } else instance_create(x, y, AmmoPickup)

            if curse {
                curse = 0
                hp -= 7
                repeat(10) instance_create(x + random(16) - 8, y + random(16) - 8, Curse)
            }

            scrSwapWeps()
            bwep = 0

            if skill_get(5) = 1 {
                snd_play(sndRobotEatUpg)
                instance_create(x, y, AmmoPickup)
            } else snd_play(sndRobotEat)

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
                name = other.wep_name[wep]
                type = other.wep_type[wep]
                sprite_index = other.wep_sprt[wep]
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

                    var dir = random(360)
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

    // ROUGE
    if race == 12 && KeyCont.press_spec[index] && (UberCont.opt_gamepad or UberCont.opt_keyboard) {
        var px = mouse_x,
            py = mouse_y

        if KeyCont.gamepad[index] {
            px = x + lengthdir_x(64, KeyCont.dir_fire[index])
            py = y + lengthdir_y(64, KeyCont.dir_fire[index])
        }

        if rogue_ammo {
            with instance_create(px, py, PortalStrike) {
                creator = other.id
            }

            rogue_ammo--
        } else if !snd_is_playing(sndPortalStrikeEmpty) {
            snd_play(sndPortalStrikeEmpty)
        }
    }

    //DIG BOG
    if race == 13 && KeyCont.press_spec[index] && ammo[4] >= 3 {
        repeat 3 {
            with instance_create(x, y, BigDogMissile) {
                team = other.team
                creator = other.id
                motion_add(random(360), 2)
                move_contact_solid(direction, 14)
            }
        }

        ammo[4] -= 3
        snd_play(sndBigDogMissile)
    }

    //SPOOKY
    if race == 14 && KeyCont.press_spec[index] && can_shoot && !reload {
        if wep_cost[wep] {
            scrFire(wep, 0)
            ammo[wep_type[wep]] += wep_cost[wep]

            can_shoot = 0
            reload = wep_load[wep]

            if ultra_get(2) {
                reload /= 5
                reload = max(reload, 1)
            }

            if random(typ_ammo[wep_type[wep]] + (skill_get(5) * 12)) < wep_cost[wep] {
                sprite_index = spr_hurt
                image_index = 0
                hp -= 1

                repeat 3 {
                    with instance_create(x, y, BloodStreak) {
                        motion_add(random(360), 2)
                        image_angle = direction
                    }
                }

                snd_play(snd_hurt)
            }

            snd_play(sndBloodGamble)
        }
    }

    if instance_exists(TutorialCont) && TutorialCont.pos == 3 && !TutorialCont.doin && KeyCont.press_spec[index] {
        TutorialCont.alarm[0] = 30
        TutorialCont.doin = 1
    }
}