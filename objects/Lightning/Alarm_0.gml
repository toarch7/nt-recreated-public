var oldx, oldy, dst = 8 + random(4), dir

if instance_exists(enemy) {
    dir = instance_nearest(x + lengthdir_x(80, direction), y + lengthdir_y(80, direction), enemy)
}

oldx = x
oldy = y

direction = image_angle + (random(30) - 15)
speed = 4

if instance_exists(enemy) {
    if point_distance(x, y, dir.x, dir.y) < 120 {
        motion_add(point_direction(x, y, dir.x, dir.y), 1)
    }
}

//
	x += lengthdir_x(dst, direction)
	y += lengthdir_y(dst, direction)
	
    if place_meeting(x, y, Wall) && !instance_is(InvisiWall, instance_place(x, y, Wall)) {
        x = xprevious
        y = yprevious
		direction += 180
    }
//

image_angle = direction
speed = 0

speed = 0
image_xscale = ((-point_distance(x, y, oldx, oldy)) / 2)
ammo --

if ammo {
    image_index += 0.4 / ammo
	
    with instance_create(x, y, Lightning) {
        hit_id = other.hit_id
        direction = other.direction
        image_angle = direction
        ammo = other.ammo
        team = other.team
        image_index = other.image_index
        event_perform(ev_alarm, 0)
    }
}
else {
	instance_create(x + lengthdir_x(image_xscale / 2, image_angle), y + lengthdir_y(image_xscale / 2, image_angle), LightningHit)
}