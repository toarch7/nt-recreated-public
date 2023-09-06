if lockstep_stop
	exit

if mouse_x > x and mouse_x < x + 48 and mouse_y > y and mouse_y < y + 32 and image_index != 6 and mouse_check_button_pressed(mb_left) {
    with Menu {
        if race = 0 race = ceil(random(racemax)) if crown = 0 crown = ceil(random(crownmax)) with instance_create(x, y, GenCont) {
            race = other.race
            crown = other.crown
        }
        instance_destroy()
        with CharSelect
        instance_destroy()
        with BackButton
        instance_destroy()
        with CrownSelect
        instance_destroy()
        with MenuGo
        instance_destroy()
    }
}