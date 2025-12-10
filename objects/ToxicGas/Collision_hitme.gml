if scr_can_hit(other.id) && (!instance_is(other, Player) || other.cantoxic) {
	scr_hit(other, damage, hitid)
	instance_destroy()
}
