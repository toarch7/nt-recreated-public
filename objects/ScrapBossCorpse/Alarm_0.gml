if !scr_check_enemies() && !instance_exists(Portal) {
    with instance_create(x, y, Portal) {
        type = 1
    }
}