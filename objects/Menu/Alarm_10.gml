if instance_exists(CharSelect) {
    with RadChest instance_destroy(id, 0)
}

with Corpse {
    if instance_exists(CampChar) {
        if distance_to_object(CampChar) <= 8 {
            instance_destroy()
        }
    }
}