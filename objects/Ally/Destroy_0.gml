scrDrop(10, 0)
ang = random(360)
repeat(14) {
    with(instance_create(x, y, AllyBullet)) {
        motion_add(other.ang, 4)
        image_angle = direction
        team = other.team
    }
    ang += 360 / 14
}
with(instance_create(x, y, Corpse)) {
    size = other.size
    mask_index = other.mask_index
    motion_add(other.direction, other.speed)
    speed += max(0, ((-other.hp) / 5))
    sprite_index = other.spr_dead
    image_xscale = other.right
    if (speed > 16) speed = 16
    if (size > 0) speed /= size
}

snd_play(snd_dead)

do {
    if (raddrop > 15) {
        raddrop -= 10
        with(instance_create(x, y, BigRad)) {
            motion_add(other.direction, other.speed)
            motion_add(random(360), (random((other.raddrop / 2)) + 2))
            repeat speed
            speed *= 0.9
        }
    }
} until (raddrop <= 15);

repeat raddrop {
    with(instance_create(x, y, Rad)) {
        motion_add(other.direction, other.speed)
        motion_add(random(360), (random((other.raddrop / 2)) + 2))
        repeat speed
        speed *= 0.9
    }
}