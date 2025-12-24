if (instance_is(other, FrogQueen) || instance_is(other, Exploder)
	|| instance_is(other, SuperFrog) || (instance_is(other, Player) && !other.cantoxic)
) {
	exit
}

if instance_exists(other.id) && scr_can_hit(other.id) {
	scr_hit(other.id, damage, hitid)
	instance_destroy()
}