event_inherited()

if walk > 0 {
    motion_add(direction, .8)
    walk -= 1
}

if speed > 4.5 {
    speed = 4.5
}

if ammo {
    if instance_exists(target) {
        gunangle = target_direction + gunoffset
    }

    if raddrop >= round(charge + 1) {
        raddrop -= round(charge + 1)

        repeat round(charge + 1) {
            with instance_create(x + random(2 + charge) * choose(1, - 1), y + random(2 + charge) * choose(1, - 1), HorrorBullet) {
                motion_add(other.gunangle, 12)
                image_angle = direction
                hit_id = other.hit_id
                team = other.team
            }
        }

        charge += .1
    }

    ammo--
} else charge = 0