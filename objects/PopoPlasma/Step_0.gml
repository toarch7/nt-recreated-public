event_inherited()

if current_frame_active && !irandom(1) {
    with instance_create(x + orandom(8), y + orandom(8), PlasmaTrail) {
        sprite_index = sprPopoPlasmaTrail
    }
}