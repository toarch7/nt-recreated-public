if lockstep_stop
	exit

if active {
    draw_sprite_ext(sprRocketFlame, - 1, x, y, image_xscale, image_yscale, image_angle, image_blend, 1)
}

draw_self()