if (image_speed > 0 || team == other.team) exit

if other.typ == 1 {
    with (other) {
		team = other.team
	    direction = point_direction(other.x, other.y, x, y)
	    image_angle = direction
		
	    with (instance_create(other.x, other.y, Deflect)) {
	        image_angle = other.direction
	    }
		
	    hitid = other.hitid
	}
}
else if other.typ == 2 {
    instance_destroy(other)
}
else exit

snd_play_pitch(sndShielderDeflect)
