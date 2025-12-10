if lockstep_stop
	exit

if !global.console_active {
	if mouse_ui_clicked() or keyboard_anykey() or scrGamepadAnykey() != -1 {
		event_perform(ev_alarm, 0)
	}
}

draw_set_color(c_black)
draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + view_height, 0)

if gamepad_button_check_pressed(0, gp_face1) {
    event_perform(ev_mouse, ev_global_left_release)
}

var _cx = view_xview_center, _cy = view_yview_center

if mode == 0 {
    draw_sprite(sprSaving, da, _cx, _cy - 16)
    da += 0.5

    draw_set_halign(fa_center)
    draw_set_valign(fa_middle)
    draw_set_color(c_white)
    draw_text_shadow(_cx, _cy + 24, "DO NOT TURN OFF NUCLEAR THRONE\nWHILE THIS SAVING ICON IS DISPLAYED.")
}

if mode == 1 {
    draw_set_halign(fa_center)
    draw_set_valign(fa_middle)
    draw_set_color(c_white)
    draw_text_nt(_cx, _cy, "@sMADE IN GAMEMAKER")
}

if mode == 2 {
	var _px = view_xview + (view_width - sprite_width) div 2,
		_py = view_yview + (view_height - sprite_height)
	
    draw_sprite(sprite_index, 0, _px, _py)
    
	gpu_set_blendmode(bm_add)
    repeat (10) {
        draw_sprite_ext(sprite_index, 0, _px + orandom(4), _py + orandom(4), 1, 1, 0, c_white, 0.1)
    }
    gpu_set_blendmode(bm_normal)
}

if mode == 3 {
    draw_set_halign(fa_center)
    draw_set_valign(fa_middle)
    draw_text_nt(_cx, _cy, "@yVLAMBEER@s#&#@wPAUL VEER#JUKIO KALLIO#JOONAS TURNER#JUSTIN CHAN#YELLOWAFTERLIFE@s##PRESENT###")
}

draw_set_halign(fa_left)
draw_set_valign(fa_top)