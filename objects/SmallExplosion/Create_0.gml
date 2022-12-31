image_speed = 0.4
dmg = 5
hit_id = sprSmallExplosion

x += random(4) - 2
y += random(4) - 2

c = 5

repeat 3 {
    with instance_create(x, y, Smoke)
    motion_add(random(360), 1 + random(2))
}

ang = random(360)

repeat c {
    with instance_create(x, y, Dust) {
        motion_add(other.ang, 6)
    }

    ang += 360 / c
}

team = -1

BackCont.shake += 3