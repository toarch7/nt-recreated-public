if current_frame_active {
	scr_damage_create(x + orandom(16), y + orandom(16), PlasmaImpact)
	
	x += orandom(1)
	y += orandom(1)
}