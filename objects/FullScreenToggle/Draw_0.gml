draw_sprite(sprite_index, UberCont.opt_fulscrn, x, y)

if mouse_check_button_pressed(mb_left) and mouse_x > x and mouse_x < x + 8 and mouse_y > y and mouse_y < y + 8 {
    if UberCont.opt_fulscrn = 0 UberCont.opt_fulscrn = 1
    else UberCont.opt_fulscrn = 0

    window_set_fullscreen(UberCont.opt_fulscrn)
}