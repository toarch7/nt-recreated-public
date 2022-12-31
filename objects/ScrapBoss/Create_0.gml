raddrop = 90
max_hp = ceil(300 * (1 + GameCont.loops / 1.2))
meleedamage = 0
size = 3

spr_idle = sprScrapBossIdle
spr_walk = sprScrapBossWalk
spr_hurt = sprScrapBossHurt
spr_dead = sprScrapBossDead
spr_fire = sprScrapBossFire

event_inherited()

right = 1

scrTarget()

if instance_exists(target) {
    gunangle = target_direction
} else gunangle = 0

alarm[0] = 30
ammo = 15
turn = choose(1, - 1)
walk = 0

if !snd_is_playing(musBoss2) {
    with MusCont {
        alarm[2] = 1
    }
}

dir = random(360)
repeat(10) {
    with instance_create(x, y, Dust) {
        motion_add(other.dir, 8)
    }

    dir += 36
}

with Wall {
    if place_meeting(x, y, other) {
        instance_destroy()
        instance_create(x, y, FloorExplo)
    }
}

snd_hurt = sndBigDogHit
snd_dead = sndBigDogDeath

sndhalfhp = 0
sndtaunt = 0
tauntdelay = 0

if instance_exists(Player) {
    with Raven {
        scrRavenLift()
    }
}

spr_shadow = shd96

alarm[2] = 20