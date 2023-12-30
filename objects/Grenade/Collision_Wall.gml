if lockstep_stop
	exit

if sticky = 1 {

    snd_play(sndGrenadeStickWall)
	
    if speed > 0
		instance_create(x, y, Dust)
	
	speed = 0
    move_contact_solid(direction, 12)
}
else {
    if speed > 1
		snd_play(sndGrenadeHitWall)
    
	move_bounce_solid(00)
	speed *= 0.6
    
	instance_create(x, y, Dust)
}