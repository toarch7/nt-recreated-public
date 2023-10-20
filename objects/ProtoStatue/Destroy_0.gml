event_inherited()
snd_play_hit_big(snd_dead, 0.2)
ang = random_angle

repeat 10 {
    with instance_create(x, y, Dust)
    motion_add(other.ang, 3)

    ang += 36
}

if rad > 24 {
    with instance_create(x, y, Portal) {
        type = 3
    }

    GameCont.area = 100
} else {
    raddrop = rad

    do {
        if raddrop > 15 {
            raddrop -= 10
            with instance_create(x, y, BigRad) {
                motion_add(other.direction, other.speed)
                motion_add(random_angle, random(other.raddrop / 2) + 2)
                repeat speed {
                    speed *= 0.9
                }
            }
        }
    } until raddrop <= 15

    repeat raddrop {
        with instance_create(x, y, Rad) {
            motion_add(other.direction, other.speed)
            motion_add(random_angle, random(other.raddrop / 2) + 2)
            repeat speed {
                speed *= 0.9
            }
        }
    }
}

GameCont.crownrad = 0