if active {
    draw_sprite_ext(sprRocketFlame, current_frame * image_speed, x, y,
		image_xscale, image_yscale, image_angle, image_blend, 1)
}

draw_self()