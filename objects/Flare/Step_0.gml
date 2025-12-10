if lockstep_stop
	exit

if current_frame_active && friction > 0.15 {
	var _dir = direction + orandom(10)
    scr_projectile_create(x, y, Flame, _dir, random(1))
}