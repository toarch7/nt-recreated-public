event_inherited()
image_speed = 0.4

repeat(10) {
    with instance_create(x, y, Smoke)
    motion_add(random(360), 1 + random(2))
}

ang = random(360)
repeat(20) {
    with instance_create(x, y, Dust)
    motion_add(other.ang, 6)

    ang += 360 / 20
}


BackCont.shake += 7

if position_meeting(x, y, Floor) instance_create(x, y, Scorch)

team = 3

hit_id = sprPopoExplo