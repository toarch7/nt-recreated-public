if (nexthurt > current_frame) gpu_set_fog(true, c_white, 0, 0)

draw_sprite_ext(spr_idle, -1, x, y - 4,
	image_xscale, image_yscale, image_angle, c_white, 1)

if (nexthurt > current_frame) gpu_set_fog(0, 0, 0, 0)