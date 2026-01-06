if lockstep_stop
	exit

if !global.console_active {
	if mouse_ui_clicked() or keyboard_anykey() or scrGamepadAnykey() != -1 {
		event_perform(ev_alarm, 0)
	}
}

draw_reset_font()
draw_align(fa_center, fa_middle)
draw_clear(c_black)

if gamepad_button_check_pressed(0, gp_face1) {
    event_perform(ev_mouse, ev_global_left_release)
}

var _cx = view_xview_center,
	_cy = view_yview_center

if mode == 0 {
    draw_sprite(sprSaving, da, _cx, _cy - 16)
    da += 0.5
	
    draw_set_color(c_white)
	
	var _msg = "DO NOT TURN OFF NUCLEAR THRONE\nWHILE THIS SAVING ICON IS DISPLAYED."
    draw_text_nt(_cx, _cy + 24, loc("Intro:SaveNote", _msg))
}

if mode == 1 {
    draw_set_color(c_white)
    draw_text_nt(_cx, _cy, loc("Intro:MadeInGM", "@sMADE IN GAMEMAKER"))
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
	var _msg = "@yVLAMBEER@s#&#@wPAUL VEER#JUKIO KALLIO#JOONAS TURNER#JUSTIN CHAN#YELLOWAFTERLIFE@s##PRESENT###"
	draw_text_nt(_cx, _cy, loc("Intro:Team", _msg))
}

draw_align()