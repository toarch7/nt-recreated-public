if lockstep_stop
	exit

shky = 0
shkx = 0

if scrGamepadAnykey() != -1 or keyboard_anykey()
    event_perform(ev_mouse, ev_global_left_press)

if shake > 0 {
	
	shky = orandom(shake)
	shkx = orandom(shake)
	
    shake --
	
	if !shake
		shake = 0
}

draw_sprite(sprLogo, image_index, view_xview + view_width / 2 + shkx, view_yview + view_height / 2 + shky)

if image_index == 7 {
    gpu_set_blendmode(bm_add)
    
	ang = 0
	
    repeat(8) {
        draw_sprite_ext(sprLogoGlow, - 1, view_xview + view_width / 2 + shkx + lengthdir_x(4 + sin(wave) * (2 + random(1)), ang), view_yview + view_height / 2 + shky + lengthdir_y(4 + sin(wave) * (2 + random(1)), ang), 1, 1, 0, c_white, 0.05)
        ang += 360 / 8
        wave += random(0.02)
    }

    gpu_set_blendmode(bm_normal)
    wave += 0.05
	
	if wave % 6 > 3 && is_gamepad() {
		draw_set_halign(fa_center)
		draw_set_valign(fa_center)
		
		draw_text_nt(view_xview + view_width / 2, view_yview + view_height - 48, loc("@sPRESS ANY BUTTON"))
		
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
	}
}