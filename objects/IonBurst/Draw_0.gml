if lockstep_stop
	exit

gpu_set_blendmode(bm_add)

draw_sprite_ext(sprLaser, -1, x, y, 1000, image_xscale, 270, c_white, 1)

if ammo < 10 && place_meeting(x, y, Floor) {
	draw_sprite_ext(sprLaser, -1, x, y, 1000, image_xscale, 270, c_white, 1)
}

gpu_set_blendmode(bm_normal)