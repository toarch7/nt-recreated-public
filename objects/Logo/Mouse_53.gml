if instance_exists(GameCont) {
    if GameCont.area == 7 && GameCont.subarea == 3 {
        with Credits instance_destroy()
        with SpiralCont instance_destroy()
        with Spiral instance_destroy()

        instance_create(0, 0, Cinematic)
		
		instance_activate_all()
		
        room_restart()

        instance_destroy()

        exit
    }
}

if visible && image_index >= 1 {
    if instance_exists(Credits) {
        with Credits visible = 0
    } else alarm[1] = 2

    visible = 0
} else if image_index < 1 {
    if alarm[0] > 10 alarm[0] = 10
}