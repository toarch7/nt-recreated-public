if scr_can_hit(other.id, false) {
    with (instance_create(x, y, Tangle)) {
		team = other.team
		creator = other.creator
	}
    instance_create(x, y, Dust)
    instance_destroy()
}