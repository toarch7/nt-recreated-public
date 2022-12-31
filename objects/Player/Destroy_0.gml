snd_stop(sndFishTB)

if race == 4 && KeyCont.activeforever[index] {
    instance_create(x, y, MeltGhost)
}

KeyCont.activeforever[index] = 0

if is_me {
    GameCont.last_hit = last_hit
}

if GameCont.crown == 2 {
    snd_play_hit_big(sndExplosionXL, 0.2)

    repeat 10 {
        instance_create(x + random_spread(1), y + random_spread(1), Explosion)
        instance_create(x + random_spread(1), y + random_spread(1), Explosion)
    }
}

snd_play(snd_dead)

with instance_create(x, y, WepPickup) {
    scrWeapons()

    wep = other.wep
    ammo = 0

    curse = other.curse
    name = wep_name[wep]
    type = wep_type[wep]
    sprite_index = wep_sprt[wep]
    motion_add(other.direction, other.speed)
    speed += max(0, - other.hp / 5)
    motion_add(random(360), 2)
    speed *= 0.8
}

if bwep > 0 {
    with instance_create(x, y, WepPickup) {
        scrWeapons()

        wep = other.bwep
        ammo = 0

        curse = other.bcurse
        name = wep_name[wep]
        type = wep_type[wep]
        sprite_index = wep_sprt[wep]
        motion_add(other.direction, other.speed)
        speed += max(0, - other.hp / 5)
        motion_add(random(360), 2)
        speed *= 0.8
    }
}

if instance_number(Player) > 1 exit

audio_stop_sound(sndFrogLoop)
audio_stop_sound(sndFrogLoopButt)

if race == 14 && is_me && !UberCont.cgot[14] && GameCont.level >= 10 {
    UberCont.cgot[14] = 1
    show_unlock_popup("@wSKELETON UNLOCKED@s#FOR REACHING LEVEL ULTRA")
    with instance_create(x, y, UnlockScreen) {
        race = 14;
        skin = 0
    }
    scrAchievement(26)
}

if race == 15 {
    var ang = random(360)

    repeat 14 {
        with instance_create(x, y, EnemyBullet1) {
            motion_add(ang, 4)
            image_angle = direction
            team = other.team
            dmg = 2

            sprite_index = sprScorpionBullet
        }

        ang += 360 / 14
    }
}

snd_stop(sndEyesLoop)
snd_stop(sndEyesLoopUpg)
snd_stop(sndChickenLoop)
snd_stop(sndChickenHeadlessLoop)

if race != 13 {
    with instance_create(x, y, CorpseActive) {
        size = 1

        mask_index = other.mask_index
        motion_add(other.direction, other.speed)

        speed += max(0, - other.hp / 5)

        sprite_index = other.spr_dead
        image_xscale = other.right

        if speed > 16 speed = 16
    }
} else {
    instance_create(x, y, BigDogExplo)
}

with MusCont {
    snd_stop(song)
    snd_loop(amb)
}

with Crown {
    persistent = 0
}

UberCont.ctot_dead[race] += 1

if !global.hardmode {
    if GameCont.kills > UberCont.cbst_kill[race] {
        UberCont.cbst_race[race] = GameCont.race
        UberCont.cbst_area[race] = GameCont.area
        UberCont.cbst_loop[race] = GameCont.loops
        UberCont.cbst_suba[race] = GameCont.subarea
        UberCont.cbst_kill[race] = GameCont.kills
    }

    if UberCont.daily_run && !UberCont.weekly_run {
        with UberCont {
            race = other.race

            if GameCont.kills > UberCont.dbst_kill[race] {
                dbst_race[race] = GameCont.race
                dbst_area[race] = GameCont.area
                dbst_loop[race] = GameCont.loops
                dbst_suba[race] = GameCont.subarea
                dbst_kill[race] = GameCont.kills
            }
        }
    }
} else {
    if GameCont.kills > UberCont.hbst_kill[race] {
        UberCont.hbst_race[race] = GameCont.race
        UberCont.hbst_area[race] = GameCont.area
        UberCont.hbst_loop[race] = GameCont.loops
        UberCont.hbst_suba[race] = GameCont.subarea
        UberCont.hbst_kill[race] = GameCont.kills
    }
}

UberCont.ctot_kill[race] += GameCont.kills

scrUnlock()

if !GameCont.win scrSendDailyData()

if race == 11 {
    do {
        if GameCont.rad > 15 {
            GameCont.rad -= 10
            with instance_create(x, y, BigRad) {
                motion_add(other.direction, other.speed)
                motion_add(random(360), random(GameCont.rad / 2) + 3)
                repeat(speed)
                speed *= 0.9
            }
        }
    }
    until GameCont.rad <= 15

    repeat(GameCont.rad) {
        with instance_create(x, y, Rad) {
            motion_add(other.direction, other.speed)
            motion_add(random(360), random(GameCont.rad / 2) + 3)
            repeat(speed)
            speed *= 0.9
        }
        GameCont.rad--
    }
}

if GameCont.area == 101 && race != 1 && race != 8 {
    with instance_create(x, y, Wind) sprite_index = sprPlayerBubblePop
}

with instance_find(UnlockScreen, 0) {
    alarm[0] = 45
}