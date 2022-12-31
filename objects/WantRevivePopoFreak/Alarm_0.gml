if instance_exists(Portal) || !instance_exists(Corpse) {
    instance_destroy()
} else {
    with instance_nearest(x, y, Corpse) {
        instance_create(x, y, RevivePopoFreak)
    }
}