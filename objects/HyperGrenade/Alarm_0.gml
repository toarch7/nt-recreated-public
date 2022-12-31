move_contact_solid(direction, 16)

repeat(4) {
    with instance_create(x, y, Smoke)
    motion_add(random(360), random(2))
}


sleep(50)
dir = 0
do {
    dir += 1 x += lengthdir_x(4, direction) y += lengthdir_y(4, direction)
}
until dir > 100 or place_meeting(x, y, Wall) or place_meeting(x, y, NothingInactive) or place_meeting(x, y, hitme)
alarm[1] = 2

speed = 4