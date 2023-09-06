if lockstep_stop
	exit

if speed > 18 {
    with other {
        instance_destroy()
        instance_create(x, y, FloorExplo)
    }

    x -= hspeed / 2
    y -= vspeed / 2

    speed -= 2
} else if speed > 0 {
    alarm[1] = 1
    snd_play_hit_big(sndBoltHitWall, 0.2)
    speed = 0
    move_contact_solid(direction, 16)
    instance_create(x, y, Dust)
    alarm[0] = 30
}