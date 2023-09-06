if lockstep_stop
	exit

move_bounce_solid(00)

if dist > 50 {
    instance_create(x, y, DiscDisappear)
    instance_destroy()
}
else {
    snd_play(sndDiscBounce)
	
    with instance_create(x, y, DiscBounce)
		image_angle = other.image_angle
}