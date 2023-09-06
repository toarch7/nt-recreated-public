if lockstep_stop
	exit

draw_sprite_ext(sprite_index, - 1, x, y, image_xscale, image_yscale, image_angle, c_white, 1)
draw_sprite_ext(sprLaserStart, img, xstart, ystart, 1, 1, image_angle, c_white, 1)
draw_sprite_ext(sprLaserEnd, img, x, y, 1, 1, image_angle, c_white, 1)