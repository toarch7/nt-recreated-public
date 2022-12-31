draw_sprite(sprite_index, UberCont.opt_fulscrn, x, y)


if mouse_check_button_pressed(mb_left) and mouse_x > x and mouse_x < x + 8 and mouse_y > y and mouse_y < y + 8 {
    if UberCont.opt_scaling > 1 UberCont.opt_scaling -= 1

    with BackCont
    screen_init()
}
if mouse_check_button_pressed(mb_left) and mouse_x > x + 10 and mouse_x < x + 18 and mouse_y > y and mouse_y < y + 8 {
    if UberCont.opt_scaling < min(floor(display_get_width() / 320), floor(display_get_height() / 240)) + 1 UberCont.opt_scaling += 1


    with BackCont
    screen_init()
}