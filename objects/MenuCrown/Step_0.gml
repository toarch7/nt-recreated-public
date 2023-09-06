if lockstep_stop
	exit

if mouse_x > x and mouse_x < x + 48 and mouse_y > y and mouse_y < y + 32 and image_index != 6 and mouse_check_button_pressed(mb_left) {
    with Menu {
        mode = 2
        instance_create(108, room_height - 52, MenuGo)
        instance_create(16, room_height - 52, BackButton)
        num = 1
        dix = 0
        diy = 0
        repeat(3) {
            repeat(4) {
                with instance_create(16 + dix, 32 + diy, CrownSelect)
                num = other.num
                num += 1
                dix += 36
            }
            dix = 0
            diy += 36
        }
        with instance_create(16 + dix, 32 + diy, CrownSelect)
        num = 0
    }
    with MenuCrown
    instance_destroy()
    with CharSelect
    instance_destroy()
}