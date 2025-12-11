if lockstep_stop
	exit

if active {
    draw_sprite_ext(sprNukeFlame, current_frame * 0.4,
		x, y, image_xscale, image_yscale, image_angle, image_blend, 1)
}

draw_self()