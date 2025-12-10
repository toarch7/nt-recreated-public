if lockstep_stop
	exit

if speed > 18 {
	scrWallDestroy(other.id)
	x -= hspeed / 2
	y -= vspeed / 2
	speed -= 2
}
else event_inherited()