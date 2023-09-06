if lockstep_stop
	exit

if hp <= 0
	instance_destroy()

if sprite_index != spr_hurt {
	if image_index > 1 {
		image_index += 0.4
		sprite_index = spr_idle
	} else
		image_index += random(0.04)
} else image_index += 0.4

if sprite_index == spr_hurt {
	if image_index > 2
		sprite_index = spr_idle
}

if speed > 1
	speed = 1

if inframes
	inframes --

