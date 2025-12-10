if lockstep_stop
	exit

if scr_projectile_generic_hit(false) && instance_exists(creator) {
	scrLightningCreate(x, y, direction + orandom(6), irandom_range(6, 10))
}