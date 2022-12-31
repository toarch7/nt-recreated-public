image_speed = 0.4
dmg = 5
hit_id = sprite_index

x = round(x + (2 - random(4)))
y = round(y + (2 - random(4)))

c = 20

if object_index == SmallExplosion c = 8

repeat(c / 2) {
    with instance_create(x, y, Smoke)
    motion_add(random(360), 2 + random(3))
}

ang = random(360)

repeat(c) {
    with instance_create(x, y, Dust)
    motion_add(other.ang, 6)

    ang += 360 / c
}

team = -1

if instance_exists(Player) && GameCont.crown == 2 && (object_index == Explosion or object_index == GreenExplosion) {
    repeat 3 {
        dir = random(360)
        with instance_create(x + lengthdir_x(12, dir), y + lengthdir_y(12, dir), SmallExplosion) {
            hit_id = other.hit_id
            team = other.team
        }
    }
}

BackCont.shake += 7

if object_index != SmallExplosion && position_meeting(x, y, Floor) {
    instance_create(x, y, Scorch)
}