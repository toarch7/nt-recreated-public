speed = 0
event_inherited()
repeat 3 instance_create(x, y, Explosion)

if GameCont.crown == 5 scrDrop(0, 60) repeat 2
scrDrop(100, 0)

repeat 5 + irandom(7) {
    with instance_create(x, y + random_spread(16), GroundFlame) {
        move_contact_solid(random(360), 8 + random(12))
    }
}

do {
    if raddrop > 15 {
        raddrop -= 10
        with instance_create(x, y, BigRad) {
            motion_add(other.direction, other.speed)
            motion_add(random(360), random(other.raddrop / 2) + 2)
            repeat(speed)
            speed *= 0.9
        }
    }
} until raddrop <= 15

repeat(raddrop) {
    with instance_create(x, y, Rad) {
        motion_add(other.direction, other.speed)
        motion_add(random(360), random(other.raddrop / 2) + 2)
        repeat(speed)
        speed *= 0.9
    }
}

if !GameCont.loops && instance_number(BigGenerator) <= 1 {
    snd_play(sndNothingGenerators)

    with Nothing {
        hp /= 2
        hp = round(hp)
    }
}

snd_play_hit_big(sndExplosionXL, 0.2)