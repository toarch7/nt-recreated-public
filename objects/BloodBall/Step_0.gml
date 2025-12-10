image_angle += spin * timescale

if (current_frame_active && random(6) < 1) {
	scr_damage_create(x + orandom(5), y + orandom(5), MeatExplosion)
}