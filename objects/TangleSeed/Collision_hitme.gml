if scr_can_hit(other.id, false) {
    instance_create(x, y, Tangle)
    instance_create(x, y, Dust)
    instance_destroy()
}