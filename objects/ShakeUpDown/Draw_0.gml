if lockstep_stop
	exit

draw_sprite(sprite_index, UberCont.opt_fulscrn, x, y)

if mouse_check_button_pressed(mb_left) and mouse_x > x and mouse_x < x + 8 and mouse_y > y and mouse_y < y + 8 {
    if UberCont.opt_shake > 0 UberCont.opt_shake -= 0.5
}
if mouse_check_button_pressed(mb_left) and mouse_x > x + 10 and mouse_x < x + 18 and mouse_y > y and mouse_y < y + 8 {
    if UberCont.opt_shake < 2 UberCont.opt_shake += 0.5
}

if UberCont.opt_shake != 1 draw_text(x + 20, y, string_hash_to_newline("NOT AS GOOD!"))