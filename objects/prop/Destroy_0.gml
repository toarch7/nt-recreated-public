if !isset("corpse") corpse = 1

if corpse {
    with instance_create(x, y, Corpse) {
        size = other.size
        sprite_index = other.spr_dead
        image_xscale = other.image_xscale
    }
}

do {
    if raddrop > 15 {
        raddrop -= 10
        with instance_create(x, y, BigRad) {
            motion_add(other.direction, other.speed)
            motion_add(random(360), random(other.raddrop / 2) + 3)
            repeat(speed)
            speed *= 0.9
        }
    }
}
until raddrop <= 15

repeat(raddrop) {
    with instance_create(x, y, Rad) {
        motion_add(other.direction, other.speed)
        motion_add(random(360), random(other.raddrop / 2) + 3)
        repeat(speed)
        speed *= 0.9
    }
}

if isset("snd_dead") snd_play_hit(snd_dead, 0.2)