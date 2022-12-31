with Wall {
    if place_meeting(x, y, other) {
        instance_destroy()
        instance_create(x, y, FloorExplo)
    }
}

instance_destroy()