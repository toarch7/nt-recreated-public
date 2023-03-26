shky = orandom(shake)
shkx = orandom(shake)

if gamepad_button_check_pressed(0, gpad.face1) {
    event_perform(ev_mouse, ev_global_left_press)
}

if shake {
    shake--
}

draw_sprite(sprLogo, image_index, view_xview + view_width / 2 + shkx, view_yview + view_height / 2 + shky)

if image_index == 7 {
    draw_set_blend_mode(bm_add)
    ang = 0
    repeat(8) {
        draw_sprite_ext(sprLogoGlow, - 1, view_xview + view_width / 2 + shkx + lengthdir_x(4 + sin(wave) * (2 + random(1)), ang), view_yview + view_height / 2 + shky + lengthdir_y(4 + sin(wave) * (2 + random(1)), ang), 1, 1, 0, c_white, 0.05)
        ang += 360 / 8
        wave += random(0.02)
    }

    draw_set_blend_mode(bm_normal)
    wave += 0.05
}