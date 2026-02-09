if lockstep_stop
	exit

draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, image_angle, c_white, 1)
draw_sprite_ext(spr_start, img, xstart, ystart, 1, 1, image_angle, c_white, 1)
draw_sprite_ext(spr_end, img, x, y, 1, 1, image_angle, c_white, 1)