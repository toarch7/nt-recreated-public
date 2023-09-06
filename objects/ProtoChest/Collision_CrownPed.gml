if lockstep_stop
	exit

var f = instance_random(Floor)

if f {
	x = f.x + f.sprite_width / 2
	y = f.y + f.sprite_height / 2
	
	xprevious = x
	yprevious = y
}