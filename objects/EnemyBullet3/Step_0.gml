if lockstep_stop
	exit

image_angle = direction


if speed < 6 and sprite_index != sprEBullet3Disappear {
    sprite_index = sprEBullet3Disappear
    image_index = 0
    image_speed = 0.4
}