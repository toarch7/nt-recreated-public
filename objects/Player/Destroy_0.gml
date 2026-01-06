snd_stop(sndFishTB)

if race == Race.Melting && KeyCont.activeforever[index] {
    instance_create(x, y, MeltGhost)
}

KeyCont.activeforever[index] = 0

if scrCrownCheck(crwn_death) {
    snd_play_hit_big(sndExplosionXL, 0.2)

    repeat 10 {
        instance_create(x + orandom(1), y + orandom(1), Explosion)
        instance_create(x + orandom(1), y + orandom(1), Explosion)
    }
}

snd_play(snd_dead)

if (wep > 0) with (scrWeaponPickupCreate(x, y, wep)) {
	motion_add(other.direction, other.hp * -0.2)
	curse = other.curse
}

if (bwep > 0) with (scrWeaponPickupCreate(x, y, bwep)) {
	motion_add(other.direction, other.hp * -0.2)
	curse = other.bcurse
}

if (instance_number(Player) > 1) exit

audio_stop_sound(sndFrogLoop)
audio_stop_sound(sndFrogLoopButt)

if race == Race.Frog {
    var ang = random_angle

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
else if race == Race.Cuz {
	var _ultra = scr_ultra_get(Race.Cuz, UltraSkill.Emotional)
	
	var _angle = 0,
		_count = 20 * (1 + _ultra),
		_step = 360 / _count
	
	repeat _count {
		scr_projectile_create(x, y, CuzTear, _angle, 6)
		_angle += _step
	}
}

snd_stop(sndEyesLoop)
snd_stop(sndEyesLoopUpg)
snd_stop(sndChickenLoop)
snd_stop(sndChickenHeadlessLoop)

if race != Race.BigDog {
    with instance_create(x, y, CorpseActive) {
        size = 1

        mask_index = other.mask_index
        motion_add(other.direction, other.speed)

        speed += max(0, -other.hp / 5)

        sprite_index = other.spr_dead
        image_xscale = other.right

        if speed > 16 speed = 16
    }
} else {
    instance_create(x, y, BigDogExplo)
}

with MusCont {
    snd_stop(song)
    snd_play_loop(amb)
}

with CrownObject {
    persistent = false
}

if scr_player_is_local(index) {
	var _race = race
	
	UberCont.ctot_dead[_race] += 1
	
	scrPlayerUpdateBestRunStats(true)
	
	if (!(UberCont.want_menu || UberCont.want_restart)) {
		scrUnlocksArea()
	}
	
	scrRaceUnlock(Race.Melting)
	
	if (!GameCont.win) scrSendDailyData()
}

if race == Race.Horror {
	scrRadDrop(x, y, GameCont.rad)
	GameCont.rad = 0
}

if GameCont.underwater && race != Race.Fish && race != Race.Robot {
    with (instance_create(x, y, Wind)) sprite_index = sprPlayerBubblePop
}

with (instance_find(UnlockScreen, 0)) alarm[0] = 45