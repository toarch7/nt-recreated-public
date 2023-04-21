draw_set_color(c_black)
draw_rectangle(view_xview, view_yview, view_xview + view_width, view_yview + view_height, 0)

if gamepad_button_check_pressed(0, gpad.face1) {
    event_perform(ev_mouse, ev_global_left_release)
}

if mode = 0 {
    draw_sprite(sprSaving, da, view_xview + view_width / 2, view_yview + view_height / 2 - 16)
    da += 0.5

    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    draw_set_color(c_white)
    draw_text_shadow(view_xview + view_width / 2, view_yview + view_height / 2 + 24, "DO NOT TURN OFF NUCLEAR THRONE\nWHILE THIS SAVING ICON IS DISPLAYED.")
}

if mode = 1 {
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    draw_set_color(c_white)
    draw_text_nt(view_xview + view_width / 2, view_yview + view_height / 2, "@sMADE IN GAME MAKER: STUDIO")
}

if mode = 2 {
    draw_sprite(sprite_index, 0, view_width / 2, view_height / 2)
    draw_set_blend_mode(bm_add)

    repeat 10 {
        draw_sprite_ext(sprite_index, 0, view_width / 2 + random(8) - 4, view_height / 2 + random(8) - 4, 1, 1, 0, c_white, .1)
    }

    draw_set_blend_mode(bm_normal)

    draw_set_halign(fa_center)
    draw_set_valign(fa_center)

    UberCont.font = fontSmall
    draw_text_nt(view_xview + view_width / 2, view_yview + view_height - 10, "@d*THIS PORT IS NOT OFFICIAL#AND IS COMPLETELY FREE ON ITCH.IO")

    UberCont.font = fntM1
}

if mode == 3 {
    draw_set_halign(fa_center)
    draw_set_valign(fa_center)
    draw_text_nt(view_xview + view_width / 2, view_yview + view_height / 2, "@yVLAMBEER@s#&#@wPAUL VEER#JUKIO KALLIO#JOONAS TURNER#JUSTIN CHAN@s##PRESENT###")
}

draw_set_halign(fa_left)
draw_set_valign(fa_top)