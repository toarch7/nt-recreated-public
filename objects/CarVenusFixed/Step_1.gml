if sprite_index != spr_hurt {
	sprite_index = spr_idle
}
else if image_index > 2 {
	sprite_index = spr_idle
}

var _floor = instance_nearest(x - 16, y - 16, Floor)
if instance_exists(_floor) && _floor.sprite_index == sprFloor5B {
    if (friction != 0.05) friction = 0.05
}
else if (friction != 1.5) friction = 1.5

if (hp <= 0) instance_destroy()

if (speed > 4) speed = 4