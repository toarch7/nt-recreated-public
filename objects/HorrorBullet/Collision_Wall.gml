if lockstep_stop
	exit

instance_destroy()
instance_create(x, y, Dust)

snd_play_hit(sndHitWall, 0.2)

if team != team_player && can_drop_rads {
    with instance_create(x, y, Rad) {
        motion_add(other.direction, other.speed)
        motion_add(random_angle, 8)
        repeat(speed) speed *= 0.9
    }
}