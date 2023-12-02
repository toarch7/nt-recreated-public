if lockstep_stop
	exit

if alarm[0] <= flash_at {
    var c = alarm[0] % 5 > 2 ? c_black : c_white

    gpu_set_fog(1, c, 0, 0)

    draw_self()

    gpu_set_fog(0, c, 0, 0)
}
else {
	draw_self()
	
	if attract_flash > 0 {
		gpu_set_fog(true, c_ultra, 0, 0)
		draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, attract_flash)
		gpu_set_fog(false, 0, 0, 0)
	}
}