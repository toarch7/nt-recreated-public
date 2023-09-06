if lockstep_stop
	exit

scrTarget()
if instance_exists(target) {
    if point_distance(x, y, target.x, target.y) < 64 and !instance_exists(Portal) and collision_line(x, y, target.x, target.y, Wall, 0, 0) < 0 {
        raddrop = 8
        meleedamage = 0
        size = 1
        image_speed = 0.4

        spr_idle = sprMeleeIdle
        spr_walk = sprMeleeWalk
        spr_hurt = sprMeleeHurt
        spr_dead = sprMeleeDead

        if GameCont.area == 105 {
            spr_idle = sprJungleAssassinIdle
            spr_hurt = sprJungleAssassinHurt
            spr_dead = sprJungleAssassinDead
            spr_walk = sprJungleAssassinWalk
        }

        //behavior
        walk = 0
        gunangle = random(360)
        alarm[1] = 90 + random(90)
        wepangle = choose(-140, 140)
        wepflip = 1
        wkick = 0
        instance_change(MeleeBandit, false)
        snd_hurt = sndAssassinHit
        snd_dead = sndAssassinDie
    }
}

if image_index < 1 {
    image_index += random(0.02)
} else {
    image_index += 0.4
}

if instance_number(enemy) = 0 or hp < max_hp {
    raddrop = 8
    meleedamage = 0
    size = 1
    image_speed = 0.4

    spr_idle = sprMeleeIdle
    spr_walk = sprMeleeWalk
    spr_hurt = sprMeleeHurt
    spr_dead = sprMeleeDead

    if GameCont.area == 105 {
        spr_idle = sprJungleAssassinIdle
        spr_hurt = sprJungleAssassinHurt
        spr_dead = sprJungleAssassinDead
        spr_walk = sprJungleAssassinWalk
    }

    wkick = 0

    //behavior
    walk = 0
    gunangle = random(360)
    alarm[1] = 90 + random(90)
    wepangle = choose(-140, 140)
    wepflip = 1
    wkick = 0
    instance_change(MeleeBandit, false)
    snd_hurt = sndAssassinHit
    snd_dead = sndAssassinDie
}

if object_index != MeleeFake snd_play(sndAssassinGetUp)