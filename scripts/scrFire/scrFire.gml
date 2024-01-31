function scrFire(wep, useAmmo = true) {
	reload = wep_load[wep]
	can_shoot = 0
    
    var oldviewx2 = BackCont.viewx2,
		oldviewy2 = BackCont.viewy2,
		oldshake = BackCont.shake
	
    if race == 7 && skill_get(mut_throne_butt) && (random(typ_ammo[wep_type[wep]]) < wep_cost[wep]) && ((random(2) < 1 or !bcan_shoot) && random(3) < 2) {
		var typ = wep_type[bwep]
		
        if typ > 0 {
            var amount = ceil(typ_ammo[typ] / 2),
                popup = instance_create(x, y, PopupText)
			
            with popup {
			    mytext = "+" + string(amount) + " " + loc(typ_name[typ])
            }
			
            ammo[typ] += amount
			
            if ammo[typ] > typ_amax[typ] {
                popup.mytext = loc_sfmt("MAX %", loc(typ_name[typ]))
                ammo[typ] = typ_amax[typ]
            }
        }
    }
	
    if wep_type[wep] == 5 && skill_get(mut_laser_brain) {
        repeat wep_cost[wep] {
            with instance_create(x, y, AnimParticle) {
                image_speed = 0.4 - random(0.1)
                creator = other.id
                image_angle = random_angle
                depth = other.depth - 1
                sprite_index = sprLaserBrain
            }
        }
    }
	
    if !infammo && useAmmo {
        ammo[wep_type[wep]] -= wep_cost[wep]
		
        if GameCont.rad >= wep_rads[@ wep]
            GameCont.rad -= wep_rads[@ wep]
    }

    if wep_type[wep] != 0 {
        drawempty = 10
    }

    // snd_play_gun already plays the normal oasis
    // shoot sound when in oasis 
    if GameCont.area == 101 && wep_type[wep] == 0 {
        snd_play_gun(sndOasisMelee)
    }

    //REVOLVER
    if wep == 1 {
        snd_play_gun(sndPistol)

        with instance_create(x, y, Shell)
			motion_add(other.gunangle + other.right * 100 + random(50) - 25, 2 + random(2))

        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle + (random(8) - 4) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(6, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(6, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 2
    }

    //TRIPLE MACHINEGUN
    if wep == 2 {
        snd_play_gun(sndTripleMachinegun)

        repeat(3) {
            with instance_create(x, y, Shell)
            motion_add(other.gunangle + other.right * 100 + random(70) - 35, 2 + random(2))
        }

        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle + (random(6) - 3) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle + 15 * other.accuracy + (random(6) - 3) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle - 15 * other.accuracy + (random(6) - 3) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(8, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(8, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 6
    }

    //WRENCH
    if wep == 3 {
        snd_play_gun(sndWrench)

        instance_create(x, y, Dust)

        with instance_create(x + lengthdir_x(skill_get(13) * 12, gunangle), y + lengthdir_y(skill_get(13) * 12, gunangle), Slash) {
            dmg = 8
            longarms = 0
            if instance_exists(Player) longarms = skill_get(13) * 2
            motion_add(other.gunangle, 2 + longarms)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        wepangle = -wepangle
        motion_add(gunangle, 6)
        BackCont.viewx2 += lengthdir_x(12, gunangle) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(12, gunangle) * UberCont.opt_shake
        BackCont.shake += 1
        wkick = -4
    }

    //MACHINEGUN
    if wep == 4 {
        snd_play_gun(sndMachinegun)
        with instance_create(x, y, Shell)
        motion_add(other.gunangle + other.right * 100 + random(50) - 25, 2 + random(2))

        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle + (random(12) - 6) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(6, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(6, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 3
        wkick = 2
    }

    //SHOTGUN
    if wep == 5 {
        snd_play_gun(sndShotgun)

        repeat(7) {
            with instance_create(x, y, Bullet2) {
                motion_add(other.gunangle + (random(40) - 20) * other.accuracy, 12 + random(6))
                image_angle = direction
                team = other.team;
                creator = other.id
            }
        }

        BackCont.viewx2 += lengthdir_x(12, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(12, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 8
        wkick = 6
    }


    //CROSSBOW
    if wep == 6 {
        snd_play_gun(sndCrossbow)

        with instance_create(x, y, Bolt) {
            motion_add(other.gunangle, 24)
            image_angle = direction
            team = other.team
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(40, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(40, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 4
    }

    //NADER
    if wep == 7 {
        snd_play_gun(sndGrenade)

        with instance_create(x, y, Grenade) {
            sticky = 0
            motion_add(other.gunangle + (random(6) - 3) * other.accuracy, 10)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 5
    }

    //DOUBLE SHOTGUN
    if wep == 8 {
        snd_play_gun(sndDoubleShotgun)

        repeat(14) {
            with instance_create(x, y, Bullet2) {
                motion_add(other.gunangle + (random(50) - 30) * other.accuracy, 12 + random(6))
                image_angle = direction
                team = other.team;
                creator = other.id
            }
        }

        motion_add(other.gunangle + 180, 2)

        BackCont.viewx2 += lengthdir_x(15, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(15, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 16
        wkick = 8
    }

    //MINIGUN
    if wep == 9 {
        snd_play_gun(sndMinigun)
        with instance_create(x, y, Shell)
        motion_add(other.gunangle + other.right * 100 + random(80) - 40, 3 + random(2))

        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle + (random(26) - 13) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        motion_add(other.gunangle + 180, 0.6)
        BackCont.viewx2 += lengthdir_x(7, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(7, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 4
    }

    //AUTO SHOTGUN
    if wep == 10 {
        snd_play_gun(sndShotgun)

        repeat(6) {
            with instance_create(x, y, Bullet2) {
                motion_add(other.gunangle + (random(30) - 15) * other.accuracy, 12 + random(6))
                image_angle = direction
                team = other.team;
                creator = other.id
            }
        }

        BackCont.viewx2 += lengthdir_x(12, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(12, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 8
        wkick = 5
    }

    //AUTO CROSSBOW
    if wep == 11 {
        snd_play_gun(sndCrossbow)

        with instance_create(x, y, Bolt) {
            motion_add(other.gunangle + (random(8) - 4) * other.accuracy, 24)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(40, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(40, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 5
        wkick = 4
    }

    //SUPER CROSSBOW
    if wep == 12 {
        snd_play_gun(sndSuperCrossbow)

        with instance_create(x, y, Bolt) {
            motion_add(other.gunangle, 24)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Bolt) {
            motion_add(other.gunangle + 5 * other.accuracy, 24)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Bolt) {
            motion_add(other.gunangle - 5 * other.accuracy, 24)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Bolt) {
            motion_add(other.gunangle + 10 * other.accuracy, 24)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Bolt) {
            motion_add(other.gunangle - 10 * other.accuracy, 24)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        motion_add(other.gunangle + 180, 1)

        BackCont.viewx2 += lengthdir_x(60, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(60, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 14
        wkick = 8
    }


    //SHOVEL
    if (wep == 13) {
        snd_play_gun(sndShovel, 0.2)
        instance_create(x, y, Dust)
        with(instance_create((x + lengthdir_x((skill_get(13) * 20), other.gunangle)), (y + lengthdir_y((skill_get(13) * 20), other.gunangle)), Slash)) {
            dmg = 16
            longarms = 0
            longarms = skill_get(13) * 3
            sprite_index = sprHeavySlash
            motion_add(other.gunangle, (3 + longarms))
            image_angle = direction
            team = other.team
        }
        with(instance_create((x + lengthdir_x((skill_get(13) * 15), (other.gunangle + (60 * accuracy)))), (y + lengthdir_y((skill_get(13) * 15), (other.gunangle + (60 * accuracy)))), Slash)) {
            dmg = 16
            longarms = 0
            longarms = skill_get(13) * 3
            sprite_index = sprHeavySlash
            motion_add((other.gunangle + (60 * other.accuracy)), (2 + longarms))
            image_angle = direction
            team = other.team
        }
        with(instance_create((x + lengthdir_x((skill_get(13) * 15), (other.gunangle - (60 * accuracy)))), (y + lengthdir_y((skill_get(13) * 15), (other.gunangle - (60 * accuracy)))), Slash)) {
            dmg = 16
            longarms = 0
            longarms = skill_get(13) * 3
            sprite_index = sprHeavySlash
            motion_add((other.gunangle - (60 * other.accuracy)), (2 + longarms))
            image_angle = direction
            team = other.team
        }

        wepangle *= -1
        motion_add(other.gunangle, 6)
        BackCont.viewx2 += (lengthdir_x(24, other.gunangle) * UberCont.opt_shake)
        BackCont.viewy2 += (lengthdir_y(24, other.gunangle) * UberCont.opt_shake)
        BackCont.shake += 1
        wkick = -4
    }

    //BAZOOKA
    if wep == 14 or wep == 102 or wep == 84 {
        snd_play_gun(sndRocket)

        with instance_create(x, y, Rocket) {
            motion_add(other.gunangle + (random(4) - 2) * other.accuracy, 2)
            image_angle = direction
            team = other.team;
            creator = other.id
            if other.wep == 102 sprite_index = sprGoldRocket
        }

        BackCont.viewx2 += lengthdir_x(30, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(30, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 10
    }

    // STICKY NADER
    if wep == 15 {
        snd_play_gun(sndGrenade)

        with instance_create(x, y, Grenade) {
            sprite_index = sprStickyGrenade
            sticky = 1
            motion_add(other.gunangle + (random(6) - 3) * other.accuracy, 11)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 5
    }

    //SMG
    if wep == 16 {
        snd_play_gun(sndPistol)
        with instance_create(x, y, Shell)
        motion_add(other.gunangle + other.right * 100 + random(60) - 30, 2 + random(2))

        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle + (random(32) - 16) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(6, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(6, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 3
        wkick = 2
    }



    //ASSAULT RIFLE
    if wep == 17 or wep == 103 {
        with instance_create(x, y, Burst) {
            creator = other.id
            ammo = 3
            time = 2
            team = other.team;
            creator = other.id
            event_perform(ev_alarm, 0)
        }
    }


    //DISC GUN
    if wep == 18 {
        snd_play_gun(sndDiscgun)

        with instance_create(x, y, Disc) {
            motion_add(other.gunangle + (random(10) - 5) * other.accuracy, 5)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 6
        wkick = 4
    }


    //LASER PISTOL
    if wep == 19 {

        if skill_get(17) snd_play_gun(sndLaserUpg)
        else snd_play_gun(sndLaser)
        with instance_create(x, y, Laser) {
            image_angle = other.gunangle + (random(2) - 1) * other.accuracy
            team = other.team;
            creator = other.id
            event_perform(ev_alarm, 0)
        }

        BackCont.viewx2 += lengthdir_x(3, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(3, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 2
    }


    //LASER RIFLE
    if wep == 20 {
        if skill_get(17) snd_play_gun(sndLaserUpg)
        else snd_play_gun(sndLaser)
        with instance_create(x, y, Laser) {
            image_angle = other.gunangle + (random(6) - 3) * other.accuracy
            team = other.team;
            creator = other.id
            event_perform(ev_alarm, 0)
        }

        BackCont.viewx2 += lengthdir_x(3, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(3, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 5
    }


    //SLUGGER
    if wep == 21 or wep == 99 {
        snd_play_gun(sndSlugger)

        with instance_create(x, y, Slug) {
            motion_add(other.gunangle + (random(10) - 5) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(14, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(14, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 10
        wkick = 8
    }

    //GATLING SLUGGER
    if wep == 22 {
        snd_play_gun(sndSlugger)

        with instance_create(x, y, Slug) {
            motion_add(other.gunangle + (random(12) - 6) * other.accuracy, 18)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 10
        wkick = 8
    }

    //ASSAULT SLUGGER
    if wep == 23 {
        with instance_create(x, y, SlugBurst) {
            creator = other.id
            ammo = 3
            time = 3
            team = other.team;
            creator = other.id
            event_perform(ev_alarm, 0)
        }
    }

    //ENERGY SWORD
    if wep == 24 {

        if skill_get(17) snd_play_gun(sndLaserSwordUpg)
        else snd_play_gun(sndLaserSword)
        instance_create(x, y, Dust)

        with instance_create(x + lengthdir_x(skill_get(13) * 12, gunangle), y + lengthdir_y(skill_get(13) * 12, gunangle), EnergySlash) {
            longarms = 0
            if instance_exists(Player) longarms = skill_get(13) * 2
            motion_add(other.gunangle, 2 + longarms)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        wepangle = -wepangle
        motion_add(other.gunangle, 7)
        BackCont.viewx2 += lengthdir_x(24, gunangle) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(24, gunangle) * UberCont.opt_shake
        BackCont.shake += 1
        wkick = -4
    }

    //SUPER SLUGGER
    if wep == 25 {
        snd_play_gun(sndSuperSlugger)

        motion_add(other.gunangle + 180, 3)

        with instance_create(x, y, Slug) {
            motion_add(other.gunangle + (random(8) - 4) * other.accuracy, 18)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Slug) {
            motion_add(other.gunangle + 10 * other.accuracy + (random(8) - 4) * other.accuracy, 18)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Slug) {
            motion_add(other.gunangle + 20 * other.accuracy + (random(8) - 4) * other.accuracy, 18)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Slug) {
            motion_add(other.gunangle - 10 * other.accuracy + (random(8) - 4) * other.accuracy, 18)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Slug) {
            motion_add(other.gunangle - 20 * other.accuracy + (random(8) - 4) * other.accuracy, 18)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 15
        wkick = 8
    }

    //HYPER RIFLE
    if wep == 26 {
        snd_play_gun(sndHyperRifle)
		
        with instance_create(x, y, Burst) {
            creator = other.id
            ammo = 6
            time = 1
            team = other.team;
            creator = other.id
            event_perform(ev_alarm, 0)
        }
    }



    //MINES
    /*
	if wep == 27
	{
	snd_play_gun(sndGrenade)

	with instance_create(x,y,Mine)
	{
	motion_add(other.gunangle+(random(30)-15)*other.accuracy,4)
	team = other.team; creator = other.id}

	BackCont.viewx2 += lengthdir_x(5,gunangle)
	BackCont.viewy2 += lengthdir_y(5,gunangle)
	wkick = 8
	}*/

    //SCREWDRIVER
    if wep == 27 or wep == 101 {
        snd_play_gun(sndScrewdriver)

        instance_create(x, y, Dust)

        with instance_create(x + lengthdir_x(skill_get(13) * 10, gunangle), y + lengthdir_y(skill_get(13) * 10, gunangle), Shank) {
            longarms = 0
            if instance_exists(Player) longarms = skill_get(13) * 2
            motion_add(other.gunangle + (random(10) - 5) * other.accuracy, 3 + longarms)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        wepangle = -wepangle
        motion_add(gunangle, 4)
        BackCont.viewx2 += lengthdir_x(12, gunangle) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(12, gunangle) * UberCont.opt_shake
        BackCont.shake += 1
        wkick = -8
    }

    //LASER MINIGUN
    if wep == 28 {
        if skill_get(17) snd_play_gun(sndLaserUpg)
        else snd_play_gun(sndLaser)
        with instance_create(x, y, Laser) {
            image_angle = other.gunangle + (random(24) - 12) * other.accuracy
            team = other.team;
            creator = other.id
            event_perform(ev_alarm, 0)
        }

        BackCont.viewx2 += lengthdir_x(5, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(5, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 8

        motion_add(other.gunangle + 180, 0.6)
    }


    //BLOOD NADER
    if wep == 29 {
        snd_play_gun(sndBloodLauncher)

        with instance_create(x, y, BloodGrenade) {
            sticky = 0
            motion_add(other.gunangle + (random(12) - 6) * other.accuracy, 10)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(5, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(5, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 3
        wkick = 4
    }

    //SPLINTER GUN
    if wep == 30 or wep == 100 {
        snd_play_gun(sndSplinterGun, 0.2)

        repeat 3 {
            with instance_create(x, y, Splinter) {
                motion_add(other.gunangle + orandom(10) * other.accuracy, 20 + random(4))
                image_angle = direction
                team = other.team
            }
        }

        repeat 2 {
            with instance_create(x, y, Splinter) {
                motion_add(other.gunangle + orandom(5) * other.accuracy, 20 + random(4))
                image_angle = direction
                team = other.team
            }
        }

        BackCont.viewx2 += lengthdir_x(15, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(15, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 3
        wkick = 3
    }


    //TOXIC BOW
    if wep == 31 {
        snd_play_gun(sndCrossbow)

        with instance_create(x, y, ToxicBolt) {
            motion_add(other.gunangle, 22)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(40, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(40, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 5
        wkick = 4
    }

    //SENTRY GUN
    if wep == 32 {
        snd_play_gun(sndGrenade)

        with instance_create(x, y, SentryGun) {
            sticky = 0
            team = other.team
            creator = other.id

            image_angle = direction
            motion_add(other.gunangle, 6)
        }

        BackCont.viewx2 += lengthdir_x(5, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(5, gunangle + 180) * UberCont.opt_shake

        wkick = -10
    }

    //WAVE GUN
    if wep == 33 {
        with instance_create(x, y, WaveBurst) {
            creator = other.id
            ammo = 7
            time = 1
            team = other.team;
            creator = other.id
            event_perform(ev_alarm, 0)
        }
    }

    //PLASMA GUN
    if wep == 34 or wep == 98 {
        if skill_get(17) snd_play_gun(sndPlasmaUpg)
        else snd_play_gun(sndPlasma)

        with instance_create(x, y, PlasmaBall) {
            motion_add(other.gunangle + (random(8) - 4) * other.accuracy, 2)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        motion_add(other.gunangle + 180, 3)
        BackCont.viewx2 += lengthdir_x(3, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(3, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 3
        wkick = 5
    }

    //PLASMA CANNON
    if wep == 35 {
        if skill_get(17) snd_play_gun(sndPlasmaBigUpg)
        else snd_play_gun(sndPlasmaBig)

        with instance_create(x, y, PlasmaBig) {
            motion_add(other.gunangle + (random(4) - 2) * other.accuracy, 2)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        motion_add(other.gunangle + 180, 6)
        BackCont.viewx2 += lengthdir_x(8, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(8, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 8
        wkick = 10
    }

    //ENERGY HAMMER
    if wep == 36 {

        if skill_get(17) snd_play_gun(sndEnergyHammerUpg)
        else snd_play_gun(sndEnergyHammer)
        instance_create(x, y, Dust)

        with instance_create(x, y, EnergyHammerSlash) {
			longarms = skill_get(13) * 2
			
			motion_add(other.gunangle, 1 + longarms)
			
			if longarms {
				x += ldrx(12, direction)
				y += ldry(12, direction)
			}
			
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        wepangle = -wepangle
        motion_add(other.gunangle, 7)
        BackCont.viewx2 += lengthdir_x(32, gunangle) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(32, gunangle) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = -3
    }

    //JACKHAMMER
    if wep == 37 {
        with instance_create(x, y, SawBurst) {
            creator = other.id
            ammo = 12
            time = 1
            team = other.team;
            creator = other.id
            event_perform(ev_alarm, 0)
        }
    }

    //FLAK CANNON
    if wep == 38 {
        snd_play_gun(sndFlakCannon)

        with instance_create(x, y, FlakBullet) {
            motion_add(other.gunangle + (random(12) - 6) * other.accuracy, 11 + random(2))
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(32, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(32, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 7
    }


    //GOLDEN REVOLVER
    if wep == 39 {
        snd_play_gun(sndGoldPistol)

        with instance_create(x, y, Shell)
        motion_add(other.gunangle + other.right * 100 + random(50) - 25, 2 + random(2))

        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle + (random(8) - 4) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(8, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(8, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 5
        wkick = 4
    }

    //GOLDEN WRENCH
    if wep == 40 {
        snd_play_gun(sndGoldWrench)

        instance_create(x, y, Dust)

        with instance_create(x + lengthdir_x(skill_get(13) * 12, gunangle), y + lengthdir_y(skill_get(13) * 12, gunangle), Slash) {
            dmg = 8
            longarms = 0
            if instance_exists(Player) longarms = skill_get(13) * 2
            motion_add(other.gunangle, 2 + longarms)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        wepangle = -wepangle
        motion_add(gunangle, 6)
        BackCont.viewx2 += lengthdir_x(16, gunangle) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(16, gunangle) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = -6
    }


    //GOLDEN MACHINEGUN
    if wep == 41 {
        snd_play_gun(sndGoldMachinegun, 0.2)
        with instance_create(x, y, Shell)
        motion_add(other.gunangle + other.right * 100 + random(50) - 25, 2 + random(2))

        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle + (random(8) - 4) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(8, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(8, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 4
    }


    //GOLDEN SHOTGUN
    if wep == 42 {
        snd_play_gun(sndGoldShotgun)

        repeat(8) {
            with instance_create(x, y, Bullet2) {
                motion_add(other.gunangle + (random(40) - 20) * other.accuracy, 12 + random(6))
                image_angle = direction
                team = other.team;
                creator = other.id
            }
        }

        BackCont.viewx2 += lengthdir_x(16, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(16, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 10
        wkick = 8
    }



    //GOLDEN CROSSBOW
    if wep == 43 {
        snd_play_gun(sndGoldCrossbow)

        with instance_create(x, y, Bolt) {
            motion_add(other.gunangle, 24)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(44, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(44, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 6
        wkick = 6
    }

    //GOLDEN NADER
    if wep == 44 {
        snd_play_gun(sndGoldGrenade)

        with instance_create(x, y, Grenade) {
            sprite_index = sprGoldGrenade
            sticky = 0
            motion_add(other.gunangle, 12)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(12, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(12, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 7
    }

    //GOLDEN LASER PISTOL
    if wep == 45 {

        if skill_get(17) snd_play_gun(sndGoldLaserUpg)
        else snd_play_gun(sndGoldLaser)
        with instance_create(x, y, Laser) {
            image_angle = other.gunangle
            team = other.team;
            creator = other.id
            event_perform(ev_alarm, 0)
        }

        BackCont.viewx2 += lengthdir_x(6, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(6, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 4
    }


    //CHICKEN SWORD
    if wep == 46 {
        snd_play_gun(sndChickenSword)

        instance_create(x, y, Dust)
        instance_create(x, y, Dust)

        with instance_create(x + lengthdir_x(skill_get(13) * 12, gunangle), y + lengthdir_y(skill_get(13) * 12, gunangle), Slash) {
            ang = other.gunangle
            dmg = 6
            longarms = 0
            if instance_exists(Player) longarms = skill_get(13) * 2
            motion_add(ang, 2 + longarms)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        wepangle = -wepangle
        motion_add(gunangle, 4)
        BackCont.viewx2 += lengthdir_x(8, gunangle) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(8, gunangle) * UberCont.opt_shake
        BackCont.shake += 1
        wkick = -6
    }


    //NUKE LAUNCHER
    if wep == 47 {
        snd_play_gun(sndNuke)

        with instance_create(x, y, Nuke) {
            motion_add(other.gunangle + (random(4) - 2) * other.accuracy, 2)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(40, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(40, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 8
        wkick = 10
    }

    //ION CANNON
    if wep == 48 {

        if skill_get(17) snd_play_gun(sndLaserUpg)
        else snd_play_gun(sndLaser)
        with instance_create(x, y, IonBurst) {
            creator = other.id
            ammo = 10
            time = 1
            hit_id = other.spr_idle
            team = other.team;
            creator = other.id
            alarm[0] = 30
        }

        BackCont.shake += 6
        wkick = 3
    }


    //QUADRUPLE MACHINEGUN
    if wep == 49 {
        snd_play_gun(sndTripleMachinegun)

        repeat(4) {
            with instance_create(x, y, Shell)
            motion_add(other.gunangle + other.right * 100 + random(70) - 35, 4 + random(3))
        }

        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle + 6 * other.accuracy + (random(6) - 3) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle - 6 * other.accuracy + (random(6) - 3) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle + 18 * other.accuracy + (random(6) - 3) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle - 18 * other.accuracy + (random(6) - 3) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 6
        wkick = 8
    }

    //FLAMETHROWER
    if wep == 50 {
        if !instance_exists(FlameSound) instance_create(x, y, FlameSound)
        with instance_create(x, y, FlameBurst) {
            creator = other.id
            ammo = 12
            time = 1
            team = other.team;
            creator = other.id
            event_perform(ev_alarm, 0)
        }
    }

    //DRAGON
    if wep == 51 {
        if !instance_exists(DragonSound) instance_create(x, y, DragonSound)
        with instance_create(x, y, DragonBurst) {
            creator = other.id
            ammo = 7
            time = 1
            team = other.team;
            creator = other.id
            event_perform(ev_alarm, 0)
        }
    }


    //FLARE GUN
    if wep == 52 {
        snd_play_gun(sndFlare)

        with instance_create(x, y, Flare) {
            sticky = 0
            motion_add(other.gunangle + (random(14) - 7) * other.accuracy, 9)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 5
        wkick = 5
    }


    //ENERGY SCREWDRIVER
    if wep == 53 {
        if skill_get(17) snd_play_gun(sndEnergyScrewdriverUpg)
        else snd_play_gun(sndEnergyScrewdriver)

        instance_create(x, y, Dust)

        with instance_create(x + lengthdir_x(skill_get(13) * 10, gunangle), y + lengthdir_y(skill_get(13) * 10, gunangle), EnergyShank) {
            longarms = 0
            if instance_exists(Player) longarms = skill_get(13) * 2
            motion_add(other.gunangle + (random(10) - 5) * other.accuracy, 3 + longarms)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        wepangle = -wepangle
        motion_add(other.gunangle, 5)
        BackCont.viewx2 += lengthdir_x(12, gunangle) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(12, gunangle) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = -8
    }


    //HYPER LAUNCHER
    if wep == 54 {
        snd_play_gun(sndHyperLauncher)

        with instance_create(x, y, HyperGrenade) {
            direction = other.gunangle + (random(4) - 2) * other.accuracy
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(20, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(20, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 8
    }

    //LASER CANNON
    if wep == 55 {


        snd_play_gun(sndLaserCannonCharge)

        with instance_create(x, y, LaserCannon) {
            creator = other.id
            ammo = 3 + skill_get(17) * 2
            time = 1
            team = other.team;
            creator = other.id
            alarm[0] = 10
        }
    }


    //RUSTY REVOLVER
    if wep == 56 {
        snd_play_gun(sndRustyRevolver)

        with instance_create(x, y, Shell)
        motion_add(other.gunangle + other.right * 100 + random(50) - 25, 2 + random(2))

        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(8, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(8, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 5
        wkick = 4
    }


    //LIGHTNING PISTOL
    if wep == 57 {

        if skill_get(17) snd_play_gun(sndLightningPistolUpg)
        else snd_play_gun(sndLightningPistol)


        with instance_create(x, y, Lightning) {
            image_angle = other.gunangle + (random(30) - 15) * other.accuracy
            team = other.team;
            creator = other.id
            ammo = 14
            event_perform(ev_alarm, 0)
            visible = 0
            with instance_create(x, y, LightningSpawn)
            image_angle = other.image_angle
        }

        BackCont.viewx2 += lengthdir_x(3, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(3, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 5
        wkick = 4
    }

    //LIGHTNING RIFLE
    if wep == 58 {

        if skill_get(17) snd_play_gun(sndLightningRifleUpg)
        else snd_play_gun(sndLightningRifle)


        with instance_create(x, y, Lightning) {
            image_angle = other.gunangle + (random(6) - 3) * other.accuracy
            team = other.team;
            creator = other.id
            ammo = 30
            event_perform(ev_alarm, 0)
            visible = 0
            with instance_create(x, y, LightningSpawn)
            image_angle = other.image_angle
        }

        BackCont.viewx2 += lengthdir_x(6, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(6, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 8
        wkick = 8
    }


    //LIGHTNING SHOTGUN
    if wep == 59 {

        if skill_get(17) snd_play_gun(sndLightningShotgunUpg)
        else snd_play_gun(sndLightningShotgun)

        repeat(8) {
            with instance_create(x, y, Lightning) {
                image_angle = other.gunangle + (random(180) - 60) * other.accuracy
                team = other.team;
                creator = other.id
                ammo = 9 + random(3)
                event_perform(ev_alarm, 0)
                visible = 0
                with instance_create(x, y, LightningSpawn)
                image_angle = other.image_angle
            }
        }


        BackCont.viewx2 += lengthdir_x(4, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(4, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 10
        wkick = 5
    }

    //ROGUE RIFLE
    if wep == 81 {

        with instance_create(x, y, IDPDBurst) {
            creator = other.id
            ammo = 2
            time = 2
            team = other.team
            event_perform(ev_alarm, 0)
        }
    }

    //SLEDGEHAMMER
    if wep == 88 {

        snd_play_gun(sndHammer)

        instance_create(x, y, Dust)

        with instance_create(x + lengthdir_x(skill_get(13) * 12, gunangle), y + lengthdir_y(skill_get(13) * 12, gunangle), Slash) {
            dmg = 22
            sprite_index = sprHeavySlash
            longarms = 0
            if instance_exists(Player) longarms = skill_get(13) * 2
            motion_add(other.gunangle, 2 + longarms)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        wepangle = -wepangle
        motion_add(gunangle, 6)
        BackCont.viewx2 += lengthdir_x(12, gunangle) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(12, gunangle) * UberCont.opt_shake
        BackCont.shake += 1
        wkick = -4
    }

    //GRENADE RIFLE
    if wep == 80 {

        with instance_create(x, y, ProjectileBurst) {
            creator = other.id
            team = other.team
            snd = sndGrenadeRifle
            ammo = 3
            proj = SmallGrenade
        }

    }

    //BLOOD HAMMER
    if wep == 67 {

        snd_play_gun(sndBloodHammer)

        instance_create(x, y, Dust)

        with instance_create(x + lengthdir_x(skill_get(13) * 12, gunangle), y + lengthdir_y(skill_get(13) * 12, gunangle), BloodSlash) {
            dmg = 14
            longarms = 0
            if instance_exists(Player) longarms = skill_get(13) * 2
            motion_add(other.gunangle, 2 + longarms)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        wepangle = -wepangle
        motion_add(gunangle, 6)
        BackCont.viewx2 += lengthdir_x(12, gunangle) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(12, gunangle) * UberCont.opt_shake
        BackCont.shake += 1
        wkick = -4
    }

    //SEEKER PISTOL
    if wep == 112 {

        repeat 2 {
            with instance_create(x, y, Seeker) {
                motion_add(other.gunangle + random_range(-15, 15) * other.accuracy, 7)
                team = other.team
            }
            snd_play_gun(sndSeekerPistol)
        }

        wkick = 4
    }

    //SEEKER SHOTGUN
    if wep == 113 {

        repeat 6 {
            with instance_create(x, y, Seeker) {
                motion_add(other.gunangle + random_range(-30, 30) * other.accuracy, 7)
                team = other.team
            }
        }

        snd_play_gun(sndSeekerShotgun)
        wkick = 4
    }

    //Double Minigun
    if wep == 83 {
        snd_play_gun_big(sndMinigun, 0.2)
        repeat 2 {
            with instance_create(x, y, Bullet1) {
                motion_add(other.gunangle + random_range(-20, 20) * other.accuracy, 16)
                team = other.team
                image_angle = direction
            }

            with instance_create(x, y, Shell)
            motion_add(other.gunangle + other.right * 100 + random(80) - 40, 3 + random(2))
        }

        motion_add(other.gunangle + 180, 1)

        wkick = 4
    }

    //Pop Gun
    if wep == 69 {
        snd_play_gun(sndPopgun)

        with instance_create(x, y, Bullet2) {
            motion_add(other.gunangle + random_range(-4, 4) * other.accuracy, 16)
            team = other.team
        }

        with instance_create(x, y, Shell)
        motion_add(other.gunangle + other.right * 100 + random(80) - 40, 3 + random(2))

        weapon_post(gunangle, 0, 2, 4)
    }

    //Pop Rifle
    if wep == 71 {
        with instance_create(x, y, ProjectileBurst) {
            creator = other.id
            team = other.team
            snd = sndPopgun
            ammo = 3
            time = 2
            proj = Bullet2
        }

        wkick = 4
    }

    //Heavy Crossbow
    if wep == 66 or wep == 105 {
        snd_play_gun(sndHeavyCrossbow)

        with instance_create(x, y, HeavyBolt) {
            motion_add(other.gunangle, 18)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        wkick = 6
    }

    //Toxic Launcher
    if wep == 72 {
        snd_play_gun(sndToxicLauncher)

        with instance_create(x, y, ToxicGrenade) {
            motion_add(other.gunangle + (random(6) - 3) * other.accuracy, 10)
            image_angle = direction
            team = other.team
            creator = other.id
        }

        wkick = 4
    }

    //FLAME SHOTGUN
    if wep == 75 {
        snd_play_gun(sndFireShotgun)

        repeat(6) {
            with instance_create(x, y, FlameShell) {
                motion_add(other.gunangle + orandom(15) * other.accuracy, 12 + random(6))
                image_angle = direction
                team = other.team;
                creator = other.id
            }
        }

        BackCont.viewx2 += lengthdir_x(12, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(12, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 8
        wkick = 6
    }

    //BOUNCER SHOTGUN
    if wep == 117 {
        snd_play_gun(sndBouncerShotgun)

        for (i = -3; i <= 3; i++) {
            with instance_create(x, y, BouncerBullet) {
                motion_add(other.gunangle + (other.i * 15) * other.accuracy, 6)
                image_angle = direction
                team = other.team;
                creator = other.id
            }
        }

        wkick = 6
    }

    //BOUNCER SMG
    if wep == 116 {
        snd_play_gun(sndBouncerSmg)

        with instance_create(x, y, BouncerBullet) {
            motion_add(other.gunangle + random_range(-10, 10) * other.accuracy, 6)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        wkick = 3
    }

    //SAWED-OFF SHOTGUN
    if wep == 61 {
        snd_play_gun(sndSawedOffShotgun)

        repeat(20) {
            with instance_create(x, y, Bullet2) {
                motion_add(other.gunangle + (random_range(-30, 30)) * other.accuracy, 10 + random(6))
                image_angle = direction
                team = other.team;
                creator = other.id
            }
        }

        motion_add(other.gunangle + 180, 0.6)
		
		weapon_post(gunangle, 12, 10, 5)
    }

    //SPLINTER PISTOL
    if wep == 62 {
        snd_play_gun(sndSplinterGun)

        repeat 4 {
            with instance_create(x, y, Splinter) {
                motion_add(other.gunangle + orandom(4) * other.accuracy, 20 + random(4))
                image_angle = direction
                team = other.team
            }
        }

        wkick = 3
    }

    //DOUBLE FLAME SHOTGUN
    if wep == 76 {
        snd_play_gun(sndDoubleFireShotgun)

        i = 0
        var offset = 10
        repeat 14 {
            i++

            if i == 7 offset = -10

            with instance_create(x, y, FlameShell) {
                motion_add(other.gunangle + (orandom(15) * other.accuracy) + offset, 12 + random(6))
                image_angle = direction
                team = other.team;
                creator = other.id
            }
        }

        wkick = 9
    }

    //GRENADE SHOTGUN
    if wep == 79 {
        snd_play_gun(sndGrenadeShotgun)

        repeat(6) {
            with instance_create(x, y, SmallGrenade) {
                motion_add(other.gunangle + (random(30) - 15) * other.accuracy, random_range(10, 15))
                image_angle = direction
                team = other.team;
                creator = other.id
            }
        }

        wkick = 8
    }

    //Lightning Hammer
    if wep == 74 {

        snd_play_gun(sndLightningHammer, 0.2)
        instance_create(x, y, Dust)

        with instance_create(x + lengthdir_x(skill_get(13) * 12, gunangle), y + lengthdir_y(skill_get(13) * 12, gunangle), LightningSlash) {
            longarms = 0
            if instance_exists(Player) longarms = skill_get(13) * 2
            motion_add(other.gunangle, 2 + longarms)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        wepangle = -wepangle
        motion_add(other.gunangle, 7)
        BackCont.viewx2 += lengthdir_x(24, gunangle) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(24, gunangle) * UberCont.opt_shake
        BackCont.shake += 1
        wkick = -4
    }

    //ERASER
    if wep == 114 {
        snd_play_gun(sndEraser)

        repeat(17) {
            with instance_create(x, y, Bullet2) {
                motion_add(other.gunangle + (random_range(-2, 2)) * other.accuracy, 8 + random(8))
                image_angle = direction
                team = other.team;
                creator = other.id
            }
        }

        wkick = 6
    }

    //HEAVY NADER
    if wep == 124 {
        snd_play_gun(sndHeavyNader)

        with instance_create(x, y, HeavyGrenade) {
            sticky = 0
            motion_add(other.gunangle + (random(6) - 3) * other.accuracy, 10)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 5
    }

    //PLASMA RIFLE
    if wep == 70 {
        if skill_get(17) snd_play_gun(sndPlasmaRifleUpg)
        else snd_play_gun(sndPlasmaRifle)

        with instance_create(x, y, PlasmaBall) {
            motion_add(other.gunangle + (random(10) - 5) * other.accuracy, 2)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        motion_add(other.gunangle + 180, 3)
        BackCont.viewx2 += lengthdir_x(3, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(3, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 3
        wkick = 5
    }

    //HEAVY REVOLVER
    if wep == 89 {
        snd_play_gun(sndHeavyRevoler)

        with instance_create(x, y, Shell)
        motion_add(other.gunangle + other.right * 100 + random(50) - 25, 2 + random(2))

        with instance_create(x, y, HeavyBullet) {
            motion_add(other.gunangle + (random(8) - 4) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(6, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(6, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 4
    }

    //SMART GUN
    if wep == 65 {
        snd_play_gun(sndSmartgun)
        en = instance_nearest(x, y, enemy)

        if instance_exists(en) gunangle = point_direction(x, y, en.x, en.y)

        with instance_create(x, y, Shell)
        motion_add(other.gunangle + other.right * 100 + random(50) - 25, 2 + random(2))

        with instance_create(x, y, Bullet1) {
            motion_add(other.gunangle + (random(4) - 2) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(6, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(6, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 4
    }

    //HEAVY MACHINEGUN
    if wep == 90 {
        snd_play_gun(sndHeavyMachinegun)

        with instance_create(x, y, Shell)
        motion_add(other.gunangle + other.right * 100 + random(50) - 25, 2 + random(2))

        with instance_create(x, y, HeavyBullet) {
            motion_add(other.gunangle + (random(10) - 5) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(6, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(6, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 4
    }

    //AUTO FLAME SHOTGUN
    if wep == 77 {
        snd_play_gun(sndFireShotgun)

        repeat(6) {
            with instance_create(x, y, FlameShell) {
                motion_add(other.gunangle + (random(26) - 13) * other.accuracy, 10 + random(8))
                image_angle = direction
                team = other.team;
                creator = other.id
            }
        }

        BackCont.viewx2 += lengthdir_x(12, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(12, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 8
        wkick = 6
    }

    //SUPER BAZOOKA
    if wep == 119 {
        snd_play_gun(sndSuperBazooka)

        for (i = -2; i <= 2; i++) {
            with instance_create(x, y, Rocket) {
                motion_add(other.gunangle + (random(4) - 2) * other.accuracy + other.i * 10, 2)
                image_angle = direction
                team = other.team;
                creator = other.id
            }
        }

        BackCont.viewx2 += lengthdir_x(30, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(30, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 16
    }

    //SUPER FLAK CANNON
    if wep == 60 {
        snd_play_gun(sndSuperFlakCannon)

        with instance_create(x, y, SuperFlakBullet) {
            motion_add(other.gunangle + (random(4) - 2) * other.accuracy, 10 + random(4))
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(30, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(30, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 10
    }

    //SUPER DSISCGUN
    if wep == 104 {
        snd_play_gun(sndSuperDiscGun)

        with instance_create(x, y, Disc) {
            motion_add(other.gunangle, 5)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Disc) {
            motion_add(other.gunangle + 5 * other.accuracy, 5)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Disc) {
            motion_add(other.gunangle - 5 * other.accuracy, 5)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Disc) {
            motion_add(other.gunangle + 10 * other.accuracy, 5)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x, y, Disc) {
            motion_add(other.gunangle - 10 * other.accuracy, 5)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        motion_add(other.gunangle + 180, 1)

        BackCont.viewx2 += lengthdir_x(60, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(60, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 14
        wkick = 4
    }

    //HEAVY ASSAULT RIFLE
    if wep == 106 {
        snd_play_gun(sndHeavyRevolver)
        with instance_create(x, y, HeavyBurst) {
            creator = other.id
            ammo = 3
            time = 2
            team = other.team;
            creator = other.id
            event_perform(ev_alarm, 0)
        }
    }

    //AUTO GRENADE SHOTGUN
    if wep == 85 {
        snd_play_gun(sndGrenadeShotgun)

        repeat(6) {
            with instance_create(x, y, SmallGrenade) {
                motion_add(other.gunangle + (random(14) - 4) * other.accuracy, 8 + random(3))
                image_angle = direction
                team = other.team;
                creator = other.id
            }
        }
		wkick = 4
    }

    //HYPER SLUGGER
    if wep == 118 {
        with instance_create(x, y, HyperSlug) {
            direction = other.gunangle + random_range(-5, 5);
            team = other.team;
            creator = other.id
        }
        snd_play_gun(sndHyperSlugger)
		wkick = 6
    }

    //PLASMA MINIGUN
    if wep == 96 {
        if skill_get(17) snd_play_gun(sndPlasmaMinigunUpg)
        else snd_play_gun(sndPlasmaMinigun)

        with instance_create(x, y, PlasmaBall) {
            motion_add(other.gunangle + (random(10) - 5) * other.accuracy, 2)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        motion_add(other.gunangle + 180, 2)
        BackCont.viewx2 += lengthdir_x(3, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(3, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 3
        wkick = 5
    }

    //INCINERATOR
    if wep == 110 {
        snd_play_gun(sndIncinerator)

        for (i = -1; i <= 1; i++)
        with instance_create(x, y, FlameShell) {
            {
                motion_add(other.gunangle + (other.i * 10 + orandom(6)) * other.accuracy, 16)
                image_angle = direction
                team = other.team;
                creator = other.id
            }
        }

        BackCont.viewx2 += lengthdir_x(3, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(3, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 3
        wkick = 5
    }

    //SUPER PLASMA CANNON
    if wep == 111 {
        if skill_get(17) snd_play_gun_big(sndPlasmaHugeUpg, .7)
        else snd_play_gun_big(sndPlasmaHuge, .7)

        with instance_create(x, y, PlasmaHuge) {
            motion_add(other.gunangle + (random(4) - 2) * other.accuracy, 2)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        motion_add(other.gunangle + 180, 6)
        BackCont.viewx2 += lengthdir_x(8, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(8, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 8
        wkick = 10
    }

    //ULTRA REVOLVER
    if wep == 86 {
        snd_play_gun(sndUltraPistol)

        with instance_create(x, y, Shell)
        motion_add(other.gunangle + other.right * 100 + random(50) - 25, 2 + random(2))

        with instance_create(x, y, UltraBullet) {
            motion_add(other.gunangle + (random(8) - 4) * other.accuracy, 18)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(6, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(6, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 2
    }

    //ULTRA SHOTGUN
    if wep == 93 {
        snd_play_gun(sndUltraShotgun)

        with instance_create(x, y, Shell)
        motion_add(other.gunangle + other.right * 100 + random(50) - 25, 2 + random(2))

        repeat(7 + random(2)) {
            with instance_create(x, y, UltraShell) {
                motion_add(other.gunangle + (random(40) - 20) * other.accuracy, 14 + random(6))
                image_angle = direction
                team = other.team;
                creator = other.id
            }
        }

        BackCont.viewx2 += lengthdir_x(6, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(6, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 2
    }

    //ULTRA CROSSBOW
    if wep == 94 {
        snd_play_gun(sndUltraCrossbow)

        with instance_create(x, y, UltraBolt) {
            motion_add(other.gunangle, 24)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(40, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(40, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 4
        wkick = 4
    }

    //ULTRA NADER
    if wep == 95 {
        snd_play_gun(sndUltraGrenade)

        with instance_create(x, y, UltraGrenade) {
            sticky = 0
            motion_add(other.gunangle + (random(6) - 3) * other.accuracy, 12)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 5
    }

    //ULTRA LASER PISTOL
    if wep == 87 {

        if skill_get(17) snd_play_gun(sndUltraLaserUpg)
        else snd_play_gun(sndUltraLaser)

        for (i = -2; i <= 2; i++) {
            with instance_create(x, y, Laser) {
                image_angle = other.gunangle + (random(2) - 1 + other.i * 12) * other.accuracy
                team = other.team;
                creator = other.id
                event_perform(ev_alarm, 0)
            }
        }

        BackCont.viewx2 += lengthdir_x(3, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(3, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 2
    }


    //ULTRA SHOVEL
    if wep == 92 {
        snd_play_gun(sndUltraShovel)

        instance_create(x, y, Dust)

        with instance_create(x + lengthdir_x(skill_get(13) * 12, gunangle), y + lengthdir_y(skill_get(13) * 12, gunangle), UltraSlash) {
            dmg = 30
            longarms = 0
            if instance_exists(Player) longarms = skill_get(13) * 2
            motion_add(other.gunangle, 3 + longarms)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x + lengthdir_x(skill_get(13) * 15, gunangle + 60 * accuracy), y + lengthdir_y(skill_get(13) * 15, gunangle + 60 * accuracy), UltraSlash) {
            dmg = 30
            longarms = 0
            if instance_exists(Player) longarms = skill_get(13) * 2
            motion_add(other.gunangle + 60 * other.accuracy, 2 + longarms)
            image_angle = direction
            team = other.team;
            creator = other.id
        }
        with instance_create(x + lengthdir_x(skill_get(13) * 15, gunangle - 60 * accuracy), y + lengthdir_y(skill_get(13) * 15, gunangle - 60 * accuracy), UltraSlash) {
            dmg = 30
            longarms = 0
            if instance_exists(Player) longarms = skill_get(13) * 2
            motion_add(other.gunangle - 60 * other.accuracy, 2 + longarms)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        wepangle = -wepangle
        motion_add(gunangle, 6)
        BackCont.viewx2 += lengthdir_x(24, gunangle) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(24, gunangle) * UberCont.opt_shake
        BackCont.shake += 1
        wkick = -4
    }

    //FROG PISTOLS
    if wep == 120 or wep == 255 {
        snd_play_gun(sndFrogPistol, 0.2)

        repeat 3 {
            with instance_create(x, y, EnemyBullet2) {
                motion_add(other.gunangle + (random(12) - 6) * other.accuracy, 10 + random(4))
                image_angle = direction
                team = other.team
                hit_id = -1
            }
        }

        BackCont.viewx2 += (lengthdir_x(4, (other.gunangle + 180)) * UberCont.opt_shake)
        BackCont.viewy2 += (lengthdir_y(4, (other.gunangle + 180)) * UberCont.opt_shake)
        BackCont.shake += 4
        wkick = 2
    }

    //GUITAR
    if wep == 115 {

        snd_play_gun(sndGuitar)

        instance_create(x, y, Dust)

        with instance_create(x + lengthdir_x(skill_get(13) * 12, gunangle), y + lengthdir_y(skill_get(13) * 12, gunangle), Slash) {
            dmg = 26
            sprite_index = sprHeavySlash
            guitar = true
            longarms = 0
            if instance_exists(Player) longarms = skill_get(13) * 2
            motion_add(other.gunangle, 2 + longarms)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        wepangle = -wepangle
        motion_add(gunangle, 6)
        BackCont.viewx2 += lengthdir_x(12, gunangle) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(12, gunangle) * UberCont.opt_shake
        BackCont.shake += 1
        wkick = -4
    }

    //BLACK SWORD
    if wep == 121 {

        if bleed {
            snd_play_gun(sndBlackSwordMega)
        } else snd_play_gun(sndBlackSword)

        instance_create(x, y, Dust)

        with instance_create(x + lengthdir_x(skill_get(13) * 12, gunangle), y + lengthdir_y(skill_get(13) * 12, gunangle), Slash) {
            dmg = 11

            if other.bleed {
                damage = 30
                image_xscale = 2
                image_yscale = 2
            }

            sprite_index = sprSlash
            longarms = 0
            if instance_exists(Player) longarms = skill_get(13) * 2
            motion_add(other.gunangle, 2 + longarms)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        wepangle = -wepangle
        motion_add(gunangle, 6)
        BackCont.viewx2 += lengthdir_x(12, gunangle) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(12, gunangle) * UberCont.opt_shake
        BackCont.shake += 1
        wkick = -4
    }

    //PARTY GUN
    if wep == 82 {
        snd_play_gun_big(sndConfettiGun, .2)

        with instance_create(x, y, ConfettiBall) {
            sticky = 0
            motion_add(other.gunangle + orandom(15) * other.accuracy, 8)
            image_angle = direction
            team = other.team
        }

        BackCont.viewx2 += (lengthdir_x(3, (other.gunangle + 180)) * UberCont.opt_shake)
        BackCont.viewy2 += (lengthdir_y(3, (other.gunangle + 180)) * UberCont.opt_shake)
        BackCont.shake += 3
        wkick = 2
    }

    //BLOOD CANNON
    if wep == 107 {
        snd_play_gun(sndBloodCannon)

        with instance_create(x, y, BloodBall) {
            sticky = 0
            motion_add(other.gunangle + (random(10) - 5) * other.accuracy, 5)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 5
    }

    //DOG SPIN ATTACK
    if wep == 108 {
        with instance_create(x, y, DogSpinAttack) {
            team = other.team
            creator = other.id
            ammo = 15
        }

        snd_play(sndBigDogSpin)
    }

    //DEVASTATOR
    if wep == 97 {
        if !skill_get(17) {
            snd_play_gun(sndDevastator)
        } else snd_play_gun(sndDevastatorUpg)

        with instance_create(x, y, Devastator) {
            motion_add(other.gunangle + (random(10) - 5) * other.accuracy, 16)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 5
    }

    //LIGHTNING CANNON
    if wep == 68 {
        if !skill_get(17) {
            snd_play_gun(sndLightningCannon)
        } else snd_play_gun(sndLightningCannonUpg)

        with instance_create(x, y, LightningBall) {
            motion_add(other.gunangle + (random(10) - 5) * other.accuracy, 3)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 5
    }

    //LIGHTNING SMG
    if wep == 64 {
        if !skill_get(17) {
            snd_play_gun(sndLightningPistol)
        } else snd_play_gun(sndLightningPistolUpg)

        with instance_create(x, y, Lightning) {
            image_angle = other.gunangle + (random(15) - 7.5) * other.accuracy
            team = other.team;
            creator = other.id
            ammo = 14
            event_perform(ev_alarm, 0)
            visible = 0
            with instance_create(x, y, LightningSpawn)
            image_angle = other.image_angle
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 5
    }

    //HEAVY SLUGGER
    if wep == 91 {
        snd_play_gun(sndHeavySlugger)

        with instance_create(x, y, HeavySlug) {
            motion_add(other.gunangle + (random(10) - 5) * other.accuracy, 11)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 5
    }

    //CLUSTER LAUNCHER
    if wep == 78 {
        snd_play_gun(sndCluster)

        with instance_create(x, y, ClusterNade) {
            motion_add(other.gunangle + (random(10) - 5) * other.accuracy, 8)
            image_angle = direction
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 5
    }

    //SUPER SPLINTER GUN
    if wep == 63 {
        snd_play_gun(sndSuperSplinterGun)

        with instance_create(x, y, SplinterBurst) {
            creator = other.id
            ammo = 6
            time = 1
            team = other.team
            event_perform(2, 0)
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 5
    }

    //FLAME CANNON
    if wep == 73 {
        snd_play_gun_big(sndFlameCannon, .2)

        with instance_create(x, y, FlameBall) {
            creator = other.id
            image_angle = direction
            team = other.team
            motion_add((other.gunangle + ((random(10) - 5) * other.accuracy)), 3)
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 2
        wkick = 5
    }

    //GOLDEN NUKE LAUNCHER
    if wep == 122 {
        snd_play_gun(sndNuke)

        with instance_create(x, y, Nuke) {
            motion_add(other.gunangle + (random(2) - 1) * other.accuracy, 4)
            image_angle = direction
            sprite_index = sprGoldNuke
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(40, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(40, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 8
        wkick = 10
    }

    //GOLDEN DISC GUN
    if wep == 123 {
        snd_play_gun(sndDiscgun)

        with instance_create(x, y, Disc) {
            motion_add(other.gunangle + (random(5) - 2.5) * other.accuracy, 6)
            image_angle = direction
            sprite_index = sprGoldDisc
            team = other.team;
            creator = other.id
        }

        BackCont.viewx2 += lengthdir_x(10, gunangle + 180) * UberCont.opt_shake
        BackCont.viewy2 += lengthdir_y(10, gunangle + 180) * UberCont.opt_shake
        BackCont.shake += 6
        wkick = 4
    }

    //Gungun
    if wep == 125 {
        snd_play_gun(sndGunGun, 0.3)

        with instance_create(x, y, WepPickup) {
            scrDecideWep(10)
            name = wep_name[id.wep]
            type = wep_type[id.wep]
            sprite_index = wep_sprt[id.wep]
            curse = 0
            ammo = 50
            motion_add(other.gunangle, 16)
            instance_create(x + hspeed, y + vspeed, GunGun)
            team = other.team
            image_angle = direction
            mask_index = mskPlasma
        }

        BackCont.viewx2 += (lengthdir_x(30, (other.gunangle + 180)) * UberCont.opt_shake)
        BackCont.viewy2 += (lengthdir_y(30, (other.gunangle + 180)) * UberCont.opt_shake)
        BackCont.shake += 8
        wkick = 6
    }
	
    if object_index == Player && index != global.index {
        BackCont.viewx2 = oldviewx2
        BackCont.viewy2 = oldviewy2
        BackCont.shake = oldshake
    }
	
	return true
}